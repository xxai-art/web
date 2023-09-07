< (index, key)=>
  (await index.get(key))?.n or 0
