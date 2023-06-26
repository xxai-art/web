> ./route.coffee > refresh

SLASH = '/'

< (url,title='')=>
  if url.charAt(0) != SLASH
    url = SLASH + url
  history.pushState null,title,url
  refresh()
  return
