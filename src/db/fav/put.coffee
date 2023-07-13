> ./toAll.coffee
  ./rm.coffee

< (s,cid,rid,ts,aid)=>
  await rm(s, cid, rid)
  await s.put {
    cid,rid,ts,aid
  }
  toAll(cid, rid, aid)
  return
