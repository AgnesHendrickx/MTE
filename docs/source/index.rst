.. MTE documentation master file, created by
   sphinx-quickstart on Thu Sep  7 16:49:44 2023.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

Welcome to MTE's documentation!
===============================

**MTE** is a Python library written to compute the magnetic field just above (~1m) topography, prescribed by an equation or a DEM. 
Code on `github <https://github.com/AgnesHendrickx/MTE/>`_

.. note::
   this project is under active development.

Contents
--------
.. toctree::
   :maxdepth: 3
   :caption: Contents:

   usage
   governing_equations
   computational_approach
   benchmarks
   flanksim
   parameters
   etna
   functions
   ref
   app1
   app2

| Check out the :doc:`usage` section for further information, including how to :ref:`install <installation>` the project. 
| First, in :doc:`governing_equations` the theoretical basis for the code are stated. 
| Followed by the numerical framework in :doc:`computational_approach`. 
| Next, we will delve into the three distinct :doc:`benchmarks` used to validate the computed values. 
| We will demonstrate not only the results but also the methodology for reproducing them. 
| In the section :doc:`flanksim` we present a case for a setup using synthetic topography.
| A simplified setup of flanksim is used for optimizing :doc:`parameters` of the model setup like mesh resolution, extent of the domain, etc.
| Lastly, we outline the final :doc:`etna` of reprocing field values from :cite:`Meyer23`, again, presenting both results and reproduction methods.  

Reproduction
------------
For more information on how to run different setups and reproduce results, see associated sections: :doc:`benchmarks`, :doc:``




Indices and tables
==================

* :ref:`genindex`
* :ref:`modindex`
* :ref:`search`
