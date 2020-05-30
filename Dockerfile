# Docker image to build the doc without having to install anything on the host
# Usage: docker build -t elabftw/elabdoc-builder .
# ./build.sh
FROM node:14-alpine

RUN apk add --no-cache make py3-pip git && pip3 install --no-cache-dir sphinx sphinx-rtd-theme

USER node

RUN git clone --depth 1 -b apidoc https://github.com/elabftw/elabftw /home/node/elabftw

WORKDIR /home/node/elabftw

RUN yarn install && yarn apidoc

RUN mkdir -p /home/node/src

WORKDIR /home/node/src

VOLUME /home/node/src

CMD ["sh", "-c", "yarn install && ./node_modules/.bin/grunt && cp -r /home/node/elabftw/apidoc/html /home/node/src/doc/_build/html/api"]
