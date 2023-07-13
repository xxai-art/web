> @w5/pair/group
  @w5/pair
  @w5/time/n2ym
  @w5/time/ymMs
  wac.tax/_/SDK.js
  ../lib/ym.coffee:time2ym
  ./TABLE.coffee > FAV SYNCED
  ./getOr0.coffee
  ./TOOL.coffee > prevIter nextIter bound PREV
  ./COL.coffee > TS
  ./dbsync.coffee
  ./fav/put.coffee

export default MAP = new Map [
  [
    1 # KIND_SYNC_FAV
    (W, li)=>
      await dbsync()
      [prev_id, last_id] = li.slice(0,2)
      li = li.slice(2)
      table = FAV
      [synced, db] = db_li = W(
        SYNCED
        table
      )
      if await getOr0(synced, table) == prev_id
        for t from group 4,li
          put db,...t
        synced.put {table, n:last_id}

      return
  ]
]
