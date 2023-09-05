> wac.tax/_/IDB.js
  wac.tax/_/leader.js > ON
  wac.tax/user/User.js > exit
  @w5/vite > b64VbyteE u64B64
  @w5/fetch-event-source > fetchEventSource
  ../conf > API
  wac.tax/user/User.js > onMe
  ./es.coffee:ES_MAP
  ./TABLE.coffee > SYNCED
  ./_sync.coffee:_sync
  ./SYNC_TABLE.coffee
  ./TOOL.coffee > prevIter
  ./COL.coffee > TS
  ./upgrade.coffee
  ./VER.coffee

# for i from [1195122, 1060177, 1195121, 1195125, 1195123, 858044, 118321, 1059456, 989581, 394934, 987658, 1308715, 808584, 1060180, 223179, 140472]
#   console.log 'http://localhost:5555/-'+b64VbyteE [2, i]


+ _R, _W, _DB,  PRE, UID, LEADER, ES_CLOSE

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
    ES_CLOSE?()
    _DB = _R = _W = undefined
    return

  [_DB,_R,_W] = await IDB['u-'+u64B64(UID)](
    VER
    {
      upgrade
    }
  )

  _sync(UID, _R, _W)

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

class ErrorClose extends Error


reconnect = (onopen)=>
  synced = new Map (await _R[SYNCED].getAll()).map((i)=>[i.p,i.n])

  # Event Source 无法获取响应状态吗，无法感知用户已经退出的401，所以改用 https://www.npmjs.com/package/@microsoft/fetch-event-source
  ctrl = new AbortController()

  ES_CLOSE = =>
    ES_CLOSE = undefined
    t = ctrl
    ctrl = new AbortController()
    t.abort()
    return

  es = fetchEventSource(
    API+'es/'+b64VbyteE(
      [
        UID
      ].concat await Promise.all SYNC_TABLE.map (_,p)=>
        synced.get(p) or 0
    )
    {
      signal: ctrl.signal
      credentials: 'include'
      onclose: =>
        if UID
          throw new ErrorClose
        return
      onopen: (r)=>
        switch r.status
          when 401
            UID = 0
            exit()
            return
          when 200
            return
        throw r
        return
      onmessage: (e)=>
        {data} = e
        if not data
          return
        # console.log data
        data = JSON.parse e.data
        [kind, user_id] = data
        data = data.slice(2)
        if user_id != UID
          return
        ES_MAP.get(kind)(
          _W, data, user_id
        )
        return
      onerror: (err) =>
        if not err instanceof ErrorClose
          console.error err
        return
    }
  )
  # es = new EventSource(
  #   API+'es/'+b64VbyteE(
  #     [
  #       UID
  #     ].concat await Promise.all SYNC_TABLE.map (_,p)=>
  #       synced.get(p) or 0
  #   )
  #   withCredentials:true
  # )
  #
  # close = es.close.bind(es)

  # es.onopen = =>
  #   ES = es
  #   onopen?()
  #   return
  #
  # es.onmessage = (e)=>
  #   data = JSON.parse e.data
  #   [kind, user_id] = data
  #   data = data.slice(2)
  #   if user_id != UID
  #     return
  #   ES_MAP.get(kind)(
  #     _W, data, user_id
  #   )
  #   return
  #
  # timer = setTimeout(
  #   =>
  #     reconnect close
  #     return
  #   94e3
  # )
  #
  # es.close = =>
  #   clearTimeout timer
  #   if es.readyState <= 1
  #     close()
  #     if UID and LEADER
  #       reconnect()
  #     else
  #       es = undefined
  #   return
  #
  # es.onerror = (event,err)=>
  #   console.log event,err
  #   clearTimeout timer
  #   close()
  #   setTimeout(
  #     =>
  #       reconnect(onopen)
  #       return
  #     1e3
  #   )
  #   return
  return


_onLeader = =>
  _clear()

  if not ES_CLOSE
    reconnect()

  return

_clear = =>
  ES_CLOSE?()
  return

ON.add (leader)=>
  if leader
    LEADER = 1
    if _R
      _onLeader()
    else
      _clear()
    # document.title = 'leader'
  else
    _clear()
    LEADER = undefined
    PRE = {}
    # document.title = ''
  return
