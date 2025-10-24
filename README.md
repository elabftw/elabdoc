# elabdoc

## Description

Source files for the [elabftw documentation](https://doc.elabftw.net).

Main project repository: [elabftw/elabftw](https://github.com/elabftw/elabftw).

## Installation

~~~bash
git clone https://github.com/elabftw/elabdoc
cd elabdoc
uv sync
~~~

## Config examples

You might want to look into the [config_examples](./config_examples) folder for Apache, HAProxy, Nginx or Traefik configuration as reverse proxy.

## Usage

To generate the HTML documentation:

~~~bash
cd doc
uv run make html
~~~

Then point your browser to the `_build/html/index.html` file inside the `doc/` folder.

## CI

The generated documentation can also be accessed in the Artifacts section of the [CircleCI builds](https://app.circleci.com/pipelines/github/elabftw/elabdoc).

Click on "pdf" to get the doc as a pdf.

## Headings used

~~~rst
***********
MAIN HEADER
***********

TITLE
=====

SUBTITLE
--------

SUBSUBTITLE
^^^^^^^^^^^

SUBSUBSUBTITLE
""""""""""""""
~~~

