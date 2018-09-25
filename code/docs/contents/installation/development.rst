Development
===========

Prerequisites
-------------

You need the following libraries and/or programs:

* `Python`_ 3.6 or higher
* Python `Virtualenv`_ and `Pip`_
* `PostgreSQL`_ 9.5 or above
* `Node.js`_
* `npm`_

.. _Python: https://www.python.org/
.. _Virtualenv: https://virtualenv.pypa.io/en/stable/
.. _Pip: https://packaging.python.org/tutorials/installing-packages/#ensure-pip-setuptools-and-wheel-are-up-to-date
.. _PostgreSQL: https://www.postgresql.org
.. _Node.js: http://nodejs.org/
.. _npm: https://www.npmjs.com/

Getting started
---------------

Developers can follow the following steps to set up the project on their local
development machine.

Obtain source
^^^^^^^^^^^^^^

You can retrieve the source code using the following command:

   .. code-block:: bash

        $ git clone git@github.com:VNG-realisatie/gemma-besluitregistratiecomponent.git bip

**Note:** You can also use the HTTPS syntax:

   .. code-block:: bash

        $ git clone https://github.com/VNG-realisatie/gemma-besluitregistratiecomponent.git bip

Setting up virtualenv
^^^^^^^^^^^^^^^^^^^^^^

1. Go to the project directory:

   .. code-block:: bash

        $ cd bip

2. Create the virtual environment:

   .. code-block:: bash

       $ virtualenv -p /usr/bin/python3.x ./env

3. Source the activate script in your virtual environment to enable it:

   .. code-block:: bash

       $ source env/bin/activate

4. Install all the required libraries:

   .. code-block:: bash

       (env) $ pip install -r requirements/dev.txt

Installing the database
^^^^^^^^^^^^^^^^^^^^^^^^

1. The default settings for the database are:

    * name: ``bip``
    * user: ``bip``
    * password: ``bip``

    You can customize these by setting (any of) the following environment
    variables:

    * ``DB_NAME``
    * ``DB_USER``
    * ``DB_PASSWORD``
    * ``DB_HOST``
    * ``DB_PORT``

2. Launch the migration process

   .. code-block:: bash

     (env) $ python src/manage.py migrate


.. note::

    You can put local, machine specific setting changes in
    ``src/bip/conf/local.py``. These settings are NOT checked into version
    control.


Running server
^^^^^^^^^^^^^^^^^^^^^^^^

1. Create a superuser to access the management interface:

   .. code-block:: bash

       (env) $ python src/manage.py createsuperuser

2. You can now run your installation and point your browser to the address
   given by this command:

   .. code-block:: bash

       (env) $ python src/manage.py runserver

Generate the API schema
---------------------------

1. Install Javascript modules:

   .. code-block:: bash

       $ npm install

2. Launch the schema generation tool:

   .. code-block:: bash

        generate-schema

3. The resulting ``openapi.yaml`` and ``swagger2.0.json`` files can be visualized with `Swagger`_

.. _Swagger: http://petstore.swagger.io/


Update installation
-------------------

When updating an existing installation:

1. Activate the virtual environment:

   .. code-block:: bash

       $ cd bip
       $ source env/bin/activate

2. Update the code and libraries:

   .. code-block:: bash

       (env) $ git pull
       (env) $ pip install -r requirements/dev.txt
       (env) $ npm install

3. Update the database:

   .. code-block:: bash

       (env) $ python src/manage.py migrate


