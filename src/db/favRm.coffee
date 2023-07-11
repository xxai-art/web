> ./TOOL.coffee > nextIter bound

< (fav, cid, rid)=>
  begin = [cid, rid, 0]
  end = begin.slice()
  end[1] += 1
  for i from nextIter fav,bound(begin, end)
    await fav.delete i
  return
