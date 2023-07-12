> ./DB.coffee > R W
  ./TABLE.coffee > FAV
  wac.tax/user/User.js > Uid
  wac.tax/user/logined.js
  ./fav/toAll.coffee
  ./fav/rm.coffee
  ./sync.coffee

< favPut = logined (uid, cid, rid, aid)=>
  W(
    FAV
  ) ( fav )=>
    now = new Date
    await rm(fav, cid, rid)
    fav.put {
      cid
      rid
      ts: Math.floor(now)
      aid
    }

    toAll(cid, rid, aid)
    sync(FAV)
  return
