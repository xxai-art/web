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
  .ico
    a.now.fav(href: title="收藏")
  R(slot="R")
    a.x(href="/" slot="R")
</template>

<style lang="stylus">
@import './a.styl'
@import '../styl/nav.ico.styl'

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
  background url(':/svg/fav.svg') 50% 55% / 20px no-repeat
  border-left 1px solid #eee
</style>

