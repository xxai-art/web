> ./DB.coffee > W R
  @w5/time/ms
  @w5/vite > _vbyteE
  ~/ws/CHANNEL.coffee > 用户行为日志
  ~/Ws.coffee > send
  ./TABLE.coffee > LOG

< (action, ...li)=>
  li.unshift action
  W(LOG) (log)=>
    q = decodeURIComponent(location.hash).replace(/^#+/g,'')
    o = {
      ts:ms()
      o:[
        q
        _vbyteE li
      ]
    }

    await log.put o
    send 用户行为日志
    return
  return

