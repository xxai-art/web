#!/usr/bin/env bash

DIR=$(realpath $0) && DIR=${DIR%/*}
cd $DIR
set -ex

bun x cep -c sw.coffee -o ../public
cd ../public
mv sw.js s.js
