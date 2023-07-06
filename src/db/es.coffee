> @w5/pair/group
  ./TABLE.coffee > FAV FAV_STATE FAV_YM FAV_Y SUM SYNCED SYNCED_ID
  ./_.coffee > incr countIncr
  ./_/state.coffee > stateSet

export default MAP = new Map

SYNC_FAV = 1

MAP.set(
  SYNC_FAV
  (W, li)=>
    last_id = li.pop()
    table = FAV
    [synced, synced_id, fav, fav_state] = db_li = W(
      SYNCED,
      SYNCED_ID,
      table
      FAV_STATE,FAV_YM,FAV_Y,SUM
    )
    for t from group 4,li
      if not await fav.get t.slice(0,3)
        [cid, rid, ctime, action] = t
        await fav.put {
          cid
          rid
          ctime
          action
        }
        incr synced, FAV, {table}
        countIncr(
          db_li.slice(4)
          FAV
          new Date ctime
        )
        begin = t.slice(0,3)
        end = begin.slice()
        end[1] += 1
        end[2] = 0
        c = await fav.openCursor IDBKeyRange.bound(begin, end),'prev'
        stateSet(fav_state, cid, rid, c.value.action)

    synced_id.put {table,id:last_id}

    return
)
