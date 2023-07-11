< bound = IDBKeyRange.bound


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

