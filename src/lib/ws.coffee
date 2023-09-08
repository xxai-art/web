> ~/conf > API
  msgpackr > unpack
  ./WS_FUNC.coffee

export default (url)=>
  ws = new WebSocket(
    (
      if import.meta.env.DEV then 'ws:' else 'wss:'
    )+url
  )
  Object.assign(
    ws
    binaryType: 'arraybuffer'
    onopen:(ev)=>
      console.log 'open',ev
      return

    onerror: (err)=>
      console.log 'err',err
      return

    onmessage:({data})=>
      msg = unpack new Uint8Array(data)
      WS_FUNC[
        msg[0]
      ](...msg.slice(1))
      return

    onclose: (ev)=>
      console.log 'close',ev
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
