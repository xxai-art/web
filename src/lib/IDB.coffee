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
export FAV_YM = 'favYm'
export FAV_Y = 'favY'
export SUM = 'sum'

KEY_PATH = keyPath:'id'


[DB,R,W] = await IDB.art(
  1 # version
  upgrade:(db)=> # upgrade(db, oldVersion, newVersion, transaction, event)
    db.createObjectStore(SAMPLER_NAME, KEY_PATH)

    store = db.createObjectStore(
      FAV
      keyPath: ['uid','cid','rid','ctime']
    )
    store.createIndex('uidCtime',['uid','ctime'])

    db.createObjectStore(FAV_STATE, KEY_PATH)
    db.createObjectStore(
      FAV_YM
      keyPath: ['uid','y','m']
    )
    db.createObjectStore(
      FAV_Y
      keyPath: ['uid','y']
    )
    db.createObjectStore(
      SUM
      keyPath: ['uid','table']
    )
    return
)

export default DB
export R = R
export W = W

