> @w5/pair/group
  @w5/pair
  @w5/time/n2ym
  @w5/time/ymMs
  wac.tax/_/SDK.js
  ../lib/ym.coffee:time2ym
  ./TABLE.coffee > FAV FAV_STATE FAV_YM SUM SYNCED SYNCED_ID
  ./_.coffee > incr countIncr
  ./_/state.coffee > stateSet
  ./TOOL.coffee > getOr0 prevIter nextIter bound PREV
  ./COL.coffee > CTIME

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
          c = await fav.openCursor bound(begin, end),PREV
          stateSet(fav_state, cid, rid, c.value.action)

      synced_id.put {table,id:last_id}

      return
  ]
  [
    2 # KIND_SYNC_FAV_BY_YEAR_MONTH
    (W, year_month, user_id)=>
      year_month = new Map pair year_month
      table = FAV
      [fav, fav_ym, sum] = W(
        table
        FAV_YM
        SUM
      )
      pre_sum = await getOr0(sum,table).n

      sum_n = 0

      ym_n = {}
      for await {id,n} from nextIter(fav_ym)
        real = year_month.get id
        sum_n += real
        if n == real and 0 # TODO remove
          year_month.delete id
        else
          ym_n[id] = n

      ctime = fav.index CTIME
      to_srv = []
      for [ym, srv_n] from year_month.entries()
        n = 0
        li = [ym]
        for await i from prevIter ctime,bound ... ymMs ... n2ym ym
          ++n
          li.push ...Object.values i

        diff = n - ym_n[ym]
        if diff
          sum_n += diff
          fav_ym.put {id:ym, n}

        if n!=srv_n or 1 # TODO remove
          to_srv.push li

      if to_srv.length
        to_insert = await SDK[FAV_YM] user_id,to_srv
        fav = W[table]
        ym_n = new Map
        for li from group 4,to_insert
          [cid, rid, ctime, action] = li.map (i)=>Number(i)
          ym = time2ym new Date ctime
          ym_n.set ym, (ym_n.get(ym) or 0) + 1
          # TODO add
          # fav.put {cid, rid, ctime, action}

        if ym_n.size
          fav_ym = W[fav_ym]
          for [ym,n] from ym_n.entries()
            sum_n += n
            fav_ym.put {
              id:ym
            }

      #   to_server = []
      #
      #   for iter
      #
      #   sum_n += to_server.length

      return
      diff = sum_n - pre_sum
      if diff
        sum = W[SUM]
        sum.put {
          table
          n:getOr0(sum,table).n + diff # 重新获取，因为上面同步添加收藏的时候可能变动
        }
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
