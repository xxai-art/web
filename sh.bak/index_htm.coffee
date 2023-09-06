#!/usr/bin/env coffee

> @w5/read
  @w5/write
  ./env > PWD
  path > join
  ./minify

do =>
  dir = join PWD,'index_htm'
  {code} = minify read join dir,'index.js'
  write(
    join PWD,'dist/index.htm'
    "<!doctype html><html><head><meta charset=UTF-8><script type=module>#{code}</script></head><body></body></html>"
  )
  return
