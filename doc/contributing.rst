.. _contributing:

Contributing
============

.. image:: img/contributing.png
    :align: center
    :alt: contributing
    :target: http://mimiandeunice.com/

What can you do to help this project?
-------------------------------------

* `Star it on GitHub <https://github.com/elabftw/elabftw>`_
* Talk about it to your colleagues, spread the word!
* Have a look at `the current issues <https://github.com/elabftw/elabftw/issues>`_
* Help with the translation
* Open GitHub issues to discuss bugs or suggest features

.. image:: img/i18n.png
    :align: right

Translating
-----------

Do you know several languages? Are you willing to help localize eLabFTW? You're in the right place.

How to translate?

* `Join the project on poeditor.com <https://poeditor.com/join/project?hash=aeeef61cdad663825bfe49bb7cbccb30>`_
* Select elabftw
* Add a language (or select an existing one)
* Start translating
* Ignore things like `<strong>, <br>, %s, %d` and keep the ponctuation like it was!

Translations are updated before a release.

Contributing to the code
------------------------

Environment installation
````````````````````````

Here is a step-by-step for installing an eLabFTW dev setup:

* First let's define a directory for dev (adapt to your needs):

.. code-block:: bash

    export dev='/home/<YOUR USERNAME>/elabdev'
    mkdir -p $dev
    cd $dev

* Go on `the repository on GitHub <https://github.com/elabftw/elabftw>`_
* Click the Fork button in the top right of the screen
* From your fork page, clone it with SSH on your machine:

.. code-block:: bash

    git clone git@github.com:<YOUR USERNAME>/elabftw.git
    cd elabftw
    # switch to the hypernext branch
    git checkout hypernext
    # create your feature branch from the hypernext branch
    git checkout -b my-feature

* PHP dependencies are managed through `Composer <https://getcomposer.org/>`_. Install it.
* JavaScript dependencies are managed through `Yarn <https://yarnpkg.com/>`_. Install it.
* Now install the PHP and JavaScript dependencies (they are not tracked by git):

.. code-block:: bash

    # php dependencies (vendor/ directory)
    composer install
    # javascript dependencies (node_modules/ directory)
    yarn install

* Install *elabctl* and the configuration file

.. code-block:: bash

    # you need root permissions for these commands
    sudo su
    wget -qO- https://get.elabftw.net > /usr/bin/elabctl && chmod +x /usr/bin/elabctl
    wget -qO- https://raw.githubusercontent.com/elabftw/elabimg/dev/src/docker-compose.yml-EXAMPLE > /etc/elabftw.yml

* Edit the docker-compose configuration file `/etc/elabftw.yml`
* Add a SECRET_KEY
* Change the `volumes:` line so it points to your `$dev/elabftw` folder.
* The container orchestration is done with `Docker Compose <https://docs.docker.com/compose/>`_. Install it.
* Start the containers:

.. code-block:: bash

   sudo elabctl start
   # allow up to 2 minutes for the web container to start

* Enable debug mode to disable the caching of Twig templates

.. code-block:: bash

    docker exec -it mysql bash
    # you are now inside the mysql container
    mysql -u$MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DATABASE
    # you are now on the mysql command line
    mysql> update config set conf_value = '1' where conf_name = 'debug';
    exit;
    exit

* Now head to https://localhost:3148
* You now should have a running local eLabFTW, and changes made to the code will be immediatly visible

Making a pull request
`````````````````````
#. Before working on a feature, it's a good idea to open an issue first to discuss its implementation
#. Create a branch from **hypernext**
#. Work on a feature
#. Make a pull request on GitHub to include it in hypernext

Code organization
`````````````````
* Real accessible pages are in the root directory (experiments.php, database.php, login.php, etc…)
* The rest is in app/
* app/models will contain classes with CRUD (Create, Read, Update, Destroy)
* app/views will contain classes to generate and display HTML
* app/classes will contain services or utility classes
* A new class will be loaded automagically thanks to the use of PSR-4 with composer (namespace Elabftw\\Elabftw)
* app/controllers will contain pages that send actions to models (like destroy something), and generally output json for an ajax request, or redirect the user.
* To get a good view of the relations between the classes, run `grunt api` and visit `_api/index.html`. Now check the Class hierarchy diagram from the top right menu.

i18n
````
* Use the script `app/locale/genPo.sh` to generate the .po file in French.

Miscellaneous
`````````````
* if you make a change to the SQL stucture, you need to add an update function in `app/classes/Update.php` and also modify `install/elabftw.sql` and `tests/_data/phpunit.sql` accordingly
* you can use the constant ELAB_ROOT (which ends with a /) to have a full path
* comment your code wisely
* your code must follow `the PSR standards <https://github.com/php-fig/fig-standards/blob/master/accepted/PSR-1-basic-coding-standard.md>`_
* add a plugin to your editor to show trailing whitespaces in red
* add a plugin to your editor to show PSR-1 errors
* remove BOM
* if you want to work on the documentation, clone the `elabdoc repo <https://github.com/elabftw/elabdoc>`_

Grunt
`````
Since version 1.1.7, elabftw uses `grunt <http://gruntjs.com/>`_ to minify and concatenate files (JS and CSS), among other things.

* Install grunt with :

.. code-block:: bash

    sudo npm install -g grunt-cli
    # regenerate JS and CSS
    grunt
    # only css (faster)
    grunt css

Tests
`````

The tests run on the Codeception framework. The acceptance tests will need to download the Selenium + Chrome headless docker image.

.. code-block:: bash

    $ grunt unit # will run the unit tests
    $ grunt test # will run the unit and acceptance tests

For code coverage you need to enable the xdebug PHP extension and run `grunt coverage`.

To run a SonarQube analysis, first start a SonarQube server and then start the scanner from the code root:

.. code-block:: bash

    $ cd $dev/sonarqube-6.3/bin/linux-x86-64 && ./sonar.sh start
    $ cd $dev/elabftw && $dev/sonar-scanner-2.9.0.670/bin/sonar-scanner

API Documentation
`````````````````

To generate a PHP Docblock documentation:

.. code-block:: bash

    $ grunt api

Then, point your browser to the `_api/index.html`.

You can have a look at the errors report to check that you commented all new functions properly.

Make a gif
----------

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
