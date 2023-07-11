> ./DB.coffee > R W
  ./TABLE.coffee > FAV TO_SYNC
  wac.tax/user/User.js > Uid
  wac.tax/user/logined.js
  ./fav/toAll.coffee
  ./fav/rm.coffee
  ./getOr0.coffee

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

  # W(
  #   FAV,FAV_STATE
  #   FAV_YM,SUM
  # ) (fav, fav_state, db_li...)=>
  #   now = new Date
  #   ctime = Math.floor(now)
  #   Promise.all [
  #     fav.put {
  #       cid
  #       rid
  #       ctime
  #       aid
  #     }
  #     countIncr(db_li, FAV, now)
  #     stateSet(fav_state, cid, rid, aid)
  #   ]
  return
