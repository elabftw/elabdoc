.. _how-to-update:

How to update
=============

.. warning:: Be sure to `read the release notes <https://github.com/elabftw/elabftw/releases/latest>`_, they might contain important information. And have a :ref:`backup <backup>`.

.. note:: If you are running out of disk space, you can do "docker system prune -a" to free up some space taken by old images.

If you installed it with elabctl
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. code-block:: bash

    elabctl update

If you installed it with git
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

To update, cd in the `elabftw` folder and do:

.. code-block:: bash

    git pull
    # see https://getcomposer.org to install composer
    composer install --no-dev
    # see https://yarnpkg.com/en/docs/install to install yarn
    yarn install
    yarn buildall

If you are using Docker without elabctl
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

In the directory where you have the `docker-compose.yml` file:

.. code-block:: bash

    docker-compose pull
    docker-compose down
    docker-compose up -d

If you installed it from a .zip or .tar.gz archive
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. note:: This is not a recommended method, use it only if you cannot use git.

1. Get the `latest archive <https://github.com/elabftw/elabftw/releases/latest>`_
2. Unpack it on your server, overwriting all the files.

3. Install php and javascript dependencies:

.. code-block:: bash

    # see https://getcomposer.org to install composer
    composer install --no-dev
    # see https://yarnpkg.com/en/docs/install to install yarn
    yarn install
    yarn buildall

Complete upgrade guide from 1.8.x to 2.0.0
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

A lot of things changed between version 1.8.x and 2.0.0. Here is what you need to know:

Docker vs. non docker
---------------------

If you are using Docker, you don't need to do anything. Just update normally, that's the big advantage with Docker, I can change a lot of things internally but because I'm in complete control of the build process, it is transparent for you! :)

If you are not using Docker you'll want to read the following paragraphs carefully.

Web root
--------

The web root has changed, previously it was directly in `elabftw` folder, now it's in `elabftw/web`. It is better to have a separate web directory that is not the root of the project. It helps separating what can be served by the webserver, and what cannot. Edit the configuration of your webserver to serve the `elabftw/web` folder instead of the `elabftw` folder.

For Apache 2.4:

.. code-block:: apache

    DocumentRoot /path/to/elabftw/web

For nginx:

.. code-block:: nginx

    root /path/to/elabftw/web;

Minified files
--------------

The minified files are not tracked by git anymore. This means you'll need to build them before the installation can work. For that you'll need to install `yarn <https://yarnpkg.com/en/docs/install>`_. Once `yarn` is installed on your system, issue these two commands:

.. code-block:: bash

    yarn install
    yarn buildall

The first command will create the `node_modules` directory with all the javascript dependencies, and the second command will build all the necessary minified files (JS and CSS). You will need to do these commands after each update.

The cache directory
-------------------

Previously all the temporary files were written to `uploads/tmp`, now there is a dedicated `cache` folder in the root directory to store the temporary files (twig cache, mpdf cache and elabftw exports). You'll need to create the directory and give it appropriate permissions:

.. code-block:: bash

    cd /path/to/elabftw
    mkdir cache
    chown www-data:www-data cache
    chmod 700 cache

In the example above I'm using the user/group `www-data` because it's the most common, but you'll need to adapt it to your needs. It might be nginx, httpd or anything else. Refer to the configuration of your webserver to see under which user the webserver is executed.
