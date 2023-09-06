#!/usr/bin/env coffee
> ./env > PWD

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
        (ID_HASH) =>
          ID_HASH.integer('id').primary()
          ID_HASH.boolean('uploaded').defaultTo(false)
          ID_HASH.binary('val').notNullable().unique()
          return
      )
    db
)
