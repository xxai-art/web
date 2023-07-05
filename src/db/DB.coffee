> wac.tax/_/IDB.js
  wac.tax/_/leader.js > ON
  @w5/vbyte/vbyteE.js
  @w5/urlb64/b64e.js
  wac.tax/_/channel.js > toAll hook
  ../lib/keyPath.coffee
  wac.tax/user/User.js > onMe
  wac.tax/_/SDK.js
  @w5/uintb64/uintB64.js
  @w5/uintb64/b64Uint.js
  ./es.coffee:ES_MAP

export FAV = 'fav'
export FAV_STATE = 'favState'
export FAV_YM = 'favYm'
export FAV_Y = 'favY'
export SUM = 'sum'
export SYNCED = 'synced'
export SYNCED_ID = 'syncedId'

CTIME = 'ctime'
< PREV = 'prev'

+ _R, _W, _DB, INTERVAL, PRE, UID, LEADER, ES

_iter = (direction,table,range,index)->
  c = _R[table]
  if index
    c = c.index(index)
  c = await c.openCursor(range,direction)
  while c
    yield c.value
    c = await c.continue()
  return

export nextIter = _iter.bind _iter,undefined
export prevIter = _iter.bind _iter,PREV


onMe (user)=>
  UID = user.id or 0
  PRE = {}

  _DB?.close()

  [_DB,_R,_W] = await IDB['u-'+uintB64(UID)](
    1 # version
    upgrade:(db)=> # upgrade(db, oldVersion, newVersion, transaction, event)
      store = db.createObjectStore(
        FAV
        keyPath: ['cid','rid','ctime']
      )

      db.createObjectStore(FAV_STATE, keyPath)
      db.createObjectStore(
        FAV_YM
        keyPath: ['y','m']
      )
      db.createObjectStore(
        FAV_Y
        keyPath: ['y']
      )
      for t from [SUM,SYNCED,SYNCED_ID]
        db.createObjectStore t,keyPath:'table'
      return
  )

  if UID and LEADER
    _onLeader()
  else
    _clear()
  return

# export DB = DB
export R = new Proxy(
    (args...)=>
      _R(...args)
    get:(_,n)=>
      _R[n]
  )

export W = new Proxy(
    (args...)=>
      _W(...args)
    get:(_,n)=>
      _W[n]
  )




> ../conf > API


reconnect = =>

  t = [UID]

  [synced,syncedid] = R(SYNCED,SYNCED_ID)

  for table from [FAV]
    [_n,_id] = await Promise.all [
      synced.get(table)
      syncedid.get(table)
    ]
    t = t.concat [
      _id?.id or 0
      _n?.n or 0
    ]

  ES = new EventSource(
    API+'es/'+b64e(vbyteE(t))
    withCredentials:true
  )

  close = ES.close.bind(ES)

  ES.onmessage = (e)=>
    data = JSON.parse e.data
    [user_id, kind] = data
    data = data.slice(2)
    if user_id != UID
      return
    ES_MAP.get(kind)(
      user_id, _R, _W, data
    )
    return

  timer = setTimeout(
    ES.close
    99e3
  )

  ES.close = =>
    clearTimeout timer
    if ES.readyState <= 1
      close()
      if UID and LEADER
        reconnect()
      else
        ES = undefined
    return

  ES.onerror = =>
    clearTimeout timer
    close()
    setTimeout(
      reconnect
      1e3
    )
    return

  return

_onLeader = =>
  _clear()

  if not ES
    reconnect()

  INTERVAL = setInterval(
    =>
      read = _R
      write = _W
      sum = read[SUM]
      c = await sum.openCursor()
      updated = []
      while c
        {n, table} = c.value
        if PRE[table] != n
          updated.push [table, n]
          PRE[table] = n
        c = await c.continue()

      for [table, n] from updated
        synced = (await read[SYNCED].get(table))?.n or 0
        if n != synced
          diff = n - synced
          # 拉出最后 diff 条，然后扔给服务器

          li = []
          for await o from prevIter(table)
            li.unshift Object.values o
            if -- diff == 0
              break

          id = await SDK.fav UID, li
          if id
            await write[SYNCED_ID].put({table, id})
          await write[SYNCED].put({table, n})
          # c = await R[table].index(UID_CTIME).openCursor(),PREV)
          # while c
          #   console.log c.value
          #   c = await c.continue()
      return
    1e3
  )

  #TODO 每 90 秒 es 断开重新连
  return

_clear = =>
  clearInterval INTERVAL
  ES?.close()
  return

ON.add (leader)=>
  if leader
    LEADER = 1
    if UID and _R
      _onLeader()
    else
      _clear()
    document.title = 'leader'
  else
    _clear()
    LEADER = undefined
    PRE = {}
    document.title = ''
  return
