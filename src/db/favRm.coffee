> ./TOOL.coffee > nextIter

< (fav, cid, rid)=>
  begin = t.slice(0,3)
  end = begin.slice()
  end[1] += 1
  end[2] = 0
  for i from nextIter fav,bound(begin, end),PREV)
    await fav.delete i
  return
