.. _install:

*****************************
Install on a GNU/Linux server
*****************************

.. image:: img/gnulinux.png
    :align: center
    :alt: gnulinux

These instructions will work for any of the GNU/Linux distributions where Docker is supported and can be installed.

.. warning:: Only 64 bits distributions are supported. Do not try to install on a 32 bits operating system!

.. image:: img/docker.png
    :align: right
    :alt: docker

.. _normal-install:

Prerequisites
=============

You will need a GNU/Linux server. Because of the use of linux containerization technology, other operating systems (FreeBSD, OpenBSD, and others) are not supported.

If you do not have a server, look at the documentation to rent one: :ref:`Install in the cloud <install-cloud>` or opt for a managed (SaaS) solution via `Deltablot PRO Hosting <https://www.deltablot.com/elabftw/>`_.

Be aware that installing **eLabFTW** means it will need to be maintained, by regularly applying updates, configuring the backups properly, and hardening the host operating system. If you do not have GNU/Linux System Administration knowledge, it is recommended to consider the `SaaS offering <https://www.deltablot.com/elabftw/>`_.

Dependencies
------------

Absolutely required dependencies
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
A containerization technology such as `docker <https://docs.docker.com/engine/installation/linux/>`_ or `podman <https://podman.io/>`_.

A **MySQL** service is already declared in the default configuration file, so you don't have to worry about installing **MySQL**. A container with **MySQL** will get created from the official **MySQL** docker image. Do **NOT** install ``mysql-server`` package.

Alternatively, you can use another pre-existing **MySQL** service on your network. Important, it must be **MySQL**, **not MariaDB**. If you do that, make sure to comment out/remove the ``mysql`` container from the `docker compose` configuration file.

The following MySQL modes are known to work fine with eLabFTW codebase:

* `ERROR_FOR_DIVISION_BY_ZERO`
* `IGNORE_SPACE`
* `NO_ENGINE_SUBSTITUTION`
* `NO_ZERO_DATE`
* `NO_ZERO_IN_DATE`
* `ONLY_FULL_GROUP_BY`
* `PIPES_AS_CONCAT`
* `REAL_AS_FLOAT`
* `STRICT_ALL_TABLES`

Strongly recommended dependencies
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
* `curl <https://curl.haxx.se/>`_, to get files from command line (very likely already installed)
* `docker compose plugin <https://docs.docker.com/compose/install/>`_, the tool to orchestrate containers, required by `elabctl`. It can be installed with the `docker-compose-plugin` package.
* `dialog <https://en.wikipedia.org/wiki/Dialog_(software)>`_, required by `elabctl install`
* `borgbackup <https://borgbackup.readthedocs.io/en/stable/>`_, a backup tool required by `elabctl backup`. Not required during installation.

Notes
-----
You can have your normal user in the `docker` group to execute docker commands without sudo (see `documentation <https://docs.docker.com/engine/install/linux-postinstall/>`_). This is generally convenient for development environments and not recommended in production.

**Ubuntu users**: Docker as a snap is known to cause issues. Uninstall that and install it without snap. See `this issue <https://github.com/elabftw/elabftw/issues/1917>`_.

Configure eLabFTW
=================

.. warning:: A proper subdomain is required!

.. warning:: Docker creates iptables rules by default at startup. As a result, it will expose your elabftw installation to the public if your server is not running behind a firewall. This will also override restrictions set with packages such as ufw. Consider manually creating some rules on the DOCKER-USER chain if you want to restrict access, see `here <https://docs.docker.com/network/packet-filtering-firewalls/#restrict-connections-to-the-docker-host>`.

We will install ``elabctl``, a tool to help you manage the elabftw installation. It is not required to install it but it is quite handy so it is recommended (also it's just a bash script, nothing fancy). If you you do not wish to use ``elabctl`` and just want a YAML config to edit, see instructions below for advanced users.


With elabctl (recommended)
--------------------------

.. code-block:: bash

    # get the program (a bash script) and make it executable
    curl -sL https://get.elabftw.net -o elabctl && chmod +x elabctl
    # add it to a directory in your $PATH
    sudo mv elabctl /usr/local/bin/

* Pre-fill the configuration file:

.. code-block:: bash

    elabctl install

* Edit the configuration file (``/etc/elabftw.yml`` by default):

    Edit the configuration to suit your server setup. For instance, you might want to change the port binding (default is 443 but it might be already used by a traditional webserver). See below for using the container with a reverse proxy.

Note about TLS certificates
---------------------------

The eLabFTW container can run an HTTP or HTTPS server. Both will run internally on port 443.

Option A: HTTP mode
^^^^^^^^^^^^^^^^^^^

You can run the container in HTTP mode (internal port 443) only if you have a reverse proxy in front doing TLS termination and sending X-Forwarded-Proto header.

* Set ``DISABLE_HTTPS=true``.

Reverse proxy configurations examples can be found `here <https://github.com/elabftw/elabdoc/tree/master/config_examples/>`_.

Option B: HTTPS mode with Let's Encrypt certificates
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

In order to request Let's Encrypt certificates, you need to install ``certbot`` and have your server publicly accessible. See `official Let's Encrypt documentation <https://letsencrypt.org/getting-started/>`_ for your system. When requesting a new certificate, make sure that port 80 is open (and also port 443 for eLabFTW if it is the one you want to use). Once certbot is installed, the command to use might look like this: `certbot certonly \--standalone -d elab.example.org`.

* Set ``DISABLE_HTTPS=false``.
* Set ``ENABLE_LETSENCRYPT=true``.
* Uncomment the line `- /etc/letsencrypt:/ssl` in the `volumes:` part of the yml config file.

Option C: HTTPS mode with custom certificates
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Have the private key and certificate in PEM format in the folder ``/etc/letsencrypt/live/SERVER_NAME/`` where ``SERVER_NAME`` matches the ``SERVER_NAME`` configuration variable. The files need to be named `fullchain.pem` and `privkey.pem`. The webserver in the container expects TLS certificates to be in a particular order and format. Make sure that your `fullchain.pem` file contains certificates in this order: <certificate> <intermediate ca> <root ca>, with PEM encoding.

* Set ``DISABLE_HTTPS=false``.
* Set ``ENABLE_LETSENCRYPT=true``.
* Uncomment the line `- /etc/letsencrypt:/ssl` in the `volumes:` part of the yml config file.


Option D: HTTPS mode with self-signed certificate
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The container can generate its own certificate. Only use this if you have no other choice, as users will see a warning that the certificate is invalid because it is self-signed.

* Set ``DISABLE_HTTPS=false``.
* Set ``ENABLE_LETSENCRYPT=false``.

Using Apache, nginx, HAProxy or traefik as a reverse proxy
----------------------------------------------------------

Mandatory if you use Option A above (HTTP mode). All the documentation related to such configurations can be found `here <https://github.com/elabftw/elabdoc/tree/master/config_examples/>`_.

Start eLabFTW
-------------

.. code-block:: bash

    elabctl start


Without elabctl (advanced users)
--------------------------------

Get the config with:

.. code-block:: bash

   curl -so docker-compose.yml "https://get.elabftw.net/?config"

Edit this file and ``docker compose up -d`` to launch the containers.

Initialize your database
========================

* Import the database structure with:

.. code-block:: bash

   elabctl initialize
   # same as: docker exec -it elabftw bin/init db:install

Replace `elabftw` in the command above by the name of the elabftw container if yours is different (for instance if you have several containers running with redis as session handler). You can check this with ``elabctl status`` or ``docker ps``.

Register a Sysadmin account
===========================

Point your browser to **\https://<your-elabftw-site.org>/register.php**

Post install
============

Don't forget to setup :ref:`backup <backup>`, and subscribe to `the newsletter <http://elabftw.us12.list-manage1.com/subscribe?u=61950c0fcc7a849dbb4ef1b89&id=04086ba197>`_!

The next step is to read the :ref:`Sysadmin guide <sysadmin-guide>`.

ENJOY! :D

Inserting locally trusted root Certificate Authority
====================================================

If you need the eLabFTW container to trust your own CA, you will need to create a custom image and run that instead of the official image.

For this, create a folder, and in that folder, create a ``Dockerfile`` with this content:

.. code-block:: bash

    # Example Dockerfile to include custom trusted Certificate Authority
    # we use the "stable" tag so this always work and needs no editing between versions
    FROM elabftw/elabimg:stable
    # in this example, the file is named "my-cert.pem" and must be present in the same folder is this Dockerfile
    # we copy it into this folder so it can be picked up by the following command
    COPY my-cert.pem /usr/local/share/ca-certificates/my-cert.crt
    RUN update-ca-certificates

Make sure to have your CA cert in the same folder, named ``my-cert.pem``, and build the image:

.. code-block:: bash

    docker buildx build -t elabftw/elabimg-custom .

And replace the image name (`elabftw/elabimg`) in the main elabftw configuration YAML file (`/etc/elabftw.yml` by default) with your custom image name (`elabftw/elabimg-custom`).
