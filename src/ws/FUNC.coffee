> wac.tax/user/User.js > exitUid

export default [
  # 退出登录
  (uid)->
    exitUid(uid)
    @close()
    return

  # 同步
  (r)=>
    console.log r
    return

]
