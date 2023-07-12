> ./_sync.coffee:_sync
  ./DB.coffee
  ./TABLE.coffee > TO_SYNC
  ./getOr0.coffee

< (table)=>
  [uid,r,w] = DB()
  o = {
    table
    n:await getOr0(r[TO_SYNC],table)+1
  }
  await w[TO_SYNC].put o
  _sync uid, r, w
