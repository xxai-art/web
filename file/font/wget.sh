#!/usr/bin/env bash

get() {
  wget --user-agent="Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:21.0) Gecko/20100101 Firefox/99.0" "https://fonts.googleapis.com/css2?family=$2" -O $1.css
  ./download.xsh $1.css $3
}

get Noto-Sans-SC 'wght@100;300;400;500;700;900'
# get Rubik "Rubik:wght@500&display=swap"
#get Josefin "Josefin+Sans:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;1,100;1,200&display=swap" J
#get Inconsolata "Inconsolata:wght@200;300;400;500;600;700;800;900&display=swap" c
#get Noto-Sans-SC "Noto+Sans+SC:wght@100;300;400;500;700;900&display=swap" h
