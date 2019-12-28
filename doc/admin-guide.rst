.. _admin-guide:

Admin guide
===========

This guide is intended for admins of teams.

General overview
----------------

The Admin
~~~~~~~~~
* Is the first registered user in a team
* Has access to the Admin Panel with settings impacting only his team
* Can change the rightmost link in the main menu (default is Documentation)
* Can override general Timestamping settings
* Can edit users of his team
* Can edit available Status for experiments of his team
* Can edit available Items Types for the database of his team
* Can edit the default text of a new experiment
* Can import data from a CSV file in the database
* Can import elabftw.zip archives (experiments or database items)
* Can manage groups of users amongst the team (see below)
* Can promote another user to Admin or give locking powers
* Can archive users. Archiving users means disable login for that account, and lock all experiments.

Items types
```````````
From the Admin Panel, you should edit the available items types (by default there is just one). Feel free to create things like "Antibody", "Microscope" or "Cell line". You can have as many as you want. Add a default text in the template to guide users on what to add when creating a new item.

Status
``````
Like items types, status are entirely editable and you can customize them to your liking.

User groups
```````````
The Admin can create User Groups from the Admin Panel. Users can then choose to set the permissions of an item to this group. Only members of this group will be able to see/edit this experiment.
