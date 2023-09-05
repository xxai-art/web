> wac.tax/wtax/On.js

H = 'H'
D = 'D'
N = 'N'

< (head, scrollElem)=>
  {classList} = head
  pre_y = 0
  pre_diff = 0
  ing = 0

  setIng = =>
    ing = 1
    setTimeout(
      =>
        ing = 0
        if classList.contains H
          classList.remove H
          classList.add N
        return
      300
    )
    return

  On(
    scrollElem
    scroll: =>
      if ing
        return
      {scrollTop} = scrollElem
      if scrollTop != pre_y
        diff = scrollTop - pre_y

        if Math.abs(diff) > 20
          pre_y = scrollTop

          add = remove = undefined

          if diff > 0 and pre_diff <= 0
            add = H
            remove = D
          else if diff < 0 and pre_diff > 0
            add = D
            remove = H
            classList.remove N

          if add
            classList.remove remove
            classList.add add
            setIng()

          pre_diff = diff
      return
  )

