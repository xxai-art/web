< getOr0 = (store, key)=>
  new Proxy(
    {}
    get:(_,attr)=>
      new Promise (resolve)=>
        t = await store.get(key)
        if t then t[attr] else 0
  )
