#!/usr/bin/env bash

DIR=$(dirname $(realpath "$0"))
cd $DIR
set -ex

./dist.js.sh
./index_htm.coffee
#../dist.sh
