> ./SortImg.coffee
  wac.tax/wtax/On.js
  @w5/vite > b64D binSet vbyteD
  ~/db/qLog.coffee
  ~/db/seen.coffee:seenSave
  ~/const/IMG_HEIGHT.coffee
  ~/const/action/SEEN.coffee:ACTION_SEEN

< scroll = 'scroll'

DIFF_HEIGHT = -IMG_HEIGHT + 50


< (ul, rowHeight, pull, li, getWidth, refresh)=>
  parentNode = ul.parentNode
  minH = =>
    parentNode.scrollTop + parentNode.offsetHeight

  if li
    len = li.length
    li.splice(0,len)
    refresh(li)
  else
    li = []

  sort = (t)=>
    SortImg(innerWidth, t, getWidth)

  buf = []

  + unbind

  seen = binSet()
  see = binSet()

  saveView = =>
    seenSave see.clear()
    return

  init = (h)=>
    need_n = Math.round(h/rowHeight) + 1
    need_n_next = need_n + 3
    if buf.length < need_n_next and pull
      loop
        r = await pull()
        if not r
          pull = undefined
          break
        [t, has_more] = r
        if not t.length
          pull = undefined
          break
        buf = sort buf.flat().concat t
        if buf.length > need_n_next
          break
        if not has_more
          pull = undefined
          break
      saveView()

    li.splice li.length,0,...buf.slice(0, need_n).flat()
    buf = buf.slice(need_n)

    if not buf.length
      unbind?()
      unbind = undefined

    refresh li
    return

  promise = do =>
    await init minH()
    if not li.length
      return

    _on = {}
    pre = [0,0]
    + pulling
    _on[scroll] = onScroll = throttle(
      =>
        {scrollTop,offsetHeight} = parentNode
        if offsetHeight == 0
          return
        if (offsetHeight <= pre[0]) and (scrollTop<=pre[1])
          return
        pre = [offsetHeight, scrollTop]

        try
          await pulling?()

        needHeight = offsetHeight * 2

        if (scrollTop + needHeight) > ul.offsetHeight
          pulling = init(needHeight).finally =>
            pulling = undefined
            return

        setTimeout(
          =>
            end = Math.max(0, offsetHeight - IMG_HEIGHT)
            view_li = []
            for i from ul.childNodes
              diff = i.offsetTop - scrollTop
              if diff > end
                break
              if diff > DIFF_HEIGHT
                cid_rid = b64D i.childNodes[0].pathname.slice(2)
                if not (see.has(cid_rid) or seen.has(cid_rid))
                  view_li.push ...vbyteD(cid_rid)
                  see.add cid_rid
            if view_li.length
              qLog ACTION_SEEN, ...view_li
              saveView()
            return
        )

        return
      1e3
    )
    onScroll()

    unbind = On(
      parentNode
      _on
    )
    return

  [
    => # unbind
      refresh = =>
      promise.finally =>
        unbind?()
        saveView()
        return
      return
    => # resort
      pre = [0,0]
      buf = sort(li.concat buf.flat())
      li = []
      init minH()
      return
  ]
