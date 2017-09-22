.. _install-mac:

Install on Mac OS X
===================

.. image:: img/apple.png
    :align: center
    :alt: apple

.. warning:: eLabFTW should be installed on a server, not a personal computer. Installing it on your personal computer is totally fine, but in the end, what you want is to install it on a server so everyone in your team (or institute/company) can benefit from it. See :ref:`install in the cloud<install-drop>` if you don't have a server.

Ok so you read the warning above and you still want to install it on your Mac? It's fine by me, but keep in mind that it's best to ask your IT department to install it on a server.

There are two ways to install eLabFTW on a Mac OS X computer, either with Docker (recommended), or with XAMPP.

Install with Docker
-------------------

Follow the instructions for :doc:`installing on Windows <install-windows>`. It's more or less the same: you install Docker, then you edit a docker-compose.yml file, and you start the containers with docker-compose.

Because I don't own a Mac, these instructions are untested, but should work nonetheless.

Install with XAMPP
------------------

Download `XAMPP for OS X <https://www.apachefriends.org/download.html>`_. Take the greatest version number. Versions below 5.6 will **NOT** work.

Now that it's downloaded, double click it and open the installer. You can untick the XAMPP Developer Files and Learn more about Bitnami checkboxes.

Once it's installed, you let it start XAMPP. On the application manager (/Applications/XAMPP/manager-osx.app):

* Go to the tab '''Manage Servers'''
* Select MySQL Database
* Click Start
* Select Apache Webserver
* Click Start

Test that everything is working by going to https://localhost. You should see a warning that the certificate is not signed and cannot be trusted, which is normal. If it doesn't work, try telling your browser to avoid proxy for local addresses.

`Download the latest release <https://github.com/elabftw/elabftw/releases/latest>`_ and extract its content to `/Applications/XAMPP/htdocs/elabftw`.

Now we need to fix the permissions. Open the terminal and type:

.. code-block:: bash

    cd /Applications/XAMPP/htdocs/elabftw
    mkdir -p uploads/tmp
    sudo chmod -R 777 .

Now we need to install `composer <https://getcomposer.org/>`_ to get the PHP dependencies. Please refer to the `composer <https://getcomposer.org/>`_ website for instructions on how to install it. Once installed:

.. code-block:: bash

    php composer.phar install --no-dev


Setup a database
----------------

With XAMPP comes phpmyadmin. We will use this interface to do this part easily.

* Go to https://localhost/phpmyadmin
* Click on the Databases tab
* Create a database named `elabftw`

Final step
----------

Browse to: https://localhost/elabftw and follow onscreen instructions.

.. hint:: There is no password for the mysql user root. So put root as mysql username and no password.

.. note:: Remember to keep your installation :doc:`backuped <backup>` and :doc:`updated <how-to-update>` ;)
