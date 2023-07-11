> ./TABLE.coffee > FAV SYNCED TO_SYNC
  ./SYNC_TABLE.coffee

< (R,W)=>
  for table from SYNC_TABLE
    pre = await R[TO_SYNC].get table
    console.log {pre}
  return
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
