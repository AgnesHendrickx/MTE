Functions
=========

Support
-------

.. autofunction:: support.add_referencefield

.. autofunction:: support.topography

.. autofunction:: support.compute_analytical_solution

.. autofunction:: support.is_point_near_diagonal

.. autofunction:: support.shift_observation_points_edge

.. autofunction:: support.read_header



Visualization
-------------

.. autofunction:: tools.export_mesh_3D

.. autofunction:: tools.export_mesh_2D

.. autofunction:: tools.export_mesh_1D

.. autofunction:: tools.export_plane_measurements

.. autofunction:: tools.export_line_measurements

.. autofunction:: tools.export_spiral_measurements

Magnetostatics
--------------

.. autofunction:: magnetostatics.cross

.. autofunction:: magnetostatics.plane

.. autofunction:: magnetostatics.line

.. autofunction:: magnetostatics.facmag

.. autofunction:: magnetostatics.compute_B_surface_integral_cuboid

.. autofunction:: magnetostatics.compute_B_surface_integral_wtopo

.. autofunction:: magnetostatics.compute_B_surface_integral_wtopo_noise

Set measurement parameters
--------------------------
.. autofunction:: set_measurement_parameters.set_measurement_parameters


.. rubric:: Footnotes

.. [#] These rough sizes are rounded off values, in case the DEM cut was not square, the value denotes the rounded length of the **shortest** side of the DEM.