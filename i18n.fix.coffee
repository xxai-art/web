#!/usr/bin/env coffee

> path > join
  @w5/uridir
  @w5/walk > walkRel
  @w5/yml/Yml

ROOT = join uridir(import.meta),'i18n'

YML = Yml ROOT

fix = (file)=>
  o = YML[file]

  dot = '···'
  {nothing} = o
  if nothing.split(' ').at(-1) != dot
    end = nothing.at(-1)
    nothing = nothing.replaceAll(end,'').trim() + ' ' + dot
    console.log nothing
    o.nothing = nothing
  o.cfg = 'CFG'
  o.txt2img = 'Txt2Img'
  o.img2img = 'Img2Img'
  o.txt2imgSr = 'Txt2Img+SR'
  YML[file] = o
  return

for await fp from walkRel(
  ROOT
  (i)=>i.startsWith('.')
)
  if fp.endsWith('.yml')
    name = fp.slice(0,-4)
    if not ['zh','zh-TW'].includes name
      fix(name)
