> ~/db/SYNC_TABLE.coffee:@ > P_FAV P_SEEN
  ~/db/TABLE.coffee > SYNCED
  ~/db/TOOL.coffee > prevIter
  ~/db/DB.coffee > R W
  ~/db/COL.coffee > TS
  ~/db/lastId.coffee
  ../SEND.coffee > 浏览器传服务器
  @w5/vite > _vbyteE vbyteD

cid_rid = (li)=>
  m = new Map
  for i from li
    [cid] = i
    pre = m.get(cid)
    if not pre
      pre = [0,[]]
      m.set cid, pre
    pre[0] += 1
    pre[1].push ...i.slice(1)
  r = []
  for [k,v] from m.entries()
    r.push k,v[0],...v[1]
  r

export default (table_pos)=>
  table = SYNC_TABLE[table_pos]
  switch table_pos
    when P_FAV
      encode = (li)=>
        cid_rid li
    when P_SEEN
      encode = (li)=>
        cid_rid li.map ([i])=>vbyteD(i)

  new Promise (resolve)=>
    R(table) (db)=>
      li = []
      for await i from prevIter(
        db.index(TS)
        IDBKeyRange.upperBound(0)
      )
        delete i.ts
        li.push Object.values i
      if li.length
        R(SYNCED) (synced)=>
          li = encode li
          li.push(
            await lastId(synced, table_pos)
            table_pos
          )
          resolve [浏览器传服务器, _vbyteE li]
          return
        return
      resolve()
      return
