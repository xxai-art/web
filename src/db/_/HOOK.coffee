> @w5/wasm > BinMap

export default HOOK = new BinMap

< hook = (key, val)=>
  s = HOOK.get key
  if s
    for i from s
      i val
  return
