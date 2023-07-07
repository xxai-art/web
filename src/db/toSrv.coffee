> wac.tax/_/SDK.js
  ./TABLE.coffee > SYNCED SYNCED_ID

< (table, user_id, write, li)=>
  id = await SDK[table] user_id, li
  if id
    write[SYNCED_ID].put({
      table, id
    })
  write[SYNCED].put({
    table, n
  })
  return
