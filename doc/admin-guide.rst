.. _admin-guide:

***********
Admin guide
***********
This guide is intended for Admins of Teams. An Admin is a User in a Team with Admin rights, and access to the Admin Panel (from the top right menu or the bottom left link). A Team can have several Admins and must have at least one.

How to become Admin?
====================
A user is automatically an Admin if they are the first user in a Team. An Admin can promote another user to Admin from the Admin Panel > Users tab. A Sysadmin can promote a User to Admin the same way (frome the Sysadmin Panel).

General overview
----------------
An Admin:

* Has access to the Admin Panel with settings impacting only their team
* Can validate/edit users of their team
* Can edit available Status for experiments of their team
* Can edit available Items Types for the database of their team
* Can edit the default experiments template
* Can manage groups of users amongst the team (see below)
* Can change the rightmost link in the main menu (default is Documentation)
* Can archive users. Archiving users means disable login for that account, and lock all experiments.

Validating accounts
-------------------
Unless this setting has been modified by the Sysadmin, new accounts will need validation from a team Admin before they can connect. It is your role as an Admin to validate new users accounts. To do that, head to the Admin panel (link at the bottom left of any page) and you will see the users waiting for validation.

If you do not wish to validate this account because they don't belong in your team, you can either ask the Sysadmin to change the team of this account, or delete the account yourself from the Users tab in the Admin Panel.

Video
-----
If you prefer, you can watch a short video introducing the Admin Panel:

.. raw:: html

   <iframe width="560" height="315" src="https://www.youtube.com/embed/EyEX9nHNWsk" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

TEAM tab
--------
The first tab of the Admin Panel contains various settings for the Team.

GROUPS tab
----------
The Admin can create User Groups from the Admin Panel. Once a User Group is created, the Admin can add Users to this group by typing their name in the input field and selecting the suggested User. Users that are part of a User Group can then choose to set the permissions of an item/experiment to this group. Only members of this group will be able to see/edit this entry.

Note that it is possible to assign members from other Teams in a group.

USERS tab
---------
The Users tab allows you to modify user accounts in your team. From this page, you can reset a password directly or "Archive" an user. An "archived" user won't be able to login anymore and all of their experiments will be locked. If the user needs to be in another team, the correct procedure is to archive the user in the first team, and create a new account (same email) in the new team. This way the first team keeps the data, and the user can have a fresh account in the new team with the same email.

You can also disable multifactor authentication for a particular user, if needed.

At the bottom, you can add directly a new user in your team. The new user will need to activate the "Reset password" functionality to access their account.

STATUS tab
----------
Like items types, status are entirely editable and you can customize them to your liking.

TYPES OF ITEMS tab
------------------
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

Select a category and click "Go" to load it. Or click "Create" to add a new category.

.. image:: img/admin-panel-itemstypes.png
    :align: right
    :alt: items types tab


When you create a new category, use the default template of that type of item to add fields. For instance, for a Plasmid category you might want to have:

**Concentration:**

**Backbone:**

**Resistance bacteria:**

**Resistance mammalian:**

You can also have a look at using :ref:`extra fields <metadata>` defined through the metadata json editor so all items created in that category will have these supplementary inputs.

EXPORT tab
----------
This tab allows you to Export experiments, items or scheduler bookings in various formats.

TAG MANAGER tab
---------------
This interface allows an Admin to edit the existing tags if needed. For instance, if you have "RPE1" and "RPE-1" and you want all the tags to be in the form "RPE-1", find the "RPE1" tag, click on it to edit it to "RPE-1", and click the Deduplicate button.
