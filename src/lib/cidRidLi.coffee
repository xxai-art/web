< (cid_rid_li)=>
  cid_rid = new Map
  for [cid, rid] from cid_rid_li
    li = cid_rid.get(cid)
    if not li
      li = []
      cid_rid.set cid, li
    li.push rid

  all = []
  for [cid, li] from cid_rid.entries()
    li.unshift cid
    all.push li
  all
