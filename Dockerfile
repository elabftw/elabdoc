# Docker image to build the doc without having to install anything on the host
# Usage: docker build -t elabftw/elabdoc-builder .
# ./build.sh
FROM node:14-alpine

RUN apk add --no-cache make py3-pip && pip3 install --no-cache-dir sphinx sphinx-rtd-theme

USER node

RUN mkdir -p /home/node/src

WORKDIR /home/node/src

RUN yarn install

VOLUME /home/node/src

CMD ["./node_modules/.bin/grunt"]
