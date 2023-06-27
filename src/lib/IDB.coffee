> wac.tax/_/IDB.js
  ./keyPath.coffee

export SAMPLER_NAME = 'samplerName'


[DB,R,W] = await IDB.art(
  1 # version
  upgrade:(db)=> # upgrade(db, oldVersion, newVersion, transaction, event)
    db.createObjectStore(SAMPLER_NAME, keyPath)
    return
)

export default DB
export R = R
export W = W

