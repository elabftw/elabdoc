.. _install:

Install on a GNU/Linux server
=============================

.. image:: img/gnulinux.png
    :align: center
    :alt: gnulinux

Tested distributions: Debian, Ubuntu, Fedora, CentOS, Arch Linux, OpenSUSE.

.. warning:: Only 64 bits distributions are supported. Do not try to install on a 32 bits operating system!

.. image:: img/docker.png
    :align: right
    :alt: docker

.. _normal-install:

Prerequisites
-------------

eLabFTW uses `Docker containers <https://www.docker.com/what-docker>`_. This saves you from dealing with a ton of dependencies, as everything is packed in a container. But we still need a few programs installed before we can get started.

Dependencies:
`````````````
* `curl <https://curl.haxx.se/>`_, to get files from command line (very likely already installed)
* `docker <https://docs.docker.com/engine/installation/linux/>`_, the container engine
* `docker-compose <https://docs.docker.com/compose/install/>`_, the tool to orchestrate containers
* `dialog <https://en.wikipedia.org/wiki/Dialog_(software)>`_, to display nice user interface during installation
* `git <https://git-scm.com/>`_, the version control system
* `zip <http://infozip.sourceforge.net/Zip.html>`_, the compression tool (for the backups)

Make sure your user is in the `docker` group so you can execute docker commands without sudo (see `documentation <https://docs.docker.com/install/linux/linux-postinstall/>`_).

Also if you are running Ubuntu 20.04 with Docker installed as a snap. Uninstall that and install it without snap. See `this issue <https://github.com/elabftw/elabftw/issues/1917>`_.

Install eLabFTW
---------------

.. warning:: A proper subdomain is required. Subfolder install is not supported!

* Install `elabctl`, a tool to help you manage the elabftw installation:

.. code-block:: bash

    # get the program (a bash script)
    curl -sL https://get.elabftw.net -o elabctl && chmod +x elabctl
    # add it to a directory in your $PATH
    sudo mv elabctl /usr/local/bin/

* Pre-fill the configuration file:

.. code-block:: bash

    elabctl install

* Edit the configuration file:

    Edit the configuration to suit your server setup. For instance, you might want to edit `/etc/elabftw.yml` to change the port binding (default is 443 but it might be already used by a traditional webserver). See below for using the container with a reverse proxy.

    If you have set `DISABLE_HTTPS=false` then you need to configure the TLS certificate. Look at the comments inside the configuration file, they describe the different use cases. In order to request Let's Encrypt certificates, you need to install `certbot`. See `official Let's Encrypt documentation <https://letsencrypt.org/getting-started/>`_ for your system. When requesting a new certificate, make sure that port 80 is open (and also port 443 for eLabFTW if it is the one you want to use). Once certbot is installed, the command to use might look like this: `certbot certonly \--standalone -d elab.example.org`.

* Start eLabFTW:

.. code-block:: bash

    elabctl start

* Import the database structure:

.. code-block:: bash

   docker exec -it elabftw bin/install start

Replace "elabftw" in the command above by the name of the elabftw container if yours is different (for instance if you have several containers running with redis as session handler). You can check this with `elabctl status`.

* Register a Sysadmin account:

    Point your browser to **\https://<your-elabftw-site.org>/register.php** (or **\https://<IP address>/register.php**)

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

