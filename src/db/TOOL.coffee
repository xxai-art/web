< getOr0 = (store, key)=>
  new Proxy(
    {}
    get:(_,attr)=>
      new Promise (resolve)=>
        t = await store.get(key)
        if t then t[attr] else 0
  )

_iter = (direction)=>
  (store, range)->
    c = store.openCursor(range, direction)
    while c
      yield c.value
      c = await c.continue()
    return

< nextIter = _iter()

< prevIter = _iter('prev')
