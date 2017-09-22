.. _faq:

Frequently asked questions
==========================

Is it totally free?
-------------------

YES. eLabFTW is free/libre software, so it is totally free of charge and always will be. `Read more about the free software philosophy <https://www.gnu.org/philosophy/free-sw.html>`_.

But how is it better than something I can buy?
----------------------------------------------

The difference is huge. Because eLabFTW is not only free (as in beer), but it is free (as in speech). This means that you can have a look at the code (and improve it) and you can also redistribute the code with your improvements.

But more importantly, you cannot trust your data with something that acts like a **black box**. What if the data you upload on the server of a company can be read by someone else? With eLabFTW, you install it on your own server, and you are the master of your data at all time.

What about patents and intellectual property?
---------------------------------------------

Since March 2013, the USA modified their law (see `America Invents Act <https://www.uspto.gov/patent/laws-and-regulations/leahy-smith-america-invents-act-implementation>`_) to switch from first-to-invent to first-inventor-to-file. This means that proving that you did this experiment before someone else has become less critical. It is only needed if you invented something, before someone put a patent on it (and you can prove it), and you want to keep using it as **prior user**.

Fortunately, eLabFTW allows rock solid `timestamping of your experiments <https://en.wikipedia.org/wiki/Trusted_timestamping#Trusted_.28digital.29_timestamping>`_. With just one click of a mouse, and for free, you can timestamp your work.

If needed, you can also choose another TimeStamping Authority allowing :rfc:`3161` timestamping.

Why use eLabFTW?
----------------

* **It's free and open source software**
* It improves the value of your experiments by allowing you to keep a good track of it
* It makes searching your data as easy as a google search
* Everything can be organized in your lab
* It makes it easy to share information between co-workers or collaborators
* It is simple to install and to keep up to date
* **It works for Windows, Mac OS X, Linux, BSD, Solaris, etc…**
* Protected access with login/password (password is very securely stored as salted SHA-512 sum)
* It can be used by multiple users at the same time
* **It can be used by multiple teams**
* You can have templates for experiments you do often
* **You can export an experiment as a PDF**
* **You can timestamp an experiment so it is legally strong**
* You can export one or several experiments as a ZIP archive
* You can duplicate experiments in one click
* There is advanced search capabilities
* You can write in Markdown
* The tagging system allows you to keep track of family of experiments
* Experiments can have color coded statuses (that you can edit at will)
* You can link an experiment with an item from the database to retrieve in a click the plasmid/sirna/antibody/chemical you used
* And it works the other way around, you can find all experiments done with a particular item from the database!
* There is a locking mechanism preventing further edition
* You can comment on an experiment (if it's not your experiment)
* You can import your old database stored in an excel file
* You can use it in your language
* :doc:`and much more… <features>`

You also have to consider the fact that installing eLabFTW on your own server means that no one will be able to snoop on your data. If you have ever used Evernote or basically any online ELN that says «Free», read carefully the privacy policy, you might be surprised what they allow themselves to do under the cover of «to improve your experience»…


Is this system stable? Can I trust my data with it?
---------------------------------------------------

Yes. It is used in numerous research centers all over the world since a few years now and if an issue is found it is quickly reported and fixed.

However, having an automated :ref:`backup <backup>` strategy is mandatory in order to be sure **nothing will be lost**.

Being able to do backups is yet another advantage over paper (you can't backup paper!).

Who else is using it?
---------------------

Here are some places running eLabFTW (non-exhaustive list):

* Cardiff University
* Hannover Medical School
* Helmholtz Zentrum Berlin für Materialien und Energie GmbH
* Indian Institute of Science, Bangalore
* Indian Institute of Technology, Delhi
* INRIA
* Institut Curie
* Karolinska Institutet
* Kuwait University
* Max-Planck-Institute of Quantum Optics
* MRC Laboratory of Molecular Biology
* Texas Tech University
* UMC Utrecht
* University of Alberta
* University of California
* University of Chicago
* University of Helsinki
* University of North Dakota
* University of Tennessee
* University of Warwick
* Uppsala University
* Washington University
* Weizmann Institute

Is the data encrypted?
----------------------

The data is encrypted when travelling from your browser to the server with the highest quality encryption currently available (TLSv1.2 with modern ciphers).

The passwords are not recoverable in case of a breach.

Only manually validated accounts can interact with the software. It is secure by default.

Is eLabFTW still maintained?
----------------------------

As of |today| I'm still actively working on it. Improvements are coming in a steady flow. There are good chances that I will continue to do so for a few years. In the unlikely event I'm not able to work on it anymore, anyone can continue the work, as the source code is available and well commented.

Will I be able to import my plasmids/antibodies/whatever in the database from a Excel file?
-------------------------------------------------------------------------------------------

Yes, in the admin panel, click on the Import CSV link and follow the instructions.

Can I try it before I install it?
---------------------------------

Sure, there is a demo online here: `eLabFTW live DEMO <https://demo.elabftw.net>`_

What about compliance to standards?
-----------------------------------
eLabFTW tries to comply to the following standards :

* `Code of Federal Regulations Title 21, paragraph 11 <http://www.accessdata.fda.gov/scripts/cdrh/cfdocs/cfcfr/CFRSearch.cfm?CFRPart=11>`_
* `FERPA <http://www2.ed.gov/policy/gen/guid/fpco/ferpa/index.html>`_
* `HIPAA <http://www.hhs.gov/ocr/privacy/>`_
* `FISMA <https://en.wikipedia.org/wiki/Federal_Information_Security_Management_Act_of_2002#Compliance_framework_defined_by_FISMA_and_supporting_standards>`_

What are the technical specifications?
--------------------------------------

eLabFTW is a server software that should be installed on a server.

**Requirements for the server**

The operating system of the server can be any.

The best is to have `Docker <https://www.docker.com>`_ installed. Otherwise, make sure to have:

* a webserver (nginx, apache, cherokee, lighttpd, …) with HTTPS enabled
* `PHP <https://secure.php.net/>`_ version > 5.6
* `Composer <https://getcomposer.org/>`_
* `MySQL <https://www.mysql.com/>`_ version > 5.5

**Requirements for the client**
- Any operating system with any browser (recent version).

--------------------

.. This was the common errors page, but it is deprecated now thanks to Docker :) I moved it in FAQ to avoid cluttering the left pane.

Failed creating *uploads/* directory
------------------------------------

If eLabFTW couldn't create an *uploads/* folder, that's because the httpd user (www-data on Debian/Ubuntu) didn't have the necessary rights. To fix it you need to:

1. Find what is the user/group of the web server. There is a good chance that it is www-data. But it might also be something else.

2. Now that you know the user/group of the webserver, you can do that (example is shown with www-data, but adapt to your need):

.. code-block:: bash

    cd /path/to/elabftw
    mkdir -p uploads/tmp
    chown -R www-data:www-data uploads
    chmod 400 config.php

The last line is to keep your config file secure. It might fail because the file is not there yet. Finish the install and do it after then.

I can't upload a file bigger than 2 Mb
--------------------------------------

Edit the file php.ini and change the value of upload_max_filesize to something bigger, example:

.. code-block:: bash

    upload_max_filesize = 128M

.. warning:: Don't forget to remove the `;` at the beginning of the line!

I can't export my (numerous) experiments in zip, I get an error 500
-------------------------------------------------------------------

Edit the file `/etc/php/php.ini` or any file called php.ini somewhere on your filesystem. Try `sudo updatedb;locate php.ini`. For XAMPP install, it is in the config folder of XAMPP.
Now that you have located the file and opened it in a text editor, search for `memory_limit` and increase it to what you wish. `Official documentation on memory_limit <http://php.net/manual/en/ini.core.php#ini.memory-limit>`_.

You can also increase the value of max_execution_time and max_input_time.
Then restart your webserver:

.. code-block:: bash

    sudo service apache2 restart

Languages don't work
--------------------

eLabFTW uses `gettext <https://en.wikipedia.org/wiki/Gettext>`_ to translate text. This means that you need to have the associated locales on the server.
To see what locale you have::

    locale -a

To add a locale, edit the file `/etc/locale.gen` and uncomment (remove the #) the locales you want. If you don't find this file you can try directly the command::

    locale-gen fr_FR.UTF-8

Replace with the locale you want, of course.
See :doc:`here <contributing>` to see a list of languages (and locales) supported by eLabFTW.
Then do::

    sudo locale-gen

And reload the webserver.
