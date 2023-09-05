<script lang="coffee">
> ./NoUser.svelte
  ./img/Wall.svelte
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


<template lang="pug">
svelte:component(this="{ C }")
</template>
