> wac.tax/_/SDK > init
  ./i18n.js:
  ./conf > API USER_TAX_CDN
  ./lib/reqMsgpack.coffee:
  ./lib/title.coffee

title 'xxAI.Art'

init API, USER_TAX_CDN

# 这样可以避免一些奇怪的错误
import('./boot.coffee')
