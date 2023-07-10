<script lang="coffee">
> ./lib/SortImg.coffee
  ./conf.js > URL_META
  ./lib/CID.coffee > CID_IMG
  @w5/wasm > vbyteE b64E
  svelte > onMount
  wac.tax/_/SDK.js
  wac.tax/user/User.js > onMe
  wac.tax/wtax/On.js
  ./Cell.svelte
  ./art/li.coffee > liPut

sortimg = SortImg()

HEIGHT= 475
IMG = URL_META+'h' + (if devicePixelRatio > 1 then HEIGHT*2 else HEIGHT)+'/'

< load = undefined

+ li

sort = (t)=>
  sortimg(innerWidth, t, (i)=>i[2]).flat()

onMe =>
  t = []
  sdk_li = await SDK.li()
  for [id,hash,w,h] from sdk_li
    t.push [
      b64E vbyteE [CID_IMG, id]
      b64E hash
      Math.round w*HEIGHT/h
    ]

  liPut sdk_li.map (i)=> [CID_IMG].concat i

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
    +each('li as [url,hash,w]')
      li(style="flex-grow:{w/HEIGHT};width:{w}px;background-image:url({IMG}{hash}),var(--svg-wait)")
        Cell(href:url)
</template>

<style lang="stylus">
@import 'styl/imgli.styl'

ul
  background #000
  min-height 100%

  & > li
    height 475px
</style>

