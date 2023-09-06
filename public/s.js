var EVENT, HOST, HOST_URL, VERSION, _get, con, get, protocol, sleep;

con = console;

VERSION = 1;

HOST = location.host;

({
  protocol,
  host: HOST
} = location);

HOST_URL = protocol + `//${HOST}/`;

sleep = (n) => {
  return new Promise((resolve) => {
    return setTimeout(resolve, n);
  });
};

_get = async(req) => {
  var config, e, rc, res, url;
  url = new URL(req.url);
  if (url.host !== HOST) {
    config = {
      credentials: "omit",
      mode: "cors"
    };
    try {
      res = (await fetch(req, config));
    } catch (error) {
      e = error;
      delete config.mode;
      res = (await fetch(req, config));
    }
  } else {
    res = (await fetch(req));
  }
  if (res) {
    res.ok = [200, 304].indexOf(res.status) >= 0;
    if (res.ok) {
      rc = new Response(res.clone().body, res);
      rc.headers.set("_", parseInt((new Date()) / 1000).toString(16));
      caches.open(VERSION).then((cache) => {
        return cache.put(req, rc);
      });
    }
  }
  return res;
};

get = async(req) => {
  var err, n;
  n = 0;
  while (true) {
    try {
      return (await _get(req));
    } catch (error) {
      err = error;
      if (n++ > 9) {
        throw err;
      }
      con.error(n, req, err);
    }
  }
};

// postMessage = (msg) =>
//   for i in await clients.matchAll()
//     i.postMessage msg
EVENT = {
  install: (event) => {
    event.waitUntil(skipWaiting());
  },
  activate: (event) => {
    event.waitUntil(clients.claim());
  },
  fetch: (event) => {
    var host, method, pathname, req, url;
    req = event.request;
    ({url, method} = req);
    if (!url.startsWith('http')) {
      return;
    }
    if (["GET", "OPTIONS"].indexOf(method) < 0) {
      return;
    }
    if (req.headers.get('accept').includes('stream')) {
      return;
    }
    ({host} = url = new URL(url));
    ({pathname} = url);
    // 单页面
    if (host === HOST && !pathname.includes('.')) {
      req = new Request('/', {
        method: method
      });
    }
    event.respondWith(caches.match(req).then(async(res) => {
      var cache, e, r, sec;
      if (res) {
        if (pathname === '/v') { // 刷新
          _get(req);
          return res;
        } else {
          cache = res.headers.get("cache-control") || '';
          while (true) {
            if (cache) {
              if (cache === "no-cache") {
                break;
              }
              sec = /max-age=(\d+)/.exec(cache);
              if (sec && (((new Date() / 1000 - parseInt(res.headers.get("_"), 16)) - sec[1]) > 0)) {
                break;
              }
            }
            return res;
          }
        }
      }
      try {
        r = (await get(req));
      } catch (error) {
        e = error;
        if (res) {
          con.error(e);
          return res;
        }
        throw e;
      }
      if (res && res.ok && (!r.ok)) {
        return res;
      }
      return r;
    }));
  }
};

(() => {
  var k, v;
  for (k in EVENT) {
    v = EVENT[k];
    addEventListener(k, v);
  }
})();
