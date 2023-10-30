Case study: Mount Etna
======================
| Additionally, two other optional modules are available exclusively for the Mount Etna case study, where the field sites from :cite:`Meyer23` are reproduced:

1. :func:`set_measurement_parameters.py`: This module provides DEM, site and path-specfiic values suach as the file to read, the location and number of measurement points, IGRF (International Geomagnetic Reference Field) values for the site, and more. See :doc:`functions` for more details.
2. ``etna.py``: This module you define input parameters (see :doc:`etna`), to run different options reproducing field paths, to call :func:`set_measurement_parameters.py`


Finally, there are two scripts, ``script_etna_full.sh`` and ``script_etna.sh``, that automatically modify ``etna.py``, see :doc:`etna` for more information.

| To run all (optimized) setups for case study Mount Etna (reproducing) field sites use ``script_etna_full``.

.. code-block::

   ./script_etna_full


Parameters of Etnean lava flows
-------------------------------
| For both the :ref:`flank simulations <flanksim>` and the final reproduction of the field sites of :cite:`Meyer23` several values were chosen aiming to best simulate Etnean lava flows. What follows is the rationale for these choises.
| The uniform remnant magnetization intensity assigned to the matter was: :math:`7.5` :math:`[A/m]`. This value compares well with both the TRM found in samples taken from the lava flows in the field :cite:`Meyer23` and with previous paleomagnetic studies of Etnean lavas :cite:`Nicolosi14`; a bulk magnetization intensity of :math:`8` :math:`[A/m]` was measured, with values ranging between :math:`5` and :math:`13` :math:`[A/m]`. However, both much lower and higher values have also been reported in other studies, :math:`0.1-1` :math:`[A/m]` and :math:`20` :math:`[A/m]` by :cite:`Tanguy04, Speranza06`, respectively. Clearly displaying the large dispersion of the measurements or values of the magnetization in Etnean lavas. The inclination of the magnetization used in this study is :math:`57 ^{\circ}`. This value was computed from Mount Etna's average latitude using the Geocentric Axial Dipole hypothesis, (:math:`\tan{I} = 2\tan({lat})`). The declination was assumed to be :math:`0 ^{\circ}` (parallel to the present geomagnetic field) and from this the components of the magnetization were calculated.
|
| When a flat bottom is chosen for the :ref:`flank simulations <flanksim>`, the input value for depth of the domain is added in the lowest value from the DEM for the area chosen, to avoid intersection situations as outlined in the note in :ref:`flank simulations <flanksim>`, however, this does if one increases domain depth, it depends on the size of the DEM cut chosen (and thus included features), how much depth is added underneath the path.