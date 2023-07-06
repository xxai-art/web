HOOK = new BinMap

export watch = (cid, rid, render)=>
  key = vbyteE [cid, rid]
  =>
    HOOK.set key, render
    =>
      HOOK.remove key

export stateSet = (store, cid, rid, action)=>
  key = vbyteE [cid, rid]
  pre = await store.get key
  if action
    if not pre
      store.put(id:key)
  else if pre
    store.delete(key)
  return




