Usage
=====

.. _installation:

Installation
------------

| To use MTE code, clone from `github <https://github.com/AgnesHendrickx/MTE/>`_. 
| Make sure to have python3, paraview, matplotlib and/or gnuplot installed and updated. 


General outline (hierarchy) of code 
-----------------------------------

The main body of code is called ``MTE.py``, here one can change model setup for different benchmarks, modify meshing, etc. 
It calls upon three modules composed of various functions: 

1. The computational module ``magnetostatics.py``, containing mostly translation of original Fortran77 code from :cite:`BLAKELY`.  
2. The visualization module ``tools.py``, containing functions to produce vtu files. 
3. The support module ``support.py``, containing several functions related to specific model setups. 

Furthermore, two other (optional) modules are available only for the Mount Etna case study, where the field sites of :cite:`Meyer23` are reproduced:

1. ``set_measurement_parameters import.py``, which contains one function (see :doc:`functions`) that returns DEM, site and path specific values like ``pathfile``, number of points, IGRF, and more, see :doc:`functions`, from input.
2. ``etna.py``, where one defines the input parameters, see :doc:`etna`, to run different options to reproduce field paths, and calling ``set_measurement_parameters import.py``

Lastly, there are two scripts that automatically modify ``etna.py``, ``script_etna_full.sh``, and ``script_etna.sh``, see :doc:`etna` for more information.

Please see each respective section for specific usage of the code: :doc:`benchmarks`, :doc:`flanksim`, :doc:`parameters` and :doc:`etna`. 


Reproducing results
-------------------

| Throughout this documentation, we provide a stepwise approach to reproducing the results. The steps can be found in collapsible subsections at the end of a respective section. Within each step, you'll find one or more code blocks detailing the required commands or changes for that specific step.
| Code blocks are preceded by captions that specify the location or context of the provided code. This caption might refer to a particular file in the codebase, such as:

.. code-block:: python
   :caption: /main/MTE.py
   :linenos:

   ....................
                                         
| In such cases, the line numbers in the code block correspond directly to the line numbers in the specified file. Changes or additions are highlighted for ease of reference.

| Alternatively, the caption might indicate a terminal command executed within a certain directory:

.. code-block:: 
   :caption: /main/
   
   ....................

| Regarding data visualization, we supply scripts for two different plotting tools: gnuplot and matplotlib. While both scripts are designed to generate similar outputs, it's worth noting that gnuplot was our primary tool for this project. As such, the plots it produces are considered the most accurate visual representation of our data. When encountering two code blocks placed side by side, this denotes the flexibility to opt for your preferred plotting tool:

+----------------------------------+-----------------------------------+
|.. code-block::                   |.. code-block::                    |
|   :caption: /main/benchmark_1/   |   :caption: /main/benchmark_1/    |
|                                  |                                   |   
|   ....................           |   ....................            | 
|                                  |                                   |   
+----------------------------------+-----------------------------------+

| In instances where specific commands are executed repeatedly, a single caption will precede all such repetitive steps:

.. code-block:: 
   :caption: /main/

   ....................

.. code-block:: 

   ....................

| Please make sure to read any notes, as they highlight important steps different from the standard procedures. 

| Any modification to the code and accompanying data not mentioned within these steps might produce unverified results. Should you make such alterations, please meticulously reviews all annotations in the code and consult the :doc:`functions` documentation.