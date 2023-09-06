#!/usr/bin/env bash

DIR=$(realpath $0) && DIR=${DIR%/*}
cd $DIR
set -ex

env_sh() {
  cd $DIR/../../conf/conn
  local i
  for i in $@; do
    set -o allexport
    source "$i".sh
    set +o allexport
  done

  cd $DIR
  unset -f env_sh
}

env_sh web web.cdn
./i18n.upload.coffee
git add -u && git commit -m'i18n' || true
./filename_min.coffee
