> @w5/pair/group
  ./TABLE.coffee > FAV FAV_STATE FAV_YM FAV_Y SUM

export default MAP = new Map

SYNC_FAV = 1
MAP.set(
  SYNC_FAV
  (W, li)=>
    last_id = li.pop()
    [fav,fav_state,fav_ym,fav_y,sum] = W(
      FAV,FAV_STATE,FAV_YM,FAV_Y,SUM
    )
    for t from group 4,li
      if not await fav.get t.slice(0,3)
        [cid, rid, ctime, action] = t
        console.log {cid, rid, ctime, action}
        # fav.put {
        #   cid
        #   rid
        #   ctime
        #   action
        # }

    return
)
