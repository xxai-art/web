> ./HOOK.coffee:HOOK
  @w5/wasm > vbyteE
  ../DB.coffee > R
  ../TABLE.coffee > FAV
  wac.tax/user/User.js > onMe

export default (cid, rid, render)=>
  key = vbyteE [cid, rid]
  unbind_onme = onMe (user)=>
    if user.id
      R(FAV) (fav)=>
        render (await fav.get([cid,rid]))?.aid
        return
    else
      render()
    return

  set = HOOK.get key
  if not set
    HOOK.set key, new Set([render])
  else
    set.add render

  =>
    s = HOOK.get(key)
    if s.size == 1
      HOOK.delete key
    else
      s.delete render

    unbind_onme()
    return
