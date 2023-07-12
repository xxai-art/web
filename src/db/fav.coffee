> ./DB.coffee > R W
  ./TABLE.coffee > FAV
  wac.tax/user/User.js > Uid
  wac.tax/user/logined.js
  ./fav/put.coffee
  ./fav/rm.coffee
  ./sync.coffee

< favPut = logined (uid, cid, rid, aid)=>
  W(
    FAV
  ) ( fav )=>
    now = new Date
    await rm(fav, cid, rid)
    put(
      fav
      cid
      rid
      Math.floor(now)
      aid
    )
    sync(FAV)
  return
