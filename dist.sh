#!/usr/bin/env bash

DIR=$(dirname $(realpath "$0"))
cd $DIR
set -ex

rm -rf dist
./build.sh
rm -rf dist/i18n
./sh/i18n.upload.coffee
./sh/filename_min.coffee
./sh/sw.coffee
cp sh/dist/* dist

# 如果更新 index.htm 、s.js ，请手动运行 sh/index.htm.sh

./sh/upload.htm.coffee

#./sh/qiniu.unload.coffee
