#!/usr/bin/env bash

DIR=$(dirname $(realpath "$0"))
cd $DIR
set -ex
git pull
rm -rf dist
cd sh
./build.sh
rm -rf "../dist/.18"
./cdn.sh
git add -u
git commit -m'dist'
git push
# ./sh/sw.coffee
# cp sh/dist/* dist
#
# # 如果更新 index.htm 、s.js ，请手动运行 sh/index.htm.sh
#
# ./sh/upload.htm.coffee
#
# #./sh/qiniu.unload.coffee
