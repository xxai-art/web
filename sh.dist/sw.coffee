con = console
HOST = location.host
{protocol,host:HOST} = location
HOST_URL = protocol+"//#{HOST}/"

sleep = (n)=>
  new Promise (resolve)=>
    setTimeout(resolve, n)

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
    res.ok = [200,304].indexOf(res.status) >= 0
    if res.ok
      rc = new Response(res.clone().body, res)
      rc.headers.set "_", parseInt((new Date)/1000).toString(16)
      caches.open(
        1 # version
      ).then (cache) =>
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
      if res
        if pathname == '/v' # 刷新
          _get req
          return res
        else
          cache = res.headers.get("cache-control") or ''
          loop
            if cache
              if cache == "no-cache"
                break
              sec = /max-age=(\d+)/.exec(cache)
              if sec and (
                (
                  (
                    new Date()/1000 - parseInt(res.headers.get("_"),16)
                  ) - sec[1]
                ) > 0
              )
                break
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

