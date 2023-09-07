> ~/i18n/code.js > SLOGAN

import onMount, { I18N } from "~/i18n/onMount.js"

export TITLE = 'xxAI.Art'

DEFAULT_TITLE = TITLE

onMount =>
  t = TITLE + ' · ' + I18N[SLOGAN]
  if document.title == DEFAULT_TITLE
    document.title = t
  DEFAULT_TITLE = t
  return

export default (tip)=>
  document.title = tip or DEFAULT_TITLE
  return

export suffix = =>
  ' - '+TITLE
