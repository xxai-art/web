> @w5/pair/group
  ./TABLE.coffee > FAV FAV_STATE FAV_YM FAV_Y SUM SYNCED SYNCED_ID
  ./_.coffee > incr countIncr stateSet

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
        console.log {cid, rid, ctime, action}
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
        fav_state.put(c.value.action)
  # return favSync [uid, cid, rid, ms(),action]
  # begin = [cid,rid,0]
  # end = begin.slice()
  # end[1]+=1
  # c = await R[FAV].openCursor(
  #   IDBKeyRange.bound(begin,end),'prev'
  # )
  # if c
  #   {value} = c
  #   if value.action == action
  #     # w = W[FAV]
  #     # w.delete [value.cid,value.rid,value.ctime]
  #     # value.ctime = ms()
  #     # w.put(value)
  #     return 1

    synced_id.put {table,id:last_id}

    return
)
