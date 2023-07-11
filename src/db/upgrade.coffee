> ./COL.coffee > TS
  ./TABLE.coffee > FAV FAV_YM SYNCED TO_SYNC

export default (db)=>
  # upgrade(db, oldVersion, newVersion, transaction, event)
  createStore = (name, keyPath)=>
    db.createObjectStore name, {keyPath}

  createStore(
    FAV
    ['cid','rid',TS]
  ).createIndex TS,TS

  for li from [
    [
      FAV_YM
      'id'
    ]
    [
      SYNCED
      TO_SYNC
      'table'
    ]
  ]
    config = li.pop()
    for t from li
      createStore t, config
  return

