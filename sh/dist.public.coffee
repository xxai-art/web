#!/usr/bin/env coffee

> ./distDb.coffee > dbExist
  @w5/ossput:put

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
