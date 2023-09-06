#!/usr/bin/env bash

DIR=$(dirname $(realpath "$0"))
cd $DIR
set -ex

if ! command -v sponge &>/dev/null; then
  case $(uname -s) in
  Linux*)
    apt-get install -y moreutils
    ;;
  Darwin*)
    brew install moreutils
    ;;
  esac
fi

./init.sh
./svg-compress.sh
./sw.sh
cd ..

js=public/s.js
esbuild $js \
  --minify \
  --format=iife |
  sed 's/^.\{6\}//; s/.\{6\}$//' | sponge $js

./i18n.sh

cd src
rm -rf conf.js

cp ../conf/ol.js conf.js

cd ..

bunx vite build

rm src/conf.js

#./sh/filename_min.coffee
