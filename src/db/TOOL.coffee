< bound = IDBKeyRange.bound

< getOr0 = (store, key)=>
  new Proxy(
    {}
    get:(_,attr)=>
      new Promise (resolve)=>
        t = await store.get(key)
        resolve if t then t[attr] else 0
        return
  )

_iter = (direction)=>
  (store, range)->
    c = await store.openCursor(range, direction)
    while c
      yield c.value
      c = await c.continue()
    return

< nextIter = _iter()

< PREV = 'prev'

< prevIter = _iter(PREV)

