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

< (store, cid, rid, aid)=>
  key = vbyteE [cid, rid]
  pre = await store.get key
  if aid
    if not pre
      await store.put {id:key}
      send key, 1
  else if pre
    store.delete(key)
    send key
  return
