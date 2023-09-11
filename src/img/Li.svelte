<script lang="coffee">
> @w5/fall
  @w5/vite > _vbyteE b64E
  ./Cell.svelte
  ~/art/li.coffee > meta
  ~/conf.js > RES
  ~/const/IMG_HEIGHT.coffee
  ~/lib/SortPull.coffee:@ > scroll
  @w5/u8 > u8eq
  lodash-es > debounce
  svelte > onMount tick
  wac.tax/wtax/On.js

IMG = RES+'h' + (if devicePixelRatio > 1 then IMG_HEIGHT*2 else IMG_HEIGHT)+'/'

+ ul, UNBIND, RESORT, li

meta_li = (sdk_li)=>
  t = []
  for [cid,id,hash,whr] from await meta sdk_li
    t.push [
      b64E _vbyteE [cid, id]
      b64E hash
      whr
      Math.round whr*IMG_HEIGHT/1024
    ]
  t

< pull = (func)=>
  li = undefined
  UNBIND?()
  [UNBIND,RESORT] = SortPull(
    ul
    IMG_HEIGHT
    =>
      r = await func()
      if r
        r[0] = await meta_li r[0]
        return r
      return
    li
    (i)=>i[3]
    (v)=>
      li = v
      return
  )
  return

< unshift = (sdk_li)=>
  if not li
    return
  li.splice(
    0
    0
    ...await meta_li(sdk_li)
  )
  RESORT()
  return


PRE_WIDTH = innerWidth

onMount =>
  fall(
    =>
      UNBIND?()
      return
    On(
      window
      resize: debounce(
        =>
          if PRE_WIDTH != innerWidth
            PRE_WIDTH = innerWidth
            RESORT?()
          else
            ul.parentNode.dispatchEvent new Event(scroll)
          return
        300
      )
    )
  )

</script>

<template lang="pug">
ul(@&ul)
  +if li
    +if li.length
      +each('li as [url,hash,r,w]')
        li(style="flex-grow:{r};width:{Math.round(w)}px;background-image:url({IMG}{hash}),var(--svg-wait)")
          Cell(href:url)
      +else
        i-t NOTHING
    +else
      i.w
</template>

<style lang="stylus">
@import '../styl/imgli.styl'

.w
  align-self center
  background var(--svg-wait) 50% 50% / 200px no-repeat rgba(0, 0, 0, 0.5)
  display block
  height 200px
  width 100%

ul
  background #000
  min-height 100%

  & > li
    height 476px

  & > i-t
    color #fff
    display flex
    font-size 26px
    justify-content center
    letter-spacing 3px
    margin auto
    width 100%
</style>

