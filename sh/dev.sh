#!/usr/bin/env bash
DIR=$(dirname $(realpath "$0"))

cd $DIR/..

set -ex
kill -9 $(lsof -i:$VITE_PORT -t) 2>/dev/null | true

bunx concurrently --kill-others \
  -r "bunx vite" # "bunx coffee -wc vite" \
