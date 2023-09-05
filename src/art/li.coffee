> ./IDB.coffee > LI W R
  ../lib/CID.coffee > CID_IMG
  wac.tax/_/SDK.js
  @w5/vite > _vbyteE b64E binMap binU64
  ~/lib/cidRidLi.coffee

META = new Map [
  [
    CID_IMG
    (bytes)=>
      [
        bytes.slice(0,16)
        binU64 bytes.slice 16
      ]
  ]
]

< meta = (show)=>
  if not show.length
    return []

  bm = binMap()
  #n = 0
  cache = R[LI]
  to_fetch = []
  for i from show
    key = _vbyteE i
    o = await cache.get(key)
    if o?.v
      bm.set key, o.v
    else
      to_fetch.push i

  all = cidRidLi(to_fetch)
  if all.length
    meta_all = await SDK.hr ...all
    cache = W[LI]
    for meta_li,pos in meta_all
      rid_li = all[pos]
      cid = rid_li.shift()
      for rid,pos in rid_li
        v = meta_li[pos]
        id = _vbyteE [cid, rid]
        cache.put {id,v}
        bm.set(
          id
          v
        )

  toAdd = []
  for i from show
    [cid, rid] = i
    r = bm.get _vbyteE i
    if r
      func = META.get(cid)
      r = func r
      toAdd.push [
        cid, rid, ...r
      ]
  toAdd
