.. _api:

API
===

What's that?
------------

It's a way to read or write data to eLabFTW from an external program (like a Python script).

For instance, instead of using a web browser to access the web interface and create an experiment,
you make a call to the API saying "hey, create an experiment for me", and the api will reply with the ID of the newly created experiment.

Documentation
-------------

The complete documentation of all endpoints with code examples is available here: `elabftw's API documentation <https://doc.elabftw.net/api/>`_.

Configuration for non Docker instances
--------------------------------------

**If you are not running the Docker image** provided, you'll need to edit your webserver configuration to redirect correctly the API calls:

Here is the configuration for Nginx:

.. code-block:: nginx

    location ~ ^/api/v1/(.*)/?$ {
         rewrite /api/v1/(.*)$ /app/controllers/ApiController.php?req=$1? last;
    }


For Apache 2.4:

.. code-block:: bash

    a2enmod proxy proxy_http rewrite

.. code-block:: apache

    SSLEngine on
    RewriteEngine On
    RewriteCond %{HTTP:Authorization} ^(.*)
    RewriteRule .* - [e=HTTP_AUTHORIZATION:%1]
    RewriteRule ^/api/v1/(.*)$ /app/controllers/ApiController.php?req=$1 [P,L]

