< =>
  {pathname, hash} = location
  pathname = pathname.slice(1)
  hash = hash.slice(1)
  if hash
    pathname += '#'+ hash
  if pathname
    pathname = '#'+pathname
  pathname
