> wac.tax/_/req.js > HOOK
  msgpackr > unpack

HOOK.set 'x-script', (r)=>
  unpack await r.arrayBuffer()

