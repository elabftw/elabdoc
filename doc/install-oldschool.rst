.. _install-oldschool:

Install without Docker
======================

.. image:: img/gnulinux.png
    :align: center
    :alt: gnulinux
.. image:: img/beastie.png
    :align: right
    :alt: beastie


Introduction
------------

.. warning:: This method is **highly inadvisable**. Only use it if you absolutely cannot install Docker and have good server administration skills!

Before going forward, consider the huge amount of care that has been given to the official Docker image for eLabFTW. It runs a deeply customized webserver with php-fpm. Everything is optimized for speed, correctness and more importantly **security**. It makes upgrades much easier and less prone to breakage. It also keeps your server nice and tidy because you won't need to install all the dependencies needed to run eLabFTW on your server.

If you don't use Docker you basically **increase the maintenance work tenfold** at least. Because breaking changes in the code are transparent to Docker users, as the image will follow, but not to you, as you will need to keep your configuration files updated manually.

If you already have let's say an Apache server running and are considering installing eLabFTW along your other PHP projects, know that you can keep your existing Apache installation and use it as a reverse proxy to a Docker container. See the `documentation for reverse proxies <https://github.com/elabftw/elabdoc/tree/master/config_examples>`_.

**You have been warned**, the only officially supported deployment strategy is through Docker, as it makes the life easier for everyone.

.. tip:: This is your last chance to go back to the :ref:`recommended installation instructions <install>`.

The only valid reason to not use Docker is if you have a BSD system and are already a capable administrator.

Nope
----

Installation instructions for running eLabFTW without Docker have been removed from the documentation. If you don't understand why, please read the paragraph above.
