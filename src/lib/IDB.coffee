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

UID_CTIME = 'uidCtime'
< PREV = 'prev'

KEY_PATH = keyPath:'id'

[DB,R,W] = await IDB.art(
  1 # version
  upgrade:(db)=> # upgrade(db, oldVersion, newVersion, transaction, event)
    db.createObjectStore(SAMPLER_NAME, KEY_PATH)

    store = db.createObjectStore(
      FAV
      keyPath: ['uid','cid','rid','ctime']
    )
    store.createIndex(UID_CTIME,['uid','ctime'])

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

_iter = (direction,table,range,index)->
  c = R[table]
  if index
    c = c.index(index)
  c = await c.openCursor(range,direction)
  while c
    yield c.value
    c = await c.continue()
  return

export nextIter = _iter.bind _iter,undefined
export prevIter = _iter.bind _iter,PREV

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

        range = [IDBKeyRange.upperBound([uid+1,0]),UID_CTIME]
        for [table, n] from updated
          synced = (await R[SYNCED].get([uid, table]))?.n or 0
          if n != synced
            diff = n - synced
            # 拉出最后 diff 条，然后扔给服务器

            li = []
            console.log {diff}
            for await o from prevIter(table,...range)
              li.unshift o
              if -- diff == 0
                break
            console.log li
            # c = await R[table].index(UID_CTIME).openCursor(),PREV)
            # while c
            #   console.log c.value
            #   c = await c.continue()
        return
      1e3
    )
    document.title = 'leader'
  else
    clearInterval INTERVAL
    PRE = {}
    document.title = ''
  return
