#!/usr/bin/env bash

DIR=$(dirname $(realpath "$0"))
cd $DIR
set -ex

cd src
rm -rf conf.js
ln -s ../conf/dev.js conf.js
cd ..

exec ./sh/dev.sh
