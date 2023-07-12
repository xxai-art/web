> @w5/pair/group
  @w5/pair
  @w5/time/n2ym
  @w5/time/ymMs
  wac.tax/_/SDK.js
  ../lib/ym.coffee:time2ym
  ./TABLE.coffee > FAV SYNCED
  ./fav/toAll.coffee
  ./getOr0.coffee
  ./TOOL.coffee > prevIter nextIter bound PREV
  ./COL.coffee > TS

export default MAP = new Map

favSet = (fav, fav_state, t)=>
  [cid, rid, ctime, aid] = t

  begin = t.slice(0,3)
  end = begin.slice()
  end[1] += 1
  end[2] = 0
  c = (await fav.openCursor bound(begin, end),PREV)?.value
  await fav.put {
    cid
    rid
    ctime
    aid
  }
  if (not c) or ( c.aid != aid and c.ctime < ctime )
    stateSet(fav_state, cid, rid, aid)
  return

[
  [
    1 # KIND_SYNC_FAV
    (W, li)=>
      # [prev_id, last_id] = li.slice(0,2)
      # li = li.slice(2)
      # table = FAV
      # [synced, fav] = db_li = W(
      #   SYNCED
      #   table
      # )
      # if await getOr0(synced, table) == prev_id
      #   synced[table].put()
      # for t from group 4,li
      #   if not await fav.get t.slice(0,3)
      #     [cid, rid, ctime, aid] = t
      #     favSet fav, fav_state, t
      #     incr synced, FAV, {table}
      #     countIncr(
      #       db_li.slice(4)
      #       FAV
      #       new Date ctime
      #     )

      # synced_id.put {table,id:last_id}

      return
  ]
  # [
  #   2 # KIND_SYNC_FAV_BY_YEAR_MONTH
  #   (W, year_month, user_id)=>
  #     year_month = new Map pair year_month
  #     table = FAV
  #     [fav, fav_ym, sum] = W(
  #       table
  #       FAV_YM
  #       SUM
  #     )
  #     pre_sum = await getOr0(sum,table).n
  #
  #     sum_n = 0
  #
  #     ym_n = {}
  #     for await {id,n} from nextIter(fav_ym)
  #       real = year_month.get id
  #       sum_n += real
  #       if n == real
  #         year_month.delete id
  #       else
  #         ym_n[id] = n
  #
  #     ctime = fav.index TS
  #     to_srv = []
  #     for [ym, srv_n] from year_month.entries()
  #       n = 0
  #       li = [ym]
  #       for await i from prevIter ctime,bound ... ymMs ... n2ym ym
  #         ++n
  #         li.push ...Object.values i
  #
  #       diff = n - (ym_n[ym] or 0)
  #       if diff
  #         sum_n += diff
  #         await fav_ym.put {id:ym, n}
  #
  #       if n!=srv_n
  #         to_srv.push li
  #
  #     if to_srv.length
  #       to_insert = await SDK[FAV_YM] user_id,to_srv
  #       [fav, fav_state] = W(table, FAV_STATE)
  #       ym_n = new Map
  #       for t from group 4,to_insert
  #         t = t.map (i)=>Number(i)
  #         [cid, rid, ctime, aid] = t
  #         ym = time2ym new Date ctime
  #         ym_n.set ym, (ym_n.get(ym) or 0) + 1
  #         favSet fav, fav_state, t
  #
  #       if ym_n.size
  #         fav_ym = W[FAV_YM]
  #         for [ym,n] from ym_n.entries()
  #           sum_n += n
  #           fav_ym.put {
  #             id: ym
  #             n: n + await getOr0(fav_ym, ym).n
  #           }
  #
  #     diff = sum_n - pre_sum
  #     if diff
  #       sum = W[SUM]
  #       sum.put {
  #         table
  #         n:diff + await getOr0(sum,table).n
  #       }
  #       synced = W[SYNCED]
  #       synced.put {
  #         table
  #         n:Math.max(
  #           sum_n
  #           diff + await getOr0(synced,table).n
  #         )
  #       }
  #
  #     return
  # ]
].map ([id,func])=>
  MAP.set id, func
  return
