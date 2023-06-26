#!/usr/bin/env coffee

> ./s3.cdn:
  ./env > DIST
  @w5/ossput:put
  @w5/doge
  @w5/read
  path > join
  stream > Readable
  ./cloudflare

url = (i)=>i.slice(i.lastIndexOf('/')+1,-1)

do =>
  for i from read(join DIST,'index.htm').split('<')
    if i.startsWith('script ')
      script = url i
    else if i.startsWith('link ')
      css = url i
  if not css
    return
  txt = css+' '+script
  console.log 'v →',txt
  await put(
    'v'
    =>
      s = new Readable
      s.push txt
      s.push null
      s
    'text/css'
  )

  url = "https://usx.tax/v"
  console.log await Promise.all [
    cloudflare(
      "purge_cache"
      {
        files:[
          url
        ]
      }
    )
    doge(
      'cdn/refresh/add.json'
      {
        rtype: 'url'
        urls: JSON.stringify([
          url
        ])
      }
    )
  ]
  return
