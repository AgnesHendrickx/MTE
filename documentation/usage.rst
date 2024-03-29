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

1. :py:mod:`magnetostatics`: This module mainly involves the translation of the original Fortran77 code from :cite:`BLAKELY`.
2. :py:mod:`tools`: This module contains functions to generate vtu files for visualization.
3. :py:mod:`support`: This module houses several functions related to specific model setups.

| The script ``run.sh`` performs a straightforward task: it executes the ``MTE.py`` code, generating output both in the terminal and writing it in a file named ``log.txt``.
| Additionally, several specific model setups have exclusive modules and (run) scripts, please see respective sections for specific usage of the code: :doc:`benchmarks`, :doc:`flanksim`, :doc:`parameters`, :doc:`artdem` and :doc:`etna`.

Reproducing results
-------------------

| Throughout this documentation, we provide a **stepwise approach** to reproduce the results. These steps can be found in **collapsible subsections** at the end of each respective section. Each step will contain one or more code blocks detailing the required commands or changes.

| Code blocks are preceded by captions that specify the location or context of the provided code. This caption might refer to a particular file in the MTE library, such as:

.. code-block:: python
   :caption: **/main/MTE.py**
   :linenos:


| In such cases, the line numbers in the code block correspond directly to the line numbers in the specified file. Changes or additions to the base version are highlighted for ease of reference.

.. note::
   Highlighted lines are changes from the last setup outlined in previous steps or sections, if any preceding steps or section were not performed, make sure to check all lines for changes to the base code [#]_.

| Alternatively, the caption might indicate a terminal (or Spyder console [#]_) command executed within a certain directory:

.. code-block::
   :caption: **/main/** (runtime: ~10 s)

| In steps were computation time is expected to be significant, an estimate of the computation time is stated in the caption [#]_.

| If testing required several changes to the same file, more concise code blocks side by side are used. So, when encountering two code blocks placed side by side **in the model setup steps**, this denotes multiple runs with different setups, each subsequent code block listed only once within that step should be performed repeatedly for all setups.
| Any changes from the previous step are again highlighted for ease of reference.
+----------------------------------+-----------------------------------+
|.. code-block::                   |.. code-block::                    |
|   :caption: **/main/benchmarks/**|   :caption: **/main/benchmarks/** |
|                                  |                                   |
|                                  |                                   |
+----------------------------------+-----------------------------------+

| Regarding data visualization, for the benchmarks we supply scripts for two different plotting tools: gnuplot and matplotlib. While both scripts are designed to generate similar outputs, it is worth noting that gnuplot was our primary tool for this project. As such, the plots it produces are considered the most accurate visual representation of our data. When encountering two code blocks placed side by side **in the plotting steps**, this denotes a choice to use your preferred plotting tool.

| In instances where specific commands are executed multiple times consecutively, a single caption will precede all such repetitive steps:

.. code-block::
   :caption: **/main/**


.. code-block::


|

.. note::
   Any modifications to the code and accompanying data not mentioned within these steps might produce unverified results. Should you make such alterations, please meticulously reviews all comments in the code and consult the :doc:`functions` documentation.

.. rubric:: Footnotes

.. [#]  The base code is the version of ``MTE.py`` on github.
.. [#]  If you are using Spyder, make sure to add the `Spyder-terminal <https://docs.spyder-ide.org/current/plugins/terminal.html/>`_ plugin.
.. [#]  Time estimate done with OS: ubuntu 22.04.3, with processor: Intel® Core™ i5-8250U CPU @ 1.60GHz × 8, and with RAM: 8,0 GiB.

