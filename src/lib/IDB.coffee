> wac.tax/_/IDB.js
  wac.tax/_/leader.js > ON

ON.add (leader)=>
  if leader
    document.title = 'leader'
  else
    document.title = ''
  return

export SAMPLER_NAME = 'samplerName'
export FAV = 'fav'
export FAV_STATE = 'favState'
export FAV_INDEX_UID_CID_RID_ID = 'uidCidRidId'

KEY_PATH = keyPath:'id'


[DB,R,W] = await IDB.art(
  1 # version
  upgrade:(db)=> # upgrade(db, oldVersion, newVersion, transaction, event)
    db.createObjectStore(SAMPLER_NAME, KEY_PATH)
    store = db.createObjectStore(FAV, KEY_PATH)
    store = db.createObjectStore(FAV_STATE, KEY_PATH)
    store.createIndex(FAV_INDEX_UID_CID_RID_ID,['uid','cid','rid','id'])
    store.createIndex('uidId',['uid','id'])
    return
)

export default DB
export R = R
export W = W


