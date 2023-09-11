> @w5/vite > _vbyteE
  ./HOOK.coffee > hook
  wac.tax/_/channel.js > toAll hook:channelHook
  ~/const/channel.coffee > MSG_FAV

CALL = new Set [hook]

call = (key, aid)=>
  for f from CALL
    f(key, aid)
  return

channelHook MSG_FAV, call

send = (key, val)=>
  call key, val
  toAll MSG_FAV, key, val

< (cid, rid, aid)=>
  key = _vbyteE [cid, rid]
  send key, aid
  return

< favHook = (func)=>
  CALL.add func
  =>
    CALL.delete func
