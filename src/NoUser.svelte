<script lang="coffee">
> ./img/NoUser.svelte
  ./AuthInput.svelte
  svelte > onMount
  @w5/sleep

+ b

load = =>
  if b
    u = b.childNodes[0]
    u.style.marginTop = 0
    loop
      {scrollHeight} = u
      if scrollHeight > innerHeight
        top = scrollHeight - innerHeight
        Object.assign(
          u.style
          transition : "all #{Math.round top/20}s linear"
          marginTop : -top+'px'
        )
        break
      await sleep(1000)
  return

</script>

<template lang="pug">
main
  h1
    i xxAI.art
    i-t SHARE_IMG
    i-t FOUND_MODEL
  b
    AuthInput
    p
      u-i18n
      a(href="//groups.google.com/g/xxai-art")
        i-t GGROUP
b(@&b)
  NoUser(load:)
</template>

<style lang="stylus">
main
  align-items center
  background rgba(0, 0, 0, 0.7)
  color #fff
  display flex
  flex-direction column
  justify-content center
  min-height 100%
  position fixed
  top 0
  user-select none
  width 100%
  z-index 1

  &>h1
    align-items center
    display flex
    flex-direction column

    &>i
      background url(':/svg/logoTxt.svg') 50% 50% / 126px no-repeat
      color #000
      display block
      filter invert(1)
      font-style normal
      height 60px
      overflow hidden
      text-indent -99em
      width 126px

    &>i-t
      font-size 1.5rem
      margin 0.5rem 0 0

  &>b
    &>p
      align-items flex-start
      display flex
      font-weight 600
      justify-content space-between
      margin-top 2.8rem

      &>u-i18n
        filter invert(1)

      &>a
        border-bottom 2px solid #fff
        color #fff
        padding-bottom 3px

        &:hover
          border-color #00BBFF
          color #00BBFF

main+b
  bottom 0
  left 0
  overflow hidden
  pointer-events none
  position absolute
  right 0
  top 0
</style>

