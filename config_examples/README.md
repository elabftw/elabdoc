# Configuration example files for eLabFTW

Here are some configuration files you can use for your webserver.

## Important note

Configuration files for running eLabFTW without Docker are no longer provided.
They require maintenance and extra work for no good reasons. The configuration
inside the Docker container is the only source of truth.

There will be **no support** for using Apache, Nginx or any other webserver without
Docker.

## Apache

The [Apache](./apache) folder contains documentation for running Apache as a reverse proxy for eLabFTW.

## HAProxy

The [haproxy](./haproxy) folder contains configuration for running HAProxy in front of one (or several) elabimg container in http mode.
