> ./toAll.coffee
  ./rm.coffee

< (s,cid,rid,ts,aid)=>
  await rm(s, cid, rid)
  await s.put {
    cid
    rid
    aid
    ts
  }
  toAll(cid, rid, aid)
  return
