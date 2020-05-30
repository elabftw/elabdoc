# Docker image to build the doc without having to install anything on the host
# Usage: docker build -t elabftw/elabdoc-builder .
# ./build.sh
FROM node:14-alpine

RUN apk add --no-cache make py3-pip git && pip3 install --no-cache-dir sphinx sphinx-rtd-theme

USER node

RUN mkdir -p /home/node/build

# DOC BUILD
RUN git clone --depth 1 -b next https://github.com/elabftw/elabdoc /home/node/elabdoc

WORKDIR /home/node/elabdoc

RUN yarn install && ./node_modules/.bin/grunt && cp -r doc/_build/html /home/node/build/doc && rm -r node_modules

# API BUILD
RUN git clone --depth 1 -b apidoc https://github.com/elabftw/elabftw /home/node/elabftw

WORKDIR /home/node/elabftw

RUN yarn install && ./node_modules/.bin/apidoc -c apidoc -o /home/node/build/doc/api -i src/controllers && rm -r node_modules

CMD ["true"]
