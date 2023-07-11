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
u-i18n
b
  a.ft(@click=full class:f=FULL)
  a.gg(href="//groups.google.com/g/xxai-art" target="_blank")
</template>

<style lang="stylus">
b
  display flex
  margin-bottom -3px
  position relative

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

u-i18n
  margin-bottom -4px
  opacity 0.75
  transform scale(0.76)
  transform-origin right 50%
</style>

