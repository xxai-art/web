> wac.tax/_/IDB.js

export SAMPLER_NAME = 'samplerName'
export META = 'meta'

[DB,R,W] = await IDB.art(
  1 # version
  upgrade:(db)=> # upgrade(db, oldVersion, newVersion, transaction, event)
    createStore = (name, keyPath)=>
      db.createObjectStore name, {keyPath}
    createStore(SAMPLER_NAME, 'id')
    createStore(META, 'id')
    return
)

export default DB
export R = R
export W = W

