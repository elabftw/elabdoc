.. _install:

Install on a GNU/Linux server
=============================

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
-------------

You'll need a GNU/Linux server. Because of the use of linux containerization technology, other operating systems (FreeBSD, OpenBSD, and others) are not supported.

If you don't have a server, look at the documentation to rent one: :ref:`Install in the cloud <install-cloud>`.

Dependencies:
`````````````

Absolutely required dependencies:
"""""""""""""""""""""""""""""""""
A containerization technology such as `docker <https://docs.docker.com/engine/installation/linux/>`_ or `podman <https://podman.io/>`_.

Strongly recommended dependencies:
""""""""""""""""""""""""""""""""""
* `curl <https://curl.haxx.se/>`_, to get files from command line (very likely already installed)
* `docker-compose <https://docs.docker.com/compose/install/>`_, the tool to orchestrate containers, required by `elabctl`
* `dialog <https://en.wikipedia.org/wiki/Dialog_(software)>`_, required by `elabctl install`
* `borgbackup <https://borgbackup.readthedocs.io/en/stable/>`_, a backup tool required by `elabctl backup`

Notes:
``````
You can have your normal user in the `docker` group to execute docker commands without sudo (see `documentation <https://docs.docker.com/engine/install/linux-postinstall/>`_).

If you are running Ubuntu 20.04 with Docker installed as a snap. Uninstall that and install it without snap. See `this issue <https://github.com/elabftw/elabftw/issues/1917>`_.

Install `docker-compose` preferentially with the `curl`/standalone method to get the latest version, as the repository versions might be outdated and will cause issues. See `install docker-compose <https://docs.docker.com/compose/install/other/>`_.

Configure eLabFTW
-----------------

.. warning:: A proper subdomain is required!

We will install `elabctl`, a tool to help you manage the elabftw installation. It is not required to install it but it is quite handy so it is recommended (also it's just a bash script, nothing fancy). If you you do not wish to use `elabctl` and just want a YAML config to edit, see instructions below for advanced users.


With elabctl (recommended)
``````````````````````````

.. code-block:: bash

    # get the program (a bash script) and make it executable
    curl -sL https://get.elabftw.net -o elabctl && chmod +x elabctl
    # add it to a directory in your $PATH
    sudo mv elabctl /usr/local/bin/

* Pre-fill the configuration file:

.. code-block:: bash

    elabctl install

* Edit the configuration file:

    Edit the configuration to suit your server setup. For instance, you might want to change the port binding (default is 443 but it might be already used by a traditional webserver). See below for using the container with a reverse proxy.

    If you have set `DISABLE_HTTPS=false` then you need to configure the TLS certificate. Look at the comments inside the configuration file, they describe the different use cases. In order to request Let's Encrypt certificates, you need to install `certbot`. See `official Let's Encrypt documentation <https://letsencrypt.org/getting-started/>`_ for your system. When requesting a new certificate, make sure that port 80 is open (and also port 443 for eLabFTW if it is the one you want to use). Once certbot is installed, the command to use might look like this: `certbot certonly \--standalone -d elab.example.org`.

* Start eLabFTW:

.. code-block:: bash

    elabctl start


Without elabctl (advanced users)
````````````````````````````````

Get the config with:

.. code-block:: bash

   curl -so docker-compose.yml "https://get.elabftw.net/?config"

Edit this file and `docker-compose up -d` to launch the containers.

Initialize your database
------------------------

* Import the database structure with:

.. code-block:: bash

   elabctl initialize
   # same as: docker exec -it elabftw bin/install start

Replace "elabftw" in the command above by the name of the elabftw container if yours is different (for instance if you have several containers running with redis as session handler). You can check this with `elabctl status`/`docker ps`

Register a Sysadmin account
---------------------------

Point your browser to **\https://<your-elabftw-site.org>/register.php**

Post install
------------

Don't forget to setup :ref:`backup <backup>`, and subscribe to `the newsletter <http://elabftw.us12.list-manage1.com/subscribe?u=61950c0fcc7a849dbb4ef1b89&id=04086ba197>`_!

The next step is to read the :ref:`Sysadmin guide <sysadmin-guide>`.

ENJOY! :D

----


Documentation for advanced setups
---------------------------------

Using a TLS certificate from a different provider than Let'sEncrypt
```````````````````````````````````````````````````````````````````

The webserver in the container expects TLS certificates to be in a particular order and format. Make sure that your `fullchain.pem` file contains certificates in this order: <certificate> <intermediate ca> <root ca>, with PEM encoding.


Using Apache, nginx, HAProxy or traefik as a reverse proxy
``````````````````````````````````````````````````````````

All the documentation related to such configurations can be found `here <https://github.com/elabftw/elabdoc/tree/master/config_examples/>`_.

