> @w5/pair/group
  # ~/lib/cidRidLi.coffee
  ~/db/fav/put.coffee:favPut
  # ~/db/seen/put.coffee:seenPut
  ~/db/TABLE.coffee > FAV SEEN SYNCED
  ~/db/SYNC_TABLE.coffee:@ > P_FAV P_SEEN
  ~/db/lastId.coffee
  ~/db/DB.coffee > W R

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

export default [

  # 收藏
  (r)=>
    nid = r.pop()
    pid = r.pop()
    R(SYNCED) (synced)=>
      if pid == await lastId(synced, P_FAV)
        W(FAV) (fav)=>
          console.log 'todo sync',r
          return
      return
    return

  # 浏览
  (r)=>
    # sync(r,3,P_SEEN, seenPut)
    # console.log '!!!',r
    return


]
