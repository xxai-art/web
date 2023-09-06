#!/usr/bin/env coffee

> ./env.coffee > PWD DIST
  @w5/u8 > u8eq
  @w5/utf8/utf8e.js
  html-minifier-terser > minify
  @w5/blake3 > blake3Hash
  @w5/blake3/stream.mjs
  path > join
  knex
  @w5/walk > walkRel
  ./mime
  fs > createReadStream
  @w5/sleep
  @w5/write
  @w5/req/reqTxt
  @w5/ossput:put
  @w5/cf
  @w5/cf/Zone
  pug
  @w5/read
  coffeescript
  @w5/coffee_plus:hack
  esbuild


hack coffeescript
{CDN} = process.env
js = coffeescript.compile(
  read(
    join PWD,'index.coffee'
  ).replace(
    'CDN=\'\''
    'CDN=\''+CDN+'\''
  )
  bare:true
)

{code:js} = await esbuild.transform(js, {
  minify: true
})

js = js.trim().replace(',document.write',';document.write').replace(/;$/,'')

htm = pug.renderFile(
  join PWD,'index.pug'
)

htm = await minify htm,{
  collapseWhitespace: true
  html5: true
  minifyCSS: true
  minifyJS: true
  removeAttributeQuotes: true
  removeComments: true
  removeRedundantAttributes: true
  removeScriptTypeAttributes: true
  removeStyleLinkTypeAttributes: true
  useShortDoctype: true
}
htm = htm.replace(
  '<script type=module></script>'
  '<script type=module>'+js+'</script>'
)

prehtm_fp = join DIST, 'index.htm'
prehtm = read prehtm_fp

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

dbExist = (fp, hash)=>
  pre = await DB(TABLE).select('hash').where({fp})
  if pre.length
    if u8eq pre[0].hash, hash
      return
  =>
    t = DB(TABLE)
    if pre.length
      t = t.where({fp}).update(hash)
    else
      t = t.insert({fp,hash})
    t

if not prehtm.includes 'document.write'
  end = prehtm.lastIndexOf '></script>'
  begin = prehtm.lastIndexOf('/',end)+1
  v = prehtm.slice(begin, end)
  fp = 'v'
  hash = blake3Hash utf8e v
  add = await dbExist fp, hash
  if add
    await put(
      fp
      =>
        v
      ''
    )
    cdn = 'https://'+CDN
    {hostname} = new URL(cdn)
    [{id}] = await cf.GET('?name='+hostname)
    url = cdn+fp
    n = 0
    loop
      console.log "清理cloudflare缓存 ， 第 #{++n} 次"
      await cf.POST id+'/purge_cache', files: [url]
      t = await reqTxt url
      if t == v
        console.log '清理完成'
        break
      await sleep 1e3
    await add()

write(
  prehtm_fp
  htm
)

{env} = process
for i from 'OSSPUT_BUCKET BACKBLAZE_url'.split(' ')
  env[i] = env['SITE_'+i]

for await fp from walkRel DIST
  full_fp = join DIST,fp
  add = await dbExist fp, await stream createReadStream full_fp
  if add
    await put(
      fp
      =>
        createReadStream(full_fp)
      mime(full_fp)
    )
    await add()

process.exit()
