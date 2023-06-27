> @w5/time/ms.js
  ../lib/IDB.coffee > R W FAV FAV_INDEX_UID_CID_RID_ID FAV_STATE
  wac.tax/user/User.js > Uid
  wac.tax/user/logined.js
  @w5/vbyte/vbyteE

< favPut = logined (uid, cid, rid, action)=>
  key = vbyteE [uid, cid, rid]
  state = W[FAV_STATE]
  if action
    state.put(id:key)
  else
    state.delete(key)

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
    if await W[FAV_STATE].get vbyteE [uid, cid, rid]
      return true
  return



    # begin = [uid,cid,rid,0]
    # end = begin.slice()
    # ++end[2]
    # c = await R[FAV].index(
    #   FAV_INDEX_UID_CID_RID_ID
    # ).openCursor(
    #   IDBKeyRange.bound(begin,end),'prev'
    # )
    # while c
    #   {action} = c.value
    #   break
