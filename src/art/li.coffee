> ./IDB.coffee > LI W
   @w5/wasm > vbyteE b64E

< liPut = (li)=>
  db = W[LI]
  for [cid, rid, hash, w, h] from li
    db.put {
      id: vbyteE(cid, rid)
      hash
      w
      h
    }
  return
