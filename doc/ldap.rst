.. _ldap:

*****************************
Configure LDAP authentication
*****************************

.. image:: img/auth.png
    :align: center
    :alt: authentication

This page describes the configuration of LDAP authentication for an eLabFTW instance.

How does eLabFTW query LDAP servers?
========================================

LDAP stands for "Lightweight directory access protocol" and is a common protocol to query databases with user information.
In general, queries to LDAP servers are performed via functions supplied by ``php``.
The overall schematic for each query with the options set in the sysadmin menu looks like this

1. Connect to the LDAP server (-> TLS?, host, port)
2. Bind (login) with username and password, or anonymously (-> username, password)
3. Search for users within a certain region of the LDAP world directory (-> base DN) and extract certain properties/fields (-> filter attribute, team name, email, firstname, lastname)
4. Unbind (log out)

Obviously, for this to work, eLabFTW needs information from you.
That is what the LDAP configuration options and the next section is for.

Sysadmin LDAP settings
======================

To find the settings, first go to the Sysconfig panel by clicking the link at the bottom left of any page or from the user menu.
Then go on the LDAP tab.

Toggle LDAP login
        Set to enabled so the option to authenticate through LDAP will be available from the login page.

LDAP Host
        Enter the domain name or IP address of the LDAP server.
        This should **not** include the protocol or the port, *i.e.* not ``ldaps://my.ldap.server:636``, but only ``my.ldap.server``.
        For selecting the protocol and port, use the dedicated "LDAP Port" and "Use TLS" options.

LDAP Port
        The port the LDAP server listenes on, 389 by default.
        Use port 636 for LDAPS or any custom port you might have configured.

LDAP Base DN
        This is the "Distinguished Name" for the search, i.e. which part of the (global) LDAP tree you want to find the users in.
        It is probably something like ``dc=example,dc=org``, but might also include "Organizational Units", so something like ``ou=myinstitute,dc=example,dc=org``.
        Importantly, this is something completely different from the LDAP username, even though the notation might be similar.

LDAP Username
        This is the DN or username that connects (binds) to the LDAP server.
        Examples include ``myuser`` or ``cn=AnAdminOf,ou=MyUnit,dc=example,dc=org``.
        The user must have permission to query other users.

LDAP Password
        This password is needed for the authentication on the LDAP server with the username specified above.

Use TLS
        Select this if using LDAPS (= LDAP with TLS).

By which LDAP attribute the user will be found (default is 'mail')
        This is the "filter attribute" from above.
        Common choices include ``cn``, ``uid`` and the default ``mail``.
        This is the LDAP field that holds the information you want users to enter into the "login" field on the start page.

What attribute to look for the team name
        The LDAP server will reply with the information associated with the user trying to authenticate.
        Which field will be the one used to determine the team in which to create the user?

Create team sent by server if it doesn't exist already
        If the team found doesn't exist already, do you want to create one?

If no team attribute is found, to which team user is assigned?
        Use this to add users to this team by default.
        Useful if the LDAP server doesn't answer with a team attribute that can be used for eLabFTW.

What attribute to look for ...
        The last three fields are to specify the fields to look for for the user email, firstname and lastname.


If you encounter difficulties, make sure to get a useful log message before opening an issue, :doc:`see debug documentation <debug>`.
