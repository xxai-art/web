> ./DB.coffee > R W
  ./TABLE.coffee > FAV
  ./SYNC_TABLE.coffee > P_FAV
  wac.tax/user/logined.js
  ./fav/put.coffee
  ./sync.coffee
  ~/const/action/FAV.coffee:ACTION_FAV
  ~/const/action/FAV_RM.coffee
  ~/db/qLog.coffee

< favPut = logined (uid, cid, rid, aid)=>
  qLog(
    [FAV_RM, ACTION_FAV][aid]
    cid
    rid
  )
  W(
    FAV
  ) ( fav )=>
    put(
      fav
      cid
      rid
      0
      aid
    )
    sync(P_FAV)
  return
