#! /bin/bash

for path in hood/*/; do
  if [ -d ${path} ]; then
    dir="$(basename $path)"
    alias $dir="cd $path"
  fi
done 
