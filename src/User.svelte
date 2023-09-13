<script lang="coffee">
> svelte > onMount
  wac.tax/_/SDK.js
  @w5/vite > vbyteD binSet _vbyteE b64VbyteD
  lodash-es > debounce
  ./img/Li.svelte
  ./db/fav/toAll.coffee > favHook
  ./db/COL.coffee > TS
  ./db/DB.coffee > R
  ./db/TABLE.coffee > FAV
  ./db/TOOL.coffee > prevIter bound
  ./lib/topfix.coffee
  ./nav/User.svelte:Nav
  ./const/IMG_LI_LIMIT.coffee
  ~/ws/synced.coffee
  wac.tax/user/User.js
  @w5/fall

ID = b64VbyteD(location.pathname.slice(2))[1]

+ LI, nav, b, name, TIMER

TMP = []

render = debounce(
  =>
    LI?.unshift TMP.reverse()
    TMP = []
    return
  100
)

EXIST = binSet()

onMount =>
  user = await User()
  result = [
    topfix nav, b
  ]
  if user.id == ID
    name = user.name
    LI.pull do =>
      + range

      ts = 0
      =>
        await synced
        # await (await import('~/ws/synced.coffee')).default
        R(FAV) (fav)=>
          li = []
          n = IMG_LI_LIMIT
          for await {
            cid,rid,aid,ts
          } from prevIter fav.index(TS),range
            if aid
              cr = [cid, rid]
              EXIST.add _vbyteE cr
              li.push cr
              if not --n
                break
          if ts
            range = bound(0, ts, true, true)
          return [li, not n]

    result.push [
      favHook (key, action)=>
        if action and not EXIST.has key
          EXIST.add key
          TMP.push vbyteD key
          render()
        return
    ]
  else
    LI.pull do =>
      prev_ts = 0
      =>
        r = await SDK.userFav ID, prev_ts
        if prev_ts
          li = r
        else
          [name,li] = r
        if li.length
          prev_ts = Number li.pop()
        [
          li
          r.length == IMG_LI_LIMIT
        ]
  fall ...result

</script>

<template lang="pug">
b
  nav(@&nav)
    +if name
      Nav(name:)
  b.w(@&b)
    Li(@&LI)
</template>

<style lang="stylus">
@import './nav/body.styl'
</style>

