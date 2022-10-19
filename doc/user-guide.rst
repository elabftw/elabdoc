.. _user-guide:

User guide
==========

This guide assumes you already have a working installation of eLabFTW on a server.

General overview
----------------

The principles
~~~~~~~~~~~~~~
By default, experiments and database items are restricted to a team. But users can choose to extend this to all registered users.

Experiments showed on the Experiments tab (the main tab) are yours only. To see experiments from other people in the team use the Search page or enable it from your User Control Panel.

Database items are common to the team and can be edited by anyone from the team.

Creating an account
~~~~~~~~~~~~~~~~~~~
New users need to register an account on the register page (`/register.php`), accessible from the login page. They need to select a team from the list.

By default, newly created accounts are disabled. The admin of the team needs to validate them by going into the admin panel and activate new users.

Experiments
-----------
Once logged in, you can create an experiment by clicking the «Create» button on the top right of the screen. You will be presented with an «edition» page (you can see 'mode=edit' in the URL); the two other modes being 'view': display a single experiment, and 'show': display a list of experiments.

See the getting started video:

.. raw:: html

    <iframe width="560" height="315" src="https://www.youtube.com/embed/k30uyH2_LMM" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Templates
~~~~~~~~~
Each user can have his own Experiments templates. Go to your user panel to create/edit your templates. You can export them as .elabftw.tpl files, and import them, too! They will be accessible from the «Create new» dropdown menu.

Edit mode
~~~~~~~~~

Tags
````
The tags allow you to easily group experiments together. You can think of it as folders, but more powerful because each experiment can have many tags, thus allowing you to cross-search efficiently!
All experiments with the same tag will be accessible by clicking this tag or searching for it. To validate a tag, press Enter or click outside the input field. It is saved immediately. The number of tags is not limited. Click on a tag to remove it (in edit mode). Tags are common to a team. Autocompletion favors the reuse of existing tags.

.. image:: img/quick_tags.gif

Date
````
The date is today's date by default, in the format YYYYMMDD. You can edit it as you wish. The real creation date/time is stored in the database in another column.

Status
``````
This useful feature lets you set the 'status' of an experiment. By default you can have:

- Running (selected upon creation)
- Need to be redone
- Success
- Fail

These status can be modified completely by the admin in the admin panel.

Title
`````
The title of your experiment. A duplicated experiment will have a «I» character appended to the title upon creation.

Experiment (body)
`````````````````
This is where you describe your experiment and write your results. It is a rich text editor where you can have formatting, tables, colors, images, links, etc… 

Images
  To insert an image in this field, first upload it by dragging it in the 'Attach files' block. Then you will see a new block appear just below, with a thumbnail of the file, its name and size. Right click on the image and select «Copy link location». Next, click on the «Insert/edit image» button in the toolbar of the rich text editor (third button before the last).
  Paste the link location. Press OK. That's it, you have an image inside your main text.
  
  Make sure to right click on the thumbnail and not on the name!

Tables
  If you add tables you might want to sort the data in the table dynamically. eLabFTW got you covered. Sort icons will be displayed in view mode when so called header cells (``<th>``) are defined. The table should have column names in the top row. You can select the top row with the mouse by clicking the left mouse button on the leftmost cell and while keeping the mouse button pressed move the mouse to the rightmost cell. Release the mouse button. The top row should be highlighted now. Next, from the rich text editor menu select «Table» → «Cell» → «Cell properties». In the dialog change «Cell type» from «Cell» (``<td>``) to «Header cell» (``<th>``). After you saved the changes you can go to view mode and dynamically sort the table. The changed order is not stored in eLabFTW.

.. image:: img/sort-table.gif
    :align: center
    :alt: Sort table demo

Steps
`````
Steps are a way to list the things one need to do during the experiment. So you can write several steps, and once they are done, click the checkbox to declare them finished. This is quite useful for long experiments spanning over several days, where the "Next step" will be shown in Show mode (index list), so you can see at one glance what is the next thing to do for this particular experiment.

Note that you can also declare steps in a template.

Linked items
````````````
This field allows you to link an item from the database. Just begin to type the name of what you want to link and you will see an autocompletion list appear. Select the one you want and press Enter. The number of links is not limited.

This feature can also be used to link an experiment to a particular Project. If you have a «Project» Item Type and have a Project item in your database, you will then be able to see all experiments linked to this project by clicking the Link icon.

Attach a file
`````````````
You can click this region to open a file browser, or drag-and-drop a file inside. The file size limit depends on the server configuration, and there is no limit on file type. If you upload an image, a thumbnail will be created. There is no limit on the number of files you can attach to an experiment.

When you are done, click the «Save and go back» button.

You are now in view mode.

Ellipsis menu (the three dots on the top right)
```````````````````````````````````````````````
This menu contains an entry to Manage Permissions, allowing you to restrict or extend the read and write permissions for that experiment.
By default, all experiments can be viewed by other team members. If you wish to restrict viewing of a particular experiment, set this to 'Only me'. An admin can also create groups of users, and users can set the visibility of experiments to this group only.

The Switch Editor entry will switch from the WYSIWYG editor (TinyMCE) to the markdown editor. And the Delete entry is to remove the experiment.

View mode of experiment
~~~~~~~~~~~~~~~~~~~~~~~
In the view mode, several actions are accessible under the date.

Edit
````
Go into edit mode.

Duplicate
`````````
Duplicating an experiment allows you to create a new item with the same Title, tags, body and links, but with today's date and a running status. Uploaded files are not duplicated. A «I» character will be added to the title to denote that it is a replicate.

Make a pdf
``````````
Clicking this will create a pdf from your experiment. The generated pdf will contain all the information related to the experiment.

Make a zip archive
``````````````````
A zip archive will contain the generated pdf of the experiment + any attached files present.

Lock
````
Once locked, an experiment cannot be modified anymore. Unless you unlock it. If it is locked by someone with locking powers (the PI), you will not be able to unlock it.

Timestamp
`````````
An experiment can be timestamped by users. It can be timestamped several times. Timestamping allows strong legal proof of the existence of the data at the timestamping date/time.

What happens when you timestamp an experiment:

- a pdf is generated
- a sha256 sum of this pdf is generated
- this data is sent to the Time Stamping Authority (TSA)
- they timestamp it
- we get a token back

More info here: https://en.wikipedia.org/wiki/Trusted_timestamping

Blockchain timestamping is also available, leveraging the Bloxberg.org blockchain to certify research data. It is the icon next to the (classic) timestamp button.

elabid
``````
In the bottom right part of the experiment, you can see something like: «Unique elabid: 20150526-e72646c3ecf59b4f72147a52707629150bca0f91». This number is unique to each experiment. You can use it to reference an experiment with an external database.

Comments
````````
People can leave comments on experiments. They cannot edit your experiment, but they can leave a comment. The owner of the experiment will receive an email if someone comment their experiment.

Database
--------
Same as experiments for a lot of things, except there is no status, but a rating system (little stars). You can store any type of items inside, the admin can edit the available types of items.

In view mode, click the link icon to show all experiments linked with this item.

Examples of database items types:

* antibodies
* microscopes
* plasmids
* drugs
* chemicals
* equipment
* projects

Team
----
This page presents the members and some statistics about the team. You'll also find here a molecule drawer. Note: this molecule drawer can be displayed when you create an experiment. Go to your user control panel to adjust this setting.

Scheduler
~~~~~~~~~
Since version 1.3.0, a scheduler is available to book equipment. First you need to set some item types as bookable from the Admin Panel. After you select an item from the Scheduler page, and use the calendar to book it.

See the video about the scheduler below:

.. raw:: html

   <iframe width="560" height="315" src="https://www.youtube.com/embed/lGESXKV2-CM" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

User panel
----------

The user panel is where you can adjust preferences for your account. You can access it by clicking the link in the bottom left of every page, or through the user menu in the top right.

Preferences tab
~~~~~~~~~~~~~~~
From here you can select a language, adjust the display settings, change the keyboard shortcuts, modify the PDF settings, select a different text editor and set the default permission settings.

Account tab
~~~~~~~~~~~
Modify your password, name and contact information.
You can also enable/disable :ref:`two-factor authentication <faq2fa>` (2FA).

Templates tab
~~~~~~~~~~~~~
Manage your templates. Once a template has been created, you can add tags, steps and links to it. It will then be available from the Create menu.

Api keys tab
~~~~~~~~~~~~
Create an API key for your account from this page. API keys are needed if you wish to access resources through the REST API.

How to have folders or projects grouping experiments?
-----------------------------------------------------

First, try to go beyond the nested, tree-like structure of hierarchical folders.

Imagine you have an experiment which is:

- about "Protein MR73"
- using "Western blot"
- an external collaboration
- with "HEK cells"

Now if that experiment was a file, you might want to store it in "Collaborations > Western Blot > MR73" maybe. Or "Project MR73 > Collaborations > HEK"?

But what if you have another one that is also using HEK cells but has nothing in common with the previous one. How would you go about looking for all the experiments with HEK? And all the experiments related to MR73 that involve a Western Blot?

In a traditional folder structure, you would need to search for it in almost each sub-folders.

Enter **tags**.

Tags
~~~~

Tags are a way to label your experiments (and database objects) with defined keywords and you can have as many as you want!

.. image:: img/tags-view.png
    :align: center
    :alt: tags

Now with the experiments correctly tagged, finding them through different search angles becomes easy! You can search for one tag or many tags directly from the main page.

Favorite tags
~~~~~~~~~~~~~

Over time, you will have some tags that become your favorites, as they are always the ones you look for for a set of experiments.

Since version 4.2.0 it is possible to define "Favorite tags" that will appear in the left pane of the page listing entries. It allows quick overview of related entries. You should try this feature, start by clicking the arrow on the left of the screen to toggle the left pane. Click the + button and start typing a tag to add it to the list of Favorite tags.

.. image:: img/favtags.gif
    :align: center
    :alt: favorite tags

Note that if you use a "Favorite tag" filter and then create an experiment, it will be tagged automatically with that tag.

Using Projects
~~~~~~~~~~~~~~

There is also another way to group experiments together, that you can use along with tags. It's using a database item of type : Project.

Go to the Admin Panel and create a type of item: "Project". Go to the Database tab and create a new "Project" describing a group of experiments, a project. Go to the Experiments tab and create an experiment. In the field "Link to database", type the name of the project and click on the autocompletion field appearing, and press enter (or click outside). This experiment is now linked to the project. So you can easily go to the project description from the experiment, but more importantly, you can from the Project entry, click the "Show related" icon (chainlink) and display all experiments linked to this project!

Make sure to create experiments templates that already link to that Project so the link will always be here when the experiment is created by a user.

Importing data
--------------

It is possible to import data from files into eLabFTW. Click the arrow on the left of the **Create** button to show the `Import from file` menu entry. A modal window appears to allow you to choose:

* Where do you import: either the category of database items, or your experiments or if you are Admin, experiments of other users
* The read/write permission levels of the imported entry(ies)
* The actual file to import

Importing from a .eln archive
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

You can import data from a .eln archive generated by any ELN software conforming to the `specification <https://github.com/TheELNConsortium/TheELNFileFormat/blob/master/SPECIFICATION.md>`_.

Importing from a .zip archive
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Only zip files generated by eLabFTW can be imported here.

Importing from a .csv file
~~~~~~~~~~~~~~~~~~~~~~~~~~

If you already have some "items" catalogued in an Excel file or File Maker database, you can import them in eLabFTW with a .csv file.
A .csv file is a very simple file format. You can save a .xlsx or .ods file into this format. It needs to be "flat", meaning the first row is the column names, and all subsequent rows correspond to one entry.

To achieve a successful import, make sure to follow these instructions:

1. Preparing the file
`````````````````````

It is important to make sure that the file you are going to import is "clean". Open your file (.xls/.xlsx/.ods/.csv) in an editor like LibreOffice Calc or Microsoft Excel.

Make sure that there are now empty rows or extra information outside the main data. And that you don't have columns with the same name, or columns with no useful information.

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

Once you are satisfied with the file, export it as a **.csv** (in File > Save as...). Make a copy of only the first 3 rows and export that too as csv, this will be our test file.

2. Importing the file
`````````````````````

Click "Import from file" from the "Create" submenu. If you haven't done it already, create first an Item Type that fits your data (or ask your Admin to do it). Here we will create an "Antibody" category as that's what we are importing, from the "Items Types" tab.

In the import windows, select the correct category (Antibody in this example). Then select the visibility. Now select your **test** CSV file (with a few rows only) and click the "Import" button.

Every row will correspond to an entry in the correct category of database items. All the columns (except title) will be imported in the body of each entry.

If the import looks good, you can now delete these newly imported items and import your complete file.

Using the API to control how things are imported
````````````````````````````````````````````````

If you want to have complete control over the import process, you can use a helper program to do the import.


.. code-block:: python

    #!/usr/bin/env python
    import elabapy
    import csv

    manager = elabapy.Manager(token="YOUR_TOKEN", endpoint="https://elabftw.example.org")

    with open('a.csv', newline='') as csvfile:
        csvreader = csv.DictReader(csvfile, delimiter=',', quotechar='"')
        for row in csvreader:
            res = manager.create_experiment()
            # start by clearing out the content (default template)
            manager.post_experiment(res['id'], {'body': ''})
            # add a title
            manager.post_experiment(res['id'], {'title': row['title']})
            # now create a body with columns in bold
            manager.post_experiment(res['id'], {'bodyappend': '<strong><h2>Content:</h2></strong>' + row['content'] + '<br>'})
            manager.post_experiment(res['id'], {'bodyappend': '<strong><h2>Category:</h2></strong>' + row['category'] + '<br>'})
            manager.post_experiment(res['id'], {'bodyappend': '<strong><h2>Elabid:</h2></strong>' + row['elabid'] + '<br>'})




Miscellaneous
-------------

You can export experiments in .zip. If the experiment was timestamped you will find in the archive the timestamped pdf and the corresponding .asn1 token.

You can export and import items from the database (it can be several items).

Press 't' to have a TODO list.

.. raw:: html

   <iframe width="560" height="315" src="https://www.youtube.com/embed/maylkcTAarg" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

In the editor, press Ctrl+shift+d to get today's date inserted at cursor position.

Signatures
~~~~~~~~~~

On paper notebooks, there was this idea of having another lab member signing every page of a notebook before the page would get plastified to prevent modifications. To my knowledge, this was seldom done properly.

With eLabFTW, you can have this workflow, but it is much easier to achieve:

- User A finishes an experiment
- User B, that has locking power (Admin + Lock user group) can go on that experiment and click the lock icon

This prevents user A from modifying the content (like plastifying), and it keeps a log of who locked it and when (like signing the page).
