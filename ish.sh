#!/bin/sh

##echo "http://dl-cdn.alpinelinux.org/alpine/latest-stable/main/" > /etc/apk/repositories
##echo "http://dl-cdn.alpinelinux.org/alpine/latest-stable/community/" >> /etc/apk/repositories
#echo https://dl-cdn.alpinelinux.org/alpine/v3.12/main >> /etc/apk/repositories
#echo https://dl-cdn.alpinelinux.org/alpine/v3.12/community >> /etc/apk/repositories

source .alias
clink .ashinit
./unixSetup.sh

apk update
apk upgrade
apk add git vim curl
apk add make gcc build-base abuild binutils util-linux npm
# fix concurrency issue
git config --global pack.threads "1"
