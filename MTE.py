import random
import time as time

import numpy as np

from magnetostatics import *
from set_measurement_parameters import *
from support import *
from tools import *

print('========================================')
print('=             ETNA project             =')
print('========================================')
start_fullrun = time.time()

###################################################################################################
# Benchmark:
# 1: Dipole (small sphere, far away), line meas.
# 2a: No perturbation, simple undeformed domain of cubic elements (box), plane and/or line meas.
# 2b: Random perturbation internal nodes cubic or pancake, plane meas.
# 3: Sphere (larger sphere, anywhere in space) analytical, spiral meas.
# 4: A prismatic body, domain with constant M vector.
# 5: Synthetic shapes, wavy surface, domain with constant M vector.
# -1: DEM topography
#
# Observation methods:
# plane: obs points (amount= plane_nnx, plane_nny) in each direction are equally distributed
#        on a plane with sides (length= plane_Lx, plane_Ly) and a corner (coord =
#        plane_x0, plane_y0) and at constant height (height= plane_z0).
#        Produces both ascii files with raw data, and vtu files for visualization.
#        Can be used for benchmark 1,2,5.
# line: obs points (amount= line_nmeas) are equally distributed on a line from starting point
#       (coord = xtart, ystart, zstart) to end point (coord= xend, yend, zend).
#       Produces both ascii files with raw data, and vtu files for visualization.
#       Can be used for benchmark 1,2,4,5.
# spiral: obs points (amount= npts_spiral) are equally distributed on a spiral at constant
#         height (radius_spiral) above a sphere (using Fibonacci spiral).
#         Can be used for benchmark 3.
# path: obs points (amount= npath) are read in from file (pathfile), computationally similar
#       to line meas, but now coordinates are from file.
#       Can be used for benchmark -1.
###################################################################################################
###################################################################################################+

benchmark = '5'

compute_vi = False  # possible for all setups apart from DEM (-1).
if compute_vi:
   nqdim = 4  # number of quadrature points, see documentation.

## ONLY BENCHMARK = -1 (DEM) & BENCHMARK = 5 (FLANKSIM) ##
flat_bottom = True  # if True, a flat bottom is generated at the lower surface of the domain.
                    # Please see documentation, as the specific setup of this feature is different
                    # for the flank simulations and the DEM test.
remove_zerotopo = True  # setup run 2 times: 1st time, zero topography setup: xy coordinates
                        # of the observation points the same, but zerotopo domain and obs path
                        # shifted to average height DEM. 2nd time, "regular" run with topography.
                        # final results are 2nd run - 1 st run values. Run time can be improved,
                        # if 1st run was done with less el (and cuboid function), yet to be done.

## ONLY BENCHMARK = 5 (FLANKSIM) ##
subbench = 'south'  # 'south', 'east', 'north', 'west', shifts topo features, and obs paths.

## ONLY BENCHMARK = -1 (DEM) ##
add_noise = False  # if True, noise is added to the DEM after loading in from file.
Nf = 1.5  # noise amplitude between -Nf and Nf, value added to the z-coor of the middle node
        # on the top/bottom surface. Only relevant if add_noise = True
art_DEM = False  # if True, path/topo file (+ header) produced by art_DEM.py read in.
                # Please note other values specified below for IGRF and magnetization etc.

###################################################################################################
###################################################################################################

if benchmark == '1':
   # General settings ## DO NOT CHANGE ##
   remove_zerotopo = False
   compute_analytical = True  # analytical solution computed and written to files to plot.
   do_spiral_measurements = False  # measurements on a spiral.
   do_path_measurements = False  # measurements on a path.

   # Domain settings
   Lx, Ly, Lz = 2, 2, 2  # length of the domain in each direction.
   nelx, nely, nelz = 100, 100, 100  # amount of elements in each direction.
   Mx0, My0, Mz0 = 0, 0, 7.5  # Magnetization [A/m], do not change Mx0 and My0.

   # Sphere settings
   sphere_R = 1  # Radius of the sphere.
   sphere_xc, sphere_yc, sphere_zc = Lx / 2, Ly / 2, -Lz / 2  # Center position of the sphere.

   # Line measurement settings
   do_line_measurements = True  # do computations along a observation line (path).
   line_nmeas = 100  # amount of observation points for a line.
   xstart, xend = Lx / 2, Lx / 2  # x-coordinates of start and end of observation path.
   ystart, yend = Ly / 2, Ly / 2  # y-coordinates "".
   zstart, zend = 0.01, 2 # zoomed setup.
   #zstart, zend = 0.01, 100  # non-zoomed setup.

   # Plane measurement settings (can be used here)
   do_plane_measurements = False  # do computations on a observation plane.
   plane_nnx, plane_nny = 3, 3  # amount of observation points in each direction.
   plane_x0, plane_y0, plane_z0 = -Lx / 2, -Ly / 2, 1  # corner coordinate for plane.
   plane_Lx, plane_Ly = 2 * Lx, 2 * Ly  # length of observation plane in each direction.

###################################################################################################

if benchmark == '2a':
   # General settings ## DO NOT CHANGE ##
   remove_zerotopo = False
   compute_analytical = False
   do_spiral_measurements = False
   do_path_measurements = False

   # Domain settings
   Lx, Ly, Lz = 10, 10, 10
   nelx, nely, nelz = 5, 5, 5
   Mx0, My0, Mz0 = 0, 0, 7.5  # Magnetization [A/m].

   # Plane measurement settings
   do_plane_measurements = True
   plane_nnx, plane_nny = 11, 11
   plane_x0, plane_y0, plane_z0 = -Lx / 2, -Ly / 2, 1
   plane_Lx, plane_Ly = 2 * Lx, 2 * Ly

   # Line measurement settings
   do_line_measurements = False
   line_nmeas = 47
   xstart, xend = 0.23 + ((Lx - 50) / 2), 49.19 + ((Ly - 50) / 2)
   ystart, yend = Ly / 2 - 0.221, Ly / 2 - 0.221
   zstart, zend = 1, 1  # 1m above surface.

###################################################################################################

if benchmark == '2b':
   # General settings ## DO NOT CHANGE ##
   remove_zerotopo = False
   compute_analytical = False
   do_spiral_measurements = False
   do_path_measurements = False
   do_line_measurements = False

   # Domain settings
   Lx, Ly, Lz = 10, 10, 10
   nelx, nely, nelz = 5, 5, 5
   #nelx, nely, nelz = 2, 10, 50
   Mx0, My0, Mz0 = 0, 0, 7.5
   dz = 0.1  # amplitude random for perturbations in domain.

   # Plane measurement settings
   do_plane_measurements = True
   plane_nnx, plane_nny = 11, 11
   plane_x0, plane_y0, plane_z0 = -Lx / 2, -Ly / 2, 1
   plane_Lx, plane_Ly = 2 * Lx, 2 * Ly

###################################################################################################

if benchmark == '3':
   # General settings ## DO NOT CHANGE ##
   remove_zerotopo = False
   compute_analytical = True
   do_line_measurements = False
   do_path_measurements = False

   # Domain settings
   Lx, Ly, Lz = 20, 20, 20
   #nelx, nely, nelz = 60, 60, 60  # 3 el/m.
   nelx, nely, nelz = 120, 120, 120  # 6 el/m.
   Mx0, My0, Mz0 = 0, 0, 7.5

   # Sphere settings
   sphere_R = 10  # do not change, or change radius_spiral as well.
   sphere_xc, sphere_yc, sphere_zc = Lx / 2, Ly / 2, -Lz / 2

   # Spiral measurement settings
   do_spiral_measurements = True
   npts_spiral = 101  # keep odd
   radius_spiral = 1.025 * sphere_R  # 25 cm above surface sphere.
   #radius_spiral = 1.05 * sphere_R  # 50 cm above surface sphere.

   # Plane measurement settings
   do_plane_measurements = False
   plane_nnx, plane_nny = 30, 30
   plane_x0, plane_y0, plane_z0 = -Lx / 2, -Ly / 2, 0.5
   plane_Lx, plane_Ly = 2 * Lx, 2 * Ly

###################################################################################################

if benchmark == '4':
   # General settings ## DO NOT CHANGE ##
   remove_zerotopo = False
   compute_analytical = False
   do_plane_measurements = False
   do_spiral_measurements = False
   do_path_measurements = False

   # Domain settings
   Lx, Ly, Lz = 10, 10, 10
   nelx, nely, nelz = int(Lx), int(Ly), 10
   Mx0, My0, Mz0 = 0, 0, 200

   # Line measurement settings
   do_line_measurements = True
   line_nmeas = 21
   xstart, xend = 6, 6
   ystart, yend = -25, 25
   zstart, zend = 0, 0

   # Reading in values from Ren.
   pathfile = 'sites/B.dat'
   with open(pathfile, 'r') as path:
        lines_path = path.readlines()
   BxB4, ByB4, BzB4  = np.zeros((3, len(lines_path)), dtype=np.float64)  # Bx, By, Bz from Ren.
   data = np.array([list(map(float, line.split())) for line in lines_path])
   BxB4, ByB4, BzB4 = data[:, 0], data[:, 1], data[:, 2]

###################################################################################################

if benchmark == '5':
   # General settings ## DO NOT CHANGE ##
   do_spiral_measurements = False
   do_path_measurements = False
   compute_analytical = False

   # Domain settings
   Lx, Ly, Lz = 250, 250, 20
   nelx, nely, nelz = int(Lx * 2), int(Ly * 2), 10
   Mx0, My0, Mz0 = 0, 4.085, -6.29
   #Lx, Ly, Lz = 50, 50, 120
   #nelx, nely, nelz = 10, 10, 10


   # Synthetic topography settings
   wavelength = 25
   A = 4
   af = 6

   # Line measurement settings
   do_line_measurements = True
   line_nmeas = 47
   xstart, xend = 0.23 + ((Lx - 50) / 2), 49.19 + ((Ly - 50) / 2)
   ystart, yend = Ly / 2 - 0.221, Ly / 2 - 0.221
   zstart, zend = 0.25, 0.25  # 1m above surface.

   # Plane measurement settings
   do_plane_measurements = False
   plane_nnx, plane_nny = 30, 30
   plane_x0, plane_y0, plane_z0 = -Lx / 2, -Ly / 2, 1
   plane_Lx, plane_Ly = 2 * Lx, 2 * Ly

   #from flanksim import *

   if subbench == 'east':
      slopex = np.tan(-af / 180 * np.pi)  # added height in x-direction due to angle of flank.
      slopey = np.tan(0 / 180 * np.pi)  # added height in y-direction due to angle of flank.
      dir = 90 / 180 * np.pi  # direction of sine function (wavy pattern).
      #xstart, ystart = ystart, xstart  # shifting of obs for each flank, only works if Lx = Ly.
      #xend, yend = yend, xend  # shifting of obs for each flank, only works if Lx = Ly.
      xstart = Lx / 2 - 0.221  # switch around of obs if Lx != Ly.
      xend = Lx / 2 - 0.221
      ystart = 0.23 + ((Ly - 50) / 2)
      yend = 49.19 + ((Ly - 50) / 2)

   if subbench == 'north':
      slopex = np.tan(0 / 180 * np.pi)
      slopey = np.tan(-af / 180 * np.pi)
      dir = 0 / 180 * np.pi

   if subbench == 'west':
      slopex = np.tan(af / 180 * np.pi)
      slopey = np.tan(0 / 180 * np.pi)
      dir = 90 / 180 * np.pi
      #xstart, ystart = ystart, xstart
      #xend, yend = yend, xend
      xstart = Lx / 2 - 0.221
      xend = Lx / 2 - 0.221
      ystart = 0.23 + ((Ly - 50) / 2)
      yend = 49.19 + ((Ly - 50) / 2)

   if subbench == 'south':
      slopex = np.tan(0 / 180 * np.pi)
      slopey = np.tan(af / 180 * np.pi)
      dir = 0 / 180 * np.pi

   IGRF_E = 1561.2e-9  # IGRF component in East direction.
   IGRF_N = 26850.3e-9  # IGRF component in North direction.
   IGRF_D = 36305.7e-9  # IGRF component in Down direction.

   IGRFx = IGRF_N  # Pmag coordinate configuration!
   IGRFy = IGRF_E
   IGRFz = IGRF_D

   #IGRFx = 18034.3 * 1e-9  # Asuncion, Paraguay
   #IGRFy = -4873.9 * 1e-9
   #IGRFz = -11904.4 * 1e-9
   #Mx0, My0, Mz0 = 0, 3.1, 6.2


   IGRFint = np.sqrt(IGRFx**2 + IGRFy**2 + IGRFz**2)  # intensity equation for pmag coord.
   IGRFinc = np.arctan2(IGRFz, np.sqrt(IGRFx**2 + IGRFy**2)) / np.pi * 180  # inclination.
   IGRFdec = np.arctan2(IGRFy, IGRFx) / np.pi * 180  # declination.

###################################################################################################

if benchmark == '-1':
   # General settings ## DO NOT CHANGE ##
   compute_analytical = False
   compute_vi = False

   if art_DEM:
      # General settings
      do_line_measurements = False
      do_plane_measurements = False
      do_spiral_measurements = False
      do_path_measurements = True

      # Domain settings
      Lz = 20
      nelz = 10
      IGRFx = 26850.3e-9  # Pmag coordinate configuration!
      IGRFy = 1561.2e-9  # Mount Etna (peak)
      IGRFz = 36305.7e-9
      Mx0, My0, Mz0 = 0, 4.085, -6.29

      # Path measurement settings
      pathfile = 'sites/art_path.txt'
      print('reading from art_path.txt')
      with open(pathfile, 'r') as path:
         npath = len(path.readlines())
      zpath_height = 1.8  # height above topo
      ho = zpath_height

      # Domain settings from artificial DEM
      topofile = 'DEMS/art_dem.ascii'
      print('reading from art_dem.ascii')
      with open(topofile, 'r') as topo:
           has_header, header = read_header(topo)

      if has_header:
         nnx = int(header['ncols'])
         nny = int(header['nrows'])
         cellsize = header['cellsize']

         nelx = nnx - 1
         nely = nny - 1
         Lx = nelx * cellsize
         Ly = nely * cellsize
      else:  # define values here if no header is present in DEM
         nnx = 31
         nny = 31
         cellsize = 2
         xllcorner = 0
         yllcorner = 0

         nelx = nnx - 1
         nely = nny - 1
         Lx = nelx * cellsize
         Ly = nely * cellsize
   else:
      from etna import *
      #Mx0, My0, Mz0 = 0, 0.545, -0.839
      #Mx0, My0, Mz0 = 0, 4.085, -6.290
      Mx0, My0, Mz0 = 0, 7.080, -10.903
      #Mx0, My0, Mz0 = 0, 10.893, -16.773


###################################################################################################
###################################################################################################

# Standard computations for any setup
nel = nelx * nely * nelz # total number of elements.
nnx = nelx + 1  # number of elements, x direction.
nny = nely + 1  # number of elements, y direction.
nnz = nelz + 1  # number of elements, z direction.
NV = nnx * nny * nnz  # number of nodes.

###################################################################################################
###################################################################################################

# All print statements clarifying chosen options
print('========================================')
print('benchmark=', benchmark)
print('Lx,Ly,Lz=', Lx, Ly, Lz)
print('nelx,nely,nelz=', nelx, nely, nelz)
print('nnx,nny,nnz=', nnx, nny, nnz)
print('nel=', nel)
print('Mx,My,Mz=', Mx0, My0, Mz0)
#print('NV=', NV)
#print('Mx0,My0,Mz0=', Mx0, My0, Mz0)
#print('nqdim=', nqdim)
print('do_plane_measurements=', do_plane_measurements)
if do_plane_measurements:
   print('  plane_x0,y0,z0=', plane_x0, plane_y0, plane_z0)
   print('  plane_Lx,plane_Ly=', plane_Lx, plane_Ly)
   print('  plane_nnx,plane_nny=', plane_nnx, plane_nny)
print('do_line_measurements=', do_line_measurements)
if do_line_measurements:
   print('xstart,ystart,zstart=', xstart, ystart, zstart)
   print('xend,yend,zend=', xend, yend, zend)
   print('line_nmeas=', line_nmeas)
   if benchmark == '5':
       print('subbench, flank=', subbench)
       print('wavelength =', wavelength)
       print('amplitude =', A)
       print('angle flank =', af)
print('do_spiral_measurements=', do_spiral_measurements)
if do_spiral_measurements:
   print('npts_spiral', npts_spiral)
   print('radius_spiral', radius_spiral)
print('do_path_measurements=', do_path_measurements)
if do_path_measurements:
   if not art_DEM:
      print('site=', site)
      print('path=', path)
      print('resolution DEM=', rDEM)
      print('size cut DEM=', sDEM)
   print('height path=', ho, zpath_height)
   print('npts path=', npath)
   print('IGRFx=', IGRFx)
   print('IGRFy=', IGRFy)
   print('IGRFz=', IGRFz)
   print('magnetization (Mx,My,Mz)', Mx0, My0, Mz0)
   if art_DEM:
      print('Artificial DEM generated')
   if add_noise:
      print(f'noise added to DEM with a noise factor of: {Nf}')
   else:
      print('no noise added')
if (benchmark == '-1' or benchmark == '5') and remove_zerotopo:
   print('Zero topography removed from final results.')

print('========================================')

###################################################################################################
# Grid point setup
# If benchmark 2, a small random perturbation is added to the z coordinate of the interior nodes.
###################################################################################################

start = time.time()

x = np.zeros(NV, dtype=np.float64)  # x coordinates
y = np.zeros(NV, dtype=np.float64)  # y coordinates
z = np.zeros(NV, dtype=np.float64)  # z coordinates
if (benchmark == "-1" or benchmark == "5") and remove_zerotopo:
    xb = np.zeros(NV, dtype=np.float64)  # x coordinates
    yb = np.zeros(NV, dtype=np.float64)  # y coordinates
    zb = np.zeros(NV, dtype=np.float64)  # z coordinates

counter = 0
for i in range(0, nnx):
    #print( int(i / nnx * 100)  ,'% done')
    for j in range(0, nny):
        for k in range(0, nnz):
            if benchmark == '4':
               x[counter] = i * Lx / float(nelx) - (Lx / 2)  # centering.
               y[counter] = j * Ly / float(nely) - (Ly / 2)  # centering.
            else:
               x[counter] = i * Lx / float(nelx)  # regular spaced domain.
               y[counter] = j * Ly / float(nely)  # regular spaced domain.

            z[counter] = k * Lz / float(nelz) - Lz  # regular spaced domain, shifted below topo.

            if (benchmark == '-1' or benchmark == '5') and remove_zerotopo:
               xb[counter] = i * Lx / float(nelx)
               yb[counter] = j * Ly / float(nely)
               if benchmark == '5' and flat_bottom:
                  zb[counter] = k * (Lz + ((Ly / 2) * np.tan(af / 180 * np.pi)) + A)\
                       / float(nelz) - Lz - ((Ly / 2) * np.tan(af / 180 * np.pi))\
                        - A  # fb extended to plane Lz below lowest height and shifted.
               else:
                  zb[counter] = k * Lz / float(nelz) - Lz
            if i != 0 and j != 0 and k != 0 and i != nnx - 1 and j != nny - 1 and k != nnz - 1 \
               and benchmark == '2b':
               z[counter] += random.uniform(-1, +1) * dz  # internal perturbations for benchmark.
            counter += 1
print("grid points setup: %.3f s" % (time.time() - start))

###################################################################################################
# Connectivity
###################################################################################################

start = time.time()

icon = np.zeros((8, nel), dtype=np.int32)

counter = 0
for i in range(0, nelx):
    #print(int( i / nelx * 100),'% done')
    for j in range(0, nely):
        for k in range(0, nelz):
            icon[0,counter] = nny * nnz * (i - 1 + 1) + nnz * (j - 1 + 1) + k
            icon[1,counter] = nny * nnz * (i     + 1) + nnz * (j - 1 + 1) + k
            icon[2,counter] = nny * nnz * (i     + 1) + nnz * (j     + 1) + k
            icon[3,counter] = nny * nnz * (i - 1 + 1) + nnz * (j     + 1) + k
            icon[4,counter] = nny * nnz * (i - 1 + 1) + nnz * (j - 1 + 1) + k + 1
            icon[5,counter] = nny * nnz * (i     + 1) + nnz * (j - 1 + 1) + k + 1
            icon[6,counter] = nny * nnz * (i     + 1) + nnz * (j     + 1) + k + 1
            icon[7,counter] = nny * nnz * (i - 1 + 1) + nnz * (j     + 1) + k + 1
            counter += 1
print("grid connectivity setup: %.3f s" % (time.time() - start))

###################################################################################################
# Adding synthetic topography to surface and deform the mesh accordingly.
# The topography function (see documentation) is build to generate the topography from the sine
# wave and the slope mirrored in the path (the height of the middle of the domain is 0).
# Therefore, the exact height of the domain underneath the path is easily computed.
# The zero topo
###################################################################################################

if benchmark == '5':
   start = time.time()

   # compute the minimum topography elevation for all nodes.
   min_topography = min([topography(x_val - Lx / 2, y_val - Ly / 2, A, wavelength, dir, slopex,\
                                     slopey)
                          for x_val, y_val in zip(x, y)])
   print("min topo:", min_topography)

   if flat_bottom:
      # flat bottom generates domain with a bottom surface flat at Lz below the lowest
      # height of the topography of the domain. LLz = local Lz, as this is not constant in domain.
      counter = 0
      for i in range(0, nnx):
          for j in range(0, nny):
              for k in range(0, nnz):
                  LLz = Lz + topography(x[counter] - Lx / 2, y[counter] - Ly / 2, A, wavelength,\
                                         dir, slopex, slopey) - min_topography
                  z[counter] = k * LLz / float(nelz) - Lz + min_topography
                  counter += 1
   else:
      # generates domain with a bottom surface at a depth constant Lz below the (top) topography.
      counter = 0
      for i in range(0, nnx):
          for j in range(0, nny):
              for k in range(0, nnz):
                  z[counter] += topography(x[counter] - Lx / 2, y[counter] - Ly / 2, A,\
                                            wavelength, dir, slopex, slopey)  # adds to reg domain.
                  counter += 1

   print("add synthetic topography: %.3f s" % (time.time() - start))

###################################################################################################
# Adding DEM topo
# Adding topography based on DEM, and reading in measurement points from field data
# uses "etna.py" for importing values.
# The DEM is read in an array "ztopo".
#
# Zero topography for DEM
# It should be noted that the remove_zerotopo is not designed in a universally accurate method.
# The zero_topo domain is generated at a height of average (ztopo) and
# to make the depth of the zero_topo domain match the depth beneath the path (roughly), a method
# that suffices in our case was chosen. However, we hypothesise it might not work optimally in
# other setups. We suggest it likely only works sufficient if the observation paths are located
# roughly in the middle of the (cut) DEM, if the path runs roughly perpendicular to the slope,
# and if the slope of the DEM (within the full spatial extent of the domain) dominates
# over the local topography differences along the path.
# If not, this should be modified into better working function!.
###################################################################################################

if benchmark == '-1':
   # topography based on DEM, measurement points from field data.
   start = time.time()
   with open(topofile, 'r') as topo:
        # reading topofile as topo (needs to be assigned before).
        has_header, header = read_header(topo)
        lines_topo = topo.readlines()

   if has_header:
      # extract header values for later use, if no header, the values should be assigned before.
      nnx = int(header['ncols'])
      nny = int(header['nrows'])
      xllcorner = header['xllcorner']
      yllcorner = header['yllcorner']
      cellsize = header['cellsize']
      NODATA_value = header['NODATA_value']

      nelx = nnx - 1
      nely = nny - 1
      Lx = nelx * cellsize
      Ly = nely * cellsize
      print("header found, values from header read in")

   N = nnx * nny  # amount of nodes on surface
   ztopo = np.zeros(N, dtype=np.float64)
   # shift coordinates of the domain to the spatial coordinates of the DEM.
   x[:] += xllcorner
   y[:] += yllcorner

   counter = 0
   if art_DEM:
      for i in range(0, nny):  # Start from the first line
          line = lines_topo[i].strip()  # Access the line directly
          columns = line.split()
          for j in range(0, nnx):
              ztopo[counter] = columns[j]
              counter += 1
   else:
      for i in range(0, nny):
          # reading lines backwards bc of how file is built.
          line = lines_topo[nny - 1 - i].strip()
          columns = line.split()
          for j in range(0, nnx):
              ztopo[counter] = columns[j]
              counter += 1

   print('add in topofile ok')
   if flat_bottom:
      # flat bottom generates domain with a bottom surface flat at Lz below the lowest value
      # within the topography (DEM). The mean of the ztopo is used both to extent the domain
      # in depth, and to shift. This only works if the obs path is roughly in the middle,
      # runs perpendicular to the slope and if the slope on the areal scale > local topo.
      zmin = np.min(ztopo) # min value of DEM topography.
      counter = 0
      for i in range(0, nnx):
          for j in range(0, nny):
              for k in range(0, nnz):
                  zmax = Lz + ztopo[j * nnx + i]
                  z[counter] = k * (zmax - zmin) / float(nelz) + zmin - Lz
                  #if remove_zerotopo:
                  #   zb[counter] = k * (Lz + np.mean(ztopo)) / float(nelz) - Lz - np.mean(ztopo)
                  counter += 1
   else:
      # generates domain with a bottom surface at a depth constant Lz below the (top) topography.
      counter = 0
      for i in range(0, nnx):
          for j in range(0, nny):
              for k in range(0, nnz):
                  zmax = Lz + ztopo[j * nnx + i]
                  zmin = 0 + ztopo[j * nnx + i]
                  z[counter] = k * (zmax - zmin) / float(nelz) + zmin - Lz
                  counter += 1

   if remove_zerotopo:
      # shift zerotopography domain, height chosen at mean height of the DEM.
      xb[:] += xllcorner
      yb[:] += yllcorner
      #zb[:] += np.mean(ztopo) + min(ztopo)

   print("adding DEM topography to domain: %.3f s" % (time.time() - start))

   # Read in path
   path = open(pathfile, 'r')  # open file to read in path observation point locations and data.
   lines_path = path.readlines()
   nlines = np.size(lines_path)
   print(pathfile + ' counts ', nlines, ' lines')
   print(npath)
   print(nlines)
   xpath = np.zeros(npath, dtype=np.float64)  # x coordinates obs point
   ypath = np.zeros(npath, dtype=np.float64)  # y coordinates obs point
   zpath = np.zeros(npath, dtype=np.float64)  # z coordinates obs point
   if remove_zerotopo:
      zbpath = np.zeros(npath, dtype=np.float64)  # z coordinates path zerotopo
   zpathO = np.zeros(npath, dtype=np.float64)  # z coordinates original
   Ic_m = np.zeros(npath, dtype=np.float64)  # measured inclination
   Dc_m = np.zeros(npath, dtype=np.float64)  # measured declination
   In_m = np.zeros(npath, dtype=np.float64)  # measured intensity (in microT)
   dmeas_m = np.zeros(npath, dtype=np.float64)  # measured distance along path
   for i in range(0, npath):
       # reading lines from pathfile
       line = lines_path[i].strip()
       columns = line.split()
       xpath[i] = columns[1]
       #xpath[i] -= xllcorner + (Lx / 2)  # (centering)
       ypath[i] = columns[2]
       #ypath[i] -= yllcorner + (Ly / 2)  # (centering)
       xpath[i], ypath[i], message = shift_observation_points_edge(x, y, Lx, Ly, nelx, nely,\
                                                                    nelz, xpath[i], ypath[i])
       if not message == "No observation points were shifted.":
          print(counter, message)
       zpath[i] = columns[3]
       zpathO[i] = zpath[i]
       Ic_m[i] = columns[4]
       Dc_m[i] = columns[5]
       In_m[i] = columns[6]
       dmeas_m[i] = columns[7]

   # height values of obs points are based on dem + zpath_height, as height differences are common.
   start = time.time()
   for i in range(0, npath):
       iel = 0
       for ielx in range(0, nelx):
           for iely in range(0, nely):
               for ielz in range(0, nelz):
                   if ielz == nelz - 1 and\
                      xpath[i] > x[icon[0,iel]] and\
                      xpath[i] < x[icon[2,iel]] and\
                      ypath[i] > y[icon[0,iel]] and\
                      ypath[i] < y[icon[2,iel]]: # finding the domain el closest to obs point
                      r = ((xpath[i] - x[icon[0,iel]]) / \
                           (x[icon[2,iel]] - x[icon[0,iel]]) - 0.5) * 2
                      s = ((ypath[i] - y[icon[0,iel]]) / \
                           (y[icon[2,iel]] - y[icon[0,iel]]) - 0.5) * 2
                      N1 = 0.25 * (1 - r) * (1 - s) # calculating distance obs P to nodes of el
                      N2 = 0.25 * (1 + r) * (1 - s)
                      N3 = 0.25 * (1 + r) * (1 + s)
                      N4 = 0.25 * (1 - r) * (1 + s)
                      zpath[i] = z[icon[4,iel]] * N1 +\
                               z[icon[5,iel]] * N2 +\
                               z[icon[6,iel]] * N3 +\
                               z[icon[7,iel]] * N4 +\
                               zpath_height  # shift points to height above topo
                   iel += 1

   for i in range(0, npath):
       if remove_zerotopo:
          zbpath[i] = np.mean(zpath) + ho  # shifting obs path zero_topo

   print("creating path points above DEM: %.3f s" % (time.time() - start))
   start = time.time()
   if flat_bottom and remove_zerotopo:
      # flat bottom generates domain with a bottom surface flat at Lz below the lowest value
      # within the topography (DEM). The mean of the ztopo is used both to extent the domain
      # in depth, and to shift. This only works if the obs path is roughly in the middle,
      # runs perpendicular to the slope and if the slope on the areal scale > local topo.
      counter = 0
      for i in range(0, nnx):
          for j in range(0, nny):
              for k in range(0, nnz):
                  zb[counter] = k * (Lz + (np.mean(zpath) - min(ztopo))) / float(nelz) - Lz + min(ztopo)
                  counter += 1

   print("adjusting zero topo solution for DEM: %.3f s" % (time.time() - start))

   print('xpath (min/max):', min(xpath), max(xpath))
   print('ypath (min/max):', min(ypath), max(ypath))
   print('zpath (min/max):', min(zpath), max(zpath))

   #export_mesh_1D(npath, xpath, ypath, zpath, 'path.vtu')

###################################################################################################
# Prescribe M inside each cell
# For benchmarks 1 and 3, M is zero everywhere except inside
# a sphere of radius sphere_R at location (sphere_xc,sphere_yc,sphere_zc)
# we use the center of an element as a representative point.
# For benchmark 2a,2b,4,5 and DEM, M is constant in space and equal to (Mx0,My0,Mz0)
###################################################################################################

start = time.time()

Mx = np.zeros(nel, dtype=np.float64)  # Magnetization in x-direction of each element.
My = np.zeros(nel, dtype=np.float64)  # Magnetization in y-direction of each element.
Mz = np.zeros(nel, dtype=np.float64)  # Magnetization in z-direction of each element.

if benchmark == '1' or benchmark == '3':
   Mx[:] = 0  # Mag for elements is zero, except inside sphere
   My[:] = 0
   Mz[:] = 0
   for iel in range(0, nel):  # find elements inside sphere
       xc = (x[icon[0,iel]] + x[icon[6,iel]]) * 0.5  # center of the element
       yc = (y[icon[0,iel]] + y[icon[6,iel]]) * 0.5
       zc = (z[icon[0,iel]] + z[icon[6,iel]]) * 0.5
       if (xc - sphere_xc)**2 + (yc - sphere_yc)**2 + (zc - sphere_zc)**2 < sphere_R**2:
          Mx[iel] = Mx0
          My[iel] = My0
          Mz[iel] = Mz0


if benchmark == '2a' or benchmark == '2b' or benchmark == '4' or benchmark == '5' \
   or benchmark == '-1':  # Mag elements is always uniform and equal to M0.
   Mx[:] = Mx0
   My[:] = My0
   Mz[:] = Mz0

export_mesh_3D(NV, nel, x, y, z, icon, 'mesh.vtu', Mx, My, Mz, nnx, nny, nnz)
if (benchmark == '-1' or benchmark == '5') and remove_zerotopo:
   export_mesh_3D(NV, nel, xb, yb, zb, icon, 'mesh_zerotopo.vtu', Mx, My, Mz, nnx, nny, nnz)

print("prescribe M vector in domain: %.3f s" % (time.time() - start))

###################################################################################################
# Plane measurements setup
# The plane originates at (plane_x0,plane_y0,plane_z0) and extends
# in the x,y directions by plane_Lx,plane_Ly.
# Note that shift observation point function is used to ensure points do not reside on a diagonal.
###################################################################################################

if do_plane_measurements:
   start = time.time()

   plane_nmeas = plane_nnx * plane_nny  # total number of points in plane

   plane_nelx = plane_nnx - 1  # nb of cells in x direction in plane
   plane_nely = plane_nny - 1  # nb of cells in y direction in plane
   plane_nel = plane_nelx * plane_nely  # total nb of cells in plane

   x_meas = np.zeros(plane_nmeas, dtype=np.float64)  # x coordinates of meas points
   y_meas = np.zeros(plane_nmeas, dtype=np.float64)  # y coordinates of meas points
   z_meas = np.zeros(plane_nmeas, dtype=np.float64)  # y coordinates of meas points

   counter = 0
   for j in range(0, plane_nny):
       for i in range(0, plane_nnx):
           # generating obs measurements on the plane, equally distributed
           x_meas[counter] = plane_x0 + (i) * plane_Lx / float(plane_nnx - 1)
           y_meas[counter] = plane_y0 + (j) * plane_Ly / float(plane_nny - 1)
           z_meas[counter] = plane_z0
           if benchmark == '5':  # shift plane in case of flank simulation
              z_meas[counter] += topography(x_meas[counter] - Lx / 2, y_meas[counter] - Ly / 2, A,\
                               wavelength, dir, slopex, slopey)
           if benchmark == '5' or benchmark == '2b':  # test for diagonal spatial problem
              x_meas[counter], y_meas[counter], message = \
               shift_observation_points_edge(x, y, Lx, Ly, nelx, nely, nelz,\
                                              x_meas[counter], y_meas[counter])
              if not message == "No observation points were shifted.":
                 print(counter, message)

           counter += 1

   icon_meas = np.zeros((4, plane_nel), dtype=np.int32)  # connectivity for plane, used in vtu.
   counter = 0
   for j in range(0, plane_nely):
       for i in range(0, plane_nelx):
           icon_meas[0,counter] = i + j * (plane_nelx + 1)
           icon_meas[1,counter] = i + 1 + j * (plane_nelx + 1)
           icon_meas[2,counter] = i + 1 + (j + 1) * (plane_nelx + 1)
           icon_meas[3,counter] = i + (j + 1) * (plane_nelx + 1)
           counter += 1

   print("setup plane measurement points: %.3f s" % (time.time() - start))

###################################################################################################
# Measuring B on a plane
# nomenclature for variables/arrays:
# _vi: volume integral
# _si: surface integral
# _th: analytical value (if applicable)
# the volume integral is parameterised by the number of quadrature
# points per dimension nqdim.
# because the integrand is not a polynomial, the volume integral
# remains a numerical solution (which depends on nqdim), while
# the surface integral is actually analytical (down to machine precision).
###################################################################################################

if do_plane_measurements:
   start_big = time.time()

   print('starting plane measurement ...')
   linefile = open("measurements_plane.ascii", "w")
   linefile.write("# 1,2,3, 4    , 5    , 6    , 7    , 8    , 9     \n")
   linefile.write("# x,y,z, Bx_vi, By_vi, Bz_vi, Bx_si, By_si, Bz_si \n")

   B_vi = np.zeros((3, plane_nmeas), dtype=np.float64)
   B_si = np.zeros((3, plane_nmeas), dtype=np.float64)
   B_th = np.zeros((3, plane_nmeas), dtype=np.float64)

   for i in range(0, plane_nmeas):
       print('------------------------------')
       print('doing', (i + 1), 'out of ', plane_nmeas)
       print('x,y,z meas', x_meas[i], y_meas[i], z_meas[i])

       if compute_vi:
          start = time.time()
          for iel in range(0, nel):
              B_vi[:,i] += compute_B_quadrature(x_meas[i], y_meas[i], z_meas[i], x, y, z,\
                                                 icon[:,iel], Mx[iel], My[iel], Mz[iel], nqdim)
          print("vol int: %.3f s" % (time.time() - start))
          #print('vol int    ->',B_vi[:,i])

       if benchmark == '5' or benchmark == '2b':
          start = time.time()
          for iel in range(0, nel):
              B_si[:,i] += compute_B_surface_integral_wtopo(x_meas[i], y_meas[i], z_meas[i],\
                                                             x, y, z, icon[:,iel], \
                                                             Mx[iel], My[iel], Mz[iel])
          print("surf int: %.3f s" % (time.time() - start))
          #print('surf int   ->',B_si[:,i])
       else:
          start = time.time()
          for iel in range(0, nel):
              B_si[:,i] += compute_B_surface_integral_cuboid(x_meas[i], y_meas[i], z_meas[i],\
                                                              x, y, z, icon[:,iel],\
                                                              Mx[iel], My[iel], Mz[iel])
          print("surf int: %.3f s" % (time.time() - start))
          #print('surf int   ->',B_si[:,i])


       linefile.write("%e %e %e %e %e %e %e %e %e \n" %(x_meas[i], y_meas[i], z_meas[i],\
                                                         B_vi[0,i], B_vi[1,i], B_vi[2,i],\
                                                         B_si[0,i], B_si[1,i], B_si[2,i]))

   export_plane_measurements(plane_nmeas, plane_nel, x_meas, y_meas, z_meas, icon_meas,\
                              'plane_measurements.vtu', B_vi, B_si, B_th)

   print("all plane measurement done: %.3f s" % (time.time() - start_big))

###################################################################################################
# Measuring B on a line
# The line starts at xstart,ystart,zstart and ends at xend,yend,zend,
# and is discretised by means of line_nmeas pts.
###################################################################################################

print('========================================')

if do_line_measurements:
   start_big = time.time()
   print('starting line measurement ...')

   # Open files to write
   if benchmark == '5':
      linefile = open("measurements_line.ascii","w")
      linefile.write("# 1,2,3, 4    , 5    , 6    , 7    , 8    , 9     \n")
      linefile.write("# x,y,z, Bx_si, By_si, Bz_si, In_si, Ic_si, Dc_si \n")
      linefile1 = open("measurements_line_plotfile.ascii","w")
      linefile1.write("# 1 , 2 , 3 , 4      , 5      , 6      , 7      , 8      , 9      ,\
                       10 (pm), 11 (pm), 12 (pm)  \n")
      linefile1.write("# xm, ym, zm, IGRF_In, IGRF_Ic, IGRF_Dc, In_siB0, Ic_siB0, Dc_siB0,\
                       Bx_siB0, By_siB0, Bz_siB0  \n")
      if remove_zerotopo:
          linefile2 = open("measurements_line_zerotopo.ascii","w")
          linefile2.write("# 1, 2, 3, 4     , 5     , 6     , 7   , 8   , 9   , 10  \n")
          linefile2.write("# x, y, z, Bbx_si, Bby_si, Bbz_si, In_si, Ic_si, Dc_si, dmeas \n")
          linefile3 = open("measurements_line_plotfile_nozt.ascii","w")
          linefile3.write("# 1 , 2 , 3 , 4      , 5      , 6      , 7      , 8      , 9      ,\
                           10 (pm), 11 (pm), 12 (pm)  \n")
          linefile3.write("# xm, ym, zm, IGRF_In, IGRF_Ic, IGRF_Dc, In_siB0, Ic_siB0, Dc_siB0,\
                           Bx_siB0, By_siB0, Bz_siB0  \n")
   else:
      linefile = open("measurements_line.ascii","w")
      linefile.write("# 1,2,3, 4    , 5    , 6    , 7    , 8    , 9    , 10   , 11   , 12    \n")
      linefile.write("# x,y,z, Bx_vi, By_vi, Bz_vi, Bx_si, By_si, Bz_si, Bx_th, By_th, Bz_th \n")

   # Allocating arrays
   x_meas = np.zeros(line_nmeas, dtype=np.float64)  # x coordinates
   y_meas = np.zeros(line_nmeas, dtype=np.float64)  # y coordinates
   z_meas = np.zeros(line_nmeas, dtype=np.float64)  # z coordinates
   B_vi = np.zeros((3, line_nmeas), dtype=np.float64)
   B_si = np.zeros((3, line_nmeas), dtype=np.float64)
   B_th = np.zeros((3, line_nmeas), dtype=np.float64)
   if benchmark == "5":
      In_si = np.zeros((line_nmeas), dtype=np.float64)
      Ic_si = np.zeros((line_nmeas), dtype=np.float64)
      Dc_si = np.zeros((line_nmeas), dtype=np.float64)
      if remove_zerotopo:
         zb_meas = np.zeros(line_nmeas, dtype=np.float64)  # z coordinates for zt

   # Setup line measurements
   for i in range(0, line_nmeas):
       xm = xstart + (xend - xstart) / (line_nmeas - 1) * i
       ym = ystart + (yend - ystart) / (line_nmeas - 1) * i
       zm = zstart + (zend - zstart) / (line_nmeas - 1) * i

       if benchmark != '1' and benchmark != '2a':  # both use surface_int_cuboid not _wtopo.
          xm, ym, message = shift_observation_points_edge(x, y, Lx, Ly, nelx, nely, nelz, xm, ym)
          if not message == "No observation points were shifted.":
             print(i, message)

       x_meas[i] = xm
       y_meas[i] = ym
       z_meas[i] = zm

       #print(xm, ym, zm)

       if benchmark == '4':  # values from Ren19 (original in [nT]).
          B_th[0,i], B_th[1,i], B_th[2,i] = BxB4[i] * 1e-9, ByB4[i] * 1e-9, BzB4[i] * 1e-9
       elif benchmark == '5':
          if remove_zerotopo:
             zb_meas[i] = zm
             #zb_meas[i] = zm + Lz / 2  # for misaligning tests.

          # shift observation points for flank simulations
          zm += topography(xm - Lx / 2, ym - Ly / 2, A, wavelength, dir, slopex, slopey)
          z_meas[i] = zm

   # Computations
   if benchmark == '5' and remove_zerotopo:
      print('starting line measurement for zerotopo ...')
      Bb_si = np.zeros((3, line_nmeas), dtype=np.float64)

      for i in range(0, line_nmeas):  # zero topography run for flank simulations
          print('doing zt for', (i + 1), 'out of ', line_nmeas)
          xm = x_meas[i]
          ym = y_meas[i]
          zm = zb_meas[i]  # zmeas for zt
          start = time.time()
          for iel in range(0, nel):
              Bb_si[:,i] += compute_B_surface_integral_wtopo(xm, ym, zm, xb, yb, zb,\
                                                              icon[:,iel], Mx[iel],\
                                                              My[iel], Mz[iel])
                                                               # TODO do cuboid here
          print("surf zt int: %.3f s" % (time.time() - start))
          #print('surf int   ->',B_si[:,i])

          In_si[i] = np.sqrt(Bb_si[0,i]**2 + Bb_si[1,i]**2 + Bb_si[2,i]**2)
          Ic_si[i] = np.arctan2(-Bb_si[2,i], np.sqrt(Bb_si[1,i]**2 + Bb_si[0,i]**2)) / np.pi * 180
          Dc_si[i] = np.arctan2(Bb_si[0,i], Bb_si[1,i]) / np.pi * 180

          linefile2.write("%e %e %e %e %e %e %e %e %e \n" %(xm, ym, zm,\
                                                             Bb_si[0,i], Bb_si[1,i], Bb_si[2,i],\
                                                             In_si[i], Ic_si[i], Dc_si[i])  )

      export_line_measurements(line_nmeas, x_meas, y_meas, zb_meas, 'line_measurements_zt.vtu',\
                                B_vi, Bb_si, B_th)

   print('starting line measurement...')
   for i in range(0, line_nmeas):
       print('doing', (i + 1), 'out of ', line_nmeas)
       xm = x_meas[i]
       ym = y_meas[i]
       zm = z_meas[i]

       if compute_vi:
          start = time.time()
          for iel in range(0, nel):
              B_vi[:,i] += compute_B_quadrature(xm, ym, zm, x, y, z, icon[:,iel],\
                                                 Mx[iel], My[iel], Mz[iel], nqdim)
          print("vol int: %.3f s" % (time.time() - start))
          #print('vol int    ->', B_vi[:,i])

       if compute_analytical:
          B_th[:,i] = compute_analytical_solution(xm, ym, zm, sphere_R, Mx0, My0, Mz0,\
                                                   sphere_xc, sphere_yc, sphere_zc, benchmark)

       if benchmark == '1' or benchmark == '2a':
          start = time.time()
          for iel in range(0, nel):
              B_si[:,i] += compute_B_surface_integral_cuboid(xm, ym, zm, x, y, z, icon[:,iel],\
                                                              Mx[iel], My[iel], Mz[iel])
          print("surf int: %.3f s" % (time.time() - start))
          #print('surf int   ->', B_si[:,i])
       else:
          start = time.time()
          for iel in range(0, nel):
              B_si[:,i] += compute_B_surface_integral_wtopo(xm, ym, zm, x, y, z, icon[:,iel],\
                                                             Mx[iel], My[iel], Mz[iel])
          print("surf int: %.3f s" % (time.time() - start))
          #print('surf int   ->', B_si[:,i])

       if benchmark == '5':
          dmeas = np.zeros((line_nmeas), dtype=np.float64)  # not used, but add_ref req.TODO: add?
          B0 = np.array([IGRFx,IGRFy,IGRFz])
          B0_name = "IGRF"
          if remove_zerotopo:
             B_siB0, In_siB0, Ic_siB0, Dc_siB0 = \
               add_referencefield(B0_name, line_nmeas, dmeas, B0, B_si, benchmark)
             linefile3.write("%e %e %e %e %e %e %e %e %e %e %e %e \n" \
                             %(xm, ym, zm, IGRFint, IGRFinc, IGRFdec, In_siB0[i], Ic_siB0[i],\
                                Dc_siB0[i], B_siB0[0,i], B_siB0[1,i], B_siB0[2,i]))
                                  # Writing to: measurements_line_plotfile_nozt.ascii.
             B_si[0,i] -= Bb_si[0,i]
             B_si[1,i] -= Bb_si[1,i]
             B_si[2,i] -= Bb_si[2,i]

          B_siB0, In_siB0, Ic_siB0, Dc_siB0 = \
            add_referencefield(B0_name, line_nmeas, dmeas, B0, B_si, benchmark)
          linefile1.write("%e %e %e %e %e %e %e %e %e %e %e %e \n" \
                          %(xm, ym, zm, IGRFint, IGRFinc, IGRFdec, In_siB0[i], Ic_siB0[i],\
                             Dc_siB0[i], B_siB0[0,i], B_siB0[1,i], B_siB0[2,i]))

          In_si[i] = np.sqrt(B_si[0,i]**2 + B_si[1,i]**2 + B_si[2,i]**2)
          Ic_si[i] = np.arctan2(-B_si[2,i], np.sqrt(B_si[1,i]**2 + B_si[0,i]**2)) / np.pi * 180
          Dc_si[i] = np.arctan2(B_si[0,i], B_si[1,i]) / np.pi * 180

          linefile.write("%e %e %e %e %e %e %e %e %e \n" %(xm, ym, zm,\
                                                            B_si[0,i], B_si[1,i], B_si[2,i],\
                                                            In_si[i], Ic_si[i], Dc_si[i]))
       else:
          linefile.write("%.20e %.20e %.20e %.20e %.20e %.20e %.20e \
                          %.20e %.20e %.20e %.20e %.20e \n" %(xm, ym, zm,\
                                                               B_vi[0,i], B_vi[1,i], B_vi[2,i],\
                                                               B_si[0,i], B_si[1,i], B_si[2,i],\
                                                               B_th[0,i], B_th[1,i], B_th[2,i]))

   export_line_measurements(line_nmeas, x_meas, y_meas, z_meas, 'line_measurements.vtu',\
                             B_vi, B_si, B_th)
   print("all line measurement done: %.3f s" % (time.time() - start_big))

print('========================================')

###################################################################################################
# Measuring B on a path
# Meant to be used above any DEM, assumed that the volume integral is always too time consuming,
# so excluded, B_th does not exist.
###################################################################################################

print('========================================')
if do_path_measurements:
   print('starting path measurement ...')

   linefile1 = open("measurements_path.ascii","w")
   linefile1.write("# 1, 2, 3, 4   , 5   , 6   , 7   , 8   , 9   , 10  \n")
   linefile1.write("# x, y, z, Bx_si, By_si, Bz_si, In_si, Ic_si, Dc_si, dmeas \n")

   B_si = np.zeros((3, npath), dtype=np.float64)
   In_si = np.zeros((npath), dtype=np.float64)
   Ic_si = np.zeros((npath), dtype=np.float64)
   Dc_si = np.zeros((npath), dtype=np.float64)
   dmeas = np.zeros((npath), dtype=np.float64)

   if remove_zerotopo:
      print('starting path measurement for zerotopo ...')

      linefile2 = open("measurements_path_zerotopo.ascii","w")
      linefile2.write("# 1, 2, 3, 4   , 5   , 6   , 7   , 8   , 9   , 10  \n")
      linefile2.write("# x, y, z, Bx_si, By_si, Bz_si, In_si, Ic_si, Dc_si, dmeas \n")
      Bb_si = np.zeros((3, npath), dtype=np.float64)

      start_big = time.time()
      for i in range(0, npath):
          print('zerotopo: doing', (i + 1), 'out of ', npath)
          xm = xpath[i]  # xmeas
          ym = ypath[i]  # ymeas
          zm = zbpath[i]  # zmeas
          #print(xm, ym, zm)

          start = time.time()
          for iel in range(0, nel):
              Bb_si[:,i]  += compute_B_surface_integral_wtopo(xm, ym, zm, xb, yb, zb,\
                                                           icon[:,iel], Mx[iel], My[iel], Mz[iel])
          print("surf int: %.3f s" % (time.time() - start))

          # PROCESSING THE DATA, note converted to Pmag axis (N,E,D as X,Y,Z),
          # pmag xyz /= model xyz, modified equations ##
          In_si[i] = np.sqrt(Bb_si[0,i]**2 + Bb_si[1,i]**2 + Bb_si[2,i]**2)
          Ic_si[i] = np.arctan2(-Bb_si[2,i], np.sqrt(Bb_si[1,i]**2 + Bb_si[0,i]**2)) / np.pi * 180
          Dc_si[i] = np.arctan2(Bb_si[0,i],Bb_si[1,i]) / np.pi * 180
          print('Obs point number=', (i + 1), "Bx (North)=", Bb_si[1,i],\
                 "By=", Bb_si[0,i], "Bz=", -Bb_si[2,i])
          print('Intensity Path:', In_si[i], 'Inclination Path:', Ic_si[i],\
                 'Declination Path:', Dc_si[i])

          if i == 0:
             dmeas[i] = 0
          else:
             dmeas[i] = np.sqrt((xpath[i] - xpath[i - 1])**2 + \
                                (ypath[i] - ypath[i - 1])**2) + dmeas[i - 1]
          linefile2.write("%e %e %e %e %e %e %e %e %e %e \n" \
                          %(xm, ym, zm, Bb_si[1,i], Bb_si[0,i], -Bb_si[2,i],\
                             In_si[i], Ic_si[i], Dc_si[i], dmeas[i]))
      print("all zerotopo surf int: %.3f s" % (time.time() - start_big))
      export_line_measurements(npath, xpath, ypath, zbpath, 'path_measurements_zerotopo.vtu',\
                                Bb_si, Bb_si, Bb_si)
      # did not want to change tool, so useless 3x B_si
      print('========================================')

   start_big = time.time()
   for i in range(0, npath):
       print('doing', (i + 1), 'out of ', npath)
       xm = xpath[i]  # xmeas
       ym = ypath[i]  # ymeas
       zm = zpath[i]  # zmeas
       #print(xm, ym, zm)
       start = time.time()
       for iel in range(0, nel):
           if add_noise:
              if iel == 0:  # noise for first "column" of the domain
                 noise = random.uniform(-1, +1) * Nf
                 #print("element nr:", iel)
                 #print("Noise:", Noise)
              elif iel%nelz == 0:  # change noise value for each new "column" of the domain
                 noise = random.uniform(-1, +1) * Nf
                 #print("element nr:", iel)
                 #print("Noise:", Noise)

              B_si[:,i] += compute_B_surface_integral_wtopo_noise(xm, ym, zm, x, y, z,\
                                                                   icon[:,iel], Mx[iel], My[iel],\
                                                                       Mz[iel], noise)

           else:
              B_si[:,i] += compute_B_surface_integral_wtopo(xm, ym, zm, x, y, z,\
                                                            icon[:,iel], Mx[iel], My[iel], Mz[iel])
       print("surf int: %.3f s" % (time.time() - start))
       if remove_zerotopo:
          B_si[0,i] -= Bb_si[0,i]
          B_si[1,i] -= Bb_si[1,i]
          B_si[2,i] -= Bb_si[2,i]

       # Processing the data
       # note converted to Pmag axis (N,E,D as X,Y,Z), pmag xyz /= model xyz, modified equations
       In_si[i] = np.sqrt(B_si[0,i]**2 + B_si[1,i]**2 + B_si[2,i]**2)
       Ic_si[i] = np.arctan2(-B_si[2,i], np.sqrt(B_si[1,i]**2 + B_si[0,i]**2)) / np.pi * 180
       Dc_si[i] = np.arctan2(B_si[0,i], B_si[1,i]) / np.pi * 180
       print('Obs point number=', (i + 1), "Bx=", B_si[1,i], "By=", B_si[0,i], "Bz=", -B_si[2,i])
       print('Intensity Path:', In_si[i], 'Inclination Path:', Ic_si[i],\
              'Declination Path:', Dc_si[i])

       linefile1.write("%e %e %e %e %e %e %e %e %e %e \n" %(xm, ym, zm,\
                                                             B_si[0,i], B_si[1,i], B_si[2,i],\
                                                             In_si[i], Ic_si[i], Dc_si[i],\
                                                             dmeas[i] ))
   print("all surf int: %.3f s" % (time.time() - start_big))
   export_line_measurements(npath, xpath, ypath, zpath,'path_measurements.vtu', B_si, B_si, B_si)
   # did not want to change tool, so useless 3x B_si

print('========================================')

#TODO: add path hight diff to other option

###################################################################################################
# STATISTICS
# and adding reference fields
###################################################################################################

print('========================================')
if do_path_measurements:
   start = time.time()
   B0 = np.array([IGRFx,IGRFy,IGRFz])
   B0_name = "IGRF"
   IGRFint = np.sqrt(IGRFx**2 + IGRFy**2 + IGRFz**2)
   IGRFinc = np.arctan2(IGRFz, np.sqrt(IGRFx**2 + IGRFy**2)) / np.pi * 180
   IGRFdec = np.arctan2(IGRFy, IGRFx) / np.pi * 180
   print('starting processing: adding reference field and statistics ...')
   (B_siB0, In_siB0, Ic_siB0, Dc_siB0) = \
      add_referencefield(B0_name, npath, dmeas, B0, B_si, benchmark)

   linefile1 = open("statistics_IGRF.ascii","w")
   linefile1.write("# 1   , 2   , 3    , 4          , 5          , 6                , 7    ,\
                   8                , 9 \n")
   linefile1.write("# data, Mean, stDEV, min In_siB0, max In_siB0, minus (from mean), maxus,\
                   minus (from IGRF), maxus  \n")
## INT ##
   MeanIn = np.mean(In_siB0)
   StdevIn = np.std(In_siB0)
   linefile1.write("int %e %e %e %e %e %e %e %e \n" %(MeanIn * 1e6, StdevIn * 1e6,\
                                                 min(In_siB0) * 1e6, max(In_siB0) * 1e6,\
                                                 (min(In_siB0) - MeanIn) * 1e6,\
                                                 (max(In_siB0) - MeanIn) * 1e6,\
                                                 (min(In_siB0) - IGRFint) * 1e6,\
                                                 (max(In_siB0) - IGRFint) * 1e6))
   print('Mean Int IGRF added=', MeanIn)
   print('stDEV Int IGRF added=', StdevIn)
## INC ##
   MeanIc = np.mean(Ic_siB0)
   StdevIc = np.std(Ic_siB0)
   linefile1.write("inc %e %e %e %e %e %e %e %e \n" %(MeanIc, StdevIc,\
                                                 min(Ic_siB0), max(Ic_siB0),\
                                                 min(Ic_siB0) - MeanIc, max(Ic_siB0) - MeanIc,\
                                                 min(Ic_siB0) - IGRFinc, max(Ic_siB0) - IGRFinc))
   print('Mean Inc IGRF added=', MeanIc)
   print('stDEV Inc IGRF added=', StdevIc)
## DEC ##
   MeanDc = np.mean(Dc_siB0)
   StdevDc = np.std(Dc_siB0)
   linefile1.write("dec %e %e %e %e %e %e %e %e \n" %(MeanDc, StdevDc,\
                                                 min(Dc_siB0), max(Dc_siB0),\
                                                 min(Dc_siB0) - MeanDc, max(Dc_siB0) - MeanDc,\
                                                 min(Dc_siB0) - IGRFdec, max(Dc_siB0) - IGRFdec))
   print('Mean Dec IGRF added=', MeanDc)
   print('stDEV Dec IGRF added=', StdevDc)

   print("statistics: %.3f s" % (time.time() - start))
###################################################################################################
# write one plot file for nice vis

if do_path_measurements:
   start = time.time()

   if art_DEM:
       poh = 0
   elif benchmark == '-1' and rDEM == 2:
      if site == 1 or site == 2 or site == 3 or site == 5:
         poh = 8.5  # offset from height of path to height of DEM
   elif benchmark == '-1' and rDEM == 5:
      if site == 1 or site == 2 or site == 5:
         poh = 7.5
      elif site == 4:
         poh = 3  # this value is different from site 6, likely due to breaking of GPS (Meyer23)
      elif site == 6:
         poh = 8.5
   else:
      poh = 0

   linefile1=open("measurements_path_plotfile.ascii","w")
   linefile1.write("# 1      , 2      , 3      , 4    , 5     , 6      , 7      , 8      ,\
                    9              , 10  , 11  , 12  , 13    , 14      \n")
   linefile1.write("# IGRF_In, IGRF_Ic, IGRF_Dc, dmeas, height, In_siB0, Ic_siB0, Dc_siB0,\
                    height m (-poh), In_m, Ic_m, Dc_m, min hP, max hP  \n")

   for i in range(0, npath):
       linefile1.write("%e %e %e %e %e %e %e %e %e %e %e %e %e %e \n" \
                       %(IGRFint, IGRFinc, IGRFdec, dmeas[i], zpath[i], In_siB0[i], Ic_siB0[i],\
                          Dc_siB0[i], zpathO[i] - poh, In_m[i], Ic_m[i], Dc_m[i], min(zpath),\
                                                                         max(zpath)))
   print("plot file gen: %.3f s" % (time.time() - start))
###################################################################################################

if do_spiral_measurements:
   start_big = time.time()

   x_spiral = np.zeros(npts_spiral, dtype=np.float64)
   y_spiral = np.zeros(npts_spiral, dtype=np.float64)
   z_spiral = np.zeros(npts_spiral, dtype=np.float64)
   r_spiral = np.zeros(npts_spiral, dtype=np.float64)
   theta_spiral = np.zeros(npts_spiral, dtype=np.float64)
   phi_spiral = np.zeros(npts_spiral, dtype=np.float64)

   golden_ratio = (1. + np.sqrt(5.)) / 2.
   golden_angle = 2. * np.pi * (1. - 1. / golden_ratio)

   for i in range(0, npts_spiral):
       r_spiral[i] = radius_spiral
       theta_spiral[i] = np.arccos(1. - 2. * i / (npts_spiral - 1.))
       phi_spiral[i] = np.fmod((i * golden_angle), 2. * np.pi)

   # Sherical coordinates to cartesian
   x_spiral[:] = r_spiral[:] * np.sin(theta_spiral[:]) * np.cos(phi_spiral[:]) + sphere_xc
   y_spiral[:] = r_spiral[:] * np.sin(theta_spiral[:]) * np.sin(phi_spiral[:]) + sphere_yc
   z_spiral[:] = r_spiral[:] * np.cos(theta_spiral[:])                         + sphere_zc

   spiralfile = open("measurements_spiral.ascii","w")
   spiralfile.write("# 1,2,3,4    ,5    ,6    ,7    ,8    ,9    ,10   ,11   ,12    \n")
   spiralfile.write("# x,y,z,Bx_vi,By_vi,Bz_vi,Bx_si,By_si,Bz_si,Bx_th,By_th,Bz_th \n")

   B_vi = np.zeros((3, npts_spiral), dtype=np.float64)
   B_si = np.zeros((3, npts_spiral), dtype=np.float64)
   B_th = np.zeros((3, npts_spiral), dtype=np.float64)

   for i in range(0, npts_spiral):
       print('doing', (i + 1), 'out of ', npts_spiral)

       if compute_vi:
          start = time.time()
          for iel in range(0, nel):
              B_vi[:,i] += compute_B_quadrature (x_spiral[i], y_spiral[i], z_spiral[i], x,\
                                                  y, z, icon[:,iel], Mx[iel], My[iel], Mz[iel], nqdim)
          print("vol int: %.3f s" % (time.time() - start))

       start = time.time()
       for iel in range(0, nel):
           B_si[:,i] += compute_B_surface_integral_cuboid(x_spiral[i], y_spiral[i], z_spiral[i],\
                                                          x, y, z, icon[:,iel], Mx[iel], My[iel], Mz[iel])
       print("surf int: %.3f s" % (time.time() - start))

       B_th[:,i] = compute_analytical_solution(x_spiral[i], y_spiral[i], z_spiral[i], sphere_R,\
                                               Mx0, My0, Mz0, sphere_xc, sphere_yc, sphere_zc, benchmark)

       spiralfile.write("%e %e %e %e %e %e %e %e %e %e %e %e \n" %(x_spiral[i], y_spiral[i], z_spiral[i],\
                                                                    B_vi[0,i], B_vi[1,i], B_vi[2,i],\
                                                                    B_si[0,i], B_si[1,i], B_si[2,i],\
                                                                    B_th[0,i], B_th[1,i], B_th[2,i]))

   export_spiral_measurements(npts_spiral, x_spiral, y_spiral, z_spiral, 'spiral_measurements.vtu', B_vi, B_si, B_th)
   print("all spiral meas: %.3f s" % (time.time() - start_big))
print('========================================')

print("full run time: %.3f s" % (time.time() - start_fullrun))

###################################################################################################
