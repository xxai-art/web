<template lang="pug">
b#M
  svelte:component(this="{M}")
+if P
  <svelte:component this="{P}" {...kw}/>
</template>

<style lang="stylus">
@import 'styl/body.styl'
@import 'styl/auth.styl'
</style>

<script lang="coffee">
> ./lib/route.coffee
  ./lib/auth.coffee:
  ./Home.svelte
  svelte > tick
  ./lib/CID.coffee > CID_IMG CID_USER
  @w5/wasm > b64VbyteD
  ./Img.svelte
  ./User.svelte

+ M,P

MAP = new Map [
  [CID_USER, User]
  [CID_IMG, Img]
]

kw = {}

display = (s)=>
  if M
    return document.getElementById('M').style
  return

route (url)=>
  if url.startsWith('-')
    p = url.indexOf('/',1)
    if p <= 0
      p = undefined
    [cid, ID] = b64VbyteD url.slice(1,p)
    kw = {ID}
    P = MAP.get(cid)
    display()?.display = 'none'
  else
    if P
      P = undefined
      display()?.removeProperty 'display'
    if not M
      M = Home
  return
</script>

