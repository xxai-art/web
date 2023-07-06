> ../lib/ym.coffee
  @w5/wasm > vbyteE BinMap

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

