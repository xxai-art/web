> ./DB.coffee > R W
  ./TABLE.coffee > FAV FAV_YM TO_SYNC
  wac.tax/user/User.js > Uid
  wac.tax/user/logined.js
  ./_.coffee > countIncr
  ./_/state.coffee > stateSet
  ./favRm.coffee

< favPut = logined (uid, cid, rid, aid)=>
  W(
    FAV
    TO_SYNC
    FAV_YM
  ) ( fav, to_sync, fav_ym )=>
    now = new Date
    fav.put {
      cid
      rid
      ctime: Math.floor(now)
      aid
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
  #       action
  #     }
  #     countIncr(db_li, FAV, now)
  #     stateSet(fav_state, cid, rid, action)
  #   ]
  return
