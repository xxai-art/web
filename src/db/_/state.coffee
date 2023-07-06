> @w5/wasm > vbyteE
  ./HOOK.coffee > hook
  wac.tax/_/channel.js > toAll hook:channelHook

MSG_FAV = 1024

channelHook MSG_FAV, (key, action)=>
  hook key, action
  return

send = (key, val)=>
  hook key, val
  toAll MSG_FAV, key, val

export stateSet = (store, cid, rid, action)=>
  key = vbyteE [cid, rid]
  pre = await store.get key
  if action
    if not pre
      await store.put {id:key}
      send key, 1
  else if pre
    store.delete(key)
    send key
  return
