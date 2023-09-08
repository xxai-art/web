> @w5/pair/group
  @w5/pair
  @w5/time/n2ym
  @w5/vite > z85VbyteD
  @w5/time/ymMs
  ../lib/ym.coffee:time2ym
  ./SYNC_TABLE.coffee > P_FAV P_SEEN
  ./TABLE.coffee > FAV SYNCED SEEN
  ./getOr0.coffee
  ./TOOL.coffee > prevIter nextIter bound PREV
  ./COL.coffee > TS
  ./sync.coffee
  ./fav/put.coffee:favPut
  ./seen/put.coffee:seenPut

export default MAP = new Map [
  [
    1 # KIND_SYNC_FAV
    (W, li)=>
      [prev_id,n] = li.slice(0,2)
      li = li.slice 2
      [synced, db] =  W(SYNCED, FAV)
      if prev_id == await getOr0(synced, P_FAV)
        for t from group 4,li
          favPut db,...t
        synced.put {p:P_FAV, n}

      return
  ]
  [
    2 # KIND_SYNC_SEEN
    (W, li)=>
      prev_id = li.shift()
      [synced, db] =  W(SYNCED, SEEN)
      if prev_id == await getOr0(synced, P_SEEN)
        n = li[0]
        if Number.isInteger n
          n = prev_id + n
          ts = n
          for rid_li from li.slice(1).map (i)=>[...z85VbyteD(i)]
            cid = rid_li.pop()
            pre = 0
            for rid from rid_li
              seenPut db,ts--,cid,rid+pre
        else
          n = 0
          for ts_rid_li from li.map (i)=>[...z85VbyteD(i)]
            cid = ts_rid_li.pop()
            ts = 0
            for [t,rid] from pair ts_rid_li
              ts = t + ts
              seenPut db,ts,cid,rid
            n = Math.max n,ts
        synced.put {p:P_SEEN,n}
      return
  ]
]
