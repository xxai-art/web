#!/usr/bin/env coffee

> @w5/uridir
  @w5/walk
  @w5/read
  path > join

HAN_REGEX = /[\u2E80-\u2E99\u2E9B-\u2EF3\u2F00-\u2FD5\u3005\u3007\u3021-\u3029\u3038-\u303B\u3400-\u4DB5\u4E00-\u9FD5\uF900-\uFA6D\uFA70-\uFAD9]/

hasChinese = (txt) =>
  return not not txt.match(HAN_REGEX)

chineseLine = (fp)=>
  li = []
  for i,pos in read(fp).split '\n'
    i = i.trim()
    p = i.indexOf('#')
    if ~p
      i = i.slice(0,p)
    if hasChinese i
      li.push [pos,i]

  if li.length
    console.log '❯',fp
    for [pos,i] from li
      console.log pos,i
  return


SRC = join uridir(import.meta), 'src'

EXT = new Set ['svelte','js','coffee']

for await fp from walk SRC
  p = fp.lastIndexOf('.')
  if ~ p
    ext = fp.slice(p+1)
    if EXT.has ext
      chineseLine fp


