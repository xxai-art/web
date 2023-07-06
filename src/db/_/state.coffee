> @w5/wasm > vbyteE
  ./HOOK.coffee > hook

export stateSet = (store, cid, rid, action)=>
  key = vbyteE [cid, rid]
  pre = await store.get key
  if action
    if not pre
      o = {id:key}
      await store.put(o)
      hook key, o
  else if pre
    store.delete(key)
    hook key
  return




