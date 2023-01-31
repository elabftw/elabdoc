.. _contributing:

************
Contributing
************

.. image:: img/contributing.png
    :align: center
    :alt: contributing
    :target: http://mimiandeunice.com/

What can you do to help this project?
=====================================

* `Star it on GitHub <https://github.com/elabftw/elabftw>`_
* Talk about it to your colleagues, spread the word!
* Have a look at `the current issues <https://github.com/elabftw/elabftw/issues>`_
* Help with the translations (see Translating below)
* Open GitHub issues to report bugs or suggest new features
* `Star it on GitHub really <https://github.com/elabftw/elabftw>`_

Non-code contributions
----------------------

Contributions are not necessarily code. There are multiple things outside of code contributions. Have a look at this article listing them: `Non code contributions to open-source <https://navendu.me/posts/non-code-contributions-to-open-source/>`_.

Reporting a security issue
--------------------------

If you've found a security issue, please contact me securely through `Keybase <https://keybase.io/nicolascarpi>`_.

.. image:: img/i18n.png
    :align: right

While there is not (yet) an official bug bounty program, responsible disclosure of a security vulnerability might be compensated.

Translating
-----------

Do you know several languages? Are you willing to help localize eLabFTW? You're in the right place.

How to translate?

* `Join the project on poeditor.com <https://poeditor.com/join/project?hash=aeeef61cdad663825bfe49bb7cbccb30>`_
* Select elabftw
* Select one or several languages (open a GitHub issue if your language is not present)
* Start translating
* Ignore things like `<strong>, <br>, %s, %d` and keep the punctuation like it was!

Translations are merged in the code before a release. You must not try and edit the .po/.mo files directly in the source code.

Contributing to the code
------------------------

Introduction
^^^^^^^^^^^^
Depending on your background, the eLabFTW project might seem daunting at first, because it uses a lot of different technologies: Docker, Yarn, Webpack, Composer, TypeScript, Scss, ...

But fear not, because there is a whole documentation about getting started, and you're already reading it ;)

Note about repositories
^^^^^^^^^^^^^^^^^^^^^^^

The eLabFTW project is split in different repositories. The main one with the actual PHP code is `elabftw/elabftw <https://github.com/elabftw/elabftw>`_. The present document is generated from reStructuredText files in `elabftw/elabdoc <https://github.com/elabftw/elabdoc>`_. So if you need to change the documentation, it will be in there.

The Docker image is built by the code at `elabftw/elabimg <https://github.com/elabftw/elabimg>`_.

Other interesting repositories are:

- `elabftw/elabctl <https://github.com/elabftw/elabctl>`_ for the elabctl tool
- `elabftw/elabapy <https://github.com/elabftw/elabapy>`_ for the python API library

The rest of this documentation is about elabftw/elabftw.

Note about branches
^^^^^^^^^^^^^^^^^^^

The repository contains (at least) 3 branches:

* The `master` branch points to the latest released version and should always be in working state. It can contain beta or rc versions but not alpha versions.
* The `next` branch points to the latest unstable version (alpha) (or latest stable if no unstable released yet). If you wish to make a bugfix PR, this is the branch that you should target (if hypernext is far from it).
* The `hypernext` branch is the dev branch, it might contain bugs and unfinished work, never use it in production! It is the latest version of the code and the one you should work against for new features or non critical bugfixes. It is a very active branch, so make sure to pull from upstream often so your fork doesn't stray too far.

Environment installation
^^^^^^^^^^^^^^^^^^^^^^^^

So the dev environment for eLab is an hybrid between Docker and a local install. The files will be served by the webserver in Docker but the source code (`elabftw` folder) will be on your computer. In this setup, we will put everything in the same folder for simplicity.

Here is a step-by-step for installing an eLabFTW dev setup:

* First we install the dependencies:

  * `Docker <https://www.docker.com>`_
  * `Docker Compose <https://docs.docker.com/compose/>`_

Make sure your user is in the `docker` group so you can execute docker commands without sudo (see `documentation <https://docs.docker.com/install/linux/linux-postinstall/>`_).

* Next let's define a directory for dev (adapt to your needs):

.. code-block:: bash

    # this folder can be anywhere you like
    export dev='/home/<YOUR USERNAME>/elabdev'
    mkdir -p $dev
    cd $dev

* Go on `the repository on GitHub <https://github.com/elabftw/elabftw>`_
* Click the Star button (it helps with visibility of the project)
* Click the Fork button in the top right of the screen
* Uncheck the box "Copy only the master branch" (we will work on another branch)
* From your fork page, clone it with SSH on your machine:

.. code-block:: bash

    git clone git@github.com:<YOUR USERNAME>/elabftw.git
    # checkout the hypernext branch because this is where dev happens
    cd elabftw
    git checkout hypernext
    cd ..

* Get *elabctl* and the configuration files

.. code-block:: bash

    # get elabctl
    curl -sLo elabctl https://get.elabftw.net && chmod +x elabctl
    # get elabctl configuration file
    curl -so elabctl.conf https://raw.githubusercontent.com/elabftw/elabctl/master/elabctl.conf
    # get the docker-compose configuration file (from the dev branch)
    curl -so elabftw-dev.yml https://raw.githubusercontent.com/elabftw/elabimg/master/src/docker-compose.yml-EXAMPLE

* Edit `elabctl.conf`, change BACKUP_DIR to `$dev/backup` or any other directory (write full paths of course, not aliases)
* Change CONF_FILE to `$dev/elabftw-dev.yml`. Again, write the full path, not the alias!
* Change DATA_DIR to `$dev/data`. Again, write the full path, not the alias!
* Edit the docker-compose configuration file `elabftw-dev.yml`
* For the web container, use "image: elabftw/elabimg:hypernext" so you are using the latest container image for dev
* Add a SECRET_KEY
* Set DEV_MODE to true
* Set ELABFTW_USER and ELABFTW_GROUP to your username/group
* SET ELABFTW_USERID and ELABFTW_GROUPID to your uid/gid (probably 1000, check with `id` command). This allows to run the container with the same user as your main user and will avoid running into permissions issues.
* Change the `volumes:` line so it points to your `$dev/elabftw` folder (for elabftw and mysql containers)
* Start the containers:

.. code-block:: bash

   ./elabctl start


.. note::

    PHP dependencies are managed through `Composer <https://getcomposer.org/>`_. It'll read the `composer.lock` file and install packages (see `composer.json`). Javascript dependencies are managed through `Yarn <https://yarnpkg.com/>`_. It'll read the `yarn.lock` file and install packages (see `package.json`). The `yarn install` command will populate the `node_modules` directory, and the `buildall` command will use `Webpack <https://webpack.js.org/>`_ to create bundles (see `builder.js` file).

* Now install the PHP and JavaScript dependencies using `composer` and `yarn` shipped with the container:

.. code-block:: bash

    cd $dev/elabftw
    # php dependencies (vendor/ directory)
    docker exec -it elabftw composer install
    # javascript dependencies (node_modules/ directory)
    docker exec -it elabftw yarn install
    docker exec -it elabftw yarn buildall

* Initialization of the database structure:

.. code-block:: bash

   docker exec -it elabftw bin/install start


* Enable debug mode to disable the caching of Twig templates

.. code-block:: bash

    elabctl mysql
    # you are now on the mysql command line
    mysql> update config set conf_value = '1' where conf_name = 'debug';
    exit;
    exit

* Now head to https://localhost:3148
* You now should have a running local eLabFTW, and changes made to the code will be immediately visible

Add `export PATH=$PATH:$(pwd)/node_modules/.bin` to your editor config file (`.zshrc`, `.bashrc`, …). This will allow you to run software installed in the `node_modules` folder.

It is possible to populate your dev database with fake generated data. See the `dev:populate` command of `bin/console`.

Code organization
^^^^^^^^^^^^^^^^^
* Real accessible pages are in the web/ directory (experiments.php, database.php, login.php, etc…)
* The rest is in app/ or src/ for PHP classes
* src/models will contain classes with CRUD (Create, Read, Update, Destroy)
* src/classes will contain services or utility classes
* A new class will be loaded automagically thanks to the use of PSR-4 with composer (namespace Elabftw\\Elabftw)
* app/controllers will contain pages that send actions to models (like destroy something), and generally output json for an ajax request, or redirect the user.
* Check out the scripts in `src/tools` too

Working with JavaScript
-----------------------
All JavaScript code is written in `TypeScript <https://www.typescriptlang.org/>`_ in `src/ts`. During build, it is converted in JS by `tsc`. It is then transpiled by `Babel <https://babeljs.io/>`_ and bundled by `Webpack <https://webpack.js.org/>`_. A full build can be quite time consuming, especially on hardware with limited CPU power.

When working on some JS, what you want is to be able to save the file and immediately see the changes. For that, use `yarn watchjs` to build the JS and watch for changes. Now changes will take a very small time to compile and be visible.

You'll also want to configure your favorite text editor to display TypeScript errors when writing the code.

Use vanilla JS and avoid the use of jQuery selectors or functions.

Miscellaneous
-------------
* if you make a change to the SQL structure, you need to add a schema file in `src/sql`. See the existing files for an example. Then increment the required version in `src/classes/Update`. Modify `src/sql/structure.sql` so new installs will get the correct structure. If possible, just add the needed line in the current schema.sql file if this schema is still only present in unstable versions (dev or alpha).
* comment your code wisely, what is important is the why, not the what
* your code must follow `the PSR standards <https://github.com/php-fig/fig-standards/blob/master/accepted/PSR-1-basic-coding-standard.md>`_
* add a plugin to your editor to show trailing whitespaces in red
* add a plugin to your editor to show PSR-1 errors
* see `editorconfig.org <https://editorconfig.org/>`_ and configure your editor to follow the settings from `.editorconfig`
* remove BOM
* if you want to work on the documentation, clone the `elabdoc repo <https://github.com/elabftw/elabdoc>`_
* if you want to make backups of your dev install, you'll need to edit `elabctl.conf` to point to the correct folders/config files. See `example <https://github.com/elabftw/elabctl/blob/master/elabctl.conf>`_
* in php camelCase; in html, dash separation for CSS stuff, camelCase for JS
* check the commands in the "scripts" part of the `package.json` file, a lot of nice things in there ;)

Glossary
--------
* Experiments + Database items + Experiments Templates = Entities. So when you see Entity it means it can be an experiment/template or a database item.

Build
-----
The javascript and css files are stored unminified in the source code. But the app uses the minified versions, so if you make a change to the javascript or css files, you need to rebuild them.

* To minify files:

.. code-block:: bash

    # install the packages first
    yarn install
    yarn buildall

Other commands exist, see `builder.js` (webpack), the `scripts` part of `package.json` (yarn). If you just want to rebuild the CSS, use `yarn buildcss`.

When working on the code, it is best to have `yarn watchjs` and `yarn watchcss` running so changes are immediately picked up.

Tests
-----

The tests run on the Codeception framework for unit and api tests. End to end testing is done with Cypress.

.. code-block:: bash

    $ yarn unit # will run the unit tests
    $ yarn test # will run the full test suite

A good contribution you can make would be adding Cypress tests.

Exceptions handling
-------------------

Here are some ground rules for exceptions thrown in the code:

* Code should not throw a generic Exception, but one of Elabftw\Exceptions
* ImproperActionException when something forbidden happens but it's not suspicious. Error is not logged, and message is shown to user
* DatabaseErrorException when a SQL query failed, the error is logged and message is shown to user
* IllegalActionException when something should not happen in normal conditions unless someone is poking around by editing the requests. Error is logged and generic permission error is shown
* FilesystemErrorException, same as DatabaseErrorException but for file operations
* For the rest, the error is logged and a generic error message is shown to user
* Code should throw an Exception as soon as something goes wrong
* Exceptions should not be caught in the code (models), only in the controllers
* Instead of returning bool, functions should throw exception if something goes wrong. This removes the need to check for return value in consuming code (something often forgotten!)

Making a pull request
---------------------
#. Before working on a feature, it's a good idea to open an issue first to discuss its implementation
#. Create a branch from **hypernext**
#. Work on a feature
#. Make sure `yarn full` exits with no errors
#. Make a pull request on GitHub to include it in **hypernext**

.. code-block:: bash

    cd $dev/elabftw
    # create your feature branch from the hypernext branch
    git checkout -b my-feature
    # modify the code, commit and push to your fork
    # go to github.com and create a pull request


Making a gif
------------

* make a capture with xvidcap, it outputs .xwd

* convert .xwd to gif:

.. code-block:: bash

    $ convert -define registry:temporary-path=/path/tmp -limit memory 2G \*.xwd out.gif
    # or another way to do it, this will force to write all to disk
    $ export MAGICK_TMPDIR=/path/to/disk/with/space
    $ convert -limit memory 0 -limit map 0 \*.xwd out.gif

* generate a palette with ffmpeg:

.. code-block:: bash

    $ ffmpeg -i out.gif -vf fps=10,scale=600:-1:flags=lanczos,palettegen palette.png

* make a lighter gif:

.. code-block:: bash

    $ ffmpeg -i out.gif -i palette.png -filter_complex "fps=10,scale=320:-1:flags=lanczos[x];[x][1:v]paletteuse" out-final.gif

* upload to original one to gfycat and the smaller one to imgur

Adding a lang
-------------

* Add lang on poeditor.com
* Get .po
* Open with poeditor and fix issues
* Save the .mo
* Upload .po fixed to poeditor
* Add the files in src/langs
* Edit Tools to add lang to menu
* Get the tinymce translation
* Rename file to 4 letters code
* Edit first line of file to match code


Adding a new term for js i18n
-----------------------------

These steps are overly complicated and should be made automatically ideally.

* Add the new term to src/langs/js-strings.php and give it an identifier
* Open all files in `src/ts/langs/*.ts` and add it there with translation for all
* Import i18next in the corresponding ts file and use `i18next.t('string-id')`

Accessing Docker MySQL database with phpmyadmin
-----------------------------------------------

You might be used to access your local MySQL dev database with PHPMyadmin. Just uncomment the part related to phpmyadmin in the config file and `elabctl restart`.

This will launch a docker container with phpmyadmin that you can reach on port 8080. Go to `localhost:8080 <http://localhost:8080>`_. Login with your mysql user (elabftw by default) and your mysql password found in the .yml configuration file. You should see the `elabftw` database now.

Using a trusted certificate for local dev
-----------------------------------------

When working locally, the docker image will generate a self-signed TLS certificate. This will show a warning in the browser address bar and multiple warnings in the console (when you press F12). To fix this, it is possible to generate certificates that are trusted by your local browser.

We'll use `FiloSottile/mkcert <https://github.com/FiloSottile/mkcert>`_ project to achieve this.

Step 1: use a real domain name
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

I like to use elab.local on port 3148. Edit `/etc/hosts` and add a line with elab.local pointing to localhost like this:

127.0.0.1 elab.local

Step 2: get certs
^^^^^^^^^^^^^^^^^

Install `mkcert <https://github.com/FiloSottile/mkcert>`_ and generate certificates for `elab.local`. Create a new folder somewhere to hold them:

.. code-block:: bash

   $ mkdir -p $dev/certs/live/elab.local
   $ mv elab.local+3.pem $dev/certs/live/elab.local/fullchain.pem
   $ mv elab.local+3-key.pem $dev/certs/live/elab.local/privkey.pem

Step 3: edit config to use certificates
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Edit the .yml file for elabftw, change `ENABLE_LETSENCRYPT` to `true`. Uncomment the volume line with `/ssl` and make it point to where you have the certs.

Example:

.. code-block:: yaml

   volumes:
     - /home/user/.dev/elabftw:/elabftw
     - /home/user/.dev/certs:/ssl

Step 4: restart containers
^^^^^^^^^^^^^^^^^^^^^^^^^^

`elabctl restart`, and you should now have a valid certificate on your local dev install of elabftw :)

How to test external auth
-------------------------

To easily test external authentication, edit in the container `/etc/php8/php-fpm.d/elabpool.conf` and at the end add:

.. code-block:: proto

   env[auth_user] = ntesla
   env[auth_username] = Nicolas
   env[auth_lastname] = Tesla
   env[auth_email] = "nico@example.com"
   env[auth_team] = "Alpha"

Restart the php process with: `s6-svc -r /var/run/s6/services/php`.

Next, configure the correct keys in the Sysconfig panel and external authentication should be working as expected.

How to test ldap
----------------

Uncomment the ldap and ldap-admin containers definitions in the config file. Then use the ldap-admin (running on port 6443 by default) to login with "cn=admin,dc=example,dc=org" and password "admin". Then click the "dc=example,dc=org" in the left menu and "Create a child entry". Create a "Generic: Posix Group". We don't care about the name but it is necessary to have one before creating our test user.

Click again the "dc=example,dc=org" in the left to be at the root, "Create a child entry" and select "Generic: User Account". In GID Number you can assign the previously created group. Once the user is created, go select it in the left menu and "Add new attribute": Email. And add the email for that user. Now you should be able to login with that user after activating ldap from the sysconfig menu. Default values from the populate script should be good to go without changes.

Install a pre-commit hook
-------------------------

It is a good idea to use a pre-commit hook to run linters before the commit is actually done. It prevents doing another commit afterwards for "fix phpcs" or "fix linting". Go into `.git/hooks`. And `cp pre-commit.sample pre-commit`. Edit it and before the last line with the "exec", add this:

.. code-block:: bash

    # eLabFTW linting pre-commit hook
    reset="\e[0m"
    red="\e[0;31m"
    set -e
    if ! yarn pre-commit
    then
        printf "${red}error${reset} Pre-commit script found a problem!.\n"
        exit 1
    fi

Now when you commit it should run this script and prevent the commit if there are errors.
