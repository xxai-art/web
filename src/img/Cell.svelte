<script lang="coffee">
> svelte > onMount
  @w5/vite > b64VbyteD b64E
  wac.tax/_/req.js
  ~/conf.js > META RES
  ~/lib/goto.coffee
  ~/lib/pathhash.coffee
  ~/db/fav/watch.coffee
  ~/db/fav.coffee > favPut
  ~/const/action/CLICK.coffee
  ~/db/qLog.coffee

< href

_cache = (p)=>
  hash = (await req META+p.slice(2))[2]
  fetch(
    RES+b64E(hash)
    mode:'no-cors'
  )

+ faved,cid,id

onMount =>
  [cid,id] = b64VbyteD(href)
  watch cid, id,  (state)=>
    faved = !!state
    return

W = 'W'

click = ->
  {classList:c, pathname:p} = @
  c.add W

  _cache(p).finally =>
    qLog(CLICK, cid, id)
    c.remove W
    goto p+pathhash()
    return
  return

aFav = =>
  faved = !faved
  favPut(cid,id,+faved)
  return

</script>

<template lang="pug">
a(@click|preventDefault|stopPropagation href="/-{href}")
nav
  //-
    a.comment
      +if comment
        | {comment}
  a.fav(class:D=faved @click=aFav)
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
    font-weight 500
    height 14px
    line-height 14px

  &>a
    background-position 0 1px
    background-repeat no-repeat
    background-size 14px
    color #000
    display inline-block
    filter invert(93%) hue-rotate(351deg) brightness(91%) contrast(87%)
    font-size 15px
    margin-left 7px
    padding-left 17px

    &:first-child
      margin-left 0

    &.fav
      background-image url(':/svg/fav.svg')

      &:global(.D)
        background-image url(':/svg/faved.svg')
        color #fff
        filter invert(14%) sepia(98%) saturate(7409%) hue-rotate(360deg) brightness(112%) contrast(111%)

    &:hover
      filter invert(53%) sepia(49%) saturate(6297%) hue-rotate(2deg) brightness(104%) contrast(106%)

      &:global(.D)
        color #000

    &.comment
      background-image url(':/svg/comment.svg')

  &:hover
    display flex

a
  display block
  height 100%

  &:hover+nav, &:focus-visible+nav
    display flex

  &:focus-visible
    border 1px solid #ff0
    box-shadow 0 0 9px #ff0 inset
    outline 0

  :global(&.W)
    background var(--svg-wait) 50% 50% / contain no-repeat rgba(0, 0, 0, 0.5)
</style>

