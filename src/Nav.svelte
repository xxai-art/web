<script lang="coffee">
> svelte > onMount
  ./lib/auth.coffee
  wac.tax/wtax/On.js
  wac.tax/user/User.js > onMe
  @w5/fall

+ menu,ME

FULL = !! document.fullscreenElement

onMount =>
  menu.querySelectorAll("u-menu a").forEach (e) =>
    e.onclick = (e) =>
      e.preventDefault()
      auth(e.target.className=='up')
      return
  fall(
    On(
      document
      fullscreenchange: =>
        FULL = !! document.fullscreenElement
        return
    )
    onMe (user)=>
      ME = user?.id
      return
  )

full = =>
  if document.fullscreenElement
    await document.exitFullscreen()
  else
    await document.body.requestFullscreen()
  return

top = =>
  if location.pathname == '/'
    document.body.childNodes[0].childNodes[1].scrollTop = 0
  return

</script>

<template lang="pug">
nav
  i
    a(@click=top href="/") xxAI.art
    a 发现
  i
    u-menu(@&menu)
      a
        i-t SIGN_IN
      | /
      a
        i-t.up SIGN_UP
      b(slot="ul")
        a(href:ME) 个人页
    u-i18n
    b
      a.ft(@click=full class:f=FULL)
      a.gg(href="//groups.google.com/g/xxai-art" target="_blank")
</template>

<style lang="stylus">
nav
  background #fff
  display flex
  justify-content space-between
  user-select none
  width 100%

  &>i
    align-items center
    display flex
    font-style initial
    margin 0 40px

    &>b
      position relative

    &>u-menu
      font-size 16px

      &>a
        &:first-child
          margin-right 5px

        &:last-child
          margin-left 5px

    u-i18n
      margin-bottom -4px
      opacity 0.75
      transform scale(0.76)
      transform-origin right 50%

    a
      border-bottom 2px solid transparent
      color #333
      cursor pointer
      display inline-flex
      font-size 18px
      line-height 1.6
      transition all 0.3s

    &>b
      display flex
      margin-bottom -3px

      &>a
        height 42px
        margin-left 25px
        margin-right 0
        width 25px

        &.ft
          background url(':/svg/full.svg') 50% 50% / 20px no-repeat

          &.f
            background-image url(':/svg/unfull.svg')

        &.gg
          background url(':/svg/google_groups.svg') 50% 50% / 50px no-repeat

    a:hover
      border-color #f40
      color #f40
      font-weight 600
      margin-bottom 0
      padding-bottom 2px

    &>a
      margin-right 24px

      &:first-child
        background url(':/svg/logoTxt.svg') no-repeat
        height 32px
        margin-bottom 0
        padding 0
        text-indent -999px
        width 66px

        &:hover
          filter invert(14%) sepia(61%) saturate(5346%) hue-rotate(354deg) brightness(119%) contrast(127%)

  u-menu
    &>b
      &>a
        border 1px solid transparent
        border-top-color #ccc
        display block
        font-weight normal
        padding 8px 16px
        text-align center
        white-space nowrap

        &:hover
          background #f40
          border-color #f40
          color #fff
          font-weight normal
          padding-bottom 8px
</style>

