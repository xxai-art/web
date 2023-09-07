> ./a.coffee:

+ PRE

HOOK = []

< (hook)=>
  HOOK.push hook
  hook(location.pathname[1..],PRE)
  return

< refresh = =>
  {pathname} = location
  url = pathname[1..]
  if url != PRE
    for f from HOOK
      f(url, PRE)
    PRE = url
  return

window.onpopstate = refresh

