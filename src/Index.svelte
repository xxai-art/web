<template lang="pug">
b.M(@&E)
  <svelte:component this="{M}"/>
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
  ./lib/CID.coffee > CID_IMG CID_USER
  @w5/vite > b64VbyteD
  ./Img.svelte
  ./User.svelte
  svelte > onMount tick
  ~/lib/goto.coffee

+ M,E,P

MAP = new Map [
  [CID_IMG, Img]
]

kw = {}

onMount =>
  route (url)=>
    if url
      if url.startsWith('-')
        p = url.indexOf('/',1)
        if p <= 0
          p = undefined
        [cid, ID] = b64VbyteD url.slice(1,p)
        oid = {ID}
        if cid == CID_USER
          M = User
        else
          kw = oid
          P = MAP.get(cid)
          E.style.removeProperty 'display'
          return
      else
        goto '/'
    else
      if Home != M
        M = Home
    if P
      P = undefined
    E.style.display = 'block'
    return
  return
</script>

