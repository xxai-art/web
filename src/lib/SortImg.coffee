LIMIT = 16

minPos = (li, getW) ->
  minValue = Infinity
  minPosition = -1

  for i, p in li
    v = getW(i)
    if v < minValue
      minValue = v
      minPosition = p

  minPosition


nextRow = (width, li, getW)=>
  n = 0
  len = li.length
  sum = 0
  while n < len
    t = getW(li[n++])
    sum += t
    if sum > width
      break
  if sum > width
    --n
    sum -= t
  if n == 0 and len
    r = [1, 0]
  else
    r = [n,width-sum]
  return r


match = (width, li, getW)=>
  [t_len,space] = nextRow(width,li,getW)
  t = li.slice(0,t_len)
  li = li.slice(t_len)

  if space <= 0
    return [t,li]

  if (not li.length)
    return [t,li]

  if t_len == 1
    min = Infinity
    xx = 0
    loop
      to_insert = undefined
      for i,pos in li.slice(0,LIMIT)
        w = getW(i)
        diff = space - w
        if diff > 0
          if diff < min
            min = diff
            to_insert = pos
      if to_insert!=undefined
        t.push li[to_insert]
        li.splice(to_insert,1)
        space = min
      else
        break
    return [t,li]

  min_pos = minPos t,getW
  while t.length
    t_min_o = t[min_pos]
    t_min = min = getW t_min_o
    space += min

    replace_p = -1
    for o,p in li.slice(0, LIMIT)
      i = getW(o)
      if i == space
        replace_p = p
        break
      if i + t_min == space
        t.push o
        li.splice(p,1)
        return [t, li]
      if i > min and i < space
        min = i
        replace_p = p

    if ~ replace_p
      t.splice(min_pos,1)
      [add] = li.splice(replace_p,1)
      t.push add
      li.unshift t_min_o
      space -= getW(add)
      if not space
        break
    else
      break
    min_pos = minPos t, getW
    if t_len == min_pos + 1
      break

  return [t,li]


sort = (width, li, getW)=>
  r = []
  limit = Number.parseInt(width/50)+1

  loop
    if not li.length
      break
    [t,tli] = match(
      width
      li.slice(0,limit)
      getW
    )
    li = tli.concat li.slice(limit)
    r.push t
  r


export default (width, li, getW)=>
  sort width, li, getW
