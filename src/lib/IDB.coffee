> wac.tax/_/IDB.js

export SAMPLER_NAME = 'samplerName'

KEY_PATH = keyPath:'id'

[DB,R,W] = await IDB.art(
  1 # version
  upgrade:(db)=> # upgrade(db, oldVersion, newVersion, transaction, event)
    db.createObjectStore(SAMPLER_NAME, KEY_PATH)
    return
)

export default DB
export R = R
export W = W

