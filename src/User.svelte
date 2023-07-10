<script lang="coffee">
> # @w5/wasm > b64VbyteE
  # ./lib/CID.coffee > CID_USER
  svelte > onMount
  ./Nav.svelte

< ID

+ name, href

onMount =>
  href = location.pathname
  [name] = await SDK.meta href.slice(2) # await SDK.meta b64VbyteE CID_USER, ID
  return
</script>

<template lang="pug">
+if name != undefined
  Nav
    a(href:) {name}
</template>

<style lang="stylus">
@import './styl/navA.styl'
</style>

