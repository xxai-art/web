import { join,dirname } from 'path'
import CoffeePlus from '@w5/coffee_plus'
import coffeescript from 'coffeescript'
import { merge } from 'lodash-es'
import vitePluginStylusAlias from './plugin/vite-plugin-stylus-alias.mjs'
import pug from 'pug'
import { defineConfig } from 'vite'

import sveltePreprocess from '@w5/svelte-preprocess'
import { svelte } from '@sveltejs/vite-plugin-svelte'
IGNORE_WARN = new Set(
  'a11y-click-events-have-key-events a11y-missing-content'.split(' ')
)

import thisdir from '@w5/uridir'
import { writeFileSync,renameSync } from 'fs'
import import_pug from './plugin/pug.js'

compile = CoffeePlus(coffeescript)

ROOT = thisdir(import.meta)
DIST = join ROOT,'dist'
SRC = join ROOT,'src'
FILE = join ROOT,'file'

INDEX_HTML = 'index.html'
SRC_INDEX_HTML = join SRC,INDEX_HTML
writeFileSync(
  SRC_INDEX_HTML
  pug.compileFile(join SRC, 'index.pug')({
  })
)
{env} = process
host = env.VITE_HOST or '0.0.0.0'
port = env.VITE_PORT or port


PRODUCTION = env.NODE_ENV == 'production'
TARGET = ["esnext"]

config = {
  publicDir: join ROOT, 'public'
  plugins: [
    {
      name: 'coffee2'
      transform: (code, id) ->
        if not id.endsWith '.coffee'
          return
        try
          out = compile code,
            filename:  id
            bare:      true
            sourceMap: true
        catch err
          throw err

        code: out.js
        map:  out.v3SourceMap
    }
    svelte(
      onwarn:(warn)=>
        {code,message} = warn
        if code == 'a11y-missing-attribute'
          return !message.includes('<a>')
        !IGNORE_WARN.has code
      preprocess: [
        sveltePreprocess(
          coffeescript: {
            label:true
            sourceMap: true
          }
          #customElement:true
          stylus: true
          pug: true
        )
      ]
    )
    vitePluginStylusAlias()
    import_pug()
  ]
  clearScreen: false
  server:{
    host
    port
    strictPort: true
    proxy:
      '[.@]|^\/i18n\/':
        target: "http://#{host}:#{port}"
        rewrite: (path)=>'/'
        changeOrigin: false
  }
  resolve:
    alias:
      ":": join(ROOT, "file")
      '~': SRC
  esbuild:
    charset:'utf8'
    legalComments: 'none'
    treeShaking: true
  root: SRC
  # css:
    # transformer: 'lightningcss'
    # lightningcss

  build:
    cssMinify: 'lightningcss'
    outDir: DIST
    rollupOptions:
      input:
        index:SRC_INDEX_HTML
    target:TARGET
    assetsDir: '/'
    emptyOutDir: true
  optimizeDeps:
    # exclude:[
    #   "@w5/vite"
    # ]
    esbuildOptions:
      target: TARGET
}

config = merge config, await do =>
  if PRODUCTION
    FILENAME = '[name].[hash].[ext]'
    JSNAME = '[name].[hash].js'

    if env.DEBUG
      base = '/'
      minify = false
    else
      base = env.CDN or '/'
      minify = true

    return {
      plugins:[
        (
          await import('./plugin/mini_html.js')
        ).default
      ]
      base
      build:{
        minify
        rollupOptions:{
          output:
            chunkFileNames: JSNAME
            assetFileNames: FILENAME
            entryFileNames: "m.js"
        }
      }
    }
  else
    return {
      plugins:[
        {
          name:'html-img-src'
          transformIndexHtml:(html)=>
            html.replaceAll(
              'src=":/'
              'src="/@fs'+FILE+'/'
            )
        }
      ]
    }


export default =>
  defineConfig config
