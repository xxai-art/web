> @w5/vite > binMap

export default HOOK = binMap()

< hook = (key, val)=>
  s = HOOK.get key
  if s
    for i from s
      i val
  return
