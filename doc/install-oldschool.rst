.. _install-oldschool:

Install without Docker
======================

.. image:: img/gnulinux.png
    :align: center
    :alt: gnulinux
.. image:: img/beastie.png
    :align: right
    :alt: beastie


Introduction
------------

.. warning:: This method is **highly inadvisable**. Only use it if you absolutely cannot install Docker and have good server administration skills!

Before going forward, consider the huge amount of care that has been given to the official Docker image for eLabFTW. It runs a deeply customized webserver with php-fpm. Everything is optimized for speed, correctness and more importantly **security**. It makes upgrades much easier and less prone to breakage. It also keeps your server nice and tidy because you won't need to install all the dependencies needed to run eLabFTW on your server.

If you don't use Docker you basically **increase the maintenance work tenfold** at least. Because breaking changes in the code are transparent to Docker users, as the image will follow, but not to you, as you will need to keep your configuration files updated manually.

If you already have let's say an Apache server running and are considering installing eLabFTW along your other PHP projects, know that you can keep your existing Apache installation and use it as a reverse proxy to a Docker container. See the `documentation for reverse proxies <https://github.com/elabftw/elabdoc/tree/master/config_examples>`_.

**You have been warned**, the only officially supported deployment strategy is through Docker, as it makes the life easier for everyone.

.. tip:: This is your last chance to go back to the :ref:`recommended installation instructions <install>`.

The only valid reason to not use Docker is if you have a BSD system and are already a capable administrator.

Prerequisites
-------------

Please refer to your distribution's documentation to install:

* A webserver like nginx (recommended), Apache, lighttpd, cherokee or caddy
* PHP version > 8.0
* MySQL version > 5.7
* Git

Nginx is recommended because configuration files for eLabFTW are provided for Nginx only, as it is the webserver running inside the official Docker image.

Getting the files
-----------------

The first part is to get the `eLabFTW` files on your server.

Connect to your server with SSH:

.. code-block:: bash

    ssh user@12.34.56.78

`cd` to the public directory where you want `eLabFTW` to be installed (can be /var/www/html, ~/public\_html, or any folder you'd like, as long as the webserver is configured properly, in doubt use /var/www/html)

.. code-block:: bash

    cd /var/www/html

Get latest stable version via git:

.. we have to use parsed-literal here and not code-block otherwise the substitution doesn't work :/

.. parsed-literal::

    git clone -b |release| --depth 1 https://github.com/elabftw/elabftw.git

The `--depth 1` option is to avoid downloading the whole history.

The `-b` option is to specify the latest release tag.

.. tip:: If you cannot connect, it's probably the proxy setting missing; try one of these two commands:

    .. code-block:: bash

        export https_proxy="proxy.example.com:3128"
        git config --global http.proxy http://proxy.example.com:8080

Install php dependencies with `composer <https://getcomposer.org/download/>`_:

.. code-block:: bash

    cd elabftw
    # step not described: install composer
    # see https://getcomposer.org/download/
    ./composer.phar install --no-dev

This will populate the `vendor` directory and also complain about missing php extensions that you should install.

Install `yarn <https://yarnpkg.com/en/docs/install>`_ and build JavaScript and CSS bundles with:

.. code-block:: bash

    yarn install --prod
    yarn buildall

Now create the cache and uploads directory with restrictive permissions:

.. code-block:: bash

    mkdir cache uploads
    chown www-data:www-data cache uploads
    chmod 700 cache uploads

Depending on your webserver configuration, the user might not be "www-data".

SQL part
--------

Create a database for elabftw
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Use the command line like below or PhpMyAdmin if it is installed on your server already.

.. code-block:: bash

    # first we connect to mysql
    mysql -uroot -p
    # we create the database (note the ; at the end!)
    mysql> create database elabftw character set utf8mb4 collate utf8mb4_0900_ai_ci;
    # we create the user that will connect to the database.
    mysql> grant usage on *.* to elabftw@localhost identified by 'YOUR_PASSWORD';
    # we give all rights to this user on this database
    mysql> grant all privileges on elabftw.* to elabftw@localhost;
    mysql> exit

You will be asked for the password you put after `identified by` three lines above during the install.

Import the database structure
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Now that we have a database with a user/password to connect to it, we need to import the structure for eLabFTW. Simply execute this command from the elabftw folder:

.. code-block:: bash

    php bin/install start

Configure the webserver correctly
---------------------------------

The Docker image of eLabFTW contains a lot of little configuration tweaks to improve the security of the web application. Your configuration should ideally be the same as the one in the Docker image.

Nginx config
^^^^^^^^^^^^

You need to look into the `nginx folder of the Docker image <https://github.com/elabftw/elabimg/tree/master/src/nginx>`_ and adapt the configuration to your instance.

Some important things to look into:

* Add security headers (IMPORTANT). See the end of `this file <https://github.com/elabftw/elabimg/blob/master/src/nginx/common.conf>`_.
* Use a proper TLS certificate, not a self-signed one
* Use DH params of 2048 bits
* Disable session tickets
* Only use TLS version > 1.2
* Use a modern cipher list
* Configure API redirect

PHP config
^^^^^^^^^^

You need to look into the `php folder of the Docker image <https://github.com/elabftw/elabimg/tree/master/src/php>`_ and adapt the configuration to your instance.

See the phpfpmConf() and phpConf() functions from `run.sh <https://github.com/elabftw/elabimg/blob/master/src/run.sh>`_ too.

* Hide PHP version (`expose_php` in php.ini)
* Set cookies httponly and secure
* Use strict mode for sessions
* Store sessions in a separate directory with restrictive permissions
* disable `url_fopen`
* enable opcache
* configure `open_basedir`
* use longer session id length (`session.sid_length`)
* disable unused functions (see the list in the php.ini file)

Note: it is recommended to have different php-fpm pools for different php apps so eLabFTW configuration will not impact other software.

Miscellaneous config
^^^^^^^^^^^^^^^^^^^^

* Put restrictive permissions on the `uploads` and `cache` folders (and `config.php` file).

Final step
----------

Finally, point your browser to your server and read onscreen instructions.

For example: https://elab.example.org

Please report bugs on `github <https://github.com/elabftw/elabftw/issues/new/choose>`_.

It's a good idea to subscribe to `the newsletter <http://elabftw.us12.list-manage1.com/subscribe?u=61950c0fcc7a849dbb4ef1b89&id=04086ba197>`_, to know when new releases are out (you can also see that from the Sysadmin panel).

~Thank you for using `eLabFTW <https://www.elabftw.net>`_ :)
