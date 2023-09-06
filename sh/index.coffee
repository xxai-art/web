do =>
  CDN=''
  document.write("<script type=module src=#{CDN}#{await (await fetch(CDN+'v')).text()}></script>")
  return
