.. _saml:

Configure SAML2 authentication
==============================

.. image:: img/auth.png
    :align: center
    :alt: authentication

This page describes the steps necessary to setup SAML2 authentication on eLabFTW with an IDentity Provider (IDP). It assumes that you already know what we're talking about.

The IDP can lookup identity on an LDAP directory and deal with two factors authentication.

Setup the Service Provider
--------------------------

The service provider is the elabftw install. Head to the Sysadmin panel, click the SAML tab.

* Debug mode: Set to "No". We don't want to print errors
* Strict mode: Set to "Yes". Otherwise the mechanism is not secure
* Base url: Where did you install elabftw? Example: https://elabftw.example.edu
* EntityId: The same as base URL
* Assertion Consumer Service binding: Only HTTP-POST is supported.
* Single Logout Service binding: Only HTTP-Redirect is supported.
* NameIDFormat: this value is to select which attribute will be used to lookup the user in the elabftw database. At the moment, only email is supported
* x509 Certificate: Generate a self-signed certificate and export it in PEM
* x509 Certificate private key: the private key corresponding to the certificate
* Rollover x509 certificate: Used when the x509 certificate is expiring. Can be set to a new certificate to publish in
  metadata

To generate a certificate, you can use this command:

.. code-block:: bash

   openssl req -newkey rsa:2048 -nodes -keyout private.key -x509 -days 9999 -out cert.crt

Use the content of `private.key` and `cert.crt`.

Alternatively you can use `this site <https://developers.onelogin.com/saml/online-tools/x509-certs/obtain-self-signed-certs>`_ to generate a self-signed certificate.

Setup the IDentity Provider
---------------------------

* Friendly Name: Visible to the user logging in. Example: "Institut Curie"
* EntityId: Provided to you by IdP. Example: https://idp1.agroparistech.fr/shibboleth
* Single Sign-On url: Single Sign On URL
* Single Sign-On binding: Only "urn:oasis:names:tc:SAML:2.0:bindings:HTTP-Redirect" is supported
* Single Log Out url: Single Log Out URL
* Single Log Out binding: Only "urn:oasis:names:tc:SAML:2.0:bindings:HTTP-Redirect" is supported
* x509 cert: the public key of the IDP to verify messages
* x509 cert (additional for rollover): an additional public key which can be used to verify messages

Disable local login/register
----------------------------

Go to the Server tab of the Sysadmin panel. From there you can disable local login (to force SAML auth) and also disable local registration.

How does it work?
-----------------

When a user successfully logins to the IDP, the email address is looked up. If it doesn't exist, the user is created. If the team doesn't exist either, it is created on the fly. You can configure this behavior from the Sysconfig panel.

Debugging
---------

SAML configuration can be tricky. I recommend that you use the SAML-tracer addon (available for Chrome or Firefox) to see the requests and be able to verify what is sent and received.
