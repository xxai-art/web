<script lang="coffee">
> svelte > onMount
  wac.tax/wtax/On.js
  ~/i18n/onMount.js:i18nOnMount > I18N
  ~/i18n/code.js > FULLSCREEN CLOSE
  wac.tax/_/lang.js > langSpace
  @w5/fall


+ fullscreen, FULL

fullscreenchange = =>
  FULL = !! document.fullscreenElement
  fullscreen = I18N[FULLSCREEN]
  if FULL
    fullscreen = I18N[CLOSE] + langSpace() + fullscreen
  return

fullscreenchange()

onMount =>
  fall(
    On(
      document
      {fullscreenchange}
    )
    i18nOnMount fullscreenchange
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
  slot(name="L")
  a.ft(@click=full class:f=FULL title="{fullscreen}")
  slot(name="R")
</template>

<style lang="stylus">
:global(b.ico>a)
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
  margin-bottom -6px
  opacity 0.75
  transform scale(0.76)
  transform-origin right 50%
</style>

