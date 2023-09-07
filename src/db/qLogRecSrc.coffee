> @w5/vite > _vbyteE vbyteD binSet
  @w5/time/ms
  @w5/u8 > u8eq
  @w5/pair
  ./COL.coffee > TS
  ./DB.coffee > R W
  ./TABLE.coffee > SEEN REC_POOL REC_CHAIN
  ./TOOL.coffee > nextIter
  ~/const/action/CLICK.coffee
  ~/const/action/FAV.coffee
  ~/const/action/FAV_RM.coffee
  ./recPool.coffee > poolAdd poolRetop

iter = (db, bin)=>
 end = new Uint8Array(bin.length + 1)
 end.set(bin)
 nextIter db, IDBKeyRange.bound([bin], [end],  false, true)

< =>
  to_log = []
  exist = binSet()

  [
    (rc, [action,o...])=> # rec src
      switch action
        when FAV,CLICK,FAV_RM
          [cid,rid] = o
          bin = _vbyteE [cid, rid]
          if action == FAV_RM
            exist.delete bin
            to_log = to_log.filter(
              (b)=>not u8eq(bin,b)
            )
          else if not exist.has bin
            exist.add bin
            to_log.push bin
            poolRetop bin
            # TODO 先插入 直接上级的个数，然后插入上级的上级，最多插入5个
            # bin = new Uint8Array [2, 135, 162, 26]

            t = []

            limit = 9
            for await {p} from iter rc,bin
              t.push p
              {length} = t
              if length >= limit
                break
            if length
              o.push length
              for i from t
                o.push ...vbyteD i

              while length and (length < limit)
                tli = []
                for b from t
                  for await {p} from iter rc,b
                    tli.push p
                    o.push ...vbyteD p
                {length} = t = tli
      [action, ...o]

    (level, rec)=> # rec save
      R(SEEN) (seen)=>
        li = []
        for rec_li, rec_pos in rec
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
              to_log[rec_pos],crl
            ]

        W(REC_POOL+level, REC_CHAIN) (rp,rc)=>
          ts = ms()
          for [p, crl] from li
            id = _vbyteE crl
            await rp.put {id, ts}
            poolAdd ts, id
            for i from pair crl
              id = _vbyteE i
              rc.put {id,p}
            ++ts
          return
        return
      return
  ]
