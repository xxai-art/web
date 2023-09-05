> ../TOOL.coffee > nextIter
  ./cidRidBound.coffee

< (fav, cid, rid)=>
  li = []
  for await i from nextIter fav, cidRidBound(cid,rid)
    li.push [i.cid,i.rid]
  return Promise.all li.map (i)=>
    fav.delete i
    return
