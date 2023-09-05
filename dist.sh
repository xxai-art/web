#!/usr/bin/env bash

DIR=$(dirname $(realpath "$0"))
cd $DIR
set -ex

rm -rf dist
./build.sh
rm -rf "dist/.18"
./sh/cdn.sh

# ./sh/sw.coffee
# cp sh/dist/* dist
#
# # 如果更新 index.htm 、s.js ，请手动运行 sh/index.htm.sh
#
# ./sh/upload.htm.coffee
#
# #./sh/qiniu.unload.coffee
