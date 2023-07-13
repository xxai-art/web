> ./DB.coffee > R W
  ./TABLE.coffee > FAV
  wac.tax/user/User.js > Uid
  wac.tax/user/logined.js
  ./fav/put.coffee
  ./sync.coffee

< favPut = logined (uid, cid, rid, aid)=>
  W(
    FAV
  ) ( fav )=>
    now = new Date
    put(
      fav
      cid
      rid
      Math.floor(now)
      aid
    )
    sync(FAV)
  return
