.. _features:

********
Features
********

General
=======
* Free as in speech
* Free as in beer
* Web application: accessible to users like any other website through their web browser
* Multiple teams: one eLabFTW instance can host several teams, each composed of users, that can belong to multiple teams
* Supported software: development and maintenance is ensured by the `Deltablot <https://www.deltablot.com/>`_ company

For Sysadmins
=============
* Dockerized service: containerization technology facilitates deployments and updates, by ensuring a specific application environment
* Centralized authentication with SAML2 or LDAP
* S3 compatible object storage for uploaded files
* Several options to configure the user provisioning workflow
* Possibility to restrict email domains

Experiments and Resources
=========================
* Status, Categories, Tags
* Rich text editor (WYSIWYG) or Markdown editor
* Advanced permission system
* Upload multiple files of any kind
* Insert images into text
* Steps list
* Templates
* Duplicate entries
* Supported export formats: PDF, PDF/A, JSON, ZIP, ELN, CSV
* Advanced export and import functions for entries, users or teams
* Supported import formats: CSV, ELN
* Lock the experiment
* Request reviews or actions from other users
* Support for various file types that will render in 2D or 3D (.mol, .sdf, .pdb, etc...)
* Links between entities
* Molecule editor
* User groups to restrict read access among a team
* Doodle canvas
* Rating system

Security
========
* HTTPS
* CSRF protection
* Secure headers
* Automated vulnerability scans on Docker images
* Secure PHP settings
* Anti bruteforce system
* Secure storage of password (bcrypt)
* Secure password reset mechanism
* Option for new account admin validation
* Two-factor authentication (TOTP)
* Password policies with complexity and expiration

Intellectual property, integrity and imputability
=================================================
* :rfc:`3161` compliant Trusted Timestamping
* Blockchain timestamping
* Audit logs
* Revisions and Changelog systems to track changes
* Cryptographic signatures (ed25519)
* Support for Keeex (see https://keeex.me/)

User experience
===============
* Lovely design (by @manonstripes)
* Internationalization (several languages available)
* Optimized code/assets for speed and correctness
* WCAG 2.1 accessibility compliance
* Various configuration options for Sysadmins, Admins or Users
* Customizable keyboard shortcuts
* TODOlist
