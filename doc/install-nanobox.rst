.. _install-nanobox:

Install on Nanobox.io
=====================

.. image:: img/nanobox.png
    :align: center
    :alt: nanobox

`Nanobox.io <https://nanobox.io/>`_ lets you install apps in the cloud without having to deal with system administration. It also facilitates scaling up. Using nanobox is pretty easy if you are familiar with the vocabulary. Otherwise you'll have to read carefully the documentation.


Deploy elabftw
--------------

* Create an account on `Nanobox.io <https://nanobox.io/>`_

* From your dashboard, click "LAUNCH AN APP". Select provider and region. Select "Generate the images for me" and click "Let's go!"

* Once it's ready to deploy, install the `nanobox` tool on your computer

* From your computer, download the code for elabftw:

.. code-block:: bash

   git clone --depth 1 https://github.com/elabftw/elabftw
   cd elabftw
   nanobox remote add <YOUR_APP_NAME>
   nanobox deploy

* The last step is to create a certificate (for HTTPS), click the SSL/TLS button and follow instructions. It is recommended to use a Let's Encrypt certificate.


That's it \o/

Don't forget to read :ref:`the post install page <postinstall>`, setup :ref:`backup <backup>`, and subscribe to `the newsletter <http://elabftw.us12.list-manage1.com/subscribe?u=61950c0fcc7a849dbb4ef1b89&id=04086ba197>`_!

ENJOY! :D
