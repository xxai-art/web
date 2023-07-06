> ./HOOK.coffee:HOOK

export default (cid, rid, render)=>
  key = vbyteE [cid, rid]
  =>
    HOOK.set key, render
    =>
      HOOK.remove key
