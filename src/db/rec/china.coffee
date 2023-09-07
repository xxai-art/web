> @w5/vite > binSet vbyteD _vbyteE binMap

ve = (cid,rid)=>
  _vbyteE [cid,rid]

export REC_CHAIN = binMap()

export recRel = (cid,rid)=>
  r = REC_CHAIN.get(
    ve cid,rid
  )
  if r
    return vbyteD r
  return

export default (cid,rid,rcid,rrid)=>
  REC_CHAIN.set(
    ve cid,rid
    ve rcid,rrid
  )
  return
