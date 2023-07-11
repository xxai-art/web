<script lang="coffee">
> svelte > onMount
  ./lib/topfix.coffee
  ./nav/Wall.svelte
  ./Imgli.svelte

+ nav,b

onMount =>
  return topfix nav, b
  # return for unbind

</script>

<template lang="pug">
b
  nav(@&nav)
    Wall
  b(@&b)
    Imgli
</template>

<style lang="stylus">
@import './styl/nav/body.styl'
</style>

