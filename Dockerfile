# Docker image to build the doc without having to install anything on the host
# Usage: docker build -t elabftw/elabdoc-builder .
# docker run --rm -it -v $(pwd):/src elabftw/elabdoc-builder
FROM node:14-alpine

RUN mkdir -p /src

WORKDIR /src

RUN yarn install

RUN apk add --no-cache make py3-pip && pip3 install --no-cache-dir sphinx sphinx-rtd-theme

VOLUME /src

CMD ["./node_modules/.bin/grunt"]
