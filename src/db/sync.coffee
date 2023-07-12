> ./_sync.coffee:_sync
  ./DB.coffee
  ./TABLE.coffee > TO_SYNC

< (table)=>
  [uid,r,w] = DB()
  await w[TO_SYNC].put {
    table
    n:await getOr0(r[to_sync],table)+1
  }
  _sync uid, r, w
