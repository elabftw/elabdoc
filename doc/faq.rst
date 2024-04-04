.. _faq:

**************************
Frequently asked questions
**************************

But how is it better than something I can buy?
==============================================

The difference is huge. Because eLabFTW is not only free (as in beer), but it is free (as in speech). This means that you can have a look at the code (and improve it) and you can also redistribute the code with your improvements.

But more importantly, you cannot trust your data with something that acts like a **black box**. What if the data you upload on the server of a company can be read by someone else? With eLabFTW, you install it on your own server, and you are the master of your data at all time.

What about patents and intellectual property?
=============================================

Since March 2013, the USA modified their law (see `America Invents Act <https://www.uspto.gov/patent/laws-and-regulations/leahy-smith-america-invents-act-implementation>`_) to switch from first-to-invent to first-inventor-to-file. This means that proving that you did this experiment before someone else has become less critical. It is only needed if you invented something, before someone put a patent on it (and you can prove it), and you want to keep using it as **prior user**.

Fortunately, eLabFTW allows rock solid timestamping of your experiments. With just one click of a mouse, you can timestamp your work. There are currently two strategies available for timestamping: Trusted Timestamping and Blockchain Timestamping.

Trusted timestamping
--------------------
This is the protocol defined by :rfc:`3161`, here is how it works:

1. we first generate a JSON export of the entity, containing all the data relevant to that entry
2. we pass it through a cryptographic hash function to get its fingerprint
3. we request a timestamp token from the Time Stamping Authority (TSA)
4. we store the JSON file along with the token in an immutable ZIP archive (visible if you display archived attachments of a timestamped entry)

A TSA is a trusted timestamping service that will be used to request a token. Several TSA are already configured in eLabFTW:

- DFN.de (free academic service, default TSA)
- Universign (eIDAS qualified, paid service)
- Digicert (free)
- Sectigo (free)
- GlobalSign (free)
- Custom: you can define your own service if necessary

Blockchain timestamping
-----------------------
This timestamping method uses the `Bloxberg consortium <https://bloxberg.org>`_ blockchain to timestamp your data. Here is how it works:

1. we first generate a JSON export of the entity, containing all the data relevant to that entry
2. we pass it through a cryptographic hash function to get its fingerprint
3. we add it to the Ethereum based blockchain
4. we store the JSON file along with a PDF certifying our data in an immutable ZIP archive (visible if you display archived attachments of a timestamped entry)


Why use eLabFTW?
================

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
* blockchain blockchain blockchain
* There is a locking mechanism preventing further edition
* You can comment on an experiment (if it's not your experiment)
* You can import your old database stored in an excel file
* You can use it in your language
* :doc:`and much more… <features>`

You also have to consider the fact that installing eLabFTW on your own server means that no one will be able to snoop on your data. If you have ever used Evernote or basically any online ELN that says «Free», read carefully the privacy policy, you might be surprised what they allow themselves to do under the cover of «to improve your experience»…


Is this system stable? Can I trust my data with it?
===================================================

Yes. It is used in numerous research centers all over the world since a few years now and if an issue is found it is quickly reported and fixed.

However, having an automated :ref:`backup <backup>` strategy is mandatory in order to be sure **nothing will be lost**.

Being able to do backups is yet another advantage over paper (you can't backup paper!).

Who else is using it?
=====================

We do not maintain a list of institutions using it anymore. There are just too many. Consider that there are thousands of eLabFTW instances worldwide.

In France, it's the ELN of choice for the CNRS, the 3rd largest research organization in the world, along with many other universities and research institutes. It is also useful to startups and companies.

In Germany, it is ubiquitous. Installed in many universities and private companies.

In Europe, it is often seen being used in universities and research centers.

In the rest of the world, it is also used, because its interface is translated in 17 languages, including many asian languages.

Is the data encrypted?
======================

The data is encrypted when travelling from your browser to the server with the highest quality encryption currently available (TLSv1.2/1.3 with modern ciphers).

The passwords are not recoverable in case of a breach and are hashed using state of the art algorithms.

Only manually validated accounts can interact with the software. It is secure by default.

If you wish to have data at rest encryption, it needs to be done during the web server installation, and is not the concern of the software itself.

Is eLabFTW still maintained?
============================

Not only it is maintained, but it is actively being worked on, with major new features and improvements being added regularly.

Since 2019, the company `Deltablot <https://www.deltablot.com>`_ exists to provide support and hosting to eLabFTW users around the world. This company will allow funding further development of the software thanks to an original business model: the software itself is entirely free, but the individual support, custom features development and hosting are paid options.

If you are interested in such options, please visit this page: `Deltablot's elabftw page <https://www.deltablot.com/elabftw/>`_.

Will I be able to import my plasmids/antibodies/whatever in the database from a Excel file?
===========================================================================================

Yes, see :ref:`Import CSV Documentation <csvimport>`.

Can I try it before I install it?
=================================

Sure, there is a demo online here: `eLabFTW live DEMO <https://demo.elabftw.net>`_.

What are the technical specifications?
======================================

eLabFTW is a server software that should be installed on a server.

Requirements for the server
---------------------------

**Hardware**

At least 2Gb of RAM, a decent processor (> 2GHz), preferably multi-core and an SSD disk with at least a few Gb free.

**Software:**

The operating system of the server can be any but GNU/Linux is highly recommended.

The service runs in `Docker <https://www.docker.com>`_ containers.

A MySQL database service is required. You can create one with Docker following the standard installation procedure, or use an existing one.

Requirements for the clients (users)
------------------------------------

- Any operating system with either Firefox, or Chrome based browser (Chrome, Chromium, Edge, Brave, Opera). Safari is known to cause issues and is not officially supported. Internet Explorer is not supported.
- An internet connection.

What about data retention/traceability
======================================

When a user is making a change to an experiment, a copy of the previous version is kept in the database. This copy cannot be altered by anyone. The admin can also prevent users from deleting experiments, and the creation date is kept in memory, even if the date field is changed later on.

When an entry is deleted, it is not completely removed from the database, but instead marked as deleted. Same with attached files: overwriting a file will mark the previous version as "Archived".

Is it compliant to 21CFR Part 11?
=================================

1. Closed system: eLabFTW requires unique credentials to access the system. A system of permissions and roles allow fine control of what can be seen by whom.

2. Experiments and database items (protocols, reagents, cell lines...) are considered signable by the locking mechanism that timestamps and locks an entity in place.

3. Trusted timestamping: RFC3161 Trusted Timestamping is available for experiments. A specific PDF is generated and timestamped cryptographically to prove anteriority if needed in a court of law.

4. Audit trail: changes to entries are internally recorded and cannot be tampered with by users. A version history is available.

5. Retention of records: a setting allows to disable the possibility to delete records entirely.

6. Copies of records: you can export your data in PDF, ZIP archives or CSV files very easily.

7. Password policy: passwords are securely stored in the database and security mechanisms such as preventing too many authentication tries are in place.

What about compliance to standards?
===================================
eLabFTW tries to comply to the following standards :

* `Code of Federal Regulations Title 21, paragraph 11 <http://www.accessdata.fda.gov/scripts/cdrh/cfdocs/cfcfr/CFRSearch.cfm?CFRPart=11>`_
* `FERPA <http://www2.ed.gov/policy/gen/guid/fpco/ferpa/index.html>`_
* `HIPAA <http://www.hhs.gov/ocr/privacy/>`_
* `FISMA <https://en.wikipedia.org/wiki/Federal_Information_Security_Management_Act_of_2002#Compliance_framework_defined_by_FISMA_and_supporting_standards>`_

The timestamping is based on RFC3161 standardized protocol and fits with the eIDAS european regulation (910/2014).

How to change the team of a user?
=================================

There is two ways to do that:

* if the user registered in the wrong team, the Sysadmin can simply change the team from the Sysadmin panel
* if the user switched team, old team needs to Archive the user (from the Admin panel), and user needs to register a new account (same email can be used) in the new team

Is there a plugin system?
=========================

No, eLabFTW has no plugins and no plan to add support for it. This decision is motivated by several factors:

- security of the application: a badly written plugin might compromise an instance (this happens daily with Wordpress plugins)
- a stable plugin API has to be maintained, which is a heavy burden on development, as plugins will hook into internals, and it opens the door to a never ending stream of requests about adding hooks here and there
- our vision is about a single coherent codebase, not a morcellated software

If you wish to add functionality to eLabFTW, the best is to discuss it in an issue, and eventually create a pull request with the code you want to merge, rather than planning on plugins.

Is it totally free?
===================

YES. eLabFTW is free/libre software, so it is totally free of charge and always will be. `Read more about the free software philosophy <https://www.gnu.org/philosophy/free-sw.html>`_.


What is the meaning of 'FTW'?
=============================

One of those:

- For The World
- For Those Wondering
- For The Worms
- Forever Two Wheels
- Free The Wookies
- Forward The Word
- Forever Together Whenever
- Face The World
- Forget The World
- Free To Watch
- Feed The World
- Feel The Wind
- Feel The Wrath
- Fight To Win
- Find The Waldo
- Finding The Way
- Flying Training Wing
- Follow The Way
- For The Wii
- For The Win
- For The Wolf
- Free The Weed
- Free The Whales
- From The Wilderness
- Freedom To Work
- For The Warriors
- Full Time Workers
- Fabricated To Win
- Furiously Taunted Wookies
- Flash The Watch
