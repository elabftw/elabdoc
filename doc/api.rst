.. _api:

API
===

What's that?
------------

It's a way to read or write data to eLabFTW from an external program (like a Python script).

Getting started
---------------

Copy your API Key from your profile page (click on your username once logged in). This key allows access to your account, keep it secret and secure!

Using Bash/cURL
---------------

.. note:: If your installation has a self-signed certificate, add the '-k' flag to cURL.

.. code-block:: bash

    # store your key in an environment variable
    export API_KEY=380915ea6baa5f08061ea49ef7ace19b9d37b40607f34bf8019d5a772c9d855459151c5e1bba35164d42
    # read experiment with id 3
    curl -H "Authorization: $API_KEY" "https://elabftw.example.org/api/v1/experiments/3"
    # read database item with id 5
    curl -H "Authorization: $API_KEY" "https://elabftw.example.org/api/v1/items/5"
    # upload a file to experiment 3
    curl -X POST -F "file=@your-file.jpg" -H "Authorization: $API_KEY" "https://elabftw.example.org/api/v1/experiments/3"


Using Python
------------

A module named `elabapy` is provided for easy access to eLabFTW's API.

How to install
``````````````

You can install elabapy using **pip**

.. code-block:: bash

    pip install -U elabapy

or via sources:

.. code-block:: bash

    python setup.py install

Features
````````

elabapy support all the features provided via
eLabFTW API, such as:

-  Get user's Experiments/Items
-  Update an Experiment/Item
-  Upload a file to an Experiment/Item

Examples
````````

Initialization
^^^^^^^^^^^^^^

.. code-block:: python

    import elabapy
    import json
    # get your token from your profile page
    manager = elabapy.Manager(endpoint="https://elab.example.org/api/v1/", token="380915ea6baa5f08061ea49ef7ace19b9d37b40607f34bf8019d5a772c9d855459151c5e1bba35164d42")

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

Nginx configuration
-------------------

If you are not running the Docker image provided, you'll need to edit your nginx configuration and add this part for the eLabFTW server:

.. code-block:: nginx

    location ~ ^/api/v1/(.*)/?$ {
         rewrite /api/v1/(.*)$ /app/controllers/ApiController.php?req=$1? last;
    }
