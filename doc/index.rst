.. elabftw documentation master file, created by
   sphinx-quickstart on Fri Jul 24 17:28:23 2015.

Welcome to elabftw's documentation!
===================================

.. image:: img/elabftw-logo.png
    :align: left
    :alt: elabftw logo

:Website:  https://www.elabftw.net
:Live demo: https://demo.elabftw.net

Introduction
------------

eLabFTW is a PHP application using MySQL to store data persistently. Once installed on a server, users can register an account and start using their electronic lab notebook.

Several teams can be hosted on the same install. Ideally, it is installed at the institution/company level. But individual teams can install it for themselves, too. Or you can run it locally on your computer.

It is distributed through Docker images, ensuring portability and added security. See the :doc:`Docker documentation <docker-doc>` for more infos.

Check out the :doc:`list of features <features>`.

See :doc:`this page <install>` to install it on your server.

See :doc:`this page <install-cloud>` if you don't own a server already.

 .. image:: img/by-sa.png
    :align: center
    :alt: cc-by-sa

Table of contents:

.. toctree::
    :caption: Installation

    install
    install-cloud
    install-nas
    install-mac
    install-windows

.. toctree::
    :caption: Usage

    user-guide
    admin-guide
    sysadmin-guide
    metadata

.. toctree::
    :caption: Documentation

    backup
    how-to-update
    contributing
    faq
    features
    docker-doc
    upgrade-to-docker
    api
    ldap
    saml
    debug

.. toctree::
    :caption: Miscellaneous

    thanks
    changelog
