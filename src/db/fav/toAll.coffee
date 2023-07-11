> @w5/wasm > vbyteE
  ./HOOK.coffee > hook
  wac.tax/_/channel.js > toAll hook:channelHook

MSG_FAV = 1024

channelHook MSG_FAV, (key, aid)=>
  hook key, aid
  return

send = (key, val)=>
  hook key, val
  toAll MSG_FAV, key, val

< (cid, rid, aid)=>
  key = vbyteE [cid, rid]
  send key, aid
  return
