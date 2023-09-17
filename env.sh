#!/usr/bin/env bash

CDN=//ok0.pw
VITE_PORT=3333

export OSSPUT_BUCKET=xxai-blog-cdn
export BACKBLAZE_url=https://f004.backblazeb2.com/file/$OSSPUT_BUCKET
export CDN="//ok0.pw/"

export SITE_OSSPUT_BUCKET=xxai-blog-web
export SITE_BACKBLAZE_url=https://f004.backblazeb2.com/file/$SITE_OSSPUT_BUCKET
export SITE=xxai.art
export BACKBLAZE_accessKeyId=
export BACKBLAZE_secretAccessKey=
export BACKBLAZE_endpoint=https://s3.us-west-004.backblazeb2.com
export CLOUDFLARE_KEY=
export CLOUDFLARE_EMAIL=
