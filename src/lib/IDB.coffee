> wac.tax/_/IDB.js
  wac.tax/_/leader.js > ON
  wac.tax/_/channel.js > toAll hook

export SAMPLER_NAME = 'samplerName'
export FAV = 'fav'
export FAV_STATE = 'favState'
export FAV_YM = 'favYm'
export FAV_Y = 'favY'
export SUM = 'sum'
export SYNCED = 'synced'

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
    db.createObjectStore(
      SYNCED
      keyPath: ['uid','table']
    )
    return
)

export default DB
export R = R
export W = W

> wac.tax/user/User.js > Uid onMe

+ INTERVAL, PRE

onMe =>
  PRE = {}

ON.add (leader)=>
  if leader
    setInterval(
      =>
        sum = R[SUM]
        uid = Uid()
        c = await sum.openCursor(IDBKeyRange.lowerBound [uid,''])
        updated = []
        while c
          {n, table} = c.value
          if PRE[table] != n
            updated.push [table, n]
            PRE[table] = n
          c = await c.continue()

        for [table, n] from updated
          synced = (await R[SYNCED].get([uid, table]))?.n or 0
          if n != synced
            diff = n - synced
            # 拉出最后 diff 条，然后扔给服务器
            console.log {diff}
        return
      1e3
    )
    document.title = 'leader'
  else
    clearInterval INTERVAL
    PRE = {}
    document.title = ''
  return
