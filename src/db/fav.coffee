> @w5/time/ms.js
  ../lib/IDB.coffee > R W FAV FAV_INDEX_UID_CID_RID_ID
  wac.tax/user/User.js > Uid
  wac.tax/user/logined.js

< favPut = logined (uid, cid, rid, action)=>
  W[FAV].put {
    id:ms()
    action
    rid
    cid
    uid
  }

< favGet = (cid, rid)=>
  action = 0
  uid = Uid()
  if uid
    begin = [uid,cid,rid,0]
    end = begin.slice()
    ++end[2]
    c = await R[FAV].index(
      FAV_INDEX_UID_CID_RID_ID
    ).openCursor(
      IDBKeyRange.bound(begin,end),'prev'
    )
    while c
      {action} = c.value
      break
      #console.log(c.key, c.value)
      # c = await c.continue()
    # if action
  return action
