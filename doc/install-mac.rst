.. _install-mac:

Install on Mac OS X
===================

.. image:: img/apple.png
    :align: center
    :alt: apple

.. warning:: eLabFTW should be installed on a server, not a personal computer. Installing it on your personal computer is totally fine, but in the end, what you want is to install it on a server so everyone in your team (or institute/company) can benefit from it. See :ref:`install in the cloud<install-cloud>` if you don't have a server.

Ok so you read the warning above and you still want to install it on your Mac? It's fine by me, but keep in mind that it's best to ask your IT department to install it on a server.

Install with Docker
-------------------

Follow the instructions for :doc:`installing on Windows <install-windows>`. It's more or less the same: you install Docker, then you edit a docker-compose.yml file, and you start the containers with docker-compose.

WARNING: by default eLabFTW will be installed in `/var` but that folder is not accessible on newer versions of Mac OS, so use something else like `/Users/<YOUR_USERNAME>/Documents/elabftw`. See `this issue <https://github.com/elabftw/elabftw/issues/1965>`_.

Because I don't own a Mac, these instructions are untested, but should work nonetheless.
