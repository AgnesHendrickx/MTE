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

| However, upon adapting domain depth, a complication surfaces: the exact nature of the magnetization in the underlying flows and deeper is unknown. Nonetheless, we continue to assume a uniform magnetization. This assumption now expands deeper, eventually stretching to the full pile of volcanic flows of Mount Etna. To validate this assumption, we refer to the geomagnetic history of Mount Etna. The last reversal of Earth's magnetic field was dated around :math:`\sim795` ka ago :cite:`Singer19` and the first volcanic activity of Mount Etna was dated around :math:`\sim500` ka ago :cite:`Branca08`.
| Therefore, no reversals are anticipated within the accumulated layers, allowing us to extend the depth for experimental purposes without restrictions. Nonetheless, as the directly underlying flow is deemed to exert the most substantial influence, expanding the depth beyond a singular flow might be redundant. The thickness of the flows underneath the field sites mentioned in :cite:`Meyer23` fluctuate between 5-15 meter :cite:`Andro05, Mur00`.
| Consequently, our tests explore domain depth ranging from 10 to 140 meter. When it comes to spatial extent, no additional consideration are necessary, and so our experiments span a spatial extent from 50 to 1000 meters.
