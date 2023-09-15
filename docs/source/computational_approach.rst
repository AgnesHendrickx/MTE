Computational approach
==========================

| From the :ref:`previous section<GE>`, we know the generated magnetic field :math:`\mathbf{B_a}` of an object with volume :math:`V` can be defined as the surface integral of each volume element :math:`\mathit{dv'}` holding a dipole moment equal to :math:`\mathbf{M} \mathit{dv'}`. What follows is the general outline and the step wise procedure of the Finite Element Model (FEM) presented in this study that solves this integral equation. As terminology can be confusing when comparing (field) data to (model) data, we will use the following terms and nouns to refer to each: 
| '*measurement points*' = the points and location at which in the field was '*measured*'. 
| '*observation points*' = the points and location at which the model '*computed*' the values, can be equal to measurement points. 

| First, a 3D domain :math:`\Omega` , containing an uniform magnetization, is tessellated into multiple elements, where the amount of elements in each direction define the resolution. This produces a mesh, composed of hexahedron elements defined by eight nodes and 6 surfaces, with nodes numbered in a clockwise fashion, see :doc:`app2`. Each element now represents a volume of uniform magnetization. 

| Next, as our main objective is to investigate the effect of the underlying topography, we simulate the domain's topography of the domain three different ways:

    * An (approximation by) equation (in this study: flank simulations of wavy topography on a volcano)
    * Obtaining elevation data from a DEM (in this study: a 2x2m and 5x5m DEM)
    * Obtaining elevation data from a field measurements (in this study: field data     from :cite:`Meyer23`)

| The first method allows for model output validation (see :doc:`benchmarks`), parameter determination for further testing and flank simulations. The other two methods serve to compare computed results to field data, with the last method only used if an adequate DEM was absent. Once the 2D surface topography is generated, the 3D domain is placed below and cells are reshaped if necessary. In the second method the resolution of the domain is limited by the resolution of the DEM used. 
| 
| Next, the magnetic anomaly at observation point ``P`` produced by an element is computed using the surface integral (second part of eq. :eq:`Bsumfinal`) with the method proposed by :cite:`BLAKELY`. A Python function, mirroring their original Fortran 77 subroutine, calculates the magnetic anomaly of an arbitrary polyhedron when iteratively applied to all its faces. The approach, grounded largely in :cite:`Bott63`'s work, resolves the surface integral by projecting onto triangles connecting the facet intersection with a perpendicular line through ``P`` (illustrated in :cite:`BLAKELY`), weighting triangles by their proximity to ``P``. 
| A spatial problem, where ``P`` lies on the facet plane, is mitigated by introducing a small (:math:`\epsilon=1e^{-20}`)  as the 'distance' from the face for computations :cite:`BLAKELY`. Despite sufficing in simple scenarios, this could yield cumulative errors if ``P`` is positioned precisely over an element boundary. Therefore, such situations are avoided in all our tests. 
| Ultimately, the subroutine's repeated calls for every side of all elements sums the magnetic contribution across the 3D domain to calculate (:math:`\mathbf{B_a (r)}`) in ``P``, see :numref:`figmodel`.
| After generating topography on both (or either) the top and bottom surfaces, nodes of these elements might not reside in one plane. So, each element's top and bottom surface is subdivided into four additional triangles, for a total of 12 faces and 10 nodes defining an element. 
|
| Once the ambient field produced by the underlying lava flow is obtained, the induction of the Earth's magnetic field at ``P`` can be added. Finally, the intensity (:math:`\mathbf{B}`), inclination (:math:`I`) and declination (:math:`D`) of the (total) magnetic field above the flow were calculated from the magnetic field components  :cite:`TAUXE`. 

| Rooted in defining an element as a single dipole (eq. :eq:`sd`), this method assumes that volume elements are 'small enough' and the distance to ``P`` is 'large' :cite:`GRIFFITHS`, with its applicability, particularly for mesh elements closest to ``P``, hinging on a constant magnetization assumption, which theoretically renders the elemental size irrelevant :cite:`BLAKELY`. Distance-related concerns are negligible unless ``P`` lies within a few molecular diameters of a uniformly magnetized element, as determined by :cite:`JACKSON`, rendering the assumption a valid one, in line with comparable studies :cite:`Baag95`.

