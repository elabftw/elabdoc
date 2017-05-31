.. _saml:

Configure SAML2 authentication
==============================

.. image:: img/auth.png
    :align: center
    :alt: authentication

.. warning:: This is a Work In Progress

This documentation describes the steps necessary to setup SAML2 authentication on eLabFTW with an IDentity Provider (IDP). It assumes that you already know what we're talking about.

The IDP can lookup identity on an LDAP directory and deal with two factors authentication.

Setup the Service Provider
--------------------------

The service provider is the elabftw install. Head to the Sysadmin panel, click the SAML tab.

* Debug mode: Set to "No". We don't want to print errors
* Strict mode: Set to "Yes". Otherwise the mechanism is not secure
* Base url: Where did you install elabftw? Example: https://elabftw.example.edu
* entityId: The same as base URL
* Assertion consumer service: Just add /index.php?acs to base URL. Example: https://elabftw.example.edu/index.php?acs
* SAML protocol binding: basically it can be POST or HTTP-redirect. Depending on your IDP, set the correct value here
* Single Logout Service: The same as entityId
* Single Logout Service protocol binding: basically it can be POST or HTTP-redirect. Depending on your IDP, set the correct value here
* NameIDFormat: this value is to select which attribute will be used to lookup the user in the elabftw database. At the moment, only email is supported
* x509 certificate: Generate a self-signed certificate and export it in PEM. Enter your public key here
* Private key: the private key corresponding to the public key

Setup the IDentity Provider
---------------------------

* Name: Visible to the user logging in. Example: "Institut Curie"
* entityId: Example: https://idp1.agroparistech.fr/shibboleth
* SSO url: Single Sign On URL
* SSO binding: Example: "urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST"
* SLO url: Single Log Out URL
* SLO binding: Example: "urn:oasis:names:tc:SAML:2.0:bindings:HTTP-Redirect"
* x509 cert: the public key of the IDP

Disable local login/register
----------------------------

Go to the Server tab of the Sysadmin panel. From there you can disable local login (to force SAML auth) and also disable local registration.

How does it work?
-----------------

When a user successfully logins to the IDP, the email address is looked up. If it doesn't exist, the user is created. If the team doesn't exist either (attribute "memberOf"), it is created on the fly.

