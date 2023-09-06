#!/usr/bin/env coffee

> ./env > DIST
  ./mime
  @w5/ossput:put
  ./s3.ali:
  @w5/walk > walkRel
  fs > createReadStream
  path > join

for await i from walkRel DIST
  console.log i
  await put(
    i
    =>
      createReadStream join(DIST, i)
    mime i
  )
