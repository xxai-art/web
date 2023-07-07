> @w5/pair/group
  @w5/pair
  @w5/time/n2ym
  @w5/time/ymMs
  ./TABLE.coffee > FAV FAV_STATE FAV_YM SUM SYNCED SYNCED_ID
  ./_.coffee > incr countIncr
  ./_/state.coffee > stateSet
  ./TOOL.coffee > getOr0 nextIter

export default MAP = new Map

[
  [
    1 # KIND_SYNC_FAV
    (W, li)=>
      last_id = li.pop()
      table = FAV
      [synced, synced_id, fav, fav_state] = db_li = W(
        SYNCED
        SYNCED_ID
        table
        FAV_STATE
        FAV_YM,SUM
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
  ]
  [
    2 # KIND_SYNC_FAV_BY_YEAR_MONTH
    (W, year_month)=>
      year_month = new Map pair year_month
      table = FAV
      [fav, fav_ym, sum] = W(
        table
        FAV_YM
        SUM
      )
      pre_sum = await getOr0(sum,table).n

      sum_n = 0

      for await {id,n} from nextIter(fav_ym)
        real = year_month.get id
        sum_n += real
        if n == real
          null
          # year_month.delete id

      for ym from year_month.keys()
        console.log ymMs ... n2ym ym
      #   await get
      #   to_server = []
      #
      #   for iter
      #
      #   sum_n += to_server.length

      return
      diff = sum_n - pre_sum
      if diff
        W[SUM].put {table,n:sum_n}
        synced = W[SYNCED]
        synced.put {
          table
          n:Math.max(
            sum_n
            diff + getOr0(synced,table).n
          )
        }

      return
  ]
].map ([id,func])=>
  MAP.set id, func
  return
