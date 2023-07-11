> ./TOOL.coffee > nextIter bound

< (fav, cid, rid)=>
  begin = [cid, rid, 0]
  end = begin.slice()
  end[1] += 1
  li = []
  for await i from nextIter fav,bound(begin, end)
    li.push [i.cid,i.rid,i.ts]
  return Promise.all li.map (i)=>
    fav.delete i
    return
