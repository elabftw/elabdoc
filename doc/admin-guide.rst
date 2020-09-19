.. _admin-guide:

Admin guide
===========

This guide is intended for admins of teams.

General overview
~~~~~~~~~~~~~~~~
* Is the first registered user in a team
* Has access to the Admin Panel with settings impacting only their team
* Can change the rightmost link in the main menu (default is Documentation)
* Can override general Timestamping settings
* Can edit users of their team
* Can edit available Status for experiments of their team
* Can edit available Items Types for the database of their team
* Can edit the default text of a new experiment
* Can import data from a CSV file in the database
* Can import elabftw.zip archives (experiments or database items)
* Can manage groups of users amongst the team (see below)
* Can promote another user to Admin or give locking powers
* Can archive users. Archiving users means disable login for that account, and lock all experiments.

Validating accounts
~~~~~~~~~~~~~~~~~~~

Unless this setting has been modified by the Sysadmin, new accounts will need validation from a team Admin before they can connect. It is your role as an Admin to validate new users accounts. To do that, head to the Admin panel (link at the bottom left of any page) and you will see the users waiting for validation.

If you do not wish to validate this account because they don't belong in your team, you can either ask the Sysadmin to change the team of this account, or delete the account yourself from the Users tab in the Admin Panel.

Video
~~~~~

If you prefer, you can watch a short video introducing the Admin Panel:

.. raw:: html

   <iframe width="560" height="315" src="https://www.youtube.com/embed/EyEX9nHNWsk" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

User groups
~~~~~~~~~~~
The Admin can create User Groups from the Admin Panel. Users can then choose to set the permissions of an item to this group. Only members of this group will be able to see/edit this experiment.

Users tab
~~~~~~~~~
The Users tab allows you to modify user accounts in your team. Make an empty search to see all the accounts. Admins can also disable 2FA for a user who locked out themselfe.

Status
~~~~~~
Like items types, status are entirely editable and you can customize them to your liking.

Types of items
~~~~~~~~~~~~~~
This is where you can configure the categories available in the main Database tab. You can have as many as you want. For instance:

* Antibody
* Cell line
* Microscope (make sure to make it bookable so it can be used in the Scheduler of the Team tab)
* Protocol (or you might prefer to use templates for that)
* Computer
* Software
* Project
* Plasmid
* ...

When you create a new category, use the default template of that type of item to add fields. For instance, for a Plasmid category you might want to have:

**Concentration:**

**Backbone:**

**Resistance bacteria:**

**Resistance mammalian:**

Experiments template
~~~~~~~~~~~~~~~~~~~~
This is the default text when someone creates an experiment. Feel free to edit it as you want.

Import
~~~~~~
If you already have some "items" catalogued in an Excel file or File Maker database, you can import them from this tab. Export it first it ".csv" and follow the instructions.

Tag manager
~~~~~~~~~~~
This interface allows an Admin to edit the existing tags if needed. For instance, if you have "RPE1" and "RPE-1" and you want all the tags to be in the form "RPE-1", find the "RPE1" tag, click on it to edit it to "RPE-1", and click the Deduplicate button.
