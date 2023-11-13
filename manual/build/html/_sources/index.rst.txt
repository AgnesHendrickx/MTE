.. MTE documentation master file, created by
   sphinx-quickstart on Thu Sep  7 16:49:44 2023.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

Welcome to MTE's documentation!
===============================
| MTE is an advanced Python library meticulously crafted to calculate the magnetic field proximately above the topography (~1 meter), as defined by either an analytical equation or a Digital Elevation Model (DEM). The code is available for download `GitHub <https://github.com/AgnesHendrickx/MTE/>`_, offering a comprehensive suite of tools for geophysical analysis and simulation, tailored for precision and ease of use in professional environments. The primary purpose is to compute magnetic anomalies in the ambient magnetic field above topographies for investigating their effect on the paleomagnetic records.
| This documentation is designed to serve as a comprehensive guide to both theoretical and practical applications of the MTE library.


.. note::
   this project is under active development.

+----------------------------+------------------------------------------------------------------------------------------------------------------+
|.. toctree::                |For a thorough understanding of the MTE library,                                                                  |
|   :maxdepth: 2             | begin with the :doc:`usage` section which provides essential details on :ref:`installation <installation>`.      |
|   :caption: Contents       |Dive into the :doc:`governing_equations`                                                                          |
|                            | to grasp the theoretical underpinnings of the code.                                                              |
|   usage                    |Proceed to the :doc:`computational_approach`                                                                      |
|   governing_equations      | for insight into the numerical framework that drives our simulations.                                            |
|   computational_approach   |Discover the validation process through four comprehensive :doc:`benchmarks`,                                     |
|   benchmarks               | where the methodology for accurate reproduction of computed values is also outlined.                             |
|   parameters               |Insights into optimizing model :doc:`parameters` such as mesh resolution and domain extent are shared,            |
|   flanksim                 | showing the process of refinement for enhanced simulation accuracy.                                              |
|   artdem                   |The :ref:`flank simulations <flanksim>` section presents a case study on applying synthetic topography,           |
|   etna                     | again offering a walkthrough of the setup process.                                                               |
|                            |Next, uncover the process of integrating a :ref:`DEM <art_dem>` into the model, from generating an artificial DEM |
|   functions                | using pseudo-fractals to incorporating real-world terrain and field paths.                                       |
|   ref                      |                                                                                                                  |
|   app1                     |Finally, the :ref:`Etna <etna>` section                                                                           |
|                            | illustrates the replication of field values from the study of :cite:`Meyer23`.                                   |
+----------------------------+------------------------------------------------------------------------------------------------------------------+

Reproduction
------------
| For most sections, a stepwise method to reproduce the presented results is given. These are located in collapsible sections at the end of each subsection. Please make sure to read the :doc:`usage` section beforehand.
|


.. todolist::
