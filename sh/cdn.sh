#!/usr/bin/env bash

DIR=$(realpath $0) && DIR=${DIR%/*}
cd $DIR
set -ex

direnv allow

de() {
  direnv exec . ./$1
}

de i18n.upload.coffee

git add -u && git commit -m'i18n' || true

de filename_min.coffee

de dist.index.coffee
de dist.public.coffee
