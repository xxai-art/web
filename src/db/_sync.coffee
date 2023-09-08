> @w5/vite > binSet _vbyteE binMap
  wac.tax/_/SDK.js
  ./TOOL.coffee > prevIter
  ./COL.coffee > TS
  ./SYNC_TABLE.coffee
  ./lastId.coffee

_sync_ = (uid,R,W,table_pos)=>
  [
    table
    encode
    update
  ] = SYNC_TABLE[table_pos]
  li = []
  # 没写入远程的 id 为负数
  for await i from prevIter(
    R[table].index(TS)
    IDBKeyRange.upperBound(0)
  )
    delete i.ts
    li = li.concat Object.values i

  if not li.length
    return

  last_id = await lastId(R,table_pos)

  r = await SDK[table](
    uid
    last_id
    ...encode li
  )

  update W, R, li, r, last_id, table, table_pos
  return


ING = binMap()
AGAIN = binSet()

_sync = (uid,R,W,table_pos)=>
  key = _vbyteE [uid,table_pos]
  promise = ING.get key
  if promise
    AGAIN.add key
    return promise
  promise = _sync_(uid,R,W,table_pos).finally =>
    ING.delete key
    if AGAIN.has key
      AGAIN.delete key
      await _sync(uid,R,W,table_pos)
    return
  ING.set key,promise
  promise


< (uid, R, W, to_sync=[0...SYNC_TABLE.length])=>
  Promise.all to_sync.map (table_pos)=>
    _sync(uid, R, W, table_pos)



