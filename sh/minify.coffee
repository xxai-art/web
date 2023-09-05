import UglifyJS from 'uglify-js'

OPT = {
  compress: {
    unsafe: true
    toplevel: false
    drop_console: true
    module: true
    passes: 3
  }
  mangle: {
    toplevel: true
    properties: {
      #debug: true
      #builtins: false
      regex: /^\$/
    }
  }
  module: true
  sourceMap: false
}


export default (code, opt={})=>
  UglifyJS.minify(
    code
    {
      ...OPT
      ...opt
    }
  )

