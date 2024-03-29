#!/bin/sh

##echo "http://dl-cdn.alpinelinux.org/alpine/latest-stable/main/" > /etc/apk/repositories
##echo "http://dl-cdn.alpinelinux.org/alpine/latest-stable/community/" >> /etc/apk/repositories
#echo https://dl-cdn.alpinelinux.org/alpine/v3.12/main >> /etc/apk/repositories
#echo https://dl-cdn.alpinelinux.org/alpine/v3.12/community >> /etc/apk/repositories

apk update
apk upgrade
apk add git vim curl
apk add make gcc build-base abuild binutils util-linux npm fortune openssh
apk add man-pages mandoc
apk add less less-doc
