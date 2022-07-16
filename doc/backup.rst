.. _backup:

How to backup
=============

Introduction
------------

This page documents how to backup an existing eLabFTW installation. It is important that you take the time to make sure that your backups are working properly.

.. image:: img/didyoubackup.jpg

There is basically three things to backup :

* the MySQL database (by default in `/var/elabftw/mysql`)
* the uploaded files (by default in `/var/elabftw/web`)
* your configuration file (by default `/etc/elabftw.yml`): not really required if you use provisioning tools like Ansible and store your config/secrets somewhere else

How to backup a Docker installation
-----------------------------------

With elabctl
````````````

Using the backup function of `elabctl` is the recommended approach. The MySQL database will be dumped thanks to `mysqldump` present in the `mysql` container. The uploaded files will be copied with `borgbackup <https://www.borgbackup.org/>`_ and you need to install it first and then configure it.

Configuration
"""""""""""""

Start by figuring out where you want the borg repository to live. It can be local or remote folder (remote is better but requires ssh correctly setup to access it). It can also be local but on a network-mounted path, which makes it remote.

After installing borg, initialize a new repository with:

.. code-block:: bash

   # for a local path
   borg init -e repokey-blake2 /path/to/elabftw-borg-repo
   # for a remote (ssh) path
   borg init -e repokey-blake2 someserver:/path/to/elabftw-borg-repo

It is necessary to use the `elabctl.conf` configuration file (available `here <https://raw.githubusercontent.com/elabftw/elabctl/master/elabctl.conf>`_). Place this file in `/root/.config/elabctl.conf` and make sure to specify the settings correctly.

Test
""""

Try the backup with:

.. code-block:: bash

    elabctl backup

You can also use `mysql-backup` to only backup the MySQL database:

.. code-block:: bash

    elabctl mysql-backup

You can also use `borg-backup` to only backup the uploaded files:

.. code-block:: bash

    elabctl borg-backup

.. warning::

    Important: verify that all the files are correctly created and that you will be able to restore from a backup!

Without elabctl
```````````````

You're on your own. Use your favorite tools to backup the MySQL database and uploaded files.

Making it automatic using cron
------------------------------

A good backup is automatic. Use a cronjob or a systemd timer job to trigger the backup job regularly (ideally daily).

With a cronjob
``````````````

If you have the traditional cron service running, try::

    crontab -e

This will open the cronjob file in edit mode.

Add this line at the bottom::

    00 04 * * * /path/to/elabctl backup

This will run the script everyday at 4am. Make sure to write the full path to `elabctl` as it might not be in the `$PATH` for cron.

With a systemd timer
````````````````````

Some systems don't use the traditional cron service, so instead of installing it, you should use a systemd timer (provided systemd is your init system, which is quite likely).

You will need to create two files, one `.service` and one `.timer`.

Content of `/etc/systemd/system/elabftw-backup.service`::

    [Unit]
    Description=Backup eLabFTW data
    Wants=elabftw-backup.timer

    [Service]
    Type=oneshot
    # make sure to edit the path below
    ExecStart=/path/to/elabctl backup

    [Install]
    WantedBy=multi-user.target

Content of `/etc/systemd/system/elabftw-backup.timer`::

    [Unit]
    Description=Backup eLabFTW data

    [Timer]
    OnCalendar=*-*-* 4:00:00
    Persistent=true

    [Install]
    WantedBy=timers.target

Now activate it::

    systemctl enable elabftw-backup
    systemctl start elabftw-backup


How to restore a backup
-----------------------

You should have three files/folders to start with:

* A MySQL dump (file ending in .sql or .sql.gz)
* Your uploaded files
* Possibly your configuration file

Let's start by moving uploaded files and config file at the correct place (adjust the paths to your case):

.. code-block:: bash

    mv /path/to/uploaded-files-backup/* /var/elabftw/web
    mv /path/to/configuration-backup-elabftw.yml /etc/elabftw.yml
    # now fix the permissions
    chown -R 101:101 /var/elabftw/web
    chmod 600 /etc/elabftw.yml

Now we import the SQL database (the mysql container must be running):

.. code-block:: bash

    gunzip mysql_dump-YYYY-MM-DD.sql.gz # uncompress the file
    docker cp mysql_dump-YYYY-MM-DD.sql mysql:/ # copy it inside the mysql container
    docker exec -it mysql bash # spawn a shell in the mysql container
    mysql -uroot -p # login to mysql prompt
    # here you type the password you put in MYSQL_ROOT_PASSWORD in the /etc/elabftw.yml file
    Mysql> drop database elabftw; # delete the brand new database
    Mysql> create database elabftw character set utf8mb4 collate utf8mb4_0900_ai_ci; # create a new one
    Mysql> use elabftw; # select it
    Mysql> set names utf8; # make sure you import in utf8 (don't do this if you are in latin1)
    Mysql> source mysql_dump-YYYY-MM-DD.sql; # import the backup
    Mysql> exit;

Now you should have your old install back :)
