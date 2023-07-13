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
  //- a.logo(@click=top href="/") xxAI.art
  form
    input(placeholder="请输入关键词")
    button(type="submit") 搜索
  R(slot="R")
    Menu
    a.gg(href="//groups.google.com/g/xxai-art" slot="R" target="_blank")
</template>

<style lang="stylus">
@import './a.styl'

form
  display flex
  height 100%
  margin-left -40px

  input
    border 0
    font-size 16px
    height 100%
    outline 0
    padding 0 1em
    width 10em

  button
    background url(':/svg/q.svg') 50% 50% / 50px transparent
    border 0
    overflow hidden
    text-indent -99px

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

