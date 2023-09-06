sleep = (n)=>
  new Promise (resolve)=>
    setTimeout(resolve, n)


HOST = location.host

get = (req) =>
  url = new URL(req.url)

  if url.host != HOST
    config = {
      credentials: "omit"
      mode: "cors"
    }
    try
      res = await fetch(req, config)
    catch e
      # 可有是 no-cors
      delete config.mode
      res = await fetch(req, config)
  else
    res = await fetch(req)

  if res
    res.ok = [200,304].indexOf(res.status) >= 0
    if res.ok
      rc = new Response(res.clone().body, res)
      #rc.headers.set "_", parseInt((new Date)/1000).toString(16)
      caches.open(
        1 # VERSION
      ).then (cache) =>
        cache.put(req, rc)

  return res


do =>
  for k,v of {
    install:(event)=>
      event.waitUntil(skipWaiting())
    activate: (event) =>
      event.waitUntil(clients.claim())
    fetch: (event) =>
      {method} = req = event.request

      if ["GET", "OPTIONS"].indexOf(method) < 0
        return

      {host, pathname} = url = new URL(req.url)

      is_self = (host == HOST)
      if is_self
        if pathname.indexOf(".") < 0
          req = new Request("/", { method: method })
      else if not host.endsWith('.tax')
        return

      event.respondWith do =>
        res = await caches.match(req)
        if res
          if pathname == "/v"
            res = await Promise.race [
              sleep(300).then(=>res)
              get(req)
            ]
        else
          res = get(req)
        res

      return
  }
    addEventListener(k,v)
  return
