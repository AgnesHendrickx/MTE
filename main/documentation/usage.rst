Usage
=====

.. _installation:

Installation
------------

| To use MTE code, clone from `github <https://github.com/AgnesHendrickx/MTE/>`_. 
| Make sure to have python3 and gnuplot installed and updated. 

General outline (hierarchy) of code 
-----------------------------------

The main body of code is called ``MTE.py``, here one can change model setup for different benchmarks, modify meshing, etc. 
It calls upon two modules composed of various functions: 

1. The computational module ``magnetostatics.py``, containing mostly translation of original Fortran77 code from :cite:`BLAKELY`.  
2. The visualization module ``tools.py``, containing functions to produce vtu files. 

Furthermore, two other (optional) modules are available only for the Mount Etna case study, where the field sites of :cite:`Meyer23` are reproduced:

1. ``set_measurement_parameters import.py``, which contains one function (see :doc:`functions`) that returns DEM, site and path specific values like ``pathfile``, number of points, IGRF, and more, see :doc:`functions`, from input.
2. ``etna.py``, where one defines the input parameters, see :doc:`etna`, to run different options to reproduce field paths, and calling ``set_measurement_parameters import.py``

Lastly, there are two scripts that automatically modify ``etna.py``, ``script_etna_full.sh``, and ``script_etna.sh``, see :doc:`etna` for more information.

Please see each respective section for specific usage of the code: :doc:`benchmarks`, :doc:`flanksim`, :doc:`parameters` and :doc:`etna`. 



