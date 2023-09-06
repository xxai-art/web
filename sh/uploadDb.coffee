#!/usr/bin/env coffee
> ./env > PWD
  knex
  path > join

< ID_HASH = 'id_hash'

export default new Proxy(
  {}
  get:(_,name)=>
    db = knex {
      client:  'better-sqlite3'
      useNullAsDefault: true
      connection: {
        filename: join PWD, name+'.db'
      }
    }

    if not await db.schema.hasTable ID_HASH
      await db.schema.createTable(
        ID_HASH
        (t) =>
          t.integer('id').primary()
          t.boolean('uploaded').defaultTo(false)
          t.binary('val').notNullable().unique()
          return
      )
    db
)
