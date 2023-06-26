<script lang="coffee">
> ./conf.js > META IMG_HASH
  wac.tax/_/req.js
  @w5/urlb64/b64e
  ./lib/goto.coffee

< href
< fav

_cache = (p)=>
  hash = (await req META+p.slice(2))[2]
  fetch(IMG_HASH+b64e(hash),mode:'no-cors')

W = 'W'

click = ->
  {classList:c, pathname:p} = @
  c.add W
  _cache(p).finally =>
    c.remove W
    goto p
    return
  return
</script>

<template lang="pug">
a(:href @click|preventDefault|stopPropagation)
nav
  //-
    a.comment
      +if comment
        | {comment}
  a.fav
    +if fav
      | {fav}
</template>

<style lang="stylus">
nav
  align-self center
  backdrop-filter blur(20px) saturate(160%)
  background linear-gradient(0, rgba(0, 0, 0, 0.4) 0, rgba(0, 0, 0, 0.6) 100%)
  border-radius 7px 7px 0 0
  box-shadow rgb(0, 0, 0, 0.5) 0 0 7px inset
  display none
  font-family M
  justify-content space-between
  padding 7px 14px
  position absolute
  user-select none

  a
    cursor pointer
    font-weight 500
    height 14px
    line-height 14px

  &>a
    background-position 0 1px
    background-repeat no-repeat
    background-size 14px
    color #000
    cursor pointer
    display inline-block
    filter invert(93%) hue-rotate(351deg) brightness(91%) contrast(87%)
    font-size 15px
    margin-left 7px
    padding-left 17px

    &:first-child
      margin-left 0

    &:hover
      filter invert(53%) sepia(49%) saturate(6297%) hue-rotate(2deg) brightness(104%) contrast(106%)

    &.fav
      background-image url(':/svg/fav.svg')

    &.comment
      background-image url(':/svg/comment.svg')

  &:hover
    display flex

a
  display block
  height 100%

  &:hover+nav
    display flex

  :global(&.W)
    background var(--svg-wait) 50% 50% / contain no-repeat rgba(0, 0, 0, 0.5)
</style>

