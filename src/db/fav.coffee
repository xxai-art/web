> ./DB.coffee > R W
  ./TABLE.coffee > FAV FAV_STATE FAV_YM FAV_Y SUM
  wac.tax/user/User.js > Uid
  wac.tax/user/logined.js
  ./_.coffee > incr countIncr
  ./_/state.coffee > stateSet

< favPut = logined (uid, cid, rid, action)=>

  now = new Date
  ctime = Math.floor(now)

  W(
    FAV,FAV_STATE
    FAV_YM,FAV_Y,SUM
  ) (fav, fav_state, db_li...)=>

    Promise.all [
      fav.put {
        cid
        rid
        ctime
        action
      }
      countIncr(db_li, FAV, now)
      stateSet(fav_state, cid, rid, action)
    ]
