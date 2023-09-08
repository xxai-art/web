> ~/conf > API
  @w5/vite > u64B64
  msgpackr > unpack pack
  ./WS_FUNC.coffee
  wac.tax/_/leader.js > ON

+ WS

_SEND = []

export send = (args...)=>
  args = pack args
  if WS
    WS.send args
  else
    _SEND.push args
  return

export default (uid, open)=>
  WS?.close()
  WS = new WebSocket(
    (
      if import.meta.env.DEV then 'ws:' else 'wss:'
    )+API+'ws/'+u64B64(uid)
  )
  {close} = WS
  WS.close = =>
    close.call(WS)
    WS = undefined
    return

  Object.assign(
    WS
    binaryType: 'arraybuffer'

    onopen:=>
      while _SEND.length
        WS.send _SEND.pop()
      open.call(WS)
      return

    onmessage:({data})=>
      msg = unpack new Uint8Array(data)
      console.log msg
      WS_FUNC[
        msg[0]
      ].apply(WS,msg.slice(1))
      return

    onclose: =>
      if WS # 非主动关闭
        WS = undefined
        setTimeout(
          =>
            conn(uid, open)
            return
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
