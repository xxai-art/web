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
  if not await DB.schema.hasTable name
    await DB.schema.createTable(
      name
      (t) =>
        t.integer('id').primary()
        t.boolean('uploaded').defaultTo(false)
        t.binary('val').notNullable().unique()
        return
    )

export tableByExt = (fp)=>
  if fp.endsWith('.css') then 'css' else 'file'
