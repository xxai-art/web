<script lang="coffee">
> ./Nav.svelte
  ./R.svelte
  ./Menu.svelte
  ~/lib/goto.coffee
  svelte > onMount

top = =>
  if location.pathname == '/'
    document.getElementById('M').childNodes[0].childNodes[1].scrollTop = 0
  return

+ form

_input = =>
  input = form.getElementsByTagName('input')[0]
  input.focus()
  input

onMount =>
  _input().value = value = decodeURIComponent(
    location.hash.slice(1)
  ).trim()
  if value
    console.log '搜索'
  else
    console.log '图片推荐'
  return

submit = ->
  input = _input()
  value = input.value.trim()
  if value
    location.hash = value
  else
    goto()
  return


</script>

<template lang="pug">
Nav
  //- a.logo(@click=top href="/") xxAI.art
  form(@&form @submit|preventDefault)
    input(placeholder="请输入关键词")
    button(type="submit") 搜索
  .ico
    a.D
    a.H(href="/")
  R(slot="R")
    Menu
    a.gg(href="//groups.google.com/g/xxai-art" slot="R" target="_blank")
</template>

<style lang="stylus">
@import './a.styl'
@import '../styl/nav.ico.styl'

.ico
  &>a.H
    &:before
      background-image url(':/svg/home.svg')

  &>a.D
    &:before
      background-image var(--svg-nabla)
      background-size 12px

form
  border-right 1px solid #eee
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
    background url(':/svg/q.svg') 50% 50% / 20px no-repeat transparent
    border 0
    cursor pointer
    opacity 0.5
    overflow hidden
    text-indent -99px
    width 56px

    &:hover
      filter invert(42%) sepia(1) saturate(47)
      opacity 1

a.gg
  background url(':/svg/google_groups.svg') 50% 50% / 50px no-repeat

/*
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
*/
</style>

