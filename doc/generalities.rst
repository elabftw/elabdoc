.. _generalities:

************
Generalities
************

Lexicon
=======
Let's define a few terms first:

* **Instance**: a running eLabFTW service, for example: https://eln.example.org
* **Team**: the main way to compartimentalize users
* **Sysadmin**: a user with Sysadmin rights can modify the Instance configuration and create Teams, it is generally the same person that installed the Instance
* **Admin**: a user with Admin rights for a given team has access to the Admin Panel and can manage settings related to their Team. A given user can be Admin in Team A and User in Team B
* **User**: a user with an account on the Instance, belonging to at least one Team

General principles
==================

One eLabFTW instance can host several Teams.

Every User needs to belong to at least one Team. Every team must have at least one Admin user.

.. code-block:: html

      ┌────────────────────────┐
      │                        │
      │    eLabFTW Instance    │
      │                        │
      └────┬───────────┬─────┬─┘       ┌──────────┐
           │           │     │         │  Team C  │
           │           │     │         ├──────────┤
           │           │     └──────►  │ Admin 1  │
           │           │               │ User 1   │
           ▼           ▼               │ User 2   │
    ┌──────────┐    ┌──────────┐       │ User 3   │
    │  Team A  │    │  Team B  │       │ User 4   │
    ├──────────┤    ├──────────┤       └──────────┘
    │ Admin 1  │    │ Admin 1  │
    │ User 1   │    │ Admin 2  │
    │ User 2   │    │ Admin 3  │
    │ User 3   │    │ User 1   │
    └──────────┘    │ User 2   │
                    │ User 3   │
                    └──────────┘

Teams
=====
A Team generally correspond to a real life research group or service. It is not advisable to use Teams as Projects as this doesn't scale well (and Teamgroups can be used instead for that purpose). A User can belong to several teams if needed, they will then need to select a team upon login.

Every Team has one or several Admin, who can change many settings affecting users in the team, such as the default experimental template, categories for database items (Items Types), experiments Status, Tags, etc...

Teams are created by the Sysadmin from the Sysconfig page (:ref:`see documentation <configure-teams>`).

Entities and permissions
========================

An Entity is an entry, which can be an Experiment, a Resource or an experiment Template.

By default, Experiments and Resources are restricted to a team. But users can choose to extend this to all registered users or even anonymous users if enabled by the Sysadmin.

Experiments belong to a user (owner), while Resources are common to the team and can be edited by anyone from the team (with default permissions).

User accounts
=============

There are several ways to manage users, they can be created by a Sysadmin, an Admin, during authentication with centralized directory, or users can create their account directly.

Users can directly create their account on the register page (`/register.php`), accessible from the login page. They will need to select a team from the list.

By default, newly created accounts are disabled. The admin of the team needs to validate them by going into the admin panel and activate new users.

It is also possible to provision users or use an external authentication service such as an Identity Provider (IdP/SAML2) or LDAP directory.
