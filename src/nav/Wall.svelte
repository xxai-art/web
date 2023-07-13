<script lang="coffee">
> ./Nav.svelte
  ./R.svelte
  ./Menu.svelte:MenuC
  wac.tax/wtax/On.js
  wac.tax/_/Menu.js
  ~/lib/title.coffee:@ > suffix
  ~/lib/hashchange.coffee
  ~/lib/goto.coffee
  svelte > onMount

top = =>
  if location.pathname == '/'
    document.getElementById('M').childNodes[0].childNodes[1].scrollTop = 0
  return

+ form, D, drop, H

_input = =>
  form.getElementsByTagName('input')[0]

CLS_O = 'o'

_setInput = =>
  input = _input()
  input.value = value = decodeURIComponent(
    location.hash.slice(1)
  ).trim()
  input.select()

  if value
    document.title = value + suffix()
    H.classList.add CLS_O
  else
    document.title = title()
    H.classList.remove CLS_O
    console.log '图片推荐'

  setTimeout(
    =>
      input.focus()
      return
  )
  return

onMount =>
  drop = Menu(
    D
    (m)->
      @classList.remove CLS_O
      for i from m.getElementsByTagName('label')
        i.onclick = (e)=>
          e.stopPropagation()
          return
      for i from m.getElementsByTagName('select')
        i.onclick = (e)=>
          e.stopPropagation()
          return
      return
    ->
      @classList.add CLS_O
      return
  )
  _setInput()
  _on={}
  _on[hashchange] = _setInput
  On(
    window
    _on
  )

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
template(@&D)
  .M
    p
      label 内容分级
      select
        option 安全
        option 成人
        option 全部

Nav
  //- a.logo(@click=top href="/") xxAI.art
  form(@&form @submit|preventDefault)
    input(placeholder="请输入关键词")
    button(type="submit") 搜索
  select
    option 全部时间
    option 过去一年
    option 过去半年
    option 过去一季
    option 过去一月
    option 自定义
  b
    .ico
      a.D.o(@click=drop)
    .ico
      a.H.o(href="/" @&H)

  R(slot="R")
    MenuC
    a.gg(href="//groups.google.com/g/xxai-art" slot="R" target="_blank")
</template>

<style lang="stylus">
@import './a.styl'
@import '../styl/nav.ico.styl'

select
  background var(--svg-nabla) no-repeat scroll 85% 53%
  border 0
  cursor pointer
  font-size 16px
  height 100%
  outline 0
  padding 0 32px 0 16px
  text-align center
  white-space nowrap
  width 120px
  -webkit-appearance none

  &:focus
    filter saturate(47)

  &:hover
    filter invert(42%) sepia(1) saturate(47)

.M
  align-items center
  background #fff
  border 1px solid #Eee
  display flex
  flex-direction column
  position absolute
  right 0
  top 64px

  select
    background-position 95% 60%
    border 0
    border-bottom 1px solid #000
    height auto
    padding 8px 16px 8px 0

  p
    border-top 1px solid #eee
    display flex
    flex-direction column
    margin 0
    padding 16px

    &:first-child
      border 0

  label
    color #666
    font-size 14px
    margin-right 8px
    white-space nowrap

b
  border-left 1px solid #eee
  display flex
  height 100%

  &>.ico
    &>a.H
      &:before
        background-image url(':/svg/logo.svg')
        opacity 0.9

      &.o
        &:before
          filter grayscale(1)

      &:hover
        &:before
          filter none

    &>a.D
      &:before
        background-image var(--svg-x)

    &>a.D.o
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

