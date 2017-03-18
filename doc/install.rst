.. _install:

Install on a GNU/Linux server
=============================

.. image:: img/gnulinux.png
    :align: center
    :alt: gnulinux

Tested distributions: Debian, Ubuntu, Fedora, CentOS, Arch Linux, OpenSUSE.

.. image:: img/docker.png
    :align: right
    :alt: docker

Prerequisites
-------------

eLabFTW uses `Docker containers <https://www.docker.com/what-docker>`_. So you need to:

* install `Docker <https://docs.docker.com/engine/installation/linux/>`_, the container engine
* and that's it!

Install eLabFTW
---------------

* Become root:

.. code-block:: bash

    sudo su

.. _normal-install:

* Install `elabctl`:

.. code-block:: bash

    wget -qO- https://get.elabftw.net > /usr/bin/elabctl && chmod +x /usr/bin/elabctl

* Configure eLabFTW:

.. code-block:: bash

    elabctl install

* (optional) Edit the configuration:

    You might want to edit the configuration here to suit your server setup. For instance, you might want to edit `/etc/elabftw.yml` to change the port binding (default is 443 but it might be already used by a traditional webserver). This is also where you can define where the data will be stored (default is /var/elabftw).

* Start eLabFTW:

.. code-block:: bash

    elabctl start

This step can take up to 3 minutes to complete because it'll generate strong Diffie-Hellman parameters. You can follow the output with:

.. code-block:: bash

    docker logs -f elabftw

Once started, you will see something like: nginx entered RUNNING state. You can now finalize the install with the last step.

* Register a Sysadmin account:

    Point your browser to **\https://<your-elabftw-site.org>** (or **\https://<IP address>**)

Post install
------------

Don't forget to read :ref:`the post install page <postinstall>`, setup :ref:`backup <backup>`, and subscribe to `the newsletter <http://elabftw.us12.list-manage1.com/subscribe?u=61950c0fcc7a849dbb4ef1b89&id=04086ba197>`_!

ENJOY! :D

----


Documentation for unusual setups
--------------------------------

Using mod_proxy to run eLabFTW Docker container behind Apache2 (https enabled)
`````````````````````````````````````````````````````````````

If eLabFTW's Docker container runs on a machine with several web applications you can use mod_proxy to access the application without opening another port on your server.

The following example forwards the URL https://your.domain/elabftw/ to the docker URL https://localhost:444. The default Docker port can be changed by setting the ports parameter in /etc/elabftw.yml to "444:443".

.. code-block:: apache

    SSLProxyEngine on
    ProxyPass /elabftw/ https://localhost:444/ 
    ProxyPassReverse /elabftw/ https://localhost:444/ 

Using mod_proxy to run eLabFTW Docker container behind Apache2 (https disabled)
`````````````````````````````````````````````````````````````

It is also possible to disable https in the elabftw docker container's web server, if Apache2 handles SSL:

.. code-block:: /etc/elabftw.yml

	DISABLE_HTTPS=true
	
One can then forward to elabftw without the option SSLProxyEngine on, if the HTTP_X_FORWARDED_PROTO header is set:

.. code-block:: apache

	RequestHeader set X-Forwarded-Proto "https"
	ProxyPass /elabftw/ http://localhost:444/
	ProxyPassReverse /elabftw/ http://localhost:444/

Using nginx to run eLabFTW Docker container
```````````````````````````````````````````

If you already have nginx running, you'll want to use the proxy capapbilities of nginx to forward packets to the Docker container.

The following example forwards the URL https://demo.elabftw.net to the docker URL http://localhost:3148. The default Docker port can be changed by setting the ports parameter in /etc/elabftw.yml to "3148:443". In this example, nginx is listening to port 8888, because HAProxy is doing SSL termination. Adapt to your needs.

.. code-block:: nginx

	server {
        server_name demo.elabftw.net;

        listen 8888;
        listen [::]:8888;

        access_log /var/log/nginx/demo.elabftw.net.log proxy;

        location / {
            proxy_pass       http://localhost:3148;
            proxy_set_header Host      $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        }
    }


Add this to /etc/nginx/nginx.conf to get the real IP address in the logs:

.. code-block:: nginx

     log_format proxy '$proxy_add_x_forwarded_for - $remote_user [$time_local] '
                      '"$request" $status $body_bytes_sent '
                      '"$http_referer" "$http_user_agent" "$gzip_ratio"';

