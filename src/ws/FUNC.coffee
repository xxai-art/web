> @w5/pair/group
  msgpackr > unpack
  # ~/lib/cidRidLi.coffee
  ~/db/fav/put.coffee:favPut
  ~/db/seen/put.coffee:seenPut
  ~/db/TABLE.coffee > FAV SEEN SYNCED
  ~/db/SYNC_TABLE.coffee > P_FAV P_SEEN
  ~/db/lastId.coffee
  ~/db/DB.coffee > W R
  ./synced.coffee > done:同步完成

# sync = (r,group_n,p, func)=>
#   table = SYNC_TABLE[p]
#   r = r.map Number
#   n = r.pop()
#   if await lastId(R,p) == n
#     W(TABLE) (w)=>
#       for i from group group_n, r
#         await func w,...i
#       W(SYNCED).put {p,n}
#       return
#   return

numli = (r)=>
  unpack(r).map Number

export default [
  同步完成

  # 收藏
  (r)=>
    r = numli r
    n = r.pop()
    pid = r.pop()
    R(SYNCED) (synced)=>
      if pid == await lastId(synced, P_FAV)
        W(FAV, SYNCED) (fav, synced)=>
          ing = []
          for i from group 4,r
            ing.push favPut fav, ...i
          await Promise.all ing
          await synced.put {p:P_FAV, n}
          return
      return
    return

  # 浏览
  (r)=>
    r = numli r
    R(SYNCED) (synced)=>
      if r.pop() == await lastId(synced, P_SEEN)
        W(SEEN, SYNCED) (seen, synced)=>
          r = group 3,r
          len = r.length
          for i from r
            await seenPut seen, ...i
          await synced.put {p:P_SEEN, n:r[len-1][0]}
          return
      return
    return

]
