> ./HOOK.coffee:HOOK
  @w5/wasm > vbyteE
  ../DB.coffee > R
  ../TABLE.coffee > FAV_STATE
  wac.tax/user/User.js > onMe

export default (cid, rid, render)=>
  key = vbyteE [cid, rid]
  unbind_onme = onMe (user)=>
    if user.id
      R(FAV_STATE) (fav)=>
        render await fav.get(key)
        return
    else
      render()
    return

  HOOK.set key, render
  =>
    HOOK.delete key
    unbind_onme()
    return
