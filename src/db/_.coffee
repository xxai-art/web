> ../lib/ym.coffee
  @w5/vbyte/vbyteE

export incr = (store, key, map)=>
  o = await store.get key
  if o
    o.n += 1
  else
    o = {n:1,...map}
  store.put o
  return

export countIncr = (store_li, table, now)=>
  [y,m] = ym now
  Promise.all [
    [
      [y, m], {y,m}
    ]
    [
      [y]
      {y}
    ]
    [
      table
      {
        table
      }
    ]
  ].map (m,p)=> incr(store_li[p],...m)

export stateSet = (store, cid, rid, action)=>
  key = vbyteE [cid, rid]
  pre = await store.get key
  if action
    if not pre
      store.put(id:key)
  else if pre
    store.delete(key)
