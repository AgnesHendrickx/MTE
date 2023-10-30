Computational approach
======================

| From the :ref:`previous section<GE>`, we know the generated magnetic field :math:`\mathbf{B_a}` of an object with volume :math:`V` can be defined as the surface integral of each volume element :math:`\mathit{dv'}` holding a dipole moment equal to :math:`\mathbf{M} \mathit{dv'}`. What follows is the general outline and the step wise procedure of the Finite Element Model (FEM) presented in this study that solves this integral equation. As terminology can be confusing when comparing (field) data to (model) data, we will use the following terms and nouns to refer to each: 
| '*measurement points*' = the points and location at which in the field was '*measured*'. 
| '*observation points*' = the points and location at which the model '*computed*' the values, can be equal to measurement points. 

| First, a 3D domain :math:`\Omega` , containing an uniform magnetization, is tessellated into multiple elements, where the amount of elements in each direction define the resolution. This produces a mesh, composed of hexahedron elements defined by eight nodes and 6 surfaces, with nodes numbered in a clockwise fashion, see :doc:`app2`. Each element now represents a volume of uniform magnetization. 

| Next, as our main objective is to investigate the effect of the underlying topography, we simulate the domain's topography of the domain three different ways:

    * An (approximation by) equation (in this study: flank simulations of wavy topography on a volcano)
    * Obtaining elevation data from a DEM (in this study: a 2x2m and 5x5m DEM)

| The first method allows for model output validation (see :doc:`benchmarks`), parameter determination for further testing and flank simulations. The other two methods serve to compare computed results to field data, with the last method only used if an adequate DEM was absent. Once the 2D surface topography is generated, the 3D domain is placed below and elements are reshaped if necessary. In the second method the resolution of the domain is limited by the resolution of the DEM used. 
| 
| Next, the magnetic anomaly at observation point ``P`` produced by an element is computed using the surface integral (second part of eq. :eq:`Bsumfinal`) with the method proposed by :cite:`BLAKELY`. A Python function :func:`magnetostatics.facmag`, mirroring their original Fortran 77 subroutine, calculates the magnetic anomaly of an arbitrary polyhedron when iteratively applied to all its faces. The approach, grounded largely in :cite:`Bott63`'s work, resolves the surface integral by projecting onto triangles connecting the facet intersection with a perpendicular line through ``P`` (illustrated in :cite:`BLAKELY`), weighting triangles by their proximity to ``P``. 
| A spatial problem, where ``P`` lies on the facet plane, is mitigated by introducing a small (:math:`\epsilon=1e^{-20}`)  as the 'distance' from the face for computations :cite:`BLAKELY`.
| Ultimately, the function's repeated calls for every side of all elements sums the magnetic contribution across the 3D domain to calculate (:math:`\mathbf{B_a (r)}`) in ``P``, see :numref:`figmodel`, see fuction :func:`magnetostatics.compute_B_surface_integral_cuboid`. 
| After generating topography on both (or either) the top and bottom surfaces, nodes of these elements might not reside in one plane. So, each element's top and bottom surface is subdivided into four additional triangles, for a total of 12 faces and 10 nodes defining an element, see function :func:`magnetostatics.compute_B_surface_integral_wtopo`. 
| This introduces more singularities leading to spatial problems similar to before, if a observation point ``P`` is located on a diagonal of the additional triangles on the top (or bottom) face of the hexahedron elements. A function, :func:`support.shift_observation_points_edge`, was designed to shift the x-coordinate of any observation points near the diagonals of any elements with a small (:math:`\epsilon=1e^{-6}`). 

| Once the ambient field produced by the underlying lava flow is obtained, the induction of the Earth's magnetic field at ``P`` can be added. Finally, the intensity (:math:`\mathbf{B}`), inclination (:math:`I`) and declination (:math:`D`) of the (total) magnetic field above the flow were calculated from the magnetic field components :cite:`TAUXE`, see function :func:`support.add_referencefield`. 

| Rooted in defining an element as a single dipole (eq. :eq:`sd`), this method assumes that volume elements are 'small enough' and the distance to ``P`` is 'large' :cite:`GRIFFITHS`, with its applicability, particularly for mesh elements closest to ``P``, hinging on a constant magnetization assumption, which theoretically renders the elemental size irrelevant :cite:`BLAKELY`. Furthermore, :cite:`JACKSON` determines distance-related concerns are negligible unless ``P`` lies within a few molecular diameters of a uniformly magnetized element. Hereby rendering the assumption a valid one, in line with comparable studies :cite:`Baag95`.

| It is important to mention that ``MTE.py`` contains sections of commented-out code _[#] that implement a volume integral computation method, a fully functional segment of the code. This approach solves :eq:`sd` after inserting :eq:`Magnetization` by using a Gaussian quadrature method. The results using this method were similar to those computed using the surface integral method when testing the :doc:`benchmarks`. Nevertheless, the substantial computational demands of resolving a volume integral, when compared to a surface integral, resulted in the discontinuation of this method for reproducing the field sites. 

.. rubric:: Footnotes

.. [#] There are also lines of code to include the volume integral values when exporting the computed values for visualization and plotting for the relevant sections.  _
