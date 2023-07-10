<script lang="coffee">
> ./Nav.svelte
</script>

<template lang="pug">
Nav
  a(@click=top href="/") xxAI.art
  a 发现
</template>

<style lang="stylus">
@import './styl/nav/a.styl'

a:first-child
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

