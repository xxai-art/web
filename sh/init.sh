#!/usr/bin/env bash

DIR=$(dirname $(dirname $(realpath "$0")))
cd $DIR
set -ex
./sh/svg-compress.sh
bunx coffee -c vite
