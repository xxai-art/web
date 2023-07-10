<script lang="coffee">
> svelte > onMount
  ./lib/auth.coffee
  ./lib/CID.coffee > CID_USER
  @w5/wasm > b64VbyteE
  wac.tax/user/User.js > onMe

+ menu,ME
onMount =>
  onMe (user)=>
    ME = '/-'+ b64VbyteE [CID_USER, user.id]
    return

signUp = =>
  auth(1)
  return

signIn = =>
  auth()
  return
</script>

<template lang="pug">
u-menu(@&menu)
  a(@click=signIn)
    i-t SIGN_IN
  | /
  a(@click=signUp)
    i-t.up SIGN_UP
  b(slot="ul")
    a(href:ME) 个人页
</template>

<style lang="stylus">
u-menu
  font-size 16px

  &>a
    margin-left 5px

    &:first-child
      margin-right 5px

  &>b
    &>a
      border 1px solid transparent
      border-top-color #ccc
      display block
      font-weight normal
      margin 0
      padding 8px 16px
      text-align center
      white-space nowrap

      &:hover
        background #f40
        border-color #f40
        color #fff
        font-weight normal
        padding-bottom 8px
</style>

