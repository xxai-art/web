#!/usr/bin/env bash

DIR=$(dirname $(realpath "$0"))
cd $DIR
set -ex

if [ ! -d "node_modules" ]; then
  ni
fi

cd src
rm -rf conf.js
ln -s ../conf/dev.js conf.js
cd $DIR

# link() {
#   sleep 1
#   wasm=__bg.wasm
#   deps=node_modules/.vite/deps/$wasm
#   if [ ! -s "$deps" ]; then
#     mkdir -p $(dirname $deps)
#     ln -s ../../@w5/vite/$wasm $deps
#   fi
# }
# link &
cd $DIR
exec ./sh/dev.sh
