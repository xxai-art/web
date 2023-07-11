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
b.ico
  a.ft(@click=full class:f=FULL)
  slot
</template>

<style lang="stylus">
:global(b.ico>a)
  cursor pointer
  height 42px
  margin-left 25px
  margin-right 0
  width 25px

  &:hover
    filter invert(42%) sepia(1) saturate(47)

b
  display flex
  margin-bottom -3px
  position relative

  &>a
    &.ft
      background url(':/svg/full.svg') 50% 50% / 20px no-repeat

      &.f
        background-image url(':/svg/unfull.svg')

u-i18n
  margin-bottom -5px
  opacity 0.75
  transform scale(0.76)
  transform-origin right 50%
</style>

