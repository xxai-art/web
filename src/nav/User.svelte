<script lang="coffee">
> svelte > onMount
  ./Nav.svelte
  ./R.svelte

< name

href = location.pathname
#
# onMount =>
#   [name] = await SDK.meta href.slice(2) # await SDK.meta b64VbyteE CID_USER, ID
#   return

</script>

<template lang="pug">
Nav
  a(href:) {name}
  a.fav(href: title="收藏")
  R(slot="R")
    a.x(href="/" slot="R")
</template>

<style lang="stylus">
@import './a.styl'

a.x
  background url(':/svg/x.svg') 50% 50% / 20px no-repeat
  border 2px solid #000
  border-radius 30px
  height 30px
  margin-left 13px
  margin-top 3px
  transform scale(0.7)
  transform-origin 100% 50%
  width 30px

a.fav
  background url(':/svg/fav.svg') 50% 60% / 20px no-repeat
  height 30px
  width 30px
</style>

