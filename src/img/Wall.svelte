<script lang="coffee">
> svelte > onMount tick
  ~/lib/topfix.coffee
  ~/db/recPool.coffee
  ~/nav/Wall.svelte:Nav
  ~/img/Li.svelte
  ~/ev/search.coffee
  @w5/vite > z85VbyteE
  wac.tax/_/SDK.js
  @w5/pair
  @w5/fset
  @w5/fall

+ nav,b,LI

onMount =>
  {q} = SDK
  + ctrl

  fall(
    topfix nav, b
    # 向 search 这个集合添加 后面的函数，会在 nav/Wall.svelte 中调用
    fset search, (args...)=>
      LI.pull =>

        ctrl?.abort()
        ctrl = new AbortController()

        [keyword, opt] = args

        {signal} = ctrl

        if keyword
          q.signal = signal
          r = await q keyword,z85VbyteE opt
          li = pair r
          has_more = 0
        else
          li = await recPool(...opt)
          has_more = 1

        if signal.aborted
          return

        [
          li
          has_more
        ]
      return
    )
  # return for unbind

</script>

<template lang="pug">
b
  nav(@&nav)
    Nav
  b(@&b)
    Li(@&LI)
</template>

<style lang="stylus">
@import '../nav/body.styl'
</style>

