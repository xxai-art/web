#!/usr/bin/env bash

DIR=$(dirname $(realpath "$0"))
set -ex

bunx i18n
bunx i18n_bin i18n src/i18n public/i18n
