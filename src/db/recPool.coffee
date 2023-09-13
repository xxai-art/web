> ./DB.coffee > R W
  @w5/pair
  wac.tax/_/SDK.js
  @w5/time/ms
  ./TABLE.coffee > REC_POOL REC KV SEEN
  ./COL.coffee > TS
  ~/lib/sampling.coffee
  @w5/vite > z85VbyteE vbyteD _vbyteE binSet binMap
  ./TOOL.coffee > prevIter
  ./KV.coffee > REC_OFFSET_TIME

###
TODO 当一个被点击，同组的全部更新为最新时间

ts - li
当 推荐 一个 就删除一个
qLogRecSrc.coffee 会往其中追加
可以用迭代器返回
可以设置返回级别
控制总ts不超过多少个，超过就删除后续的ts
如果seen，删除，然后下一个
###

{q} = SDK

[
  poolRetop
  poolAdd
  poolRec
] = do =>
  + map_level,gli

  tsli = []
  map = new Map
  existSet = binSet()
  existMap = binMap()
  not_exist = (b)=>
    not (existSet.has(b) or existMap.has(b))

  add = (ts, bin_li)=>
    tsli.unshift ts
    map.set ts,bin_li
    return

  retop = (bin)=>
    ts = existMap.get bin
    if not ts
      return
    p = tsli.indexOf(ts)
    if p > 0
      tsli.splice p,1
    tsli.unshift ts
    W(REC_POOL+map_level) (rp)=>
      id = map.get ts
      rp.delete(id)
      rp.put {id,ts:ms()}
      return
    return

  全局推荐 = (seen, limit)=>
    return_li = []
    n = 0
    while n < limit
      id = gli.pop()
      if not id
        break
      if not_exist(id) and not await seen.get id # 第一次加载可能还没同步好seen
        return_li.push id
        ++n

    rec_db = REC+map_level
    if n
      W(rec_db) (db)=>
        for i from return_li
          db.delete i
        return
    while n < limit
      await new Promise (resolve)=>
        R(KV) (kv)=>
          now = Number.parseInt(+new Date/36e5)

          # 记录时间 和 offset
          pre_time_offset = await kv.get(REC_OFFSET_TIME)

          if pre_time_offset
            [pre_time, offset] = vbyteD pre_time_offset.v
            if pre_time - now > 24
              offset = 0
          else
            offset = 0

          # TODO 换成 cloudflare + fly + CDN 缓存1小时
          li = pair await q '',z85VbyteE [map_level, offset]
          R(SEEN) (seen)=>
            for i from li
              bin = _vbyteE i
              if not_exist(bin) and not await seen.get bin
                if n < limit
                  ++n
                  push_li = return_li
                else
                  push_li = gli
                push_li.push bin

            W(KV, rec_db) (kv, rec)=>
              await kv.put {
                k:REC_OFFSET_TIME
                v:_vbyteE [now, offset+li.length]
              }
              for id from gli
                rec.put {id}
              resolve()
              return
            return
          return
    return return_li

  recer = (level)=>
    new Promise (resolve)=>
      rp_db = REC_POOL+level
      if level != map_level
        map.clear()
        gli = []
        tsli = []
        await new Promise (resolve)=>
          R(rp_db, REC+level) (rp, r)=>
            for await {id,ts} from prevIter rp.index(TS)
              map.set ts, id
              tsli.push ts
            for await {id} from prevIter r
              gli.push id
            resolve()
            return
          return
        map_level = level

      update = (ts,bin,id)=>
        W(rp_db) (rp)=>
          rp.delete bin
          if id.length
            rp.put {id,ts}
          return

      remove_ts = (li)=>
        W(rp_db) (rp)=>
          for ts from li
            bin = map.get ts
            rp.delete bin
            map.delete ts
        return

      R(SEEN) (seen)=>
        r = []
        ts_remove = new Set
        for ts from sampling(tsli, remove_ts)
          bin = map.get ts
          if bin # 可能是切换了安全级别
            crl = vbyteD bin
            for cr,p in pair crl
              b = _vbyteE cr
              if (not await seen.get b) and not_exist(b)
                existMap.set b, ts
                r.push cr
                break
            new_bin =  crl.slice(2*(p+1))
            if new_bin.length
              new_bin = _vbyteE new_bin
              map.set ts,new_bin
            else
              map.delete ts
              ts_remove.add ts
            update ts, bin, new_bin

        if ts_remove.size
          tsli = tsli.filter (i)=>not ts_remove.has i

        for b from await 全局推荐(seen, 42-r.length)
          existSet.add b
          r.push vbyteD b
        resolve(r)
        return
      return
  [retop, add, recer]

export poolAdd = poolAdd
export poolRetop = poolRetop
export default poolRec
