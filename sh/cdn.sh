#!/usr/bin/env bash

DIR=$(realpath $0) && DIR=${DIR%/*}
cd $DIR
set -ex

direnv allow
direnv exec . ./i18n.upload.coffee
git add -u && git commit -m'i18n' || true
direnv exec . ./filename_min.coffee
