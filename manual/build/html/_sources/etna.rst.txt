.. _etna:

Case study: Mount Etna
======================
| Additionally, two other optional modules are available exclusively for the Mount Etna case study, where the field sites from :cite:`Meyer23` are reproduced:

1. :mod:`set_measurement_parameters.py`: This module provides DEM, site and path-specific values such as the file to read, the location and number of measurement points, IGRF (International Geomagnetic Reference Field) values for the site, and more. See :doc:`functions` for more details.
2. ``etna.py``: This module you define input parameters, to run different options reproducing field paths, to call :mod:`set_measurement_parameters.py`


Finally, there are two scripts, ``script_etna_full.sh`` and ``script_etna.sh``, that automatically modify ``etna.py``.

| To run all (optimized) setups for case study Mount Etna (reproducing) field sites use ``script_etna_full``.


| Run DEM simulation:

.. code-block::
   :caption: **/main/** (runtime: ~30 min)

   ./script_etna_full


.. todo:: finish this section

..
   \subsubsection{Topography from Digital Elevation Models at field paths}
   The 2x2m spatial resolution DEM \cite{ATA} is geo-referenced using the ROMA 40/EST - EPSG 3004 in Gauss–Boaga projection. We converted the 2m DEM to WGS84 UTM 33N in ArcGIS Pro using bilinear interpolation. This 2m DEM is publicly accessible through the web-sphere of SITR. While detailed information regarding data acquisition methods is absent, it is understood that the original data source was LiDAR. In contrast, the 5x5m spatial resolution DEM presented in \cite{Bisson16} is geo-referenced using the WGS84 UTM 33N System, boasting a vertical accuracy with a root-mean-square-error of $\pm 0.24 m$. This DEM is derived from data obtained using airborne LiDAR. Regarding the 5m DEM, it is stated that the DEM was obtained by resampling of an original 2m DEM using the nearest neighbors algorithm \parencite{Bisson16}. Subsequently, they conclude that the vertical and horizontal accuracy of the original data is conserved. Both DEMs were cut to different sizes, ranging in spatial extent from 50x50 m to $\sim$2x2km around the sites. While retaining the original 2m accuracy is commendable, working with a 5m DEM inherently restricts us to a 5m resolution, hence capping our potential accuracy. Despite multiple attempts, the original 2m DEM remained elusive, compelling this study to proceed with the 5m DEM.\par
   \par
   To reproduce the field data, a path can be generated based on the GPS coordinates of field data by using the x \& y coordinates from the field path, the height is computed at a constant value above the surface of the DEM. The GPS field data in this study was converted from decimal degrees to the WGS84 UTM 33N system to match the DEMs. The DEM cut's corner x- and y-coordinates were subtracted from the field coordinates, ensuring alignment. The height of the GPS placement on the measuring device, 2m above the surface \parencite{deGroot19}, was subtracted from the field data beforehand.
   \par
   Two different reference fields were added to the computed values: The IGRF at the site or the average on the Etna at the moment of measuring (April 2018) and $\mathbf{B_{ref}}$. The latter is the computed mean of all field data from all paths at one site. Inputting the appropriate site (and path) details triggers an automatic retrieval of the relevant DEM, reference field, IGRF, magnetization, etc.


   \subsection{Visualisation}
   As our final objective is to compare the observed to the measured values, it is desirable to display the computed values in plots that include the field data points and the trajectory of the path. Therefore, the magnetic field above the flow and the height of the elevation will be plotted against the distance between the measurement points. Such plots are easily comparable on all slopes and at all sites. This does affect the reliability of the displayed topography in these plots; only if the path is perpendicular to the slope would this display the topography perfectly. Undoubtedly, this was not always possible or achieved in the field. However, as one of the selection criteria for the paths was for it to be perpendicular to the slope, we trust these plots to hold an accurate representation of the salient topographic features.  \par
   Discrepancies in height data between the DEM and field data are not uncommon. Multiple factors can contribute to such misfit, including inaccuracies in the field data or DEM, multiple coordinate conversions, potential discrepancies between coordinate systems, and more. To quantify this disparity, we computed the height difference across all field path points for both DEMs, averaged them, and then adjusted the field measurement paths accordingly (refer to the code for exact values). Ideally, one constant offset would be applicable across all sites, but this wasn't the reality. Nonetheless, our primary concern is aligning heights for accurate comparison. We aren't particularly invested in identifying the genuine offset or its root cause. Hence, applied offsets might vary by site and were deducted from all field measurement points prior to plotting. Any height offset between values of the 2 and 5m DEM were also compensated in similar fashion. \par
   Additionally, in some instances, a clear spatial misalignment was evident, with the field topography and DEM aligning better after a minor adjustment. Any adjustments made for visualization clarity were applied manually, grounded in enhancing the congruence of topographic features. Whenever modifications were made, the figures are labeled as "shifted", and the original unaltered plots can be found in the appended section.

