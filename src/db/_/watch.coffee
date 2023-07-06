> ./HOOK.coffee:HOOK
  @w5/wasm > vbyteE
  ../DB.coffee > R
  ../TABLE.coffee > FAV
  wac.tax/user/User.js > onMe

export default (cid, rid, render)=>
  key = vbyteE [cid, rid]
  =>
    unbind_onme = onMe (user)=>
      if user.id
        R(FAV) (fav)=>
          render await fav.get(key)
      else
        render()
      return

    HOOK.set key, render
    =>
      HOOK.remove key
      unbind_onme()
      return
