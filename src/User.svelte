<script lang="coffee">
> # @w5/wasm > b64VbyteE
  # ./lib/CID.coffee > CID_USER
  svelte > onMount
  ./nav/User.svelte:Nav
  ./lib/topfix.coffee
  wac.tax/user/User.js

< ID

+ href, nav, b

onMount =>
  user = await User()
  if user.id == ID
    console.log 'self'
  else
    console.log 'not me'
  return topfix nav, b
</script>

<template lang="pug">
b
  nav(@&nav)
    Nav
  b(@&b)
</template>

<style lang="stylus">
@import './nav/body.styl'
</style>

