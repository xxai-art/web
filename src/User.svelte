<script lang="coffee">
> # @w5/wasm > b64VbyteE
  # ./lib/CID.coffee > CID_USER
  svelte > onMount
  ./nav/Nav.svelte
  ./lib/topfix.coffee

< ID

+ name, href, nav, b

onMount =>
  href = location.pathname
  [name] = await SDK.meta href.slice(2) # await SDK.meta b64VbyteE CID_USER, ID
  return topfix nav, b
</script>

<template lang="pug">
b
  nav(@&nav)
    Nav
      +if name
        a(href:) {name}
  b(@&b)
</template>

<style lang="stylus">
@import './nav/a.styl'
@import './nav/body.styl'
</style>

