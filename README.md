# elabdoc

## Description

Source files for the [elabftw documentation](https://doc.elabftw.net).

Main project repository: [elabftw/elabftw](https://github.com/elabftw/elabftw).

## Installation

~~~bash
git clone https://github.com/elabftw/elabdoc
cd elabdoc
pip install --user sphinx sphinx_rtd_theme
~~~

## Usage

To generate the HTML documentation:

~~~bash
cd doc
make html
~~~

Then point your browser to the `_build/html/index.html` file inside the `doc/` folder.

## Config examples

You might want to look into the [config_examples](./config_examples) folder for Apache, HAProxy, Nginx or Traefik configuration as reverse proxy.
