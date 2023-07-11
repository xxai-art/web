<script lang="coffee">
> svelte > onMount
  ./lib/topfix.coffee
  ./nav/Wall.svelte:Nav
  ./Imgli.svelte

+ nav,b

onMount =>
  return topfix nav, b
  # return for unbind

</script>

<template lang="pug">
b
  nav(@&nav)
    Nav
  b(@&b)
    Imgli
</template>

<style lang="stylus">
@import './nav/body.styl'
</style>

