# Apache

If you already have an Apache webserver running, you can use it to forward requests to the Docker container (this is called a reverse proxy).

For that you will need to install/enable the `mod_proxy` Apache module, along with `mod_headers`:

~~~bash
sudo a2enmod proxy
sudo a2enmod headers
~~~

It is recommended to run the Docker container in HTTP mode and let Apache do
TLS termination. But letting the Docker container deal with TLS is also a
possibility. Both configurations are presented below.

## Prerequisite: running the container on a custom port

Because our Apache is already running on port 443, we will want the Docker container to run on another port.

In the `ports` part of this configuration file, expose the container on port 3148 for instance:

~~~yaml
ports:
  - '127.0.0.1:3148:443'
~~~

Note: we're using the 127.0.0.1 localhost ip to avoid Docker exposing the port by bypassing the firewall configuration (see [this issue](https://github.com/moby/moby/issues/22054)).

## Using mod_proxy to run eLabFTW Docker container in http mode (recommended)

### Running the container in HTTP mode

By default the eLabFTW (elabftw/elabimg) container runs in HTTPS mode, so you'll need to edit your `elabftw.yml` file (or `docker-compose.yml`) and add:

~~~yaml
DISABLE_HTTPS=true
~~~

### Configuring the reverse proxy

In your VirtualHost configuration block for eLabFTW, add the following lines:

~~~apacheconf
RequestHeader set X-Forwarded-Proto "https"
ProxyPreserveHost On
ProxyPass "/" "http://localhost:3148/"
ProxyPassReverse "/" "http://localhost:3148/"
~~~

## Using mod_proxy to run eLabFTW Docker container in https mode

You will need `mod_ssl` activated.

Add these lines to your Apache configuration file (probably in `/etc/apache2/apache.conf` or in your VirtualHosts files).

~~~apacheconf
SSLEngine on
SSLProxyEngine on
ProxyPreserveHost On
ProxyPass "/" "https://localhost:444/"
ProxyPassReverse "/" "https://localhost:444/"
~~~
