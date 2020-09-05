.. _debug:

Debug
=====

You have an issue with your eLabFTW installation? Here are the things you should check before opening an issue on GitHub ;)

Docker logs
-----------

If the server is not responding at all, check the web container logs. If the application cannot connect to MySQL, check the mysql container logs.

.. code-block:: bash

   # to check if the containers are running
   elabctl status
   # or
   docker ps
   # for the web container
   docker logs elabftw
   # for the mysql container
   docker logs mysql

PHP logs
--------

If you get "An error occured!" message, check the PHP logs. All errors should be logged there.

.. code-block:: bash

   # for php errors
   elabctl error-logs
   # or
   docker logs elabftw 1>/dev/null
