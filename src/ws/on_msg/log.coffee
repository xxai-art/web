
# > ./DB.coffee > W R
  # ~/var/Level.coffee
  # @w5/vite > _vbyteE vbyteD
  # ./TABLE.coffee > LOG REC_CHAIN
  # ~/const/action/SEEN.coffee
  # ./qLogRecSrc.coffee
# merge = (action,t,o)=>
#   for i in t.slice(1)
#     if action == i[0]
#       i.push ...o.slice(1)
#       return
#   t.push o
#   return

# + ing
#
# sync = (max)=>
#   try
#     await ing
#   ing = new Promise (resolve)=>
#     R(LOG, REC_CHAIN) (log, rc)=>
#       c = await log.openCursor()
#       li = [
#         # [ 查询字符串, [操作, 对象id ...]...]
#       ]
#       ts_li = []
#       + pre, t
#
#       [rec_src,  rec_save] = qLogRecSrc()
#       while c and (--max > 0)
#         {o, ts} = c.value
#         ts_li.push ts
#         key = o[0]
#         o = await rec_src rc, vbyteD o[1]
#         action = o[0]
#         #o = z85VbyteE vbyteD o[1]
#
#         if key == pre
#           if SEEN == action
#             merge(action,t,o)
#           else
#             t.push o
#         else
#           if t
#             li.push t
#           pre = key
#           t = [key, o]
#
#         c = await c.continue()
#
#       if t
#         li.push t
#
#       if ts_li.length
#         for i from li
#           len = i.length
#           p = 0
#           while ++p < len
#             # [操作, 对象id ...] => z85 编码
#             console.log '>>>',i[p]
#             i[p] = _vbyteE i[p]
#         level = Level()
#         console.log level, li
#         # SDK.log(
#         #   level
#         #   ...li
#         # ).then (rec)=>
#         #   rec_save level, rec
#         #
#         #   W(LOG) (log)=>
#         #     for i in ts_li
#         #       await log.delete i
#         #     if max == 0
#         #       sync(max*2)
#         #   return
#       resolve()
#       return
#     return
#   return

export default =>
  console.log 'todo log'
  return
