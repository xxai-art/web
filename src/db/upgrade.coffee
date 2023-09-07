> ./COL.coffee > TS ID CID_RID CID
  ./TABLE.coffee > FAV SYNCED SEEN LOG KV REC REC_POOL REC_CHAIN

export default (db)=>
  # upgrade(db, oldVersion, newVersion, transaid, event)
  createStore = (name, keyPath)=>
    db.createObjectStore name, {keyPath}

  for s from [
    [SEEN, ID]
    [FAV,CID_RID]
  ]
    createStore(...s).createIndex TS,TS

  i = -1
  while ++i < 3
    for k from [REC, REC_POOL]
      createStore(
        k+i
        ID
      ).createIndex TS,TS

  for li from [
    [
      REC_CHAIN
      [
        ID
        'p'
      ]
    ]
    [
      KV
      'k'
    ]
    [
      LOG
      TS
    ]
    [
      SYNCED
      'p'
    ]
  ]
    createStore ...li
  return

