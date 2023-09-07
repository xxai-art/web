<style lang="stylus">
a.x, main>b>header>b.R>a
  background-position 50% 50%
  background-repeat no-repeat
  background-size 20px
  border 1px solid #000
  border-radius 18px
  cursor pointer
  display inline-block
  filter invert(100%)
  height 20px
  padding 5px
  transform scale(0.7)
  transform-origin 50% 50%
  transition all 0.3s
  width 20px

  &:hover
    background-color #fff
    border-color #fff
    filter none
    height 25px
    margin 0 6px
    padding 2px
    transform none
    width 25px

a.x
  background-image url(':/svg/x.svg')

main>b>header>b.R>a
  &.s
    background-image url(':/svg/fav.svg')
    background-position 50% -64%
    background-size 32px
    border 0
    margin-right 3px

    &:hover
      background-color transparent
      filter invert(45%) sepia(82%) saturate(2903%) hue-rotate(0) brightness(102%) contrast(106%)

  &:global(.s.D)
    background-image url(':/svg/faved.svg')
    filter invert(14%) sepia(98%) saturate(7409%) hue-rotate(360deg) brightness(112%) contrast(111%)

  &.n, &.p
    background-image url(':/svg/right.svg')
    background-size 22px

  &.p
    transform rotate(-180deg) scale(0.7)

    &:hover
      transform rotate(-180deg)

main
  align-items stretch
  background #000
  color #fff
  display flex
  display flex
  flex-direction row
  height 100vh
  justify-content space-between
  position absolute
  width 100vw
  z-index 1

  &.w
    background var(--svg-wait) 50% 50% / 128px no-repeat

    &>a.x
      position absolute
      right 16px
      top 16px

  &>b
    position relative

  &>.L
    align-items center
    display flex
    flex 1
    height 100%
    overflow auto

    &.w
      background var(--svg-wait) 50% 50% / 128px no-repeat

    &>img
      margin auto
      max-height 100%
      max-width 100%
      user-select none

  &>.R
    border-left 1px solid #333
    flex-shrink 0
    height 100%
    overflow auto
    width 400px

    &>header
      align-items center
      background #000
      border-bottom 1px solid #333
      box-sizing border-box
      display flex
      height 63px
      justify-content space-between
      line-height 30px
      padding 16px
      position fixed
      user-select none
      width 400px
      z-index 1

      &>b
        display flex

      &>.L
        &>a
          color #fff

          &:hover
            color #f60

    i
      font-style normal

    &>b
      overflow auto
      position absolute
      top 62px

      &>b>i, &>i
        flex-direction row
        font-style normal
        font-weight 600

      &>b
        display flex
        flex-wrap wrap
        justify-content space-between
        margin 16px

        &>i
          margin-right 16px
          max-width 351px
          overflow hidden
          text-overflow ellipsis
          white-space nowrap

          &>b, &>i-t
            margin-right 16px

          &>a
            border-bottom 1px solid #fff
            color #fff
            padding-bottom 1px

            &:hover
              border-color #f40
              color #f60

      &>i
        display flex
        flex-direction column
        margin 16px

        &>pre
          background #333
          color #eee
          font-size 16px
          font-weight bold
          margin-bottom 0
          outline none
          padding 10px 16px
          resize none
          white-space normal

          &>:global(a)
            border-bottom 1px solid #3af
            color #3af
            padding-bottom 3px

            &:hover
              border-color #f40
              color #f60
</style>

<script lang="coffee">
> svelte > onMount
  ./art/sampler.coffee
  ./conf.js > META RES
  ./db/fav.coffee > favPut
  ./db/fav/watch.coffee
  ./i18n/code.js > INPAINT IMG2IMG TXT2IMG TXT2IMG_SR SAMPLE STEP SEED SIZE CFG HOTKEY CLOSE PREV NEXT FAV
  ./i18n/onMount.js:i18nOnMount > I18N
  ./lib/CID.coffee > CID_IMG
  ./lib/goto.coffee
  ./lib/hashpath.coffee
  ./lib/keymap.coffee
  @w5/fall
  @w5/link
  @w5/pair
  @w5/sd_token/a.js:sdA
  @w5/vite > b64E
  wac.tax/_/SDK.js
  wac.tax/_/req.js

< ID

back = hashpath()


+ GENWAY, src, user, model, genway_id, prompt, nprompt, faved, time

HOT = []

mli = []

CIVITAI = link 'civitai.com'

load = ->
  @parentNode.classList.remove 'w'
  return

fav = =>
  if faved != undefined # 没加载之前可能会被快捷键触发
    faved = !faved
    favPut(CID_IMG,ID,+faved)
  return

onMount =>
  unbind_key = keymap(
    88,=>
      goto back # x
      return
    70,fav # f
    # -> 39 ; <- 37
  )

  [
    time
    adult
    hash_bin
    prompt
    nprompt
    prompt_id
    nprompt_id
    res
    user
    sampler_id
    w
    h
    step
    genway_id
    seed
    src_id
    cfg
  ] = await req(META+location.pathname.slice(2))

  time = new Date(time*1000).toLocaleString()
  embed = new Map()
  lora = new Map()

  if res
    for [file_id,kind,name,ver,rid,key], pos in res
      url = CIVITAI+'models/'+rid
      switch kind
        when 2 # checkpoint
          model = [url,name]
        when 4, 1,3,6 # 4 embed else lora
          if key == 0
            key = name.toLocaleLowerCase()
          if kind == 4
            m = embed
          else
            m = lora
          m.set key, url

  prompt = sdA(prompt,lora,embed)
  nprompt = sdA(nprompt,lora,embed)

  if sampler_id
    mli.push [
      SAMPLE
      await sampler sampler_id
    ]

  if cfg
    mli.push [
      CFG
      cfg
    ]

  if w and h
    mli.push [
      SIZE
      w+'×'+h
    ]

  if step
    mli.push [
      STEP
      step
    ]


  if seed
    mli.push [
      SEED
      seed
    ]

  if user and src_id
    user = [
      CIVITAI+'images/'+src_id
      user[1]
    ]
  else
    user = 0
  src=RES+b64E(hash_bin)

  document.body.requestFullscreen().catch(=>)

  return fall(
    unbind_key
    watch CID_IMG, ID,  (state)=>
      faved = !!state
      return
    i18nOnMount (I18N)=>
      HOT = pair([
        CLOSE,'X',
        PREV,'←'
        NEXT,'→'
        FAV,'F'
      ]).map ([code,i])=>
        "#{I18N[code]} ( #{I18N[HOTKEY]} #{i} )"

      GENWAY = [
        TXT2IMG_SR
        TXT2IMG
        IMG2IMG
        INPAINT
      ].map (i)=>I18N[i]
      return
  )
</script>

<template lang="pug">
+if src
  main
    b.L.w
      img(src: @load)
    b.R
      header
        b.L
          +if user
            a(href="{ user[0] }" title="{time}") { user[1] }
        b.R
          +if faved != undefined
            a.s(class:D=faved @click=fav title:HOT[3])
          a.p(href="/" title:HOT[1])
          a.n(href="/" title:HOT[2])
          a.x(href:back title:HOT[0])
      b
        b
          +if model
            i
              i-t MODEL
              a(href="{ model[0] }") {model[1]}

          +if genway_id
            i {GENWAY[genway_id-1]}
          +each mli as i
            i
              b {I18N[i[0]]}
              i {i[1]}
        +if prompt
          i
            i-t PROMPT
            pre {@html prompt}
        +if nprompt
          i
            i-t N_PROMPT
            pre.np {@html nprompt}
  +else
    main.w
      a.x(href:back title:HOT[0])
</template>

