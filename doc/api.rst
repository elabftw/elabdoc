.. _api:

API
===

What's that?
------------

It's a way to read or write data to eLabFTW from an external program (like a Python script).

Prerequisite
------------

If you are not running the Docker image provided, you'll need to edit your webserver configuration to redirect correctly the API calls:

Here is the configuration for Nginx:

.. code-block:: nginx

    location ~ ^/api/v1/(.*)/?$ {
         rewrite /api/v1/(.*)$ /app/controllers/ApiController.php?req=$1? last;
    }


For Apache 2.4:

.. code-block:: bash

    a2enmod proxy proxy_http rewrite

.. code-block:: apache

    SSLEngine on
    RewriteEngine On
    RewriteCond %{HTTP:Authorization} ^(.*)
    RewriteRule .* - [e=HTTP_AUTHORIZATION:%1]
    RewriteRule ^/api/v1/(.*)$ /app/controllers/ApiController.php?req=$1 [P,L]

Getting started
---------------

Copy your API Key from your profile page (click on your username once logged in). This key allows access to your account, keep it secret and secure!

Using Bash/cURL
---------------

.. note:: If your installation has a self-signed certificate, add the '-k' flag to cURL.

.. code-block:: bash

    # store your key in an environment variable
    export API_KEY=380915ea6baa5f08061ea49ef7ace19b9d37b40607f34bf8019d5a772c9d855459151c5e1bba35164d42
    # create an experiment
    curl -X POST -H "Authorization: $API_KEY" "https://elabftw.example.org/api/v1/experiments"
    # read experiment with id 3
    curl -H "Authorization: $API_KEY" "https://elabftw.example.org/api/v1/experiments/3"
    # read database item with id 5
    curl -H "Authorization: $API_KEY" "https://elabftw.example.org/api/v1/items/5"
    # upload a file to experiment 3
    curl -X POST -F "file=@your-file.jpg" -H "Authorization: $API_KEY" "https://elabftw.example.org/api/v1/experiments/3"
    # add a link to an experiment
    curl -X POST -F "link=195" -H "Authorization: $API_KEY" "https://elabftw.example.org/api/v1/experiments/3"
    # add a tag to an experiment
    curl -X POST -F "tag=my-super-tag" -H "Authorization: $API_KEY" "https://elabftw.example.org/api/v1/experiments/3"
    # download an attached file (only for files you own)
    # first get the id and real_name of the upload, then get the file itself
    curl -s -H "Authorization: $API_KEY" "https://elabftw.example.org/api/v1/uploads/805" -o file.png


Using Python
------------

A module named `elabapy` is provided for easy access to eLabFTW's API. You need to use Python 3. Versions below 3 will not work.

How to install
``````````````

You can install elabapy using **pip**

.. code-block:: bash

    pip install --user -U elabapy

or via **conda**:

.. code-block:: bash

    conda skeleton pypi elabapy
    conda-build elabapy

or via sources:

.. code-block:: bash

    git clone https://github.com/elabftw/elabapy
    cd elabapy
    python setup.py install


Features
````````

elabapy support all the features provided via
eLabFTW API, such as:

-  Get user's Experiments/Items
-  Update an Experiment/Item
-  Upload a file to an Experiment/Item

The complete documentation is available here: `elabftw's API documentation <https://doc.elabftw.net/api/>`_

Examples
````````

Initialization
^^^^^^^^^^^^^^

.. code-block:: python

    import elabapy
    # to pretty print the results
    import json
    # get your token from your profile page
    manager = elabapy.Manager(endpoint="https://elab.example.org/api/v1/", token="3855459151c...5e1bba35164d42")

Listing the experiments
^^^^^^^^^^^^^^^^^^^^^^^

This example shows how to list all the experiments:

.. code-block:: python

    experiments = manager.get_all_experiments()

Get info for an experiment
^^^^^^^^^^^^^^^^^^^^^^^^^^

This example shows how to print data from experiment with ID 1:

.. code-block:: python

    # get data for experiment 1
    exp = manager.get_experiment(1)
    # show the title
    print(exp["title"])
    # pretty print everything
    print(json.dumps(exp, indent=4, sort_keys=True))

Create an experiment
^^^^^^^^^^^^^^^^^^^^

This example shows how to create a new experiment and read its ID:

.. code-block:: python

    # create experiment
    exp = manager.create_experiment()
    print("Created a new experiment with id:", exp["id"])

Change the body, title and date
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Here is how you can update your experiment body, title and date:

.. code-block:: python

    # payload is a dict
    params = {"title": "New title", "body": "Experiment updated through API", "date": "20170415"}
    manager.post_experiment(1, params)
    # or for an item
    manager.post_item(1, params)

Upload a file
^^^^^^^^^^^^^

Here is how you can attach a file to an experiment (or item):

.. code-block:: python

    files = {'file': open('report.xls', 'rb')}
    print(manager.upload_to_experiment(94, files))
    print(manager.upload_to_item(17, files))

Fetch an uploaded file
^^^^^^^^^^^^^^^^^^^^^^

You can find the upload ID from the info of an experiment/item using the methods described above.

.. code-block:: python
    
    # This example gets a file with upload ID 63
    print(manager.get_upload(63))

Create a database item
^^^^^^^^^^^^^^^^^^^^^^

Before creating a database item, we want to get a list of the available item types (as they differ from one team to another). We're looking for the "id" of the correct type.

.. code-block:: python

    print(json.dumps(manager.get_items_types(), indent=4, sort_keys=True))

Look at the output and note the id of your favorite item type. Let's assume it's '3'.

Now you can create a database item like so:

.. code-block:: python

    print(json.dumps(manager.create_item(3), indent=4, sort_keys=True))

This command will reply with the id of the newly created database item. Let's assume it's "1337". To edit it:

.. code-block:: python

    params = {"title", "Your title", "body": "The content to input", "date": "20191014"}
    manager.post_item(1337, params)

