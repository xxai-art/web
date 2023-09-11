> ~/conf > API WS:WS_URL
  @w5/vite > u64B64 binU64 b64D _vbyteE
  @w5/u8 > u8merge
  ./ws/FUNC.coffee
  wac.tax/_/leader.js > ON:ON_LEADER
  wac.tax/user/User.js > exitUid
  ~/db/DB.coffee > R
  ~/db/SYNC_TABLE.coffee > P_FAV
  ~/db/TABLE.coffee > SYNCED
  ~/ws/SEND.coffee > 服务器传浏览器
  wac.tax/_/channel.js > toAll hook
  ~/const/channel.coffee > MSG_WS
  wac.tax/user/User.js > onMe
  ./ws/ON_MSG.coffee
  ~/ws/CHANNEL.coffee > 同步上传

+ WS, TIMEOUT, UID, UNBIND

open = (ws)=>
  R(SYNCED) (synced)=>
    to_sync = await synced.getAll()
    li = []
    for {p,n} from to_sync
      li.push p,n
    ws.send 服务器传浏览器, _vbyteE li
    return

  onMsg 同步上传,P_FAV
  return

_send = sendToAll = (args...)=>
  toAll MSG_WS, ...args
  return

export send = (args...)=>
  _send ...args
  return

wsClose = =>
  WS?.close()
  return

onMsg = (action, msg...)=>
  r = await ON_MSG[action] ...msg
  if r
    WS?.send ...r
  return

ON_LEADER.add (leader)->
  if leader
    if not UNBIND
      unbind = onMe (user)=>
        UID = user.id
        _conn()
        return
      unbind_hook = hook MSG_WS, onMsg
      UNBIND = =>
        unbind()
        unbind_hook()
        return
  else if UNBIND
    UNBIND()
    UNBIND = undefined
    wsClose()
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
    _send = sendToAll
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
      _send = onMsg
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

