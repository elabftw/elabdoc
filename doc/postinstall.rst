.. _postinstall:

Post install
============

Setting up email
----------------

If there is only one thing to do after an install, it's setting up email. Otherwise users will not be able to reset their password!

If a mail server is present, it will work out of the box. However, it is recommended to use an authenticated SMTP account to avoid the emails going to the spam folders of recipients. That is, unless your mail server is perfectly configured (with DKIM and SPF).

Go to the Sysadmin panel (a link is at the bottom left of a page) and add the requested infos.

If you don't know what to do, register a new account on `SMTP2GO <https://www.smtp2go.com/signup>`_. Once logged in, it will provide you with a login and password to connect to the SMTP server "mail.smtp2go.com". Input these credentials on the Sysadmin panel and test sending an email.

Make sure that the `uploads` folder cannot be accessed
------------------------------------------------------

This is only if you installed it **without** docker:

Just visit `https://your-elabftw-server.org/uploads/` and see if you see the files there (or at least the `tmp` folder). If you see a white page, all is good. If not, either configure your webserver to deny access to this folder.

For Apache:

.. code-block:: apache

    <Directory /var/www/elabftw/uploads>
        Options -Indexes
    </Directory>

For Nginx:

.. code-block:: nginx

    location /uploads {
        deny all;
        return 403;
    }

Set up backup
-------------

See the :ref:`backup <backup>` page.

Set up the teams :sup:`(optional)`
-----------------------------------

The Sysadmin panel (`sysconfig.php`) allows you to add another team to your install. You should also edit your team name.

Set up timestamping :sup:`(optional)`
--------------------------------------

eLabFTW provides an easy way to do `Trusted Timestamping <https://en.wikipedia.org/wiki/Trusted_timestamping>`_ for your experiments, so you can have strong legal value for your lab notebook.

By default, it is setup to use `pki.dfn.de <https://www.pki.dfn.de/zeitstempeldienst/>`_ as :abbr:`TSA (TimeStampingAuthority)`. It is free for researchers. The only problem, is that they don't have ETSI certification for this service (although their PKI infrastructure is certified ETSI TS 102 042).

So if you need a stronger certification, you should go with a commercial solution providing an :rfc:`3161` way of timestamping documents. We recommend Universign.eu, as they are one of the most serious and recognized :abbr:`TSA (TimeStampingAuthority)` out there, but feel free to use the one you prefer.

You need to add the root certificate of the TSA somewhere where elabftw can read it for this to work.

Remember: no data is sent to the `TSA (TimeStampingAuthority)`, only the hash of the data is sent, so no information can leak!

Set up a cronjob to rewew TLS certificates :sup:`(optional)`
-------------------------------------------------------------

If you installed it with a proper domain name and you used letsencrypt to get your TLS certificate, then you need to renew them every 3 months.

Create a script containing:

.. code-block:: bash

    # stop webserver
    docker exec elabftw supervisorctl stop nginx
    # renew certificate
    /var/elabftw/letsencrypt/letsencrypt-auto renew --quiet --no-self-upgrade
    # and start the webserver again
    docker exec elabftw supervisorctl start nginx

Add this script as a cronjob:

.. code-block:: bash

    0 4 1 * * /root/renew.sh

This line will run the script at 4am every 1st day of the month.

Use mod_proxy to run elabftw docker container behind apache2 :sup:`(optional)`
------------------------------------------------------------------------------

If eLabFTW's docker container runs on a machine with several web applications you can use mod_proxy to access the application without opening another port on your server.

The following example forwards the URL https://your.domain/elabftw/ to the docker URL https://localhost:444. The default docker port can be changed by setting the ports parameter in /etc/elabftw.yml to "444:443".

.. code-block:: bash

    SSLProxyEngine on
    ProxyPass /elabftw/ https://localhost:444/ 
    ProxyPassReverse /elabftw/ https://localhost:444/ 

Update often
------------

It is important to keep your install up to date with the latest bug fixes and new features.

`Subscribe to the newsletter <http://eepurl.com/bTjcMj>`_ to be warned when a new release is out.

See instructions on updating eLabFTW on :ref:`how-to-update`.

