#!/bin/bash
# Download Avatar Show resources from web.sanguosha.com
# Author: Luckylele <club.sanguosha.com>

dir=${0%/*}
if [ "$dir" = "" ]; then
  dir="."
fi
cd $dir

flag=0
type wget &> /dev/null && flag=2
type curl &> /dev/null && flag=1

if [ $flag = 0 ]; then
  echo "Error: 请安装 wget 或 curl 以从网络下载资源!"
  exit
fi

if [ ! -d avatar ]; then
  mkdir avatar
fi
if [ ! -d border ]; then
  mkdir border
fi
if [ ! -d background ]; then
  mkdir background
fi
if [ ! -d title ]; then
  mkdir title
fi

if [ $flag = 2 ]; then
  while read -r url; do
    url=${url%%[[:cntrl:]]}
    bname=${url##*/}
    pname=${url%/*}
    pname=${pname##*/}
    output="${pname}/${bname}"
    if [ ! -f "$output" ]; then
      echo "Downloading $output"
      wget -q "$url" -O "$output" || rm "$output"
    fi
  done < list.txt
fi

if [ $flag = 1 ]; then
  while read -r url; do
    url=${url%%[[:cntrl:]]}
    bname=${url##*/}
    pname=${url%/*}
    pname=${pname##*/}
    output="${pname}/${bname}"
    if [ ! -f "$output" ]; then
      echo "Downloading $output"
      curl -sfk "$url" -o "$output"
    fi
  done < list.txt
fi

