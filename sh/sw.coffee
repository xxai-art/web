con = console
HOST = location.host
{protocol,host:HOST} = location

sleep = (n)=>
  new Promise (resolve)=>
    setTimeout(resolve, n)

now = =>
  parseInt new Date / 1000

_get = (req) =>
  url = new URL(req.url)

  if url.host != HOST
    config = {
      credentials: 'omit'
      mode: 'cors'
    }
    try
      res = await fetch(req, config)
    catch e
      delete config.mode
      res = await fetch(req, config)
  else
    res = await fetch(req)

  if res
    ok = [200,301,304].includes(res.status)
    if ok
      res.ok = ok
      cache = res.headers.get('cache-control') or ''
      if cache != 'no-cache'
        sec = /max-age=(\d+)/.exec(cache)
        if sec
          sec = +sec[1]
          if sec > 0
            rc = new Response(res.clone().body, res)
            rc.headers.set '-', (now()+sec).toString(36)
            caches.open(2).then (cache) =>
              cache.put(req, rc)
  return res

get = (req)=>
  n = 0
  loop
    try
      return await _get req
    catch err
      if n++ > 9
        throw err
      con.error n,req,err
  return

# postMessage = (msg) =>
#   for i in await clients.matchAll()
#     i.postMessage msg

EVENT = {
install:(event)=>
  event.waitUntil(skipWaiting())
  return
activate: (event) =>
  event.waitUntil(clients.claim())
  return
fetch: (event) =>
  req = event.request
  {url,method} = req
  if not url.startsWith 'http'
    return

  if ['GET', 'OPTIONS'].indexOf(method) < 0
    return
  if req.headers.get('accept').includes 'stream'
    return
  {host} = url = new URL(url)

  {pathname} = url
  # 单页面
  if host == HOST and not pathname.includes '.'
    req = new Request('/', { method: method })
  event.respondWith(
    caches.match(req).then (res)=>
      if res and (
        parseInt(res.headers.get('-'),36) > now()
      )
        return res
      try
        r = await get(req)
      catch e
        if res
          con.error e
          return res
        throw e
      if res and res.ok and (not r.ok)
        return res
      return r
  )
  return
}

do =>
  for k, v of EVENT
    addEventListener(k,v)
  return

