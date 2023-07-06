> ./HOOK.coffee:HOOK
  @w5/wasm > vbyteE

export default (cid, rid, render)=>
  key = vbyteE [cid, rid]
  =>
    HOOK.set key, render
    =>
      HOOK.remove key
