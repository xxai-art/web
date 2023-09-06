var HOST, get, sleep;

sleep = (n) => {
  return new Promise((resolve) => {
    return setTimeout(resolve, n);
  });
};

HOST = location.host;

get = async(req) => {
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
      // 可有是 no-cors
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
      //rc.headers.set "_", parseInt((new Date)/1000).toString(16)
      caches.open(1).then((cache) => { // VERSION
        return cache.put(req, rc);
      });
    }
  }
  return res;
};

(() => {
  var k, ref, v;
  ref = {
    install: (event) => {
      return event.waitUntil(skipWaiting());
    },
    activate: (event) => {
      return event.waitUntil(clients.claim());
    },
    fetch: (event) => {
      var host, is_self, method, pathname, req, url;
      ({method} = req = event.request);
      if (["GET", "OPTIONS"].indexOf(method) < 0) {
        return;
      }
      ({host, pathname} = url = new URL(req.url));
      is_self = host === HOST;
      if (is_self) {
        if (pathname.indexOf(".") < 0) {
          req = new Request("/", {
            method: method
          });
        }
      } else if (!host.endsWith('.tax')) {
        return;
      }
      event.respondWith((async() => {
        var res;
        res = (await caches.match(req));
        if (res) {
          if (pathname === "/v") {
            res = (await Promise.race([
              sleep(300).then(() => {
                return res;
              }),
              get(req)
            ]));
          }
        } else {
          res = get(req);
        }
        return res;
      })());
    }
  };
  for (k in ref) {
    v = ref[k];
    addEventListener(k, v);
  }
})();
