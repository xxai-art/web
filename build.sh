#!/usr/bin/env bash

DIR=$(dirname $(realpath "$0"))
cd $DIR
set -ex

./i18n.sh

cd src
rm -rf conf.js

cp ../conf/ol.js conf.js

cd ..

./sh/init.sh

bunx vite build

rm src/conf.js

#./sh/filename_min.coffee
