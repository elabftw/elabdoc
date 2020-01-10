.. _install-freebsd:

Install on FreeBSD
==================

.. image:: img/freebsd.png
    :align: center
    :alt: freebsd

Because Docker on FreeBSD is not working. We'll need to install it the old school way. Here is a step-by-step for the BSD lovers out there :)

This howto was made on FreeBSD 11.0. It uses nginx as a webserver. I'll describe all the steps, but you don't need to follow all of them if you already have a webserver running of course. eLabFTW version is 1.6.0.

If you want to use OpenBSD, I have made a full tutorial `here <https://nicolascarpi.github.io/install/2017/07/11/openbsd.html>`_.

Installing a FEMP stack
-----------------------

Install nginx, php 7.2 + extensions, php-fpm and MySQL server.

.. code-block:: bash

    pkg install nginx mysql57-server php72 php72-session php72-mcrypt php72-json php72-openssl php72-ctype php72-curl php72-mbstring php72-dom php72-gettext php72-gd php72-filter php72-fileinfo php72-iconv php72-zlib php72-pdo php72-pdo_mysql php72-phar php72-zip php72-extensions
    echo 'php_fpm_enable="YES"' >> /etc/rc.conf
    echo 'nginx_enable="YES"' >> /etc/rc.conf
    echo 'mysql_enable="YES"' >> /etc/rc.conf
    # configure nginx.conf properly (user nobody, proper php-fpm config, TLS)
    # modify php-fpm config
    sed -ie 's/user = www/user = nobody/' /usr/local/etc/php-fpm.d/www.conf
    sed -ie 's/group = www/group = nobody/' /usr/local/etc/php-fpm.d/www.conf
    service nginx start
    service php-fpm start
    service mysql-server start
    mysql_secure_installation


Installing the gmagick extension
--------------------------------

Note that this step is optional. eLabFTW will use GD if gmagick is not installed (pkg install php72-gd). Gmagick can deal with PDF and Tif files, unlike GD.
The package pecl-gmagick is bound to php version 5.6. But we want 7.2. So we'll compile it ourselves.

.. code-block:: bash

    pkg install gcc-ecj binutils giflib gcc webp libwmf lcms2 GraphicsMagick mpfr mpc autoconf
    fetch https://pecl.php.net/get/gmagick
    tar xf gmagick
    cd gmagick-2.0.5RC1
    phpize
    ./configure
    make
    make install
    echo "extension=gmagick.so" > /usr/local/etc/php/ext-20-gmagick.ini

Installing elabftw
------------------

Follow instructions from :ref:`Install without Docker page <install-oldschool>`.

Creating the database
---------------------

.. code-block:: bash

    mysql -uroot -p # enter the password chosen during mysql_secure_installation
    # for some reason you need to do that again here
    set password = password('<YOUR_ROOT_PASSWORD>');
    create database elabftw;
    grant usage on *.* to elabftw@localhost identified by '<ELABFTW_USER_PASSWORD>';
    grant all privileges on elabftw.* to elabftw@localhost;
    exit;

Final step
----------

At this point you should have:

* a working nginx with php + https

I had to change the file `/usr/local/etc/nginx/fastcgi_params`, and modify the SCRIPT_NAME line to this:
`fastcgi_params SCRIPT_NAME $document_root$fastcgi_script_name;`

For a working nginx config, see the files here: https://github.com/elabftw/elabimg/tree/master/src/nginx or here: https://github.com/elabftw/elabdoc/tree/master/config_examples/nginx

* a mysql server with an `elabftw` database
* the `elabftw` php files

Import the database structure with:

.. code-block:: bash

    bin/install start

Go to https://<YOUR_SERVER>/elabftw or the address you configured in nginx to point to the `web/` folder of elabftw.

That's all folks!
