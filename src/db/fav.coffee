> ./DB.coffee > R W
  ./TABLE.coffee > FAV FAV_STATE FAV_YM FAV_Y SUM
  wac.tax/user/User.js > Uid
  wac.tax/user/logined.js
  @w5/vbyte/vbyteE
  ../lib/ym.coffee

ms = =>
  Math.floor new Date

stateSet = (store, cid, rid, action)=>
  key = vbyteE [cid, rid]
  if action then store.put(id:key) else store.delete(key)

_countIncr = (store, key, map)=>
  o = await store.get key
  if o
    o.n += 1
  else
    o = {n:1,...map}
  store.put o
  return

countIncr = (table, y, m)=>
  store_li = W FAV_YM, FAV_Y, SUM
  Promise.all [
    [
      [y, m], {y,m}
    ]
    [
      [y]
      {y}
    ]
    [
      table
      {
        table
      }
    ]
  ].map (m,p)=> _countIncr(store_li[p],...m)


< favPut = logined (uid, cid, rid, action)=>
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

  now = new Date
  ctime = Math.floor(now)
  [year,month] = ym now

  [
    fav
    state
  ] = W FAV, FAV_STATE

  Promise.all [
    fav.put {
      cid
      rid
      ctime
      action
    }
    countIncr(FAV, year, month)
    stateSet(state, cid, rid, action)
  ]


< favGet = (cid, rid)=>
  uid = Uid()
  if uid
    return await R[FAV_STATE].get vbyteE [
      cid, rid
    ]
  return

# # favSync [时间戳, uid, cid, rid, action]
# < favSync = (row)=> # id 是操作的时间戳
#   [uid, cid, rid, ctime, action] = row
#   await W[FAV].put({uid, cid, rid, ctime, action})
#
#   row[3] = 0
#   row.pop()
#
#   begin = row # [uid,cid,rid,0]
#   end = begin.slice()
#   ++end[2]
#   #   const myIndex = objectStore.index("lName");
#
#   c = await R[FAV].openCursor(
#     IDBKeyRange.bound(begin,end),'prev'
#   )
#
#   if c
#     {uid,cid,rid,action} = c.value
#     return stateSet(W[FAV_STATE],uid,cid,rid,action)
# # while c
# #   console.log c.value
# #   c = await c.continue()
#   return
