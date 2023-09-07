<script lang="coffee">
> svelte > onMount
  ./lib/auth.coffee
  wac.tax/wtax/On.js
  wac.tax/_/SDK.js
  wac.tax/user/User.js > last
  wac.tax/_/AutoFocus.js
  wac.tax/_/byTag.js > byTag0
  ./i18n/onMount.js:i18nOnMount
  ./i18n/code.js > INPUT_MAIL

+ mail, form, ing

placeholder = ''

onMount i18nOnMount (I18N)=>
  placeholder = I18N[INPUT_MAIL]
  return

_submit = =>
  mail.value = v = mail.value.trim()
  if not v
    return
  box = auth(!await SDK.auth.mail.has v)
  On box,{
    close:=>
      setTimeout(
        =>
          mail?.focus()
          return
        1e3
      )
      return
  }
  byTag0(box,'u-auth').account = v
  return

submit = =>
  if ing
    return
  ing = 1
  _submit().finally =>
    ing = undefined
    return
  return

onMount =>
  mail.value = await last()?[3] or ''
  AutoFocus form
</script>

<template lang="pug">
form(@&form @submit|preventDefault class:I=ing)
  input(@&mail placeholder:placeholder type="email")
  button(type="submit")
</template>

<style lang="stylus">
form
  align-items center
  display flex
  justify-content center
  margin-top 1rem
  position relative

  &>button
    background url(':/svg/arrowr.svg') 0 0 / cover no-repeat
    border 0
    cursor pointer
    height 2.5rem
    outline 0
    position absolute
    right 1rem
    width 2.5rem

    &:hover
      filter invert(50%) sepia(81%) saturate(1261%) hue-rotate(161deg) brightness(100%) contrast(107%)

  &.I> button
    background-image var(--svg-wait)

  &>input
    background transparent
    border 2px solid #fff
    box-sizing border-box
    color #fff
    font-size 1.5em
    font-weight 600
    min-width 476px
    outline none
    padding 0.8rem 3.5rem 1rem 1rem
    width 100%

    &::placeholder
      color #ccc
</style>

