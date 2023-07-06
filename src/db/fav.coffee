> ./DB.coffee > R W
  ./TABLE.coffee > FAV FAV_STATE FAV_YM SUM
  wac.tax/user/User.js > Uid
  wac.tax/user/logined.js
  ./_.coffee > incr countIncr
  ./_/state.coffee > stateSet

< favPut = logined (uid, cid, rid, action)=>
  W(
    FAV,FAV_STATE
    FAV_YM,SUM
  ) (fav, fav_state, db_li...)=>
    now = new Date
    ctime = Math.floor(now)
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
