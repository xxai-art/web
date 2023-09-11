> ~/db/SYNC_TABLE.coffee > P_SEEN
  ~/db/sync.coffee
  ~/db/TABLE.coffee > SEEN
  ~/db/DB.coffee > W

export default (see_li)=>
  if see_li.length
    W(
      SEEN
    ) (w)=>
      ing = []
      for id from see_li
        if not await w.get id
          ing.push w.put {id,ts:-new Date}
      await Promise.all ing
      if ing.length
        sync(P_SEEN)
      return
  return
