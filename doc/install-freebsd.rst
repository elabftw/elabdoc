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

Install nginx, php 7.1 + extensions, php-fpm and MySQL server.

.. code-block:: bash

    pkg install nginx mysql57-server php71 php71-session php71-mcrypt php71-json php71-openssl php71-ctype php71-curl php71-mbstring php71-dom php71-gettext php71-gd php71-filter php71-fileinfo php71-iconv php71-zlib php71-pdo php71-pdo_mysql php71-phar php71-zip php71-extensions
    echo 'php_fpm_enable="YES"' >> /etc/rc.conf
    echo 'nginx_enable="YES"' >> /etc/rc.conf
    echo 'mysql_enable="YES"' >> /etc/rc.conf
    # configure nginx.conf properly (user nobody, proper php-fpm config, TLS)
    # modify php-fpm config
    sed -ie 's/user=www/user=nobody/' /usr/local/etc/php-fpm.d/www.conf
    sed -ie 's/group=www/group=nobody/' /usr/local/etc/php-fpm.d/www.conf
    service nginx start
    service php-fpm start
    service mysql-server start
    mysql_secure_installation


Installing the gmagick extension
--------------------------------

Note that this step is optional. eLabFTW will use GD if gmagick is not installed (pkg install php71-gd). Gmagick can deal with PDF and Tif files, unlike GD.
The package pecl-gmagick is bound to php version 5.6. But we want 7.1. So we'll compile it ourselves.

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

.. code-block:: bash

    cd /usr/local/www/nginx/ # or wherever you configured nginx to serve
    git clone --depth 1 https://github.com/elabftw/elabftw
    cd elabftw
    # install composer: see https://getcomposer.org/download/
    php composer.phar install --no-dev
    mkdir cache
    mkdir uploads
    chown nobody:nobody cache uploads
    chmod 700 cache uploads

Now we need to install yarn to build the javascript files required. Install node.js first, and then yarn, and finally build the minified files.

.. code-block:: bash

    pkg install node
    curl -o- -L https://yarnpkg.com/install.sh | bash
    yarn install
    yarn buildall

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

For a working nginx config, see the files here: https://github.com/elabftw/elabimg/tree/master/src/nginx

* a mysql server with an `elabftw` database
* the `elabftw` php files

Go to https://<YOUR_SERVER>/elabftw or the address you configured in nginx to point to the `web/` folder of elabftw.

It'll probably let you download the `config.php` file. Upload this file to the root directory of `elabftw` and reload the page.

That's all folks!
