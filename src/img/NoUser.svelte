<script lang="coffee">
> wac.tax/user/User.js > onMe
  wac.tax/_/SDK.js
  @w5/pair
  ./Li.svelte
  svelte > onMount

< load = undefined

+ elem

onMount =>
  onMe =>

    # 切换登录未登录会在 await SDK.li 之后到 elem 为空
    elem?.pull =>
      li = pair(await SDK.q())
      if load
        setTimeout(
          load
          500
        )
        load = undefined
      [
        li
        false
      ]
    return

</script>

<template lang="pug">
Li(@&elem)
</template>


