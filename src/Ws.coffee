> ~/conf > API WS:WS_URL
  @w5/vite > u64B64 binU64 b64D _vbyteE
  @w5/u8 > u8merge
  ./ws/FUNC.coffee
  wac.tax/_/leader.js > ON
  wac.tax/user/User.js > exitUid
  ~/db/DB.coffee > R
  ~/db/TABLE.coffee > SYNCED
  ~/ws/CONST.coffee > 同步
  wac.tax/user/User.js > onMe

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

ON.add (leader)=>
  if leader
    if not UNBIND_ON_ME
      UNBIND_ON_ME = onMe (user)=>
        UID = user.id
        _conn()
        return
  else if UNBIND_ON_ME
    UNBIND_ON_ME()
    UNBIND_ON_ME = undefined
    wsClose()
  return

_SEND = []

export send = (args...)=>
  if WS
    WS.send ...args
  else
    _SEND.push args
  return

export wsClose = =>
  WS?.close()
  return


_conn = =>
  WS?.close()
  if not UID
    return
  WS = new WebSocket(
    (
      if import.meta.env.DEV then 'ws:' else 'wss:'
    )+WS_URL+u64B64 UID
  )
  {close,send:_send} = WS

  WS.close = =>
    clearTimeout TIMEOUT
    try
      close.call(WS)
    WS = undefined
    return

  WS.send = (action, bin)=>
    _send.call WS, u8merge(
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



# import URI from "~/config/ws.txt"
# import {unpack} from 'msgpackr'
# import { ntob, bton } from '@1ky/n64'
# import me_id from '~/ws/me/id'
# import net from '~/coffee/ref/net'
#
# TAB_ID = localStorage.WS = ntob(1+bton(localStorage.WS or '')%0x1fffffffffffff)
# export ID = localStorage.I + ":" + TAB_ID
#
# TIMEOUT = 9000
#
# _new_ws = (self, resolve)=>
#   ws = new WebSocket(URI+ID)
#
#   timer = setTimeout(
#     =>
#       ws.close()
#     TIMEOUT
#   )
#
#   Object.assign ws,{
#     binaryType: 'arraybuffer'
#     onmessage:({data})=>
#       li = unpack new Uint8Array(data)
#       method = li.shift()
#       if method != "me/id"
#         return
#
#       clearTimeout timer
#       me_id(...li)
#       ws.onmessage = ({data})=>
#         li = unpack new Uint8Array(data)
#         method = li.shift()
#         (await import("~/ws/"+method)).default(...li)
#         return
#       self.ws = ws
#       delete self.err
#       net.value = 1
#       resolve()
#       return
#
#     onclose:(err)=>
#       self.err = 1+(self.err or 0)
#       if self.err > 3
#         net.value = 0
#       clearTimeout timer
#       delete self.ws
#       setTimeout(
#         =>
#           _new_ws(self,resolve)
#         TIMEOUT
#       )
#       return
#
#     onopen:=>
#       return
#   }
#
#
# new_ws = (self)=>
#   new Promise (resolve)=>
#     _new_ws self, resolve
#
# export default WS = {}
#
# export init = =>
#   await new_ws(WS)
