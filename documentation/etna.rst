.. _etna:

Case study: Mount Etna
======================
| Additionally, two other optional modules are available exclusively for the Mount Etna case study, where the field sites from :cite:`Meyer23` are reproduced:

1. :func:`set_measurement_parameters.py`: This module provides DEM, site and path-specific values such as the file to read, the location and number of measurement points, IGRF (International Geomagnetic Reference Field) values for the site, and more. See :doc:`functions` for more details.
2. ``etna.py``: This module you define input parameters (see :doc:`etna`), to run different options reproducing field paths, to call :func:`set_measurement_parameters.py`


Finally, there are two scripts, ``script_etna_full.sh`` and ``script_etna.sh``, that automatically modify ``etna.py``, see :doc:`etna` for more information.

| To run all (optimized) setups for case study Mount Etna (reproducing) field sites use ``script_etna_full``.

.. code-block::

   ./script_etna_full

| run time 30 min


.. todo:: finish this section
