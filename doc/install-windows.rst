.. _install-windows:

Install on Windows
==================

.. image:: img/windows.png
    :align: center
    :alt: windows

.. warning:: eLabFTW should be installed on a server, not a personal computer. Installing it on your personal computer is totally fine, but in the end, what you want is to install it on a server so everyone in your team (or institute/company) can benefit from it. See :ref:`install in the cloud<install-cloud>` if you don't have a server.

Installing eLabFTW on Windows is not your typical Setup.exe > Next > Next > Finish install. Because it is a server software, we will run it on a server. And this server will be inside a container, run by `Docker <https://www.docker.com>`_.

Follow the steps below to install eLabFTW on your system:

#. Read the documentation and install `Docker for Windows <https://docs.docker.com/docker-for-windows/install/>`_
#. `Download this configuration file template <https://raw.githubusercontent.com/elabftw/elabimg/master/src/docker-compose.yml-EXAMPLE>`_
#. Save it as docker-compose.yml (type "All files" so it's not saved with a .txt extension)
#. Edit it with `Notepad++ <https://notepad-plus-plus.org/>`_ or any editor you like but not plain old Notepad.
#. Read carefully the comments and edit what is needed
#. Save it as docker-compose.yml (make sure there is no .txt extension)
#. Open Powershell (or Terminal on Mac)
#. Enter these commands:

.. code-block:: bash

    cd D:\Data\elabftw # adapt the path to your situation
    docker-compose up -d

    # for Mac OS users:
    cd /Users/YOU/Documents/elabftw # adapt the path to your situation
    docker-compose up -d

Import the database structure
-----------------------------

Before using eLabFTW, we need to import the database structure:

.. code-block:: bash

    docker exec -it elabftw bin/install start

Create your Sysadmin account
----------------------------

**Final step**: click here: https://localhost/register.php

.. note:: Remember to keep your installation :doc:`backuped <backup>` and :doc:`updated <how-to-update>` ;)

.. note:: If you need to access eLabFTW from another computer, or if you installed it on a Windows server, you'll need to forward ports to the VirtualBox instance.
