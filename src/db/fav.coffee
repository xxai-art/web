> ./DB.coffee > R W
  ./TABLE.coffee > FAV FAV_STATE FAV_YM FAV_Y SUM
  wac.tax/user/User.js > Uid
  wac.tax/user/logined.js
  @w5/wasm > vbyteE
  ./_.coffee > incr countIncr
  ./_/state.coffee > stateSet

< favPut = logined (uid, cid, rid, action)=>

  now = new Date
  ctime = Math.floor(now)

  [
    fav
    fav_state
  ] = db_li = W FAV,FAV_STATE,FAV_YM,FAV_Y,SUM

  Promise.all [
    fav.put {
      cid
      rid
      ctime
      action
    }
    countIncr(db_li.slice(2), FAV, now)
    stateSet(fav_state, cid, rid, action)
  ]



