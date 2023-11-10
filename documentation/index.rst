.. MTE documentation master file, created by
   sphinx-quickstart on Thu Sep  7 16:49:44 2023.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

Welcome to MTE's documentation!
===============================
| MTE is an advanced Python library meticulously crafted to calculate the magnetic field proximately above the topography (~1 meter), as defined by either an analytical equation or a Digital Elevation Model (DEM). The code is available for download `GitHub <https://github.com/AgnesHendrickx/MTE/>`_, offering a comprehensive suite of tools for geophysical analysis and simulation, tailored for precision and ease of use in professional environments.
| This documentation is designed to serve as a comprehensive guide to both theoretical and practical applications of the MTE library.


.. note::
   this project is under active development.

.. todo:: make the list next to the toctree?

.. toctree::
   :maxdepth: 2
   :caption: Contents

   usage
   governing_equations
   computational_approach
   benchmarks
   parameters
   flanksim
   artdem
   etna
   functions
   ref
   app1

|
| For a thorough understanding of the MTE library, begin with the :doc:`usage`  section which provides essential details on :ref:`install <installation>` and project initiation.

| Dive into the :doc:`governing_equations` to grasp the theoretical underpinnings of the code.

| Proceed to the :doc:`computational_approach` for insight into the numerical framework that drives our simulations.

| Discover the validation process through four comprehensive :doc:`benchmarks`, where the methodology for accurate reproduction of computed values is also outlined.

| Insights into optimizing model :doc:`parameters` such as mesh resolution and domain extent are shared, showing the process of refinement for enhanced simulation accuracy.

| Refine your simulations by optimizing model :doc:`parameters` such as mesh resolution and domain extent.

| The :ref:`flank simulations <flanksim>` section presents a case study on applying synthetic topography, offering a walkthrough of the setup process.

| Uncover the process of integrating a :ref:`DEM <art_dem>` into the model, from generating an artificial DEM using pseudo-fractals to incorporating real-world terrain and field paths.

| Finally, the :ref:`Etna <etna>` section illustrates the replication of field values from the study cited as :cite:`Meyer23`


+----------------------------+------------------------------------------------------------------------------------------------------------------+
|.. toctree::                |For a thorough understanding of the MTE library,                                                                  |
|   :maxdepth: 2             |begin with the :doc:`usage` section which provides essential details on :ref:`install <installation>`.            |
|   :caption: Contents       |Dive into the :doc:`governing_equations` to grasp the theoretical underpinnings of the code.                      |
|                            |Proceed to the :doc:`computational_approach` for insight into the numerical framework that drives our simulations.|
|   usage                    |Discover the validation process through four comprehensive :doc:`benchmarks`,                                     |
|   governing_equations      | where the methodology for accurate reproduction of computed values is also outlined.                             |
|   computational_approach   |Insights into optimizing model :doc:`parameters` such as mesh resolution and domain extent are shared,            |
|   benchmarks               | showing the process of refinement for enhanced simulation accuracy.                                              |
|   parameters               |The :ref:`flank simulations <flanksim>` section presents a case study on applying synthetic topography,           |
|   flanksim                 | again offering a walkthrough of the setup process.                                                               |
|   artdem                   |Uncover the process of integrating a :ref:`DEM <art_dem>` into the model, from generating an artificial DEM       |
|   etna                     | using pseudo-fractals to incorporating real-world terrain and field paths.                                       |
|   functions                |Finally, the :ref:`Etna <etna>` section illustrates the replication of field values from the study :cite:`Meyer23`|
|   ref                      |                                                                                                                  |
|   app1                     |                                                                                                                  |
+----------------------------+------------------------------------------------------------------------------------------------------------------+


Reproduction
------------
For most sections, a stepwise method to reproduce the presented results is given. These are located in collapsible sections at the end of each subsection. Please make sure to read the :doc:`usage` section beforehand.


.. todolist::
