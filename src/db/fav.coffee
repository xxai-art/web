> ./DB.coffee > R W
  ./TABLE.coffee > FAV TO_SYNC
  wac.tax/user/User.js > Uid
  wac.tax/user/logined.js
  ./fav/toAll.coffee
  ./fav/rm.coffee
  ./getOr0.coffee
  ./sync.coffee

< favPut = logined (uid, cid, rid, aid)=>
  W(
    FAV
    TO_SYNC
  ) ( fav, to_sync, fav_ym )=>
    now = new Date
    await rm(fav, cid, rid)
    fav.put {
      cid
      rid
      ts: Math.floor(now)
      aid
    }

    to_sync.put {
      table: FAV
      n:await getOr0(to_sync,FAV)+1
    }
    toAll(cid, rid, aid)
    sync()
  return
