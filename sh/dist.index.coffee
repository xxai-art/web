#!/usr/bin/env coffee

> ./env.coffee > PWD DIST
  html-minifier-terser > minify
  path > join
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
if not prehtm.includes 'document.write'
  end = prehtm.lastIndexOf '></script>'
  begin = prehtm.lastIndexOf('/',end)+1
  v = prehtm.slice(begin, end)
  filename = 'v'
  await put(
    filename
    =>
      v
    ''
  )
  cdn = 'https://'+CDN
  {hostname} = new URL(cdn)
  [{id}] = await cf.GET('?name='+hostname)
  url = cdn+filename
  n = 0
  loop
    console.log "清理cloudflare缓存 ， 第 #{++n} 次"
    await cf.POST id+'/purge_cache', files: [url]
    t = await reqTxt url
    if t == v
      console.log '清理完成'
      break
    await sleep 1e3

write(
  prehtm_fp
  htm
)

{env} = process
for i from 'OSSPUT_BUCKET BACKBLAZE_url'.split(' ')
  env[i] = env['SITE_'+i]

DB = knex {
  client:  'better-sqlite3'
  useNullAsDefault: true
  connection: {
    filename: join PWD, 'dist.public.db'
  }
}
for await i from walkRel DIST
  console.log i
# await put(
#   'index.htm'
#   =>createReadStream(prehtm_fp)
#   mime(prehtm_fp)
# )
