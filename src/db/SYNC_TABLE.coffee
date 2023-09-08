> ./TABLE.coffee > FAV SEEN

export P_FAV = 0
export P_SEEN = 1

export default [
  FAV
    # (li)=>
    #   li = li.map vbyteD
    #   result = []
    #   for rid_li from cidRidLi li
    #     t = [
    #       rid_li.shift()
    #     ]
    #     rid_li.sort()
    #     pre = 0
    #     for i from rid_li
    #       t.push i - pre
    #       pre = i
    #     result.push z85VbyteE t
    #   result
    #
    # (W, R, input, output, last_id, table, table_pos)=>
    #   output = output.map Number
    #   n = output.pop()
    #   w = W[table]
    #
    #   for i from group 3,output
    #     seenPut w,...i
    #
    #   for id from input
    #     o = await w.get id
    #     if o
    #       o.ts = -o.ts
    #       w.put o
    #
  SEEN
    #   W[SYNCED].put {p:P_SEEN, n}
    #   return
    # (li)=>li
    # (W, R, input, output, last_id, table, table_pos)=>
    #   ts = + new Date
    #   w = W[table]
    #   for [cid,rid,aid] from group 3, input.map(Number)
    #     favPut w,cid,rid,ts,aid
    #
    #   id = output.pop()
    #   if id
    #     if await lastId(R,table_pos) == last_id
    #       w = W[table]
    #       for [cid,rid,ts,aid] from group 4,output
    #         favPut w,cid,rid,ts,aid
    #       W[SYNCED].put {p:P_FAV, n:id}
    #   return
]


