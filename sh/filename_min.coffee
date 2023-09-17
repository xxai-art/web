#!/usr/bin/env coffee

> @w5/uridir
  @w5/utf8/utf8e.js
  fs > createReadStream
  fs/promises > rename writeFile readFile opendir unlink readdir
  path > join dirname
  @w5/blake3 > blake3Hash
  @w5/blake3/stream.mjs
  @w5/pool > Pool
  base-x
  ./mime
  ./env > DIST ROOT PWD
  @w5/ossput:put
  ./uploadDb > DB tableByExt
  @w5/write
  @w5/read

m_js_name = 'm.js'

fp = join DIST,m_js_name

m_js = read(fp)

end_css = '.endsWith(".css")'
if m_js.indexOf(end_css) > 0
  m_js = m_js.replace(end_css,'.endsWith(".")')
  # 修复重复导入
  # begin = m_js.indexOf('(()=>import("./boot') + 12
  # end = m_js.indexOf('"',begin+1)
  # m_js = m_js.slice(0,end+4)+m_js.slice(end*2+4-begin)

  m_js = 'await navigator.serviceWorker.register("/s.js");'+m_js
  out_name = Buffer.from(blake3Hash(utf8e(m_js))).toString('base64url') + '.js'
  out = join(
    DIST
    out_name
  )
  write(
    out
    m_js
  )
  await unlink fp

  # 替换所有的 m.js 引用，避免引用上一个版本的文件
  for i from await readdir(DIST)
    if i.endsWith '.js'
      if i == out_name
        continue
      js_fp = join DIST,i
      js = read js_fp
      js_new = js.replaceAll('"./'+m_js_name+'"','./'+out_name)
      if js!=js_new
        write(
          js_fp
          js_new
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
    # console.log fp,url
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

