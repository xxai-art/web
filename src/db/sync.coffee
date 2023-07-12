> ./TABLE.coffee > FAV SYNCED TO_SYNC
  ./SYNC_TABLE.coffee
  ./getOr0.coffee
  ./TOOL.coffee > prevIter
  ./COL.coffee > TS
  @w5/pair/group

< (user_id, R, W)=>
  sync = (to_sync,table,li)=>
    last_id = await getOr0(R[SYNCED],table)
    r = (await SDK[table](
      user_id
      last_id
      ...li
    )).map Number
    id = r.pop()
    if id
      if await getOr0(R[TO_SYNC],table) == to_sync
        await W[TO_SYNC].delete table
      if await getOr0(R[SYNCED],table) == last_id
        t = W[table]
        for [cid,rid,ts,aid] from group 4,r
          await t.put {cid,rid,ts,aid}
        await W[SYNCED].put {table, n:id}
    return

  ing = []
  for table,pos in SYNC_TABLE
    n = to_sync = await getOr0(R[TO_SYNC], table)

    if n
      li = []
      for await i from prevIter R[table].index(TS)
        if n-- == 0
          break
        li = li.concat Object.values i
      ing.push sync(to_sync, table,li)
  return Promise.all ing
    #if pre

  # sum = read[SUM]
  # c = await sum.openCursor()
  # updated = []
  # while c
  #   {n, table} = c.value
  #   if PRE[table] != n
  #     updated.push [table, n]
  #     PRE[table] = n
  #   c = await c.continue()
  #
  # for [table, n] from updated
  #   synced = await getOr0(read[SYNCED],table).n
  #   if n > synced
  #     diff = n - synced
  #     # 拉出最后 diff 条，然后扔给服务器
  #
  #     li = []
  #     for await o from prevIter(read[table].index(TS))
  #       li.unshift Object.values o
  #       if -- diff == 0
  #         break
  #
  #     toSrv(table, user_id, write, li)
  #     write[SYNCED].put({
  #       table
  #       n
  #     })
