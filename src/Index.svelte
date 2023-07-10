<template lang="pug">
svelte:component(this="{ M }")
+if P
  <svelte:component this={P} {...kw}/>
</template>

<style lang="stylus">
@import 'styl/body.styl'
@import 'styl/auth.styl'
</style>

<script lang="coffee">
> ./lib/route.coffee
  ./lib/auth.coffee:
  ./Home.svelte
  ./Img.svelte
  svelte > tick
  ./lib/CID.coffee > CID_IMG
  @w5/wasm > b64VbyteD

+ M,P

MAP = new Map [
  [CID_IMG, Img]
]

kw = {}

display = (s)=>
  document.body.childNodes[0].style

route (url)=>
  if url.startsWith('-')
    p = url.indexOf('/',1)
    if p <= 0
      p = undefined
    [cid, ID] = b64VbyteD url.slice(1,p)
    kw = {ID}
    P = MAP.get(cid)
    if M
      display().display = 'none'
  else
    if P
      P = undefined
      if M
        display().removeProperty 'display'
    if not M
      M = Home
  return
</script>

