.. _install-freebsd:

Install on FreeBSD
==================

.. image:: img/freebsd.png
    :align: center
    :alt: freebsd

Because Docker on FreeBSD is not working. We'll need to install it the old school way. Here is a step-by-step for the BSD lovers out there :)

This howto was made on FreeBSD 12.2. It uses nginx as a webserver. I'll describe all the steps, but you don't need to follow all of them if you already have a webserver running of course. eLabFTW version is 4.0.0. Last update is March 2021. If you find issues in this tutorial, please report them through a GitHub issue.

If you want to use OpenBSD, I have made a full tutorial `here <https://nicolascarpi.github.io/install/2017/07/11/openbsd.html>`_.

Please note that this tutorial is for administrators familiar with FreeBSD. If you are a beginner you should use Docker on GNU+Linux.

Installing a FEMP stack
-----------------------

Install nginx, php 8.0 + extensions, php-fpm, yarn and MySQL 8.0 server.

.. code-block:: bash

    pkg install nginx mysql80-server php80 php80-session php80-openssl php80-ctype php80-curl php80-mbstring php80-dom php80-gettext php80-gd php80-filter php80-fileinfo php80-iconv php80-zlib php80-pdo php80-pdo_mysql php80-phar php80-zip php80-extensions php80-exif php80-ldap php80-pecl-imagick yarn
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


Installing elabftw
------------------

Follow instructions from :ref:`Install without Docker page <install-oldschool>`.

Creating the database
---------------------

.. code-block:: bash

    mysql -uroot -p # enter the password chosen during mysql_secure_installation
    create database elabftw character set utf8mb4 collate utf8mb4_0900_ai_ci;
    create user 'elabftw'@'localhost' identified with mysql_native_password by '<ELABFTW_USER_PASSWORD>';
    grant all privileges on elabftw.* to elabftw@localhost;
    exit;

Final step
----------

At this point you should have:

* a working nginx with php + https

I had to change the file `/usr/local/etc/nginx/fastcgi_params`, and this line:
`fastcgi_params SCRIPT_FILENAME $document_root$fastcgi_script_name;`

For a working nginx config, see the files here: https://github.com/elabftw/elabimg/tree/master/src/nginx.

* a mysql server with an `elabftw` database
* the `elabftw` php files where the `root` config of nginx points

Import the database structure with:

.. code-block:: bash

    bin/install start

Go to https://<YOUR_ELABFTW_DOMAIN> and register an account. Next step is to go to the sysconfig panel and configure email. See :ref:`Sysadmin guide <sysadmin-guide>`.

It's a good idea to subscribe to `the newsletter <http://elabftw.us12.list-manage1.com/subscribe?u=61950c0fcc7a849dbb4ef1b89&id=04086ba197>`_, to know when new releases are out (you can also see that from the Sysadmin panel).

That's all folks!

~Thank you for using `eLabFTW <https://www.elabftw.net>`_ :)
