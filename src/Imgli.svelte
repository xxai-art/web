<script lang="coffee">
> ./lib/SortImg.coffee
  ./lib/goto.coffee
  ./conf.js > IMG_HASH
  ./lib/CID.coffee > CID_IMG
  @w5/urlb64/b64e
  @w5/wasm > b64VbyteE
  svelte > onMount
  wac.tax/_/SDK.js
  wac.tax/user/User.js > onMe
  wac.tax/wtax/On.js
  ./Cell.svelte

sortimg = SortImg()

HEIGHT= 475
IMG = IMG_HASH+'h' + (if devicePixelRatio > 1 then HEIGHT*2 else HEIGHT)+'/'

< load = undefined

+ li

sort = (t)=>
  sortimg(innerWidth, t, (i)=>i[2]).flat()

onMe =>
  t = []
  for [id,hash,w,h,fav,reply] from await SDK.li()
    t.push [
      id
      b64e hash
      Math.round w*HEIGHT/h
      fav
      reply
      b64VbyteE [CID_IMG, id]
    ]
  li = (li or []).concat sort(t)

  if load
    setTimeout(
      load
      1e3
    )
  return

+ TIMEOUT
PRE_WIDTH = innerWidth

onMount =>
  On(
    window
    resize: =>
      clearTimeout TIMEOUT
      if PRE_WIDTH != innerWidth
        TIMEOUT = setTimeout(
          =>
            li = sort li
            PRE_WIDTH = innerWidth
            return
          300
        )

      return
  )

</script>

<template lang="pug">
+if li
  ul
    +each('li as [id,hash,w,fav,comment,url]')
      li(style="flex-grow:{w/HEIGHT};width:{w}px;background-image:url({IMG}{hash}),var(--svg-wait)")
        Cell(href="/-{url}" fav="{fav}")
</template>

<style lang="stylus">
@import 'styl/imgli.styl'

ul
  background #000
  min-height 100%

  & > li
    height 475px
</style>

