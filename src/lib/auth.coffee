> ../conf > USER_TAX_CDN
  wac.tax:
  wac.tax/_/byTag.js > byTag0
  wac.tax/user/i18n/var > ver
  wac.tax/_/Box
  wac.tax/_/req.js
  wac.tax/_/utf8d.js
  wac.tax/_/lang
  wac.tax/user/Auth.agree:AuthAgree
  wac.tax/user/Sign.auth:SignAuth
  wac.tax/user/WAY > waySet
  wac.tax/user/WAY/MAIL

waySet(MAIL)

export default boxAuth = (up) =>
  box = Box(
    '<div class="auth"><header><b class="org"><b></b><b><i-slogan></i-slogan></b></b></header><u-auth></u-auth></div>',
  )
  Object.assign(byTag0(box,"u-auth"), {
    up
    next: box.close.bind(box),
  })
  box

SignAuth(boxAuth)

AuthAgree =>
  dialog = Box(
    '<div style="padding:0 1.8em 2em;height:calc(100vh - 8em);"><b style="height:100%;justify-content:center;display:flex;align-items:center"><svg xmlns="http://www.w3.org/2000/svg" width="64" height="64" viewBox="0 0 100 100"><circle cx="50" cy="50" fill="none" stroke="#ccc" stroke-width="10" r="35" stroke-dasharray="164.93361431346415 56.97787143782138"><animateTransform type="rotate" repeatCount="indefinite" dur="1s" values="0 50 50;360 50 50" keyTimes="0;1" attributeName="transform"/></circle></svg></b></div>',
  )
  [md, marked] = await Promise.all([
    utf8d await req(USER_TAX_CDN + "user/#{ver}/law." + lang())
    import("//cdn.staticfile.org/marked/5.0.0/lib/marked.esm.min.js")
  ])
  dialog.lastChild.innerHTML = marked.parse(md)
  dialog.style = "width:85vw;max-width:750px"
  return

