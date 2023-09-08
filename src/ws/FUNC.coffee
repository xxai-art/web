> wac.tax/user/User.js > exitUid
  @w5/pair/group
  ~/lib/cidRidLi.coffee
  ~/db/fav/put.coffee:favPut
  ~/db/seen/put.coffee:seenPut
  ~/db/TABLE.coffee > FAV SEEN SYNCED
  ~/db/lastId.coffee

export default [
  # 退出登录
  (uid)->
    exitUid(uid)
    @close()
    return

  # 收藏
  (r)=>
    pid = r.pop()
    console.log r
    return

  # 浏览
  (r)=>
    pid = r.pop()
    console.log r
    return


]
