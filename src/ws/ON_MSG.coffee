> ~/db/SYNC_TABLE.coffee:@ > P_FAV P_SEEN
  ~/db/TABLE.coffee > SYNCED
  ~/db/TOOL.coffee > prevIter
  ./SEND.coffee > 浏览器传服务器
  ~/db/DB.coffee > R W
  ~/db/COL.coffee > TS
  ~/db/lastId.coffee
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

    new Promise (resolve)=>
      R(table) (db)=>
        li = []
        for await i from prevIter(
          db.index(TS)
          IDBKeyRange.upperBound(0)
        )
          delete i.ts
          li.push ...Object.values i
        if li.length
          R(SYNCED) (synced)=>
            li.push(
              await lastId(synced, table_pos)
              table_pos
            )
          result = [浏览器传服务器, encode li]
        resolve result
        return
]
