.. _api:

API
===

What's that?
------------

It's a way to read or write data to eLabFTW from an external program (like a Python script).

Getting started
---------------

Copy your API Key from your profile page (click on your username once logged in). This key allows access to your account, keep it secret and secure!

Using cURL
----------

.. note:: If your installation has a self-signed certificate, add the '-k' flag to cURL.

.. code-block:: bash

    # store your key in an environment variable
    export API_KEY=def50200f15a...
    # read experiment with id 3
    curl -H "Authorization: $API_KEY" "https://elabftw.example.org/api/v1/experiments/3"
    # read database item with id 5
    curl -H "Authorization: $API_KEY" "https://elabftw.example.org/api/v1/items/5"
    # upload a file to experiment 3
    curl -X POST -F "file=@your-file.jpg" -H "Authorization: $API_KEY" "https://elabftw.example.org/api/v1/experiments/3"


Using Python
------------

.. code-block:: python


    #!/bin/env python
    import requests

    # load the key
    API_KEY = 'def50200445ccfaa9d...'
    # your elabftw server
    URL='https://elab.local/'
    # because my certificate is self-signed we need this
    TLS_CERT='/etc/nginx/server.pem'

    mydata = {
            'title': 'From python',
            'date': '20170119',
            'body': 'This was sent through the API'
    }

    # update the content of an experiment
    # you can set verify=False here, too.
    r = requests.post(URL + 'api/v1/experiments/21',
    data=mydata,
    verify=TLS_CERT,
    headers={'Authorization': API_KEY})

    print(r.text)
