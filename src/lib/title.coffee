> ~/i18n/code.js > SLOGAN

import onMount, { I18N } from "~/i18n/onMount.js"

+ DEFAULT_TITLE, TITLE

onMount =>
  t = TITLE + ' · ' + I18N[SLOGAN]
  if document.title == DEFAULT_TITLE
    document.title = t
  DEFAULT_TITLE = t
  return

setTitle = (title)=>
  TITLE = DEFAULT_TITLE = title
  setTitle = =>
    document.title = title or DEFAULT_TITLE
    return
  setTitle title
  return

export default (tip)=>
  setTitle tip
  return

export suffix = =>
  ' · '+TITLE
