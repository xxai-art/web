<script lang="coffee">
> svelte > onMount
  wac.tax/wtax/On.js

FULL = !! document.fullscreenElement

onMount =>
  On(
    document
    fullscreenchange: =>
      FULL = !! document.fullscreenElement
      return
  )

full = =>
  if document.fullscreenElement
    await document.exitFullscreen()
  else
    await document.body.requestFullscreen()
  return


</script>

<template lang="pug">
nav
  i
    slot
  i
    slot(name="rl")
    u-i18n
    b
      a.ft(@click=full class:f=FULL)
      a.gg(href="//groups.google.com/g/xxai-art" target="_blank")
</template>

<style lang="stylus">
@import './styl/nav/a.styl'

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

    u-i18n
      margin-bottom -4px
      opacity 0.75
      transform scale(0.76)
      transform-origin right 50%

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
</style>

