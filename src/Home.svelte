<script lang="coffee">
> ./NoUser.svelte
  ./Wall.svelte
  wac.tax/user/User.js > onMe
  svelte > onMount
  ./WaitOnMe.svelte

C = WaitOnMe

# 写 onMount => onMe (xxx)=> 会报错，不知道为什么
unbind = onMe (user)=>
  C = if user.id then Wall else NoUser
  return

onMount =>
  unbind
</script>

<style lang="stylus">
b
  font-weight 400
  height 100%
  overflow auto
  position absolute
  width 100%
</style>

<template lang="pug">
svelte:component(this="{ C }")
</template>
