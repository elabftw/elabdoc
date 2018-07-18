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

PHP version
-----------

The minimum PHP version is now 7.1. If you are running an earlier version than that you'll need to update your PHP to at least 7.1. It is possible to have several versions of PHP running at the same time. But if you cannot update to a more recent version of PHP there are two things you can do:

* Stay on branch 1.8 for the time being
* :ref:`Convert your installation to Docker <upgrade-to-docker>`

Now before you open a GitHub issue ranting about why I do not support PHP < 7.1, let me tell you a few reasons why this was done:

* eLabFTW is a Docker first project, it means that although using it outside Docker is possible (and always will be), running into versions problems is inherent to any non docker process. As I said above, you can install Docker and convert your install to a Docker install and forget about missing PHP extensions and versions mismatchs.
* Some dependencies used by eLabFTW require PHP 7.1 like SwiftMailer (to send emails) and HTTPFoundation. Because the rest of the ecosystem is moving forward, and eLabFTW being a modern web app, it is also moving forward.
* There is a ~2X speed improvement between PHP 5.6 and 7.x.
* PHP 7.1 allows me to use strict typing, which will highly reduce the possibility of bugs.
* Making PHP 7.1 allows me to remove the fixes that I had to make to be compatible with PHP 5.6.
* PHP 5.6 and 7.0 are already in Security Fixes only mode (see `PHP supported versions <https://secure.php.net/supported-versions.php>`_).
* PHP 5.6 and 7.0 support ends at the end of 2018, so you'll have to update anyway.
* It is the responsability of the developer to push forward for new versions. Wordpress can still be run with PHP 5.2 and that's an issue. It makes the code ancient and bad, forbidding devs to use modern solutions implemented in the most recent iterations of the language. This also enables users to keep insecure versions of PHP installed on their webserver. I'm pretty concerned about security, so I have absolutely no intent to keep supporting old versions that do not receive security fixes anymore.
* It might push users to finally use Docker. The Docker version of eLabFTW is much more secure than a 'normal install' because I've taken numerous steps to configure all the components tightly. Something that can only be replicated outside Docker in certain conditions.

Web root
--------

The web root has changed, previously it was directly in `elabftw` folder, now it's in `elabftw/web`. It is better to have a separate web directory that is not the root of the project. It helps separating what can be served by the webserver, and what cannot. Edit the configuration of your webserver to serve the `elabftw/web` folder instead of the `elabftw` folder.

For Apache 2.4:

.. code-block:: apache

    DocumentRoot "/path/to/elabftw/web"

For nginx:

.. code-block:: nginx

    root /path/to/elabftw/web;

Minified files
--------------

The minified files are not tracked by git anymore. This means you'll need to build them before the installation can work. For that you'll need to install `yarn <https://yarnpkg.com/en/docs/install>`_. Once `yarn` is installed on your system, issue these two commands from the elabftw directory:

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
