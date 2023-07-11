> ./TOOL.coffee > nextIter bound

< (fav, cid, rid)=>
  begin = [cid, rid, 0]
  end = begin.slice()
  end[1] += 1
  for await i from nextIter fav,bound(begin, end)
    await fav.delete [i.cid,i.rid,i.ts]
  return
