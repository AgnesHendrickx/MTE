import random

import numpy as np


###################################################################################################
# this function adds reference field to measurements and computes Pmag Int,Inc,Dec


def add_referencefield(B0_name, npath, dmeas, B0, B_si, benchmark):
    """
    This function returns total computed magnetic field, along with its intensity, inclination
    and declination at all points on a specified path using the following steps:,

    1. Rotating the vector from the model's coordinate system to align with the paleomagnetism coordinate system.
    2. Incorporating a (global) reference field, denoted as B0.
    3. Applying standard paleomagnetic equations for calculation as referenced in :cite:`TAUXE`.

    Subsequently, the function outputs the individual (x,y,z) components of the total magnetic field, as well as the calculated intensity, inclination, and declination values. These results are saved into a file titled: ``measurements_path_refField{BO_name}.ascii``

    :param B0_name: name of reference field (used in writing file).
    :type B0_name: str
    :param npath: amount of points on path.
    :type npath: scalar(int)
    :param dmeas: 1D array(npath) containing distance between two points of the path (from meyer), used for plotting.
    :type dmeas: array_like(float)
    :param B0: 1D array(3) containing 3 components (0=x;1=y;2=z), components of reference field to be added.
    :type B0: array_like(float)
    :param B_si: 2D array(3,npath), containing components (0=x;1=y;2=z,npath) of the computed magnetic field due to the underlying magnetized matter (anomalous field) at each point of the path.
    :type B_si: array_like(float)
    :param benchmark: number associated with benchmark, see :doc:`benchmarks`.
    :type benchmark: str
    :return:
        - **B_siB0** *(array_like(float))* - 2D array(3,npath), containing components (0=x;1=y;2=z,npath) of the total magnetic field (anomalous + reference field) at each point of the path.
        - **In_siB0** *(array_like(float))* - 1D array(npath), containing intensity of the total magnetic field (anomalous + reference field) at each point of the path.
        - **Ic_siB0** *(array_like(float))* - 1D array(npath), containing inclination of the total magnetic field (anomalous + reference field) at each point of the path.
        - **Dc_siB0** *(array_like(float))* - 1D array(npath), containing declination of total magnetic field (anomalous + reference field) at each point of the path.

    """

    linefile1 = open(f"measurements_path_refField{B0_name}.ascii", "w")
    linefile1.write("# 1    , 2      , 3      , 4      , 5      , 6      , 7       \n")
    linefile1.write("# dmeas, Bx_siB0, By_siB0, Bz_siB0, In_siB0, Ic_siB0, Dc_siB0 \n")

    B_siB0 = np.zeros((3, npath), dtype=np.float64)
    In_siB0 = np.zeros((npath), dtype=np.float64)
    Ic_siB0 = np.zeros((npath), dtype=np.float64)
    Dc_siB0 = np.zeros((npath), dtype=np.float64)
    for i in range(0, npath):
        B_siB0[0,i] = B_si[1,i] + B0[0]  # adding B0 in pmag coor + B_si in model coor
        B_siB0[1,i] = B_si[0,i] + B0[1]
        B_siB0[2,i] = -B_si[2,i] + B0[2]

        In_siB0[i] = np.sqrt(B_siB0[0,i]**2 + B_siB0[1,i]**2 + B_siB0[2,i]**2)
        Ic_siB0[i] = np.arctan2(B_siB0[2,i], np.sqrt(B_siB0[0,i]**2 + B_siB0[1,i]**2)) / np.pi * 180
        Dc_siB0[i] = np.arctan2(B_siB0[1,i], B_siB0[0,i]) / np.pi * 180

        if benchmark == '4':
           linefile1.write("%e %e %e %e %e %e \n" %(B_siB0[0,i], B_siB0[1,i], B_siB0[2,i],\
                                                    In_siB0[i], Ic_siB0[i], Dc_siB0[i]))
        else:
           linefile1.write("%e %e %e %e %e %e %e \n" %(dmeas[i],\
                                                       B_siB0[0,i], B_siB0[1,i], B_siB0[2,i],\
                                                      In_siB0[i], Ic_siB0[i], Dc_siB0[i]))
    return B_siB0, In_siB0, Ic_siB0, Dc_siB0

###################################################################################################
# this function returns a topography value at each point x,y passed as argument


def topography(x, y, A, llambda, dir, slopex, slopey):
    """
    Returns topography (height) value at each point defined by x,y coordinates passed.

    :param x: x coordinate of computation point.
    :type x: scalar(float)
    :param y: y coordinate of computation point.
    :type y: scalar(float)
    :param A: amplitude of sine function used to approximate wavy topography of ridges and gullies.
    :type A: scalar(float)
    :param llambda: wavelength of sine function used to approximate wavy topography of ridges and gullies.
    :type llambda: scalar(float)
    :param cos_dir: cosine of ``direction``, that defines the direction of the wave function along the surface (default = perpendicular to slope).
    :type cos_dir: scalar(float)
    :param sin_dir: sine of ``direction``, that defines the direction of the wave function along the surface (default = perpendicular to slope).
    :type sin_dir: scalar(float)
    :param slopex: the tangent of the angle (in rad) of the surface that defines the slope in x direction for each respective side.
    :type slopex: scalar(float)
    :param slopey: the tangent of the angle (in rad) of the surface that defines the slope in y direction for each respective side.
    :type slopey: scalar(float)

    :return:
        - **h_fs** *(scalar(float))* - the height value for the point passed to function for the respective position on the flank (chosen by ``subbench``).

    """
    cos_dir = np.cos(dir)
    sin_dir = np.sin(dir)

    if llambda == 0:
       pert1 = 0
    else:
       pert1 = A * np.sin(2 * np.pi / llambda * (x * cos_dir + y * sin_dir))
    pert2 = slopex * x + slopey * y
    return pert1 + pert2

###################################################################################################
# returns analytical solution (vector B)


def compute_analytical_solution(x, y, z, R, Mx, My, Mz, xcenter, ycenter, zcenter, benchmark):
    """
    Returns analytical solution, see :doc:`benchmarks`, of the components of the magnetic field for each benchmark.

    :param x: 1D array(npath) containing x coordinate of each computation point.
    :type x: array_like(float)
    :param y: 1D array(npath) containing y coordinate of each computation point.
    :type y: array_like(float)
    :param z: 1D array(npath) containing z coordinate of each computation point.
    :type z: array_like(float)
    :param R: radius of the sphere (if applicable)
    :type R: scalar(float)
    :param Mx: x component magnetization of magnetized body (constant).
    :type Mx: scalar(float)
    :param My: y component magnetization of magnetized body (constant).
    :type My: scalar(float)
    :param Mz: z component magnetization of magnetized body (constant).
    :type Mz: scalar(float)
    :param xcenter: x coordinate of center of the sphere.
    :type xcenter: scalar(float)
    :param ycenter: y coordinate of center of the sphere.
    :type ycenter: scalar(float)
    :param zcenter: z coordinate of center of the sphere.
    :type zcenter: scalar(float)
    :param benchmark: number associated with benchmark, see :doc:`benchmarks`.
    :type benchmark: str

    :return:
         - **h_fs** *(array_like(float))* - 2D array(3,npath) containing components (0=x;1=y;2=z) produced by the analytical solution for the magnetic field for chosen benchmark (and model setup) and each point.

    """

    #-----------------------------------------------------------------
    if benchmark == '1':
       mu0 = 4 * np.pi *1e-7
       V = 4 / 3 * np.pi * R**3
       r = np.sqrt((x - xcenter)**2 + (y - ycenter)**2 + (z - zcenter)**2)
       #M aligned with Z-axis
       Bx = 0
       By = 0
       Bz = 2 * mu0 * V / 4 / np.pi / r**3 * Mz

    #-----------------------------------------------------------------
    if benchmark == '3':
       r = np.sqrt((x - xcenter)**2 + (y - ycenter)**2 + (z - zcenter)**2)
       theta = np.arccos((z - zcenter) / r)
       phi = np.arctan2((y - ycenter), (x - xcenter))
       mu0 = 4 * np.pi * 1e-7
       Q = (R / r)**3 * mu0 / 3
       rux = np.sin(theta) * np.cos(phi)
       ruy = np.sin(theta) * np.sin(phi)
       ruz = np.cos(theta)
       thux = np.cos(theta) * np.cos(phi)
       thuy = np.cos(theta) * np.sin(phi)
       thuz = -np.sin(theta)
       Bx = Q * Mz * (2 * (rux * np.cos(theta)) + thux * np.sin(theta))
       By = Q * Mz * (2 * (ruy * np.cos(theta)) + thuy * np.sin(theta))
       Bz = Q * Mz * (2 * (ruz * np.cos(theta)) + thuz * np.sin(theta))

    return np.array([Bx,By,Bz], dtype=np.float64)
# returns analytical solution (vector B)

###################################################################################################


def is_point_near_diagonal(x, y, Lx, Ly, eps):
    """
    | This function checks if a point (x, y) is near to either of the two diagonals of a rectangle with sides of length Lx and Ly.
    | Distance units are irrelevant but must be consistent.

    :param x: x-coordinate of the observation point.
    :type x: scalar(float)
    :param y: y-coordinate of the observation point.
    :type y: scalar(float)
    :param Lx: length of the edge of a rectangle along the x-axis.
    :type Lx: scalar(float)
    :param Ly: length of the edge of a rectangle along the y-axis.
    :type Ly: scalar(float)
    :param eps: tolerance value for proximity check.
    :type eps: scalar(float)

    :return:
        - **bool** *(bool)* - True if (x, y) is near (<eps) to either diagonal, False otherwise.

    """

    # Slopes of the two diagonals
    m1 = -Ly / Lx
    m2 = Ly / Lx

    # Constants for line equations of the form Ax + By + C = 0
    # For the two diagonals:
    # y = m1 * x becomes: -m1*x + y = 0 => A1=-m1, B1=1, C1=0
    # y = m2 * x becomes: -m2*x + y = 0 => A2=-m2, B2=1, C2=0

    A1, B1, C1 = -m1, 1, 0
    A2, B2, C2 = -m2, 1, 0

    # Calculating distances from point to both diagonals
    d1 = abs(A1 * x + B1 * y + C1) / (A1**2 + B1**2) ** 0.5
    d2 = abs(A2 * x + B2 * y + C2) / (A2**2 + B2**2) ** 0.5

    # Check if (x, y) is close to either diagonal
    return d1 < eps or d2 < eps

###################################################################################################


def shift_observation_points_edge(x, y, Lx, Ly, nelx, nely, nelz, xm, ym):
    """
    | The original subroutine of :cite:`BLAKELY`, was initially designed exclusively for use with the faces of a polyhedron. In contrast, our model s subdivides the top and bottom of the hexahedron elements into four triangles, see :func:`magnetostatics.compute_B_surface_integral_wtopo`. This introduces additional singularities, and thus spatial issues, if the observation point ``p`` lies on the diagonal of the top or bottom face of an element.
    | This function adjusts observation points positioned near the diagonal of additional triangles on the top (or bottom) of a hexahedron cell.
    | This function uses :func:`support.is_point_near_diagonal`, passing the length of an element in the x- and y-direction, and the x- and y- coordinates of each observation point with the x-coordinate and y-coordinate of each node on the top surface (see nnz-1) subtracted. This ensures testing of proximity to the diagonals of all elements. The function is designed to stop after first modification, as within macroscopic purposes we do not expect an observation point to be shifted to another diagonal. Afterwards, it states any modification within the "message".
    | Both x- and y-coordinates are shifted using a random value between -1 and 1 times the artificial distance (factor).
    | This spatial problem isn't restricted to the domain bounds. While generating an artificial distance for singularities within the main calculation function (:func:`magnetostatics.facmag`) similar to the solution of :cite:`Bott63,BLAKELY` for edge alignment, would be preferred. The problem emerges from our decision to utilize the :func:`magnetostatics.facmag` in this particular manner (by subdividing the top and bottom into additional triangles). Since this setup is invoked via an external function, and because it falls outside the scope of the function’s original intention (to handle planes as polyhedron sides), we have opted to create this external function as well. Furthermore, there are several setups that do not require subdivision, and subsequently use the :func:`magnetostatics.compute_B_surface_integral_cuboid`, hence shifting there could only potentially introduce inaccuracies. This is avoided by the introduction of this function, only called for in case function :func:`magnetostatics.compute_B_surface_integral_wtopo` is employed, see :doc:`benchmarks`,:doc:`flanksim`,:doc:`etna`.

    | Benchmarks have established that the epsilon should be at least of a factor **1e-5** or larger. It is important to note that this value is not dynamically scaled and should be treated with careful consideration, particularly if there are any modifications to the core implementation of the model.

    :param x: 1D array(NV) containing the x-coordinate of each domain nodes.
    :type x: array_like(float)
    :param y: 1D array(NV) containing the y-coordinate of each domain nodes.
    :type y: array_like(float)
    :param Lx: length of domain along the x-axis.
    :type Lx: scalar(float)
    :param Ly: length of domain along the y-axis.
    :type Ly: scalar(float)
    :param nelx: amount of elements (domain) in x-direction.
    :type nelx: scalar(int)
    :param nely: amount of elements (domain) in y-direction.
    :type nely: scalar(int)
    :param nelz: amount of elements (domain) in z-direction.
    :type nelz: scalar(int)
    :param xm: x-coordinate of the observation point.
    :type xm: scalar(float)
    :param ym: y-coordinate of the observation point.
    :type ym: scalar(float)

    :return:
        - **xm** *(scalar(float))* - adjusted x coordinate of the observation point.
        - **ym** *(scalar(float))* - adjusted x coordinate of the observation point.

        - **message** *(str))* - message indicating any adjustments made to the observation point.

    """

    nnx, nny, nnz = nelx + 1, nely + 1, nelz + 1  # number of nodes, x,y,z- direction

    counter = 0
    message = "These observation points have been shifted:"
    eps = 1e-5  # m
    for i in range(0, nnx):
        for j in range(0, nny):
            for k in range(0, nnz):
                if k == nnz - 1:  # adjusting to check the last element
                    if (
                        is_point_near_diagonal(
                            xm - x[counter], ym - y[counter], Lx / nelx, Ly / nely, eps
                        )
                        and message == "These observation points have been shifted:"
                    ):
                        xm += random.uniform(-1, +1) * eps
                        ym += random.uniform(-1, +1) * eps
                        #xm += eps
                        message += f"x-coordinate was shifted by {eps} meters, due \
                            to diagonal alignment."
                        break  # exiting the k loop if condition is met,
                                # if statement for message prevents repeated testing.
                counter += 1

    # If message hasn't changed, no points were shifted
    if message == "These observation points have been shifted:":
       message = "No observation points were shifted."

    return xm, ym, message

###################################################################################################


def read_header(topo_file):
    """
    | This function checks if a DEM file has a header, and if so, reads in the values.
    | These values are stored in dictionary {}. Header keys checked for: ncols, nrows, xllcorner, yllcorner, cellsize, and NODATA_value.
    | This function works optimally when the header is in a standardized ASCII format.

    :param topo_file: the opened (with read statement) "topofile", containing the possible header to be read in.
    :type topo_file: string

    :return:
        - **header** *(array_like(string))* - dictionary containing values read in from header.
        - **statement** *(bool))* - bool set to True if the full header was read in completely,\
              in case of an unexpected header term found or no header found, it is set to False.

    """
    header = {}
    header_keys = [
        "ncols",
        "nrows",
        "xllcorner",
        "yllcorner",
        "cellsize",
        "NODATA_value",
    ]

    # Create a backup of current file position to restore later
    initial_position = topo_file.tell()
    # Check if the first line contains 'ncols', indicative of a header
    first_line = topo_file.readline().strip().split()
    topo_file.seek(initial_position)  # Reset the file position

    if len(first_line) == 2 and first_line[0] == "ncols":
       # A header seems to be present. Proceed to read it.
       for _ in range(6):  # Assuming the header consists of 6 lines
           line = topo_file.readline().strip().split()
           if len(line) != 2:
              break
           key, value = line
           if key in header_keys:
              header[key] = float(value)
           else:
              # Unexpected key. Reset file pointer and return
              print("Unexpected key found, header may be incomplete.")
              topo_file.seek(initial_position)
              return False, {}
       # If the header was read successfully, return
       if all(key in header for key in header_keys):
          return True, header

    # If reached here, either no header was present or it was incomplete
    topo_file.seek(initial_position)
    print("header was not found, no values read in")
    return False, {}

###################################################################################################
