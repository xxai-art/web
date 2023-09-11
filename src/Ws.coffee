> ~/conf > API WS:WS_URL
  @w5/vite > u64B64 binU64 b64D _vbyteE
  @w5/u8 > u8merge
  ./ws/FUNC.coffee
  wac.tax/_/leader.js > ON:ON_LEADER
  wac.tax/user/User.js > exitUid
  ~/db/DB.coffee > R
  ~/db/TABLE.coffee > SYNCED
  ~/ws/CONST.coffee > 同步
  wac.tax/user/User.js > onMe
  wac.tax/_/channel.js > toAll hook

+ WS, TIMEOUT, UID, UNBIND_ON_ME

open = (ws)=>
  R(SYNCED) (synced)=>
    to_sync = await synced.getAll()
    li = []
    for {p,n} from to_sync
      li.push p,n
    ws.send 同步, _vbyteE li
    return
  # setTimeout(
  #   _run_sync
  #   6e3
  # )
  return

wsClose = =>
  WS?.close()
  return

ON_LEADER.add (leader)->
  console.log 'leader', leader
  if leader
    if not UNBIND_ON_ME
      UNBIND_ON_ME = onMe (user)=>
        UID = user.id
        _conn()
        return
  else
    console.log @#,@.postMessage
    if UNBIND_ON_ME
      UNBIND_ON_ME()
      UNBIND_ON_ME = undefined
      wsClose()
  return

_SEND = []

_send = send_push = (args...)=>
  _SEND.push args
  return

export send = (args...)=>
  _send ...args
  return

_conn = =>
  wsClose()
  if not UID
    return
  WS = new WebSocket(
    (
      if import.meta.env.DEV then 'ws:' else 'wss:'
    )+WS_URL+u64B64 UID
  )
  {close,send:ws_send} = WS

  WS.close = =>
    _send = send_push
    clearTimeout TIMEOUT
    try
      close.call(WS)
    WS = undefined
    return

  WS.send = (action, bin)=>
    ws_send.call WS, u8merge(
      [
        action
      ]
      bin
    )
    return

  Object.assign(
    WS
    binaryType: 'arraybuffer'
    onopen:=>
      while _SEND.length
        WS.send ..._SEND.pop()
      _send = WS.send
      open(WS)
      return

    onmessage:({data})=>
      data = new Uint8Array(data)
      if data.length
        msg = data
        FUNC[
          msg[0]
        ].call(WS,msg.slice(1))
      return

    # onerror: (err)=>
    #   console.error err
    #   return

    onclose: ({code, reason})=>
      if 4401 == code
        exitUid UID
        return
      if WS # 非主动关闭
        WS = undefined
        TIMEOUT = setTimeout(
          _conn
          1e3
        )
      return
  )
  return

