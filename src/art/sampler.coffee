> ./IDB.coffee:@ > R W SAMPLER_NAME
  wac.tax/_/req.js
  ../conf > SPI

< (sampler_id)=>
  r = R[SAMPLER_NAME]
  o = await r.get(sampler_id)
  if o
    return o.v

  url = SPI+'sampler'
  if 0 == await r.count()
    li = await req url
  else
    li = [
      sampler_id
      await req url+'/'+sampler_id
    ]
  w = W[SAMPLER_NAME]
  for [id,v] from li
    if id == sampler_id
      name = v
    await w.put {id,v}
  name
