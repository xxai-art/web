#!/usr/bin/env coffee

> @w5/uridir
  fs > createReadStream
  fs/promises > rename writeFile readFile opendir unlink
  path > join dirname
  @w5/blake3/stream.mjs
  @w5/pool > Pool
  base-x
  ./mime
  ./env > DIST ROOT PWD
  @w5/ossput:put
  ./uploadDb > DB tableByExt
  @w5/write
  @w5/read

fp = join DIST,'m.js'

write(
  fp
  read(fp).replace('.endsWith(".css")','.endsWith(".")')
)

BFILE = BaseX '!$-0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ_abcdefghijklmnopqrstuvwxyz'

encode = (n)=>
  bin = Buffer.allocUnsafe 6
  bin.writeUIntBE(n,0,6)
  for i,pos in bin
    if i!=0
      break
  BFILE.encode bin[pos..]

css_js = new Map()
to_replace = []

IGNORE = new Set()

PUBLIC = join(
  ROOT
  'public'
)

for await fp from await opendir PUBLIC
  if not fp.isFile()
    continue
  IGNORE.add fp.name

all = new Set()
for await fp from await opendir DIST
  if not fp.isFile()
    continue
  fp = fp.name
  if IGNORE.has fp
    continue
  all.add fp
  name = fp.split('.')
  ext = name.at -1
  hex = name.at -2
  if ['htm','html','css','js'].includes(ext)
    css_js.set(
      fp
      await readFile(join(DIST,fp),'utf8')
    )
  if not ['s.js','index.html','index.htm'].includes(fp)
    to_replace.push fp

to_replace.sort()

ID = []

for i from to_replace
  fp = join DIST, i
  val = Buffer.from await stream(
    createReadStream fp
  )
  table = tableByExt fp
  id = (await DB(table).where({val}))[0]?.id or 0
  if not id
    [id] = await DB(table).insert({val})
    key = encode id
    if key == 'css'
      continue
    # 跳过这些键
    if [
      'I18N'
      'v'
    ].includes(key)
      await DB(table).where({id}).delete()
      ++id
      await DB(table).insert({id,val})

  ID.push id

for [k,v] from css_js.entries()
  for fp,n in to_replace
    url = encode(ID[n])
    if fp.endsWith '.css'
      url += '.'
    v = v.replaceAll(
      fp
      url
    )
    console.log fp,url
  await writeFile(
    join(DIST,k)
    v
  )

pool = Pool 99


upload = (table, id, fp)=>
  key = encode(id)
  if table == 'css'
    key += '.'
  await put(
    key
    =>
      createReadStream fp
    mime i
  )
  await DB(table).where({id}).update({uploaded:true})
  await unlink fp
  return

pool = Pool 64
for i,p in to_replace
  fp = join DIST, i
  id = ID[p]
  table = tableByExt i
  {uploaded} = (await DB(table).where({id}).select())[0]
  if uploaded
    await unlink fp
    continue
  await pool upload, table, id, fp
await pool.done

process.exit()

