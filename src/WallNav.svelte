<script lang="coffee">
> ./Nav.svelte
  ./NavMenu.svelte

top = =>
  if location.pathname == '/'
    document.getElementById('M').childNodes[0].childNodes[1].scrollTop = 0
  return

</script>

<template lang="pug">
Nav
  a.logo(@click=top href="/") xxAI.art
  a 发现
  NavMenu(slot="rl")
</template>

<style lang="stylus">
@import './styl/nav/a.styl'

a.logo
  background url(':/svg/logoTxt.svg') no-repeat
  border 0
  height 32px
  margin-bottom 0
  padding 0 0 5px
  text-indent -999px
  width 66px

  &:hover
    filter invert(14%) sepia(61%) saturate(5346%) hue-rotate(354deg) brightness(119%) contrast(127%)
</style>

