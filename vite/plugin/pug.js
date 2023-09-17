#!/usr/bin/env -S node --loader=@w5/jsext --trace-uncaught --expose-gc --unhandled-rejections=strict
import pug from 'pug';

import {
  extname
} from 'path';

export default () => {
  return {
    name: 'import-pug',
    transform: (code, id) => {
      if ('pug' === extname(id).slice(1)) {
        return {
          code: "export default " + JSON.stringify(pug.compile(code)())
        };
      }
    }
  };
};

/*
opts.sourceMap  ?= true
opts.bare       ?= true
opts.extensions ?= ['.coffee', '.litcoffee']

try
  coffee = findCoffee opts.version
catch err
  return name: 'coffee2 (disabled)'

name: 'coffee2'
transform: (code, id) ->
  if opts.extensions.indexOf(extname id) == -1
    return null

  try
    out = coffee.compile code,
      filename:  id
      bare:      opts.bare
      sourceMap: opts.sourceMap
  catch err
    if err.location?
      err.formattedMessage = formatError code, id, err
    throw err

  code: out.js
  map:  sourceMap out
*/
