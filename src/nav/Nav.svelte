<script lang="coffee">



</script>

<template lang="pug">
nav
  i
    slot
  i
    slot(name="R")
</template>

<style lang="stylus">
@import './a.styl'

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
</style>

