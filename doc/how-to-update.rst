.. _how-to-update:

*************
How to update
*************

.. warning:: Be sure to `read the release notes <https://github.com/elabftw/elabftw/releases/latest>`_, they might contain important information. And have a :ref:`backup <backup>`.

.. note:: If you are running out of disk space, you can do "docker system prune -a" to free up some space taken by old images.

STEP 0: Before the update
=========================

Make sure to figure out what version you are running and **read the release notes** for the new version.

The current running version can be seen in the bottom right of every page.

.. warning:: Be sure to `read the release notes <https://github.com/elabftw/elabftw/releases/latest>`_, they might contain important information. And have a :ref:`backup <backup>`.

STEP 1: Specify which version you want
======================================

Start by editing your configuration file (`/etc/elabftw.yml` by default) and change the version of the image (line `image: elabftw/elabimg:X.Y.Z`)

The latest version can be found on `this page <https://github.com/elabftw/elabftw/releases/latest>`_.


STEP 2: Launch a new container
==============================

With elabctl
------------

.. code-block:: bash

    elabctl update

Without elabctl
---------------

In the directory where you have the `docker-compose.yml` file:

.. code-block:: bash

    docker-compose pull
    docker-compose down
    docker-compose up -d

STEP 3: Run the database migration
==================================

.. code-block:: bash

    # change the name of the container if it is different in your configuration
    docker exec -it elabftw bin/console db:update
    # Note: for version 3.3 to 3.4 use this instead
    docker exec -it elabftw bin/console db:updateTo34
    # Note: for version 2.x to 3.x use this instead
    docker exec -it elabftw bin/console db:updateto3

Congratulations, you are now running the latest version! Make sure to keep your installation regularly updated!

If you encounter an issue during the database migration, open a GitHub issue!

Note that you can use `db:revert XYZ` to revert the changes made by schema `XYZ`, or use `--force` to ignore errors (only do that if you know what you are doing!).

If you are using it on a NAS
============================

.. warning:: Be sure to `read the release notes <https://github.com/elabftw/elabftw/releases/latest>`_, they might contain important information. And have a :ref:`backup <backup>`.

You can follow this tutorial: `Update eLabFTW on a Synology NAS <https://github.com/elabftw/elabhow/tree/master/howto-update-nas#how-to-update-elabftw-on-a-synology-nas>`_

Complete upgrade guide from 2.0.7 to 3.0.0
==========================================

Updating the database structure
-------------------------------

After updating the container/code, run this command to update the database schema:

.. code-block:: bash

    # for Docker users
    docker exec -it elabftw php bin/console db:updateto3

    # for non-Docker users, from the elabftw directory
    yarn install
    yarn buildall
    composer install --no-dev -a
    php bin/console db:updateto3

This will prepare the database, then cleanup any orphaned rows found, and update the structure.

For other updates, calling "db:update" should be enough. Always read the release notes!

Breaking update
---------------

Two thing are breaking in this update, the way to update, as described above, and the API keys.

API keys now have a different format and are no longer stored in clear in the database (after all, they allow access to your data, so they should be treated as passwords).

Users using the API will have to go to their profile and create new API keys. The old ones are erased upon update.
