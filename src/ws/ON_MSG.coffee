> ~/db/SYNC_TABLE.coffee:@ > P_FAV P_SEEN
  ~/db/TOOL.coffee > prevIter
  ~/db/DB.coffee > R W
  ~/db/COL.coffee > TS
  @w5/vite > _vbyteE vbyteD

export default [
  (table_pos)=>
    table = SYNC_TABLE[table_pos]
    switch table_pos
      when P_FAV
        encode = _vbyteE
      when P_SEEN
        encode = (li)=>
          r = []
          for i from li
            r.push ...vbyteD(i)
          _vbyteE r

    R(table) (db)=>
      li = []
      for await i from prevIter(
        db.index(TS)
        IDBKeyRange.upperBound(0)
      )
        delete i.ts
        li.push ...Object.values i
      if not li.length
        return
      console.log table, encode li
      return
    return
]
