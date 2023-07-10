<script lang="coffee">
> @w5/wasm > b64VbyteE
  ./lib/CID.coffee > CID_USER
  svelte > onMount

< ID

onMount =>
  console.log await SDK.meta b64VbyteE CID_USER, ID
  return
</script>

<template lang="pug">
nav
  a(href="/")
h1 User Id {ID}
</template>

<style lang="stylus">
h1
  color #999
</style>

