.. _saml:

******************************
Configure SAML2 authentication
******************************

.. image:: img/auth.png
    :align: center
    :alt: authentication

This page describes the steps necessary to setup SAML2 authentication on eLabFTW with an IDentity Provider (IDP). It assumes that you already know what we're talking about.

The IDP can lookup identity on an LDAP directory and deal with two factors authentication.

Setup the Service Provider
==========================

The service provider is the elabftw install. Head to the Sysadmin panel, click the SAML tab.

* Debug mode: Set to "No". We don't want to print errors
* Strict mode: Set to "Yes". Otherwise the mechanism is not secure
* Base url: Where did you install elabftw? Example: https://elabftw.example.edu
* entityId: The same as base URL
* SAML protocol binding: basically it can be POST or HTTP-redirect. Depending on your IDP, set the correct value here
* Single Logout Service: The same as entityId
* Single Logout Service protocol binding: basically it can be POST or HTTP-redirect. Depending on your IDP, set the correct value here
* NameIDFormat: match the supported NameIDFormat of the IDP, eLabFTW doesn't use this but it needs to be specified most of the time. Example values:

  - urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress [default]
  - urn:oasis:names:tc:SAML:2.0:nameid-format:persistent
  - urn:oasis:names:tc:SAML:2.0:nameid-format:transient
  - urn:oasis:names:tc:SAML:1.1:nameid-format:unspecified

* x509 certificate: Generate a self-signed certificate and export it in PEM
* Private key: the private key corresponding to the certificate
* Rollover x509 certificate: Used when the x509 certificate is expiring. Can be set to a new certificate to publish in metadata.

To generate a certificate, you can use this command:

.. code-block:: bash

   openssl req -newkey rsa:2048 -nodes -keyout private.key -x509 -days 9999 -out cert.crt

Use the content of `private.key` and `cert.crt`.

Alternatively you can use `this site <https://developers.onelogin.com/saml/online-tools/x509-certs/obtain-self-signed-certs>`_ to generate a self-signed certificate.

Setup the IDentity Provider
===========================

* Name: Visible to the user logging in. Example: "Institut Curie"
* entityId: Example: https://idp1.agroparistech.fr/shibboleth
* SSO url: Single Sign On URL
* SSO binding: Example: "urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST"
* SLO url: Single Log Out URL
* SLO binding: Example: "urn:oasis:names:tc:SAML:2.0:bindings:HTTP-Redirect"
* x509 cert: the public key of the IDP

Attributes for the IDP
----------------------
We need to specify where to look in the attributes sent in the response for email, team and name of the user. You can use the FriendlyName or the Name from the table below. Note that this will depend on your IDP and using the SAML Tracer plugin (see below) to see the response will be helpful in determining what fields you want to use.

.. list-table:: SAML attributes
   :widths: 25 25 25 25
   :header-rows: 1

   * - Attribute
     - FriendlyName
     - Name
     - Required
   * - Email
     - mail
     - urn:oid:0.9.2342.19200300.100.1.3
     - Yes
   * - Firstname
     - givenName
     - urn:oid:2.5.4.42
     - No
   * - Lastname
     - sn
     - urn:oid:2.5.4.4
     - No
   * - Userid (internal ID)
     - uid
     - urn:oid:0.9.2342.19200300.100.1.1
     - No

If you cannot have information about the team, or do not wish to use it, make sure to have the setting "Let user select a team" when the user is created during first login.

Note that the metadata.xml file (accessible at `/metadata.php`) will contain a section informing the IDP of the requested attributes.

About the Userid / Internal ID
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

If you configure the ``uid`` (Userid/Internal ID) parameter for an IDP, the value will be read from the SAML assertion and:

- for user creation on the fly, the ``orgid`` (Organization ID) field of the user will contain the value of the ``uid`` attribute
- for an existing user logging in, the ``orgid`` will not be modified

If you enable "Fallback to internal id if existing user cannot be matched with email", then the ``uid`` will be used to try and match an existing user if, during login, the match could not be done on the ``email`` field (user changed email for instance). You can then chose to enable "If user is matched with internal id, update the email sent by IDP?" so that the email sent by the IDP is updated in the local database.

Disable local login/register
============================

Go to the Server tab of the Sysadmin panel. From there you can disable local login (to force SAML auth) and also disable local registration.

How does it work?
=================

When a user successfully logins to the IDP, the email address is looked up. If it doesn't exist, the user is created. If the team doesn't exist either, it is created on the fly. You can configure this behavior from the Sysconfig panel.

Debugging
=========

SAML configuration can be tricky. I recommend that you use the SAML-tracer addon to see the requests and be able to verify what is sent and received.

* `link to addon for Firefox <https://addons.mozilla.org/en-US/firefox/addon/saml-tracer/>`_
* `link to addon for Chrome <https://chrome.google.com/webstore/detail/saml-tracer/mpdajninpobndbfcldcmbpnnbhibjmch?hl=en>`_

Looking at the PHP logs will also be helpful to get the complete error message.
