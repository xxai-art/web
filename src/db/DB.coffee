> wac.tax/_/IDB.js
  wac.tax/_/leader.js > ON
  @w5/wasm > b64VbyteE u64B64
  ../conf > API
  ../lib/keyPath.coffee
  wac.tax/user/User.js > onMe
  wac.tax/_/SDK.js
  ./es.coffee:ES_MAP
  ./TABLE.coffee > FAV FAV_STATE FAV_YM FAV_Y SUM SYNCED SYNCED_ID


CTIME = 'ctime'
< PREV = 'prev'

+ _R, _W, _DB, INTERVAL, PRE, UID, LEADER, ES

_rw = (args, next, db, pending)=>
  if db
    return next ... db(...args)
  else
    return new Promise (resolve,reject)=>
      pending.push [
        args
        (a...)=>
          try
            resolve await next(...a)
          catch err
            reject err
          return
      ]
  return

_R_PENDING = []

export R = (args...)=>
  (next)=>
    _rw(args, next, _R, _R_PENDING)

_W_PENDING = []

export W = (args...)=>
  (next)=>
    _rw(args, next, _W, _W_PENDING)

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

  if not UID
    _DB = _R = _W = undefined
    return

  [_DB,_R,_W] = await IDB['u-'+u64B64(UID)](
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

  for [db, pending] from  [
    [_W,_W_PENDING]
    [_R,_R_PENDING]
  ]
    for [args,next] from pending
      next ...db(...args)
    pending.splice(0,pending.length)

  if UID and LEADER
    _onLeader()
  else
    _clear()
  return



reconnect = (onopen)=>
  R(SYNCED,SYNCED_ID) (synced,syncedid)=>
    t = [UID]

    for table from [FAV]
      [_n,_id] = await Promise.all [
        synced.get(table)
        syncedid.get(table)
      ]
      t = t.concat [
        _id?.id or 0
        _n?.n or 0
      ]

    es = new EventSource(
      API+'es/'+b64VbyteE(t)
      withCredentials:true
    )

    close = es.close.bind(es)

    es.onopen = =>
      ES = es
      onopen?()
      return

    es.onmessage = (e)=>
      console.log e.data
      data = JSON.parse e.data
      [kind, user_id] = data
      data = data.slice(2)
      if user_id != UID
        return
      ES_MAP.get(kind)(
        _W, data
      )
      return

    timer = setTimeout(
      =>
        reconnect =>
          clearTimeout timer
          close()
        return
      94e3
    )

    es.close = =>
      clearTimeout timer
      if es.readyState <= 1
        close()
        if UID and LEADER
          reconnect()
        else
          es = undefined
      return

    es.onerror = =>
      clearTimeout timer
      close()
      setTimeout(
        =>
          reconnect(onopen)
          return
        1e3
      )
      return
    return
  return

_onLeader = =>
  _clear()

  if not ES
    ES = {}
    reconnect()

  INTERVAL = setInterval(
    =>
      if not _R
        return
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
        if n > synced
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
      return
    1e3
  )

  return

_clear = =>
  clearInterval INTERVAL
  ES?.close?()
  return

ON.add (leader)=>
  if leader
    LEADER = 1
    if _R
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
