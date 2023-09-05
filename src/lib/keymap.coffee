> @w5/pair
  wac.tax/wtax/On.js

< (args...)=>
  key_map = new Map pair args
  On(
    document.body
    keyup: (e)=>
      {tagName:t} = document.activeElement
      if ['TEXTAREA', 'AREA'].includes(t) or ~t.indexOf('-')
        return
      key_map.get(e.keyCode)?()
      return
  )
