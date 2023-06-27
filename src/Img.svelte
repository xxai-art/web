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

  &:global(.s.d)
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

          &>b
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
  wac.tax/_/SDK.js
  ./lib/goto.coffee
  ./lib/CID.coffee > CID_IMG
  ./lib/sampler.coffee
  ./conf.js > META IMG_HASH
  ./db/fav.coffee > favPut favGet
  ./lib/keymap.coffee
  wac.tax/_/req.js
  @w5/urlb64/b64e
  @w5/uintb64/b64Uint.js
  @w5/link
  @w5/sd_token/a.js:sdA
  wac.tax/user/User.js > onMe

< ID

GENWAY = [
  '文生图+超分'
  '文生图'
  '图生图'
  '局部重绘'
]

+ src, user, model, genway_id, prompt, nprompt, aFav

mli = []

CIVITAI = link 'civitai.com'

load = ->
  @parentNode.classList.remove 'w'
  return

D = 'd'

_refresh = =>
  _turn await favGet(CID_IMG, ID)
  return

_turn = (state)=>
  {classList} = aFav
  if state
    classList.add D
  else
    classList.remove D
  return

fav = =>
  if aFav # 没加载之前可能会被快捷键触发
    turn = +(not aFav.classList.contains D)
    if favPut(CID_IMG,ID,turn)
      _turn turn
  return

onMount =>
  unbind_key = keymap(
    88,=>goto '' # x
    83,fav # s
    # -> 39 ; <- 37
  )

  [
    cid
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
    time
    rid
    cfg
  ] = await req(META+location.pathname.slice(2))


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
      '采样器'
      await sampler sampler_id
    ]

  if step
    mli.push [
      '迭代数'
      step
    ]

  if cfg
    mli.push [
      '词强度'
      cfg
    ]

  if w and h
    mli.push [
      '分辨率'
      w+'×'+h
    ]

  if seed
    mli.push [
      '随机种'
      seed
    ]

  if user and rid
    user = [
      CIVITAI+'images/'+rid
      user[1]
    ]
  else
    user = 0
  src=IMG_HASH+b64e hash_bin

  try
    await document.body.requestFullscreen()

  unbind_on_me = onMe _refresh
  =>
    unbind_key()
    unbind_on_me()
    return
</script>

<template lang="pug">
+if src
  main
    b.L.w
      img(:src @load)
    b.R
      header
        b.L
          +if user
            a(href="{ user[0] }") { user[1] }
        b.R
          a.s(@&aFav @click=fav title="收藏 ( 快捷键 S )")
          a.p(href="/" title="上一张 ( 快捷键 ← )")
          a.n(href="/" title="下一张 ( 快捷键 → )")
          a.x(href="/" title="关闭 ( 快捷键 X )")
      b
        b
          +if model
            i
              b 模型
              a(href="{ model[0] }") {model[1]}

          +if genway_id
            i {GENWAY[genway_id-1]}
          +each mli as i
            i
              b {i[0]}
              i {i[1]}
        +if prompt
          i
            b 提示词
            pre {@html prompt}
        +if prompt
          i
            b 负向词
            pre.np {@html nprompt}
  +else
    main.w
      a.x(href="/" title="快捷键 X")
</template>

