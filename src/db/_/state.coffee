
export stateSet = (store, cid, rid, action)=>
  key = vbyteE [cid, rid]
  pre = await store.get key
  if action
    if not pre
      store.put(id:key)
  else if pre
    store.delete(key)
  return




