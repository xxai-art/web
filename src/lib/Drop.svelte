<script lang="coffee">
> wac.tax/_/Menu.js
  svelte > onMount tick
  wac.tax/_/byTag.js
  ../i18n/onMount.js:i18nOnMount

< li
< id
< _

+ D, d, val

txt = '　'

bind = (pos)=>
  (e)=>
    val = pos
    txt = _ pos
    return

onMount i18nOnMount =>
  [txt,val] = _()
  await tick()
  # 先打开图片页面，刷新，然后再关闭，D是undefined，很奇怪
  d = Menu(
    D
    (m)->
      for i,pos in [...byTag m,'a']
        if pos == val
          m.removeChild i
        else
          i.onclick = bind(pos)
      return
  )
  return
</script>

<template lang="pug">
template(@&D)
  i.Drop
    +each li as t
      a {t}
b
  a(@click=d) {txt}
</template>

<style lang="stylus">
i
  font-style normal

b
  align-items center
  display flex
  font-weight 400
  margin-right 14px
  position relative

  &>a
    border 1px solid #333
    border-radius 14px
    box-shadow 0 0 3px #999 inset
    color #000
    font-size 14px
    margin-right 0
    opacity 0.6
    padding 4px 22px 4px 10px
    position relative
    transition all 0.3s

    &:after
      background var(--svg-nabla) 50% 50% / 8px no-repeat
      content ''
      height 8px
      position absolute
      right 8px
      top 14px
      width 8px

    &:hover
      filter invert(42%) sepia(1) saturate(47)
      font-weight normal
      opacity 1

:global(i.Drop)
  align-items center
  border-bottom 0
  display flex
  flex-direction column
  min-width 100%
  position absolute
  top 42px

  &>a
    background #fff
    border 1px solid #999
    border-radius 14px
    box-shadow 0 0 3px #aaa inset
    box-sizing border-box
    color #444
    display flex
    font-size 14px
    justify-content center
    margin 0
    margin-bottom 7px
    padding 4px 10px
    text-wrap nowrap
    transition all 0.3s
    width 100%

    &:hover
      border-color #f40
      box-shadow 0 0 3px #f40 inset
      color #f40
</style>

