<script lang="coffee">
> ./Nav.svelte
  ./R.svelte
  ./Menu.svelte

top = =>
  if location.pathname == '/'
    document.getElementById('M').childNodes[0].childNodes[1].scrollTop = 0
  return

</script>

<template lang="pug">
Nav
  a.logo(@click=top href="/") xxAI.art
  a 发现
  R(slot="R")
    Menu
    a.gg(href="//groups.google.com/g/xxai-art" target="_blank" slot="R")
</template>

<style lang="stylus">
@import './a.styl'

a.gg
  background url(':/svg/google_groups.svg') 50% 50% / 50px no-repeat

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

