> ./_sync.coffee:_sync
  ./DB.coffee
  ./TABLE.coffee > TO_SYNC
  ./getOr0.coffee

< (table)=>
  [uid,r,w] = DB()
  await w[TO_SYNC].put {
    table
    n:await getOr0(r[TO_SYNC],table)+1
  }
  _sync uid, r, w
