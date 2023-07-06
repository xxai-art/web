> ./HOOK.coffee:HOOK


export watch = (cid, rid, render)=>
  key = vbyteE [cid, rid]
  =>
    HOOK.set key, render
    =>
      HOOK.remove key
