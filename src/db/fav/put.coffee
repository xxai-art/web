> ./toAll.coffee

< (s,cid,rid,ts,aid)=>
  await s.put {
    cid,rid,ts,aid
  }
  toAll(cid, rid, aid)
  return
