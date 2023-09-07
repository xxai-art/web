#!/usr/bin/env coffee

> ./distDb.coffee > dbExist
  @w5/ossput:put
  @w5/cf
  @w5/walk > walkRel
  @w5/blake3/stream.mjs
  path > join
  fs > createReadStream
  ./mime
  ./env > DIST

{env} = process
for i from 'OSSPUT_BUCKET BACKBLAZE_url'.split(' ')
  env[i] = env['SITE_'+i]

to_add = []
files = []

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
    if fp == 'index.htm'
      fp = '/'
    files.push fp
    to_add.push add

if files.length
  [{id}] = await cf.GET('?name=xxai.art')
  await cf.POST id+'/purge_cache', {files}
  for add from to_add
    await add()

process.exit()
