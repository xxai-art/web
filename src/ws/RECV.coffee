> @w5/pair/group
  @w5/pair
  @w5/time/ms
  @w5/vite > _vbyteE
  msgpackr > unpack
  # ~/lib/cidRidLi.coffee
  ~/db/fav/put.coffee:favPut
  ~/db/seen/put.coffee:seenPut
  ~/db/TABLE.coffee > FAV SEEN SYNCED REC_POOL REC_CHAIN
  ~/db/SYNC_TABLE.coffee > P_FAV P_SEEN
  ~/db/lastId.coffee
  ~/db/DB.coffee > W R
  ./synced.coffee > done:同步完成
  ~/db/recPool.coffee > poolAdd
# sync = (r,group_n,p, func)=>
#   table = SYNC_TABLE[p]
#   r = r.map Number
#   n = r.pop()
#   if await lastId(R,p) == n
#     W(TABLE) (w)=>
#       for i from group group_n, r
#         await func w,...i
#       W(SYNCED).put {p,n}
#       return
#   return

numli = (r)=>
  unpack(r).map Number

export default [
  同步完成

  (r)=> # 收藏
    r = numli r
    n = r.pop()
    pid = r.pop()
    R(SYNCED) (synced)=>
      if pid == await lastId(synced, P_FAV)
        W(FAV, SYNCED) (fav, synced)=>
          ing = []
          for i from group 4,r
            ing.push favPut fav, ...i
          await Promise.all ing
          await synced.put {p:P_FAV, n}
          return
      return
    return

  (r)=> # 浏览
    r = numli r
    R(SYNCED) (synced)=>
      if r.pop() == await lastId(synced, P_SEEN)
        W(SEEN, SYNCED) (seen, synced)=>
          r = group 3,r
          len = r.length
          for i from r
            await seenPut seen, ...i
          await synced.put {p:P_SEEN, n:r[len-1][0]}
          return
      return
    return

  (r) => # 推荐
    {length:len} = r
    level = r[--len]
    R(SEEN) (seen)=>
      li = []
      for [cid, rec_li_li] from unpack r.slice(0,len)
        for rec_li from rec_li_li
          click_rid = rec_li.pop()
          crl = []
          pos = 0
          while pos < rec_li.length
            cid = rec_li[pos++]
            n = rec_li[pos++]
            end = 1 + pos + n
            for rid from rec_li.slice(pos,end)
              bin = _vbyteE [cid,rid]
              if not await seen.get bin
                crl.push cid,rid
            pos = end
          if crl.length
            li.push [
              _vbyteE [cid, click_rid]
              crl
            ]
      W(REC_POOL+level, REC_CHAIN) (rp,rc)=>
        ts = ms()
        for [p, crl] from li
          to_add = []
          for i from pair crl
            id = _vbyteE i
            if not await rc.get([id,p])
              rc.put {id,p}
              to_add.push i
          if to_add.length
            id = _vbyteE to_add
            await rp.put {id, ts}
            poolAdd ts, id
            ++ts
        return
    return
]
