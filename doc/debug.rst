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

   docker logs elabftw 1>/dev/null

Accessing MySQL database
------------------------

Sometimes it might be necessary to look directly into the database. You can use `elabctl mysql` to get a MySQL prompt directly.

Resetting a password directly from MySQL
----------------------------------------

If you can't reset a password because the mail system doesn't work and have access to the MySQL database, you can reset it manually.

First connect to a MySQL prompt:

.. code-block:: bash

   # docker users
   elabctl mysql

Find out the userid of the user you want to reset the password:

.. code-block:: sql

   SELECT userid FROM users WHERE firstname = 'XXX';

Replace XXX with the firstname. You can of course also search with "email" or "lastname". Now that you have the userid, we need to change the `password_hash` column. The `password_hash` column will be:

$2y$10$KXkB/w1NhLnl1mHbK0yTsuAbgJ8st4qQ2i36KyTk7kwo.G6Oq6LXa

.. code-block:: sql

   UPDATE users SET password_hash = "$2y$10$KXk..." WHERE userid = X;

Replace X with the correct userid.

Once this is done, you can login with the password: "totototo". Make sure to change it again from the User Control Panel once logged in!
