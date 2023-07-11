<script lang="coffee">
> svelte > onMount
  ./Nav.svelte
  ./R.svelte

+ name

href = location.pathname

onMount =>
  [name] = await SDK.meta href.slice(2) # await SDK.meta b64VbyteE CID_USER, ID
  return

</script>

<template lang="pug">
Nav
  +if name
    a(href:) {name}
  R(slot="R")
    a.x(slot="R")
</template>

<style lang="stylus">
@import './a.styl'

a.x
  background url(':/svg/google_groups.svg') 50% 50% / 50px no-repeat
</style>

