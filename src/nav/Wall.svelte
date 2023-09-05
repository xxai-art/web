<script lang="coffee">
> ../i18n/code.js > RATING TIME ANY LAST A_DAY A_WEEK A_MONTH A_Q H_Y A_Y Q_KEYWORD SAFE ADULT ALL
  ../i18n/onMount.js:i18nOnMount
  ./Menu.svelte:MenuC
  ./Nav.svelte
  ./R.svelte
  ~/const/IMG_HEIGHT.coffee
  @w5/u8 > u8eq
  @w5/hashval
  @w5/hashval/hashset
  svelte > tick onMount
  @w5/fset/call
  wac.tax/_/byTag.js > byTag0
  wac.tax/_/lang.js > langSpace
  wac.tax/wtax/On.js
  ~/lib/Drop.svelte
  ~/var/Level.coffee:@ > set:levelSet
  ~/lib/goto.coffee
  ~/lib/hashchange.coffee
  ~/lib/title.coffee:@ > suffix
  ~/ev/search.coffee

+ form, H, langL, langT, DTP, Q
# Q = 搜索

MIN_HEIGHT = 2*IMG_HEIGHT

DLP = Level()

placeholder = ''

DT = DL = []


onMount i18nOnMount (I18N)=>
  space = langSpace()
  langT = space + I18N[TIME]
  langL = space + I18N[RATING]
  placeholder = ' '+I18N[Q_KEYWORD]
  any = I18N[ANY]
  DT = [
    any
    I18N[LAST] + space + I18N[A_Y]
    I18N[LAST] + space + I18N[H_Y]
    I18N[LAST] + space + I18N[A_Q]
    I18N[LAST] + space + I18N[A_MONTH]
    I18N[LAST] + space + I18N[A_WEEK]
    I18N[LAST] + space + I18N[A_DAY]
  ]
  DL = [
    I18N[ADULT]
    I18N[SAFE]
    any
  ]
  return

dl = (pos)=>
  is_init = pos == undefined
  if is_init
    pos = DLP
  else
    levelSet DLP = pos
  txt = DL[pos] + langL
  if is_init
    return [txt, pos]
  submit()
  return txt

dt = (pos)=>
  is_init = pos == undefined

  if is_init
    pos = DTP = 0

  txt = DT[pos]
  if pos == 0
    txt += langT

  if is_init
    r = [txt, pos]
  else
    r = txt
    DTP = pos
    submit()
  return r

top = =>
  if location.pathname == '/'
    document.getElementById('M').childNodes[0].childNodes[1].scrollTop = 0
  return


_input = =>
  byTag0(form,'input')

CLS_O = 'o'

_setInput = =>
  input = _input()

  setTimeout(
    =>
      input.focus()
      return
  )


  input.value = value = hashval()

  input.select()

  if value
    document.title = value + suffix()
    H.classList.add CLS_O
  else
    document.title = title()
    H.classList.remove CLS_O
  return

submitByHash = =>
  input = _input()
  val = hashval()
  if val != input.value
    input.value = val
    submit()
  return

onMount =>
  _on={}
  _on[hashchange] = =>
    if location.pathname == '/'
      submitByHash()
    return
  _input().value = hashval()
  tick().then =>
    submit()
    return
  On(
    window
    _on
  )

PRE = []

submit = ->
  input = _input()
  value = input.value.trim()
  if value
    hashset value
  else if location.hash
    goto()
  _setInput()

  opt = [
    DLP # 分级
  ]
  if value
    opt.push(
      [0,365,183,92,31,7,1][DTP] # 时长
      0 # 截止日期
    )
  args = [
    value
    opt
  ]
  if u8eq args, PRE
    return
  PRE = args
  Q = args[0]
  call(search, ...args)
  return

</script>

<template lang="pug">
Nav
  //- a.logo(@click=top href="/") xxAI.art
  i.H.ico
    a.o(@&H href="/")
  form(@&form @submit|preventDefault)
    input(placeholder:)
    button(type="submit")
      i-t SEARCH
  Drop#qL(_:dl li:DL)
  +if Q
    Drop#qT(_:dt li:DT)
  R(slot="R")
    a.gg(href="//groups.google.com/g/xxai-art" slot="R" target="_blank")
    MenuC
</template>

<style lang="stylus">
@import './a.styl'
@import '../styl/nav.ico.styl'

b
  display flex

  &.O
    &>:global(b>a)
      opacity 0.3

.ico.H
  margin-left -40px

  &>a
    &:before
      background-image url(':/svg/logo.svg')
      opacity 0.9

    &.o
      &:before
        filter grayscale(1)

    &:hover
      margin-bottom -1px

      &:before
        filter none

form
  border-right 1px solid #eee
  display flex
  height 100%
  margin-right 22px

  input
    background transparent
    border 0
    font-size 16px
    height 100%
    outline 0
    padding 0 1em
    width 10em

  button
    background url(':/svg/q.svg') 50% 50% / 20px no-repeat transparent
    border 0
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

