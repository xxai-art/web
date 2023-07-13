<script lang="coffee">
> # @w5/wasm > b64VbyteE
  # ./lib/CID.coffee > CID_USER
  svelte > onMount
  ./nav/User.svelte:Nav
  ./lib/topfix.coffee
  wac.tax/user/User.js
  ./db/DB.coffee > R
  ./db/TABLE.coffee > FAV
  ./db/COL.coffee > TS
  ./db/TOOL.coffee > prevIter

< ID

+ nav, b, name

onMount =>
  user = await User()
  if user.id == ID

    R(FAV) (fav)=>
      cid_rid = new Map
      #n = 0
      for await {cid,aid,rid,ts} from prevIter fav.index(TS)
        if aid
          li = cid_rid.get(cid)
          if not li
            li = []
            cid_rid.set cid, li
          li.push rid
          #++n
          #if n == 100
          #  cid_rid = new Map
          #  n = 0
      all = []
      for [cid, li] from cid_rid.entries()
        li.unshift cid
        all.push li
      console.log await SDK.meta all
      name = user.name
      return
  else
    console.log 'not me'
  return topfix nav, b
</script>

<template lang="pug">
b
  nav(@&nav)
    +if name
      Nav(name:)
  b(@&b)
</template>

<style lang="stylus">
@import './nav/body.styl'
</style>

