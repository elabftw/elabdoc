# Configuration example files for eLabFTW

Here are some configuration files you can use for your webserver.

## Important note

Configuration files for running eLabFTW without Docker are no longer provided.
They require maintenance and extra work for no good reasons. The configuration
inside the Docker container is the only source of truth.

There will be **no support** for using Apache, Nginx or any other webserver without
Docker.

## Apache

The [Apache folder](./apache) contains documentation for running Apache as a reverse proxy for eLabFTW.

## Nginx

The [Nginx folder](./nginx) contains documentation for running Nginx as a reverse proxy for eLabFTW.

## HAProxy

The [HAProxy folder](./haproxy) contains configuration for running HAProxy in front of one (or several) elabimg container in http mode.

## Traefik

The [Traefik folder](./traefik) contains documentation related to traefik.
