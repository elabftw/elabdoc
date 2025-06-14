.. _import-export:

***************
Import / Export
***************

Introduction
============

When users add information into systems like eLabFTW, that information can get trapped in this system. We do not want that. We want information to flow freely.

As such, eLabFTW allows users to freely export and import data, in different file formats, as well as accessing it through a :ref:`public API <api>`, for automation tools.

This page describes the Import and Export features available in eLabFTW.

.. _importing-data:

Importing data
==============

Data import can be used to facilitate ingestion of multiple records into the current system. It can also be a convenient way to transfer data between systems. For instance, a research group leaving an institution can export all their team's data and import it into the new institution.

Import can be done from the web interface, accessible to all users, but also from the Command Line Interface (CLI), which is only accessible to Sysadmins with console access to the container. CLI import is the recommended way to import big files (such as a full team export), as it prevents issues such as timeouts, if the import takes too long.

Two filetypes are currently supported for import: `.eln` (vnd.eln+zip) and `.csv` (text/csv).

Importing a .eln archive
------------------------

You can import data from a `.eln` archive generated by any ELN software conforming to the `specification <https://github.com/TheELNConsortium/TheELNFileFormat/blob/master/SPECIFICATION.md>`_.

Importing a `.eln` file created by an eLabFTW instance will produce the best results. This documentation focuses on these.

A `.eln` can contain any type of data:

* Experiments
* Experiments templates
* Resources
* Resources categories

eLabFTW will pick up the type of each entry through its `genre <https://schema.org/genre>`_ attribute. Alternatively, you can force the type of entry by selecting one from the dropdown menu (web UI) or using the `--type` option (CLI). The same logic applies to selecting the appropriate category.

Importing through web interface
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Head to the "Import" tab of your Profile page by selecting "Import" from the top right menu.

Select a `.eln` file to display import options. Then click Import.

Importing through CLI
^^^^^^^^^^^^^^^^^^^^^

.. note:: This approach is only available to Sysadmins with shell access.

If you wish to import a rather large `.eln` archive (such as a full team export), the CLI is the better approach. Display the help with:

.. code-block:: bash

   docker exec -it -u nginx:nginx elabftw bin/console import:eln -h

As you can see, there are two mandatory arguments, the path to the file, and the Team ID where the import will be performed. The first thing to do is to copy the file in the right place in the container. It must be in `/elabftw/exports` folder. Copy it with a command similar to this:

.. code-block:: bash

   docker cp your.eln elabftw:/elabftw/exports/

Figure out the Team ID by looking at the Teams tab from the Sysconfig panel, where the ID will be displayed next to the Team. Next, import your file with:

.. code-block:: bash

   # import in team 12 and be verbose
   docker exec -it -u nginx:nginx elabftw bin/console import:eln -vv your.eln 12
   # import in team 25, force everything to be owned by user 5 and be extra verbose
   docker exec -it -u nginx:nginx elabftw bin/console import:eln -vvv your.eln 25 --userid 5
   # import in team 42, force everything to be of type "Resources" with category "6"
   docker exec -it -u nginx:nginx elabftw bin/console import:eln --type items --category 6 your.eln 42

By default (if no ``--userid`` setting is provided), the ownership of the items will be
determined by comparing the email addresses of users between the export and import
servers. This allows for simple migration of data from one eLabFTW instance to another,
even if users have differing ``userid`` values on the two instances. If the user that owns 
an item in the exported data is not present on the destination (import) instance, the
import process will create users as necessary.


.. _csvimport:

Importing a .csv file
---------------------

If you already have some Resources catalogued in an Excel file or File Maker database, you can import them in eLabFTW with a .csv file.
A .csv file is a very simple file format. You can save a .xlsx or .ods file into this format. If using Microsoft Office, make sure to select "CSV UTF-8" in the dropdown menu. It needs to be "flat", meaning the first row is the column names, and all subsequent rows correspond to one entry.

To achieve a successful import, make sure to follow these instructions:

1. Preparing the file
^^^^^^^^^^^^^^^^^^^^^

It is important to make sure that the file you are going to import is "clean". Open your file (.xls/.xlsx/.ods/.csv) in an editor like LibreOffice Calc or Microsoft Excel.

Make sure that there are no empty rows or extra information outside the main data. And that you don't have columns with the same name, or columns with no useful information.

You should have a number of columns and rows, looking something like that:

.. list-table:: Example antibodies dataset
   :header-rows: 1

   * - Name
     - Host
     - Target
     - Reference
     - Seller
     - Storage
   * - Anti α-actin
     - Mouse
     - Human
     - AB3148
     - Abcam
     - -20°C
   * - Anti γ-tubulin
     - Rabbit
     - Human
     - AB1337
     - Abcam
     - +4°C


Now you need to have a column named **title**. This is the column that will be picked up as the title of the eLabFTW entry once imported. This column doesn't necessarily needs to be the first one, but it needs to be there. Here we're going to change the "Name" column. So now it looks like this:


.. list-table:: Example antibodies dataset modified
   :header-rows: 1

   * - title
     - Host
     - Target
     - Reference
     - Seller
     - Storage
   * - Anti α-actin
     - Mouse
     - Human
     - AB3148
     - Abcam
     - -20°C
   * - Anti γ-tubulin
     - Rabbit
     - Human
     - AB1337
     - Abcam
     - +4°C

If you wish to include tags during the import, specify a column "tags" that will contain the tags separated by a "|" character. You can also have a "metadata" column containing JSON. The same logic applies to "metadata" column which can contain JSON that will be included in the metadata of the created entry.

Once you are satisfied with the file, export it as a **.csv** (in File > Save as...). Make a copy of only the first 3 rows and export that too as csv, this will be our test file.

2. Importing the file
^^^^^^^^^^^^^^^^^^^^^

Select "Import" from the main top right user menu. If you haven't done it already, create first a Resource Category that corresponds to your data type (or ask your Admin to do it). Here we will use an "Antibody" category as that's what we are importing.

Start by selecting your `.csv` file. Options to select the type (Resource) and category (Antibody in our case) appear. Select the appropriate options and click "Import".

In the import window, select the correct category (Antibody in this example). Then select the visibility. Now select your **test** CSV file (with a few rows only) and click the "Import" button.

Every row will correspond to an entry in the correct category of Resources. All the columns (except title, tags, metadata, date, custom_id, and other picked up special columns) will be imported in the body of each entry.

If the import looks good, you can now delete these newly imported items and import your complete file.

Using the API to control how things are imported
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

If you want to have complete control over the import process, you can use a few lines of python to do the import.

.. warning:: **Important**: the scripts linked below will import automatically all the rows present in your CSV file. Try first with a few rows before importing everything, so you have a chance to correct errors easily!

We will use the `elabapi-python` library to make things easy. See `installation instructions <https://github.com/elabftw/elabapi-python#installation>`_.

You can then have a look at `this example to import CSV using the API and metadata/extra fields <https://github.com/elabftw/elabapi-python/blob/master/examples/09-import-csv.py>`_.

.. _compounds-import:

Importing compounds through CLI (csv file)
------------------------------------------

.. note:: This approach is only available to Sysadmins with shell access.

If you're working with a large database of compounds, using the CLI is a more efficient approach. Display the help with:

.. code-block:: bash

   docker exec -it elabftw bin/console import:compounds -h

The file must be available inside the container at /elabftw/exports. Use the following to copy your file into the container:

.. code-block:: bash

   docker cp your_compounds.csv elabftw:/elabftw/exports/

Figure out the Team ID by looking at the Teams tab from the Sysconfig panel, where the ID will be displayed next to the Team. Next, import your file with:

.. code-block:: bash

   # import in team 2 and be verbose
   docker exec -it elabftw bin/console import:compounds -vv your_compounds.csv 2
   # import in team 25, force everything to be owned by user 5 and be extra verbose
   docker exec -it elabftw bin/console import:compounds -vvv your_compounds.csv 25 --userid 5

Preparing the CSV file for import
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

One thing to know, is that the import command has an option (``-p``) to match compounds with PubChem, through the CAS or PubChem CID. So a .csv file with a single column ``cas`` or ``pubchemcid`` is enough to import compounds in eLabFTW.

When importing, there is an option to automatically create a Resource for each imported Compound. The Resource will be linked to the Compound, and its title will be the Compound name. For this, simply provide the Resource Category ID with the ``-c`` flag.

To also import locations/containers with quantity and units, use columns:

- ``location``: as a ``/`` separated value. For example: "Building C / Floor 2 / Chemistry room". Note that it is possible to specify another separator, which might be useful if your existing data is using another character than ``/``.
- ``quantity``: this should be a number corresponding to the quantity stored at the location
- ``unit``: this should be a value such as μg, mg, g, kg, mL, L

Other columns such as ``inchi``, ``smiles``, ``molecularweight``, ``molecularformula`` will also match and be imported to the compound. The full list of columns matched is accessible `here <https://github.com/elabftw/elabftw/blob/master/src/commands/ImportCompoundsCsv.php#L56>`_.

Once you have your CSV file ready, send it to your Sysadmin and let them know if it should be imported with PubChem and if you want to create Resources, too.

Matching an existing database
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Maybe you already have a Resource Category: "Chemical compounds" for instance, with Compounds associated to a "CAS" extra field. And you'd like to import the already existing compounds in the Compounds table in eLab so they exist as proper compounds.

To do that, the import should be done with the ``--match-with`` command option, which will match an existing Resource through its extra field value. For example: ``--match-with cas`` will import the compound and link it to the Resource where an extra field ``cas`` has the same value as the row from the column ``cas`` in the .csv.


.. _exporting-data:

Exporting data
==============

Exporting through web interface
-------------------------------

The Export tab from your Profile allows full export of all your data, in several formats. Click "Create new export" to configure how you want the data to be exported. A "File is not ready" entry will be displayed. Wait a few seconds and click "Refresh". Once you see a link to the file, you can click it and download the exported file.

Very long exports will still be processed if you close your browser or navigate away.

Note to Sysadmins: on a given instance, export jobs are processed only one at a time. Users can each keep only 6 exported files. They are stored in `exports` within the elabFTW root folder. The `exports` folder may be mapped to a path outside the container to prevent exceeding the disk usage quota of the container.
This can be done by adding a corresponding entry to `/etc/elabftw.yml` beneath the existing mapping for the upload path. In the example below, the exports folder is mapped to `/var/elabftw/exports`.

.. code:: yaml

    volumes:
        # this is where you will keep the uploaded files persistently
        # for Windows users it might look like this
        # - D:\Users\Nico\elab-data\web:/elabftw/uploads
        # host:container
        - /var/elabftw/web:/elabftw/uploads
        # mapping of exports folder
        - /var/elabftw/exports:/elabftw/exports

Exporting through CLI
---------------------

As a Sysadmin with shell access, you can export an entire team, which can be useful if that team migrates out of your instance for instance. Use `bin/console export:eln -h`. The only argument is the team ID that you wish to export.

It will export everything into a .eln file, that you need to copy out of the container. This file can later be re-imported on another instance.

Important note: Import/Export is only supported between instances of the same version, preferably the latest version!
