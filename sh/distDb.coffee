#!/usr/bin/env coffee

> ./env > PWD
  path > join
  knex
  @w5/u8 > u8eq

DB = knex {
  client:  'better-sqlite3'
  useNullAsDefault: true
  connection: {
    filename: join PWD, 'dist.public.db'
  }
}
TABLE = 'fp_hash'

if not await DB.schema.hasTable TABLE
  await DB.schema.createTable(
    TABLE
    (t) =>
      t.string('fp').primary()
      t.binary('hash').notNullable()
      return
  )

< dbExist = (fp, hash)=>
  pre = await DB(TABLE).select('hash').where({fp})
  if pre.length
    if u8eq pre[0].hash, hash
      return
  =>
    t = DB(TABLE)
    if pre.length
      t = t.where({fp}).update({hash})
    else
      t = t.insert({fp,hash})
    t
