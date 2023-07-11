> wac.tax/_/IDB.js
  wac.tax/_/leader.js > ON
  @w5/wasm > b64VbyteE u64B64
  ../conf > API
  wac.tax/user/User.js > onMe
  ./toSrv.coffee
  ./es.coffee:ES_MAP
  ./TABLE.coffee > FAV FAV_YM SYNCED
  ./SYNC_TABLE.coffee
  ./TOOL.coffee > getOr0 prevIter
  ./COL.coffee > CTIME
  ./upgrade.coffee

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

onMe (user)=>
  UID = user.id or 0
  PRE = {}

  _DB?.close()

  if not UID
    _DB = _R = _W = undefined
    return

  [_DB,_R,_W] = await IDB['u-'+u64B64(UID)](
    1 # version
    upgrade
  )

  # for t from [SUM,SYNCED]
  #   await _W[t].put {table:FAV, n:3}
  # await _W[FAV].delete [2, 215060, 1688551713546]
  # await _W[FAV].put {cid:2, rid:215060, ctime:Math.floor(new Date), action:0}

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
  R(SYNCED) (synced)=>
    t = [UID]

    for table from SYNC_TABLE
      id = synced.get(table)

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
      data = JSON.parse e.data
      [kind, user_id] = data
      data = data.slice(2)
      if user_id != UID
        return
      ES_MAP.get(kind)(
        _W, data, user_id
      )
      return

    timer = setTimeout(
      =>
        reconnect close
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
      user_id = UID
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
        synced = await getOr0(read[SYNCED],table).n
        if n > synced
          diff = n - synced
          # 拉出最后 diff 条，然后扔给服务器

          li = []
          for await o from prevIter(read[table].index(CTIME))
            li.unshift Object.values o
            if -- diff == 0
              break

          toSrv(table, user_id, write, li)
          write[SYNCED].put({
            table
            n
          })
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
