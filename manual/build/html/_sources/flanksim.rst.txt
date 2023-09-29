.. _flanksim:

Synthetic topopography: flank simulations
=========================================

.. _fflanksim:
.. figure:: figures/flanks2edit.png
   :class: with-border
   
   Flank simulation on the Etna. (:math:`\mathbf{M}`) = :math:`7.5 [A/m]` (arrows). The slope (:math:`a` in :numref:`fflanksim`) is  :math:`6 ^{\circ}`. The computations of the magnetic field (:math:`\mathbf{B}`) above the flanks are done at point composing either a path or a plane above each flank. The flanks are labeled as displayed. Please note, for visual purposes, a different extent and resolution of the mesh was chosen for the displayed mesh, not adhering the optimized testing setup outlined before and in section :doc:`parameters`.

| Given that the majority of lava flows are located on the flanks of volcanoes, simulating volcanic flanks is a relevant and intuitive starting point for our initial generic modeling setup. While the magnetization direction remains consistent, the dip direction of the surfaces on these flanks varies. 
| 
| To explore the impact of these variances, we established a model setup dedicated to flank simulations, as illustrated in :numref:`fflanksim`. In our approach, the flank topography is emulated by a sine function running perpendicular to the sloped surface. The sine wave resemble the characteristic ridges and gullies of volcanic topography.

.. _bdeg:
.. figure:: figures/bdegflank.png
   :class: with-border
   
   Direction on south flank is :math:`-31 ^{\circ}`, an example of a variation possible while doing flank simulations tests.

Model setup
-----------
| In these simulations, a wide range of parameters can be adjusted to investigate their influence on the magnetic field. These include the surface slope, the amplitude and wavelength of the sine function, and the angle between the sine wave's direction and either the x-axis or y-axis—depending on the flank, as depicted in :numref:`bdeg`.
| 
| For alignment with the :doc:`etna`, parameter used to define the synthetic topography aim to replicate the ridges and gullies of Mount Etna. The estimated amplitude, wavelength, and angle for the slope were :math:`4m`, :math:`25m`, and :math:`6 ^{\circ}`, respectively, were derived from aerial images and Digital Elevation Models (DEMs) of the area around the field sites of :cite:`Meyer23`. 
| Furthermore, the uniform remanent magnetization intensity chosen was :math:`7.5` :math:`[A/m]` with a inclination of :math:`57 ^{\circ}` and a declination of :math:`0 ^{\circ}`. For the rationale of chosen magnetization, see section :doc:`etna`. The Earth's magnetic field for the flank simulation was estimated using an average of all site (:cite:`Meyer23`) values of the IGRF :cite:`IGRF`. 
| 
| Flank simulations were done using a domain of 250x250x20m with 375x375x10 elements (chosen upon careful consideration, see section :doc:`parameters`), with computation done a path of 47 points located one meter above the center of the domain. The sine wave was shifted to create the exact same topography underneath the path at the center of each flanks.

Reproduce
^^^^^^^^^
.. collapse:: How to reproduce the results and figures

   Please note basic setup in :ref:`installation`

   1. In ``MTE.py``, modify benchmark attribution to ``4``:

      .. code-block:: python
         :caption: /main/MTE.py
         :linenos:
         :lineno-start: 24

         benchmark='4'

   2. Run ``subbench`` **south** & move results

      .. code-block:: python
         :caption: /main/MTE.py
         :linenos:
         :lineno-start: 24
         :emphasize-lines: 5 

         benchmark='4'
         ## ONLY BENCHMARK=-1 (ETNA) & BENCHMARK=4 (FLANKSIM) ##
         flat_bottom=True 
         ## ONLY BENCHMARK=4 (FLANKSIM) ##
         subbench='south'

      .. code-block:: console
         :caption: /main$

         $ python3 MTE.py > log.txt   

      .. code-block:: console
         :caption: /main$

         $ mkdir flanksim_parameters/south flanksim_parameters/south/250_250_20 && mv log.txt *.vtu *.ascii flanksim_parameters/south/250_250_20

   3. Run ``subbench`` **east** & move results

      .. code-block:: python
         :caption: /main/MTE.py
         :linenos:
         :lineno-start: 24
         :emphasize-lines: 5 

         benchmark='4'
         ## ONLY BENCHMARK=-1 (ETNA) & BENCHMARK=4 (FLANKSIM) ##
         flat_bottom=True 
         ## ONLY BENCHMARK=4 (FLANKSIM) ##
         subbench='east'

      .. code-block:: console
         :caption: /main$

         $ python3 MTE.py > log.txt   

      .. code-block:: console
         :caption: /main$

         $ mkdir flanksim_parameters/east flanksim_parameters/east/250_250_20 && mv log.txt *.vtu *.ascii flanksim_parameters/east/250_250_20

   4. Run ``subbench`` **north** & move results

      .. code-block:: python
         :caption: /main/MTE.py
         :linenos:
         :lineno-start: 24
         :emphasize-lines: 5 

         benchmark='4'
         ## ONLY BENCHMARK=-1 (ETNA) & BENCHMARK=4 (FLANKSIM) ##
         flat_bottom=True 
         ## ONLY BENCHMARK=4 (FLANKSIM) ##
         subbench='north'

      .. code-block:: console
         :caption: /main$

         $ python3 MTE.py > log.txt   

      .. code-block:: console
         :caption: /main$

         $ mkdir flanksim_parameters/north flanksim_parameters/north/250_250_20 && mv log.txt *.vtu *.ascii flanksim_parameters/north/250_250_20

   5. Run ``subbench`` **west** & move results

      .. code-block:: python
         :caption: /main/MTE.py
         :linenos:
         :lineno-start: 24
         :emphasize-lines: 5 

         benchmark='4'
         ## ONLY BENCHMARK=-1 (ETNA) & BENCHMARK=4 (FLANKSIM) ##
         flat_bottom=True 
         ## ONLY BENCHMARK=4 (FLANKSIM) ##
         subbench='west'

      .. code-block:: console
         :caption: /main$

         $ python3 MTE.py > log.txt   

      .. code-block:: console
         :caption: /main$

         $ mkdir flanksim_parameters/west flanksim_parameters/west/250_250_20 && mv log.txt *.vtu *.ascii flanksim_parameters/west/250_250_20

   6. Go to directory & plot 

      .. code-block:: console
         :caption: /main$

         $ cd flanksim_parameters

      .. code-block:: console
         :caption: /main/flanksim_parameters$

         $ gnuplot flanksim.p
