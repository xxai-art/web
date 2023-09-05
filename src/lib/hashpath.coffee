< =>
  {hash} = location
  url = '/'
  if hash
    url+=hash.slice(1).replace(/^\/+/g,'')
  url

