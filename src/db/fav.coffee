> @w5/time/ms.js
  ../lib/IDB.coffee > R W FAV FAV_STATE
  wac.tax/user/User.js > Uid
  wac.tax/user/logined.js
  @w5/vbyte/vbyteE

stateSet = (store, uid, cid, rid, action)=>
  key = vbyteE [uid, cid, rid]
  if action then store.put(id:key) else store.delete(key)

< favPut = logined (uid, cid, rid, action)=>
  # return favSync [uid, cid, rid, ms(),action]
  [fav,state] = W FAV, FAV_STATE
  fav.put {
    uid
    cid
    rid
    ctime:ms()
    action
  }
  stateSet(state, uid, cid, rid, action)

< favGet = (cid, rid)=>
  uid = Uid()
  if uid
    return await R[FAV_STATE].get vbyteE [uid, cid, rid]
  return

# favSync [时间戳, uid, cid, rid, action]
< favSync = (row)=> # id 是操作的时间戳
  [uid, cid, rid, ctime, action] = row
  await W[FAV].put({uid, cid, rid, ctime, action})

  row[3] = 0
  row.pop()

  begin = row # [uid,cid,rid,0]
  end = begin.slice()
  ++end[2]
  c = await R[FAV].openCursor(
    IDBKeyRange.bound(begin,end),'prev'
  )

  if c
    {uid,cid,rid,action} = c.value
    return stateSet(W[FAV_STATE],uid,cid,rid,action)
# while c
#   console.log c.value
#   c = await c.continue()
  return
