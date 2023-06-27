> @w5/time/ms.js
  ../lib/IDB.coffee > R W FAV FAV_INDEX_UID_CID_RID_ID FAV_STATE
  wac.tax/user/User.js > Uid
  wac.tax/user/logined.js
  @w5/vbyte/vbyteE

stateSet = (uid, cid, rid, action)=>
  key = vbyteE [uid, cid, rid]
  state = W[FAV_STATE]
  if action then state.put(id:key) else state.delete(key)

< favPut = logined (uid, cid, rid, action)=>
  stateSet(uid, cid, rid, action)
  W[FAV].put {
    id:ms()
    action
    rid
    cid
    uid
  }

< favGet = (cid, rid)=>
  uid = Uid()
  if uid
    return await W[FAV_STATE].get vbyteE [uid, cid, rid]
  return

# favSync [时间戳, uid, cid, rid, action]
< favSync = (row)=> # id 是操作的时间戳
  [id, uid, cid, rid, action] = row
  await W[FAV].put({id, uid, cid, rid, action})

  row[4] = 0
  row.shift()
  begin = row # [uid,cid,rid,0]
  end = begin.slice()
  ++end[2]
  c = await R[FAV].index(
    FAV_INDEX_UID_CID_RID_ID
  ).openCursor(
    IDBKeyRange.bound(begin,end),'prev'
  )

  if c
    {uid,cid,rid,action} = c.value
    return stateSet(uid,cid,rid,action)
# while c
#   console.log c.value
#   c = await c.continue()
  return
