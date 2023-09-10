+ _resolve

export default new Promise (resolve)=>
  _resolve = resolve
  return

export done = =>
  _resolve()
  return
