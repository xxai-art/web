do =>
  navigator.serviceWorker.register('/s.js')
  CDN=''
  document.write("<script type=module src=#{CDN}/#{await (await fetch(CDN+'/v')).text()}></script>")
  return
