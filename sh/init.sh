#!/usr/bin/env bash

DIR=$(dirname $(dirname $(realpath "$0")))
cd $DIR
set -ex
bunx coffee -c vite
