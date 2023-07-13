> ./route.coffee > refresh
  ./hashchange.coffee

SLASH = '/'

< (url='',title='')=>
  if url.charAt(0) != SLASH
    url = SLASH + url
  has_hash = location.hash
  history.pushState null,title,url
  if has_hash
    window.dispatchEvent(new HashChangeEvent hashchange)

  refresh()
  return
