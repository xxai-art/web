#!/usr/bin/env coffee
> ./env > PWD
  knex
  path > join

export DB = knex {
  client:  'better-sqlite3'
  useNullAsDefault: true
  connection: {
    filename: join PWD, 'filename_min.db'
  }
}

for name from ['css','file']
  if not await db.schema.hasTable name
    await db.schema.createTable(
      name
      (t) =>
        t.integer('id').primary()
        t.boolean('uploaded').defaultTo(false)
        t.binary('val').notNullable().unique()
        return
    )

export tableByExt = (ext)=>
  if fp.endsWith('.css') then 'css' else 'file'
