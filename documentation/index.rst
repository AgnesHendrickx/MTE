.. MTE documentation master file, created by
   sphinx-quickstart on Thu Sep  7 16:49:44 2023.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

Welcome to MTE's documentation!
===============================
| MTE is a Python library crafted to compute the magnetic field above (:math:`> 0.1` m) various topographies. Topographies can be simulated using either an analytical equation or a Digital Elevation Model (DEM). The code is available for download `GitHub <https://github.com/AgnesHendrickx/MTE/>`_. The primary purpose is to compute magnetic anomalies in the ambient magnetic field above topographies for investigating their effect on the paleomagnetic records.
| This documentation is designed to serve as a comprehensive guide to both theoretical and practical applications of the MTE library.


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
|                            | illustrates the replication of field values from the study of :cite:`Meyer24`.                                   |
+----------------------------+------------------------------------------------------------------------------------------------------------------+

Reproduction
------------
| For most sections, a stepwise method to reproduce the presented results is given. These are located in collapsible sections at the end of each subsection. Please make sure to read the :doc:`usage` section beforehand.

Contact
------------
For any bugs or questions, please contact: a.e.hendrickx@uu.nl 
