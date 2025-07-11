.. _addons:

******
Addons
******

What are addons?
=================

Addons are services that can be deployed to provide extended functionality for eLabFTW. They are not a requirement but are definitely recommended.

Chem Plugin
===========

Description
-----------

The ``chem-plugin`` addon is necessary for two things:

- calculating fingerprint of chemical compounds (which subsequently allows for substructure search)
- enabling all features of the chemical editor

How to install
--------------

Deploy a ``chem-plugin`` container somewhere. It can be on the same server than eLabFTW or some other place. Adding a service to your ``docker-compose.yml`` file is the easiest. See the `example docker-compose.yml file <https://github.com/elabftw/elabimg/blob/e1e5a2da33db11ae8d54924c15a227d6abcd4e43/src/docker-compose.yml-EXAMPLE#L414-L419>`_.

The deployment is really straightforward, as there is nothing to configure. You just start the container and that's it.

.. code:: yaml

     chem-plugin:
        image: elabftw/chem-plugin:latest
        container_name: chem-plugin
        restart: always
        networks:
          - elabftw-net

Next, configure eLabFTW to use that service by adding two environment variables:

.. code:: yaml

    # This service is necessary for the Chemical structure editor (Ketcher)
    - USE_INDIGO=true
    - INDIGO_URL=http://chem-plugin/
    # The fingerprinter is necessary to create a fingerprint of chemical compounds so we can do sub-structure search
    - USE_FINGERPRINTER=true
    - FINGERPRINTER_URL=http://chem-plugin:8000/

In the example above, the container is on the same network as ``elabftw`` container, so we use its name as hostname.

Restart the ``elabftw`` container to take these changes into account.

OpenCloning addon
=================

.. _opencloning-install:

Description
-----------

`OpenCloning <https://github.com/manulera/OpenCloning>`_ is an application used to plan and document cloning. DNA data can be loaded from various sources, and the application is tightly integrated with eLabFTW. This means that you can easily use Resource entries in eLabFTW and their attached files to perform cloning operations. See :ref:`usage documentation <opencloning-use>`.

How to install
--------------

To enable OpenCloning in eLabFTW, deploy a container. See this example: `example docker-compose.yml <https://github.com/elabftw/elabimg/blob/7a6940475e9866492166e4c2450fc63f38587566/src/docker-compose.yml-EXAMPLE#L429-L440>`_.

Then enable it in the ``elabftw`` container configuration:

.. code:: yaml

    # This is for the integration of the DNA Cloning tool
    - USE_OPENCLONING=true
    - OPENCLONING_URL=http://opencloning-plugin:8000/

Restart the ``elabftw`` container to apply these changes.
