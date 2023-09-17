#!/usr/bin/env coffee

> ./env > DIST
  @w5/blake3 > blake3Hash
  path > join
  fs > existsSync
  fs/promises > readdir unlink
  @w5/read
  @w5/write
  @w5/utf8/utf8e.js

< =>
  m_js_name = 'm.js'

  fp = join DIST,m_js_name

  if not existsSync fp
    return
  end_css = '.endsWith(".css")'
  m_js = read(fp).replace(end_css,'.endsWith(".")')
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
    if i == out_name
      continue
    pos = i.lastIndexOf('.')
    if pos < 0
      continue
    ext = i.slice(pos+1)
    if ['htm','js'].includes(ext)
      js_fp = join DIST,i
      js = read js_fp
      js_new = js.replaceAll('"./'+m_js_name+'"','"./'+out_name+'"')
      if js!=js_new
        write(
          js_fp
          js_new
        )
  return
