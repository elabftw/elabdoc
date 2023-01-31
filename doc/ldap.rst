.. _ldap:

*****************************
Configure LDAP authentication
*****************************

.. image:: img/auth.png
    :align: center
    :alt: authentication

This page describes the configuration of LDAP authentication for an eLabFTW instance.

First go to the Sysconfig panel by click the link at the bottom left of any page or from the user menu. Then go on the LDAP tab.

Set the "Toggle LDAP login" to Enabled so the option to authenticate through LDAP will be available from the login page.

Enter the domain name or IP address of the LDAP server in the "LDAP Host" field.

LDAP Port is 389 by default. Use port 636 for LDAPS or any custom port you might have configured.

"LDAP Base DN" will probably be something like "dc=example,dc=org".

"LDAP Username" is the admin login for LDAP server. Not necessarily admin but at least a user that can query other users.

"LDAP Password" is the password associated with the previously set account.

"Auth lookup with cn or uid". There is no science here. Try with one, if it doesn't work, try with the other ('cn' or 'uid').

Set "Use TLS" if using LDAPS.

"What attribute to look for the team name". The LDAP server will reply with the information associated with the user trying to authenticate. Which field will be the one used to determine the team in which to create the user?

"Create team sent by server if it doesn't exist already". If the team found doesn't exist already, do you want to create one?

"If no team attribute is found, to which team user is assigned?". Use this to add users to this team every time. Useful if the LDAP server doesn't answer with a team attribute that can be used for eLabFTW.

The last three fields are to specify the fields to look for for the user email, firstname and lastname.


If you encounter difficulties, make sure to get a useful log message before opening an issue: :doc:`see debug documentation <debug>`.
