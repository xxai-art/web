> wac.tax/_/IDB.js
  wac.tax/_/leader.js > ON
  @w5/wasm > b64VbyteE u64B64
  ../conf > API
  wac.tax/user/User.js > onMe
  ./es.coffee:ES_MAP
  ./TABLE.coffee > SYNCED
  ./_sync.coffee
  ./SYNC_TABLE.coffee
  ./TOOL.coffee > prevIter
  ./COL.coffee > TS
  ./upgrade.coffee

+ _R, _W, _DB,  PRE, UID, LEADER, ES

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

export default =>
  [
    UID
    _R
    _W
  ]


export R = (args...)=>
  (next)=>
    _rw(args, next, _R, _R_PENDING)

_W_PENDING = []

export W = (args...)=>
  (next)=>
    _rw(args, next, _W, _W_PENDING)

onMe (user)=>
  if _DB
    _db = _DB
    _sync(UID,_R,_W).finally =>
      _db.close()
      return

  UID = user.id or 0
  PRE = {}

  if not UID
    _DB = _R = _W = undefined
    return

  [_DB,_R,_W] = await IDB['u-'+u64B64(UID)](
    1 # version
    {
      upgrade
    }
  )
  _sync(UID, _R, _W)
  # for t from [SUM,SYNCED]
  #   await _W[t].put {table:FAV, n:3}
  # await _W[FAV].delete [2, 215060, 1688551713546]
  # await _W[FAV].put {cid:2, rid:215060, ctime:Math.floor(new Date), aid:0}

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
  synced = _R[SYNCED]
  es = new EventSource(
    API+'es/'+b64VbyteE(
      [
        UID
      ].concat await Promise.all SYNC_TABLE.map (table)=>
        r = await synced.get(table)
        if r
          return r.id
        return 0
    )
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


_onLeader = =>
  _clear()

  if not ES
    ES = {}
    reconnect()

  return

_clear = =>
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
