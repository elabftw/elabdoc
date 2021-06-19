.. _install-oldschool:

Install without Docker
======================

.. image:: img/gnulinux.png
    :align: center
    :alt: gnulinux
.. image:: img/beastie.png
    :align: right
    :alt: beastie

Prerequisites
-------------

.. warning:: This method is deprecated. Only use it if you cannot install Docker!

Please refer to your distribution's documentation to install :

* A webserver (like nginx, Apache, lighttpd, cherokee or caddy)
* PHP version > 7.3.7
* MySQL version > 5.5 < 8.0 (5.7 recommended, 8.0 not working fully yet)
* Git

.. tip:: If you don't know how to do that, or can't update php, have a look at :ref:`installing eLabFTW on a drop <install-drop>` or :ref:`in a docker container <install>`.

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

The Docker image of eLabFTW contains a lot of little configuration tweaks to improve the security of the web application. Here are some of them that you can apply to your web server configuration.

Nginx or Apache config
^^^^^^^^^^^^^^^^^^^^^^

Example config files are provided in the `config_examples <https://github.com/elabftw/elabdoc/tree/master/config_examples>`_ directory.

* Add security headers (IMPORTANT). See the end of `this file <https://github.com/elabftw/elabimg/blob/master/src/nginx/common.conf>`_.
* Use a proper TLS certificate, not a self-signed one
* Use DH params of 2048 bits
* Disable session tickets
* Only use TLS version > 1.2
* Use a modern cipher list
* Configure API redirect

PHP config
^^^^^^^^^^

See the phpfpmConf() and phpConf() functions from `run.sh <https://github.com/elabftw/elabimg/blob/master/src/run.sh>`_.

* Hide PHP version (`expose_php` in php.ini)
* Set cookies httponly and secure
* Use strict mode for sessions
* Store sessions in a separate directory with restrictive permissions
* disable `url_fopen`
* enable opcache
* configure `open_basedir`
* use longer session id length (`session.sid_lenght`)
* disable unused functions (see the list in the run.sh script)

Note: these configuration changes will affect all the PHP apps on the server, so you can really only do that if the server is only serving eLabFTW (do you see now why Docker is great? :p).

Miscellaneous config
^^^^^^^^^^^^^^^^^^^^

* Put restrictive permissions on the `uploads` and `cache` folders (and `config.php` file).

Final step
----------

Finally, point your browser to your server and read onscreen instructions.

For example: https://12.34.56.78/elabftw

Please report bugs on `github <https://github.com/elabftw/elabftw/issues>`_.

It's a good idea to subscribe to `the newsletter <http://elabftw.us12.list-manage1.com/subscribe?u=61950c0fcc7a849dbb4ef1b89&id=04086ba197>`_, to know when new releases are out (you can also see that from the Sysadmin panel).

~Thank you for using `eLabFTW <https://www.elabftw.net>`_ :)
