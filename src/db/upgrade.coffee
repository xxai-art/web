> ./COL.coffee > TS
  ./TABLE.coffee > FAV SYNCED TO_SYNC

export default (db)=>
  # upgrade(db, oldVersion, newVersion, transaid, event)
  createStore = (name, keyPath)=>
    db.createObjectStore name, {keyPath}

  createStore(
    FAV
    ['cid','rid',TS]
  ).createIndex TS,TS

  for li from [
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

