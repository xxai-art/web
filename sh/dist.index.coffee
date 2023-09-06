#!/usr/bin/env coffee

> ./env.coffee > PWD DIST
  html-minifier-terser > minify
  path > join
  @w5/ossput:put
  @w5/cf
  @w5/cf/Zone
  pug
  @w5/read
  coffeescript
  @w5/coffee_plus:hack
  esbuild

hack coffeescript
{CDN} = process.env
js = coffeescript.compile(
  read(
    join PWD,'index.coffee'
  ).replace(
    'CDN=\'\''
    'CDN=\''+CDN+'\''
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
  filename = 'v'
  await put(
    filename
    =>
      v
    ''
  )
  url = 'https://'+CDN
  {hostname} = new URL(url)
  [{id}] = await cf.GET('?name='+hostname)
  zone = Zone id
  await cf.POST id+'/purge_cache', files: [url+filename]
