#!/usr/bin/env coffee

> ./env.coffee > PWD DIST
  html-minifier-terser > minify
  path > join
  @w5/ossput:put
  pug
  @w5/read
  coffeescript
  @w5/coffee_plus:hack
  esbuild

hack coffeescript

js = coffeescript.compile(
  read(
    join PWD,'index.coffee'
  ).replace(
    'CDN=\'\''
    'CDN=\''+process.env.CDN+'\''
  )
  bare:true
)

{code:js} = await esbuild.transform(js, {
  minify: true
})

js = js.trim()

htm = pug.renderFile(
  join PWD,'index.pug'
)

htm = await minify htm,{
  collapseWhitespace: true
  html5: true
  minifyCSS: true
  minifyJS: true
  removeAttributeQuotes: true
  removeComments: true
  removeRedundantAttributes: true
  removeScriptTypeAttributes: true
  removeStyleLinkTypeAttributes: true
  useShortDoctype: true
}
htm = htm.replace(
  '<script type=module></script>'
  '<script type=module>'+js+'</script>'
)
prehtm = read join DIST, 'index.htm'
if not prehtm.includes '.serviceWorker.'
  end = prehtm.lastIndexOf '></script>'
  begin = prehtm.lastIndexOf('/',end)+1
  v = prehtm.slice(begin, end)
  console.log 'v',v