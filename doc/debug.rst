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

If you get "An error occurred!" message, check the PHP logs. All errors should be logged there.

.. code-block:: bash

   # for php errors
   elabctl error-logs
   # or
   docker logs elabftw 1>/dev/null

Resetting a password directly from MySQL
----------------------------------------

If you can't reset a password because the mail system doesn't work and have access to the MySQL database, you can reset it manually.

First connect to a MySQL prompt:

.. code-block:: bash

   # docker users
   elabctl mysql
   # non-docker
   mysql -uelabftw -p elabftw

Find out the userid of the user you want to reset the password:

.. code-block:: sql

   SELECT userid FROM users WHERE firstname = 'XXX';

Replace XXX with the firstname. You can of course also search with "email" or "lastname". Now that you have the userid, we need to change the "password" and "salt" columns. The password column will be :

f5664da4107ca5f521d8057caa8a97639c6ba8a8276fc722d8df98219fd3a11dd4bdd4573172556ce30a0993c4414773a3f2885aff38077867b915fdbce53263

and the salt column will be :

f93c630ce2d74ef0636488a7ba85d24e67a579e9e0aca7e0a4769c8eed8d90156de5479ccded33585c82c4a631133e2f051e8df971d479cba8045df102c92c79

.. code-block:: sql

   UPDATE users SET password = f566..., salt = f93c... WHERE userid = X;

Replace X with the correct userid.

Once this is done, you can login with the password: "totototo".
