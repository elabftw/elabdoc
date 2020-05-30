#!/usr/bin/env bash
if [ "$1" == "-u" ]; then
    docker build -t elabftw/elabdoc-builder .
fi
docker run --rm -it -v "$(pwd):/home/node/src" elabftw/elabdoc-builder
