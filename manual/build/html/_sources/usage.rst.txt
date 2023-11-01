Usage
=====

.. _installation:

Installation
------------
| To use the MTE code, follow these steps:

1. Clone from `github <https://github.com/AgnesHendrickx/MTE/>`_.
2. Ensure that you have the following dependencies installed and up to date: python3, paraview, matplotlib and/or gnuplot.


General outline (hierarchy) of code
-----------------------------------

| The main body of the code is in ``MTE.py``, where you can configure the model setup for various benchmarks and modify meshing, among other tasks. It relies on three modules that consist of various functions:

1. ``magnetostatics.py``: This module mainly involves the translation of the original Fortran77 code from :cite:`BLAKELY`.
2. ``tools.py``: This module contains functions to generate vtu files for visualization.
3. ``support.py``: This module houses several functions related to specific model setups.

| The script ``run.sh`` performs a straightforward task: it executes the ``MTE.py`` code, generating output both in the terminal and writing it in a file named ``log.txt``.
| Additionally, several specific model setups have exclusive modules and (run) scripts, please see respective sections for specific usage of the code: :doc:`benchmarks`, :doc:`flanksim`, :doc:`parameters` and :doc:`etna`.

Reproducing results
-------------------

| Throughout this documentation, we provide a stepwise approach to reproduce the results. These steps can be found in collapsible subsections at the end of each respective section. Each step will contain one or more code blocks detailing the required commands or changes.
| Code blocks are preceded by captions that specify the location or context of the provided code. This caption might refer to a particular file in the MTE library, such as:

.. code-block:: python
   :caption: /main/MTE.py
   :linenos:


| In such cases, the line numbers in the code block correspond directly to the line numbers in the specified file. Changes or additions are highlighted for ease of reference.

.. note::
   When the lines of code relevant to the step are located in an if statement, the if statement will be stated as the first line in a codeblock (for clarification). However, there might be several lines of code not included in the snippet between this if statement and the relevant code section. Hence, the line numbering in this snippet can not be fully correct. We have made sure the line numbering is always correct on the section of code containing the (highlighted) lines that need to be changed. Consequently, the line number of the if statement might in some cases be incorrect.


| Alternatively, the caption might indicate a terminal (or Spyder console [#]_) command executed within a certain directory:

.. code-block::
   :caption: /main/


| Regarding data visualization, we supply scripts for two different plotting tools: gnuplot and matplotlib. While both scripts are designed to generate similar outputs, it is worth noting that gnuplot was our primary tool for this project. As such, the plots it produces are considered the most accurate visual representation of our data. When encountering two code blocks placed side by side, this denotes the flexibility to use your preferred plotting tool:

+----------------------------------+-----------------------------------+
|.. code-block::                   |.. code-block::                    |
|   :caption: /main/benchmark_1/   |   :caption: /main/benchmark_1/    |
|                                  |                                   |
|                                  |                                   |
+----------------------------------+-----------------------------------+

| In instances where specific commands are executed repeatedly, a single caption will precede all such repetitive steps:

.. code-block::
   :caption: /main/


.. code-block::


| Please make sure to read any notes, as they highlight important steps that may be different from the standard procedures.

| Any modifications to the code and accompanying data not mentioned within these steps might produce unverified results. Should you make such alterations, please meticulously reviews all comments in the code and consult the :doc:`functions` documentation.

.. rubric:: Footnotes

.. [#]  If you are using Spyder, make sure to add the `Spyder-terminal <https://docs.spyder-ide.org/current/plugins/terminal.html/>`_ plugin.