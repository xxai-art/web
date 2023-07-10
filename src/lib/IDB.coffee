> wac.tax/_/IDB.js

export SAMPLER_NAME = 'samplerName'
export LI = 'li'

[DB,R,W] = await IDB.art(
  1 # version
  upgrade:(db)=> # upgrade(db, oldVersion, newVersion, transaction, event)
    createStore = (name, keyPath)=>
      db.createObjectStore name, {keyPath}

    for li from [
      [
        SAMPLER_NAME
        LI
        'id'
      ]
    ]
      config = li.pop()
      for t from li
        createStore t, config

    return
)

export default DB
export R = R
export W = W

