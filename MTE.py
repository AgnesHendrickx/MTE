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
# 1: Dipole (small sphere, far away), line measurement
# 2a: Random perturbation internal nodes cubic-> checks cancellation of internal faces
# 2b: Random perturbation internal nodes pancake-> checks cancellation of internal faces
# 3: Sphere (larger sphere, anywhere in space) analytical
# 4: A prismatic body, domain with constant M vector.
# 5: Synthetic shapes, wavy surface, domain with constant M vector.
# -1: DEM topography
###################################################################################################
###################################################################################################
benchmark = '5'
compute_vi = False

## ONLY BENCHMARK = -1 (DEM) & BENCHMARK = 5 (FLANKSIM) ##
flat_bottom = True  # If True, a flat bottom is generated at the lower surface of the domain, please see documentation.
                    # As the specific setup of this feature is different for the flank simulations and the DEM test.
remove_zerotopo = True  # Setup run 2 times: first time, zero topography setup: xy observation points same a path
                        # but zerotopo domain shifted to average height DEM.
                        # Second time, full domain with topography ("regular" run).
                        # From which the zerotopo values are subtracted before writing to regular output files.

## ONLY BENCHMARK = 5 (FLANKSIM) ##
subbench = 'south'  # Either 'south', 'east', 'north', 'west', choosing flank shifts domain features, and observation paths.

## ONLY BENCHMARK = -1 (DEM) ##
add_noise = False  # If True, noise is added to the DEM after loading in from file, if False not.
Nf = 1  # Noise amplitude between -Nf and Nf, value added to the z-coordinate of the middle node on the top/bottom surface.
        # Only relevant if add_noise = True
art_DEM = True  # If True, the model takes path and topo file produced by art_DEM.py (see documentation) and reads in header.
                # Please note other values specified below for IGRF and magnetization etc.

###################################################################################################

if benchmark == '1':
   Lx = 2
   Ly = 2
   Lz = 2
   nelx = 100
   nely = 100
   nelz = 100
   Mx0 = 0  # Do not change.
   My0 = 0  # Do not change.
   Mz0 = 7.5
   nqdim = 4
   sphere_R = 1
   sphere_xc = Lx / 2
   sphere_yc = Ly / 2
   sphere_zc = -Lz / 2
   ## line meas ##
   do_line_measurements = True
   xstart = Lx / 2
   ystart = Ly / 2
   zstart = 0.01  # Slightly above surface.
   xend = Lx / 2
   yend = Ly / 2
   zend = 2
   #zend = 100
   line_nmeas = 100
   ## plane meas ##
   do_plane_measurements = False
   plane_x0 = -Lx / 2
   plane_y0 = -Ly / 2
   plane_z0 = zend
   plane_Lx = 2 * Lx
   plane_Ly = 2 * Ly
   plane_nnx = 3
   plane_nny = 3
   do_spiral_measurements = False
   do_path_measurements = False
   remove_zerotopo = False
   compute_analytical = True

if benchmark == '2a':
   Lx = 10
   Ly = 10
   Lz = 10
   nelx = 5
   nely = 5
   nelz = 5
   Mx0 = 0
   My0 = 0
   Mz0 = 7.5
   nqdim = 6
   #dz = 0  # Base setup.
   dz = 0.1  # Amplitude random.
   ## plane meas ##
   do_plane_measurements = True
   plane_x0 = -Lx / 2
   plane_y0 = -Ly / 2
   plane_z0 = 1
   plane_Lx = 2 * Lx
   plane_Ly = 2 * Ly
   plane_nnx = 11
   plane_nny = 11
   do_line_measurements = False
   xstart = 99
   zstart = 1  # 1m above surface.
   xend = 110
   ystart = 10.5
   yend = 10.5
   zend = 1
   line_nmeas = 3

   sphere_R = 0
   sphere_xc = 0
   sphere_yc = 0
   sphere_zc = 0
   do_spiral_measurements = False
   do_path_measurements = False
   remove_zerotopo = False
   compute_analytical = False

if benchmark == '2b':
   Lx = 10
   Ly = 10
   Lz = 10
   nelx = 2
   nely = 10
   nelz = 50
   Mx0 = 0
   My0 = 0
   Mz0 = 7.5
   nqdim = 6
   dz = 0.1  # Amplitude random.
   ## plane meas ##
   do_plane_measurements = True
   plane_x0 = -Lx / 2
   plane_y0 = -Ly / 2
   plane_z0 = 1
   plane_Lx = 2 * Lx
   plane_Ly = 2 * Ly
   plane_nnx = 11
   plane_nny = 11
   do_line_measurements = False
   sphere_R = 0
   sphere_xc = 0
   sphere_yc = 0
   sphere_zc = 0
   do_spiral_measurements = False
   do_path_measurements = False
   remove_zerotopo = False
   compute_analytical = True

if benchmark == '3':
   Lx = 20
   Ly = 20
   Lz = 20
   nelx = 30
   #nelx = 60  # 3 el/m.
   #nelx = 120  # 6 el/m.
   nely = nelx
   nelz = nelx
   Mx0 = 0
   My0 = 0
   Mz0 = 7.5
   sphere_R = 10  # Do not change, or change radius_spiral as well.
   sphere_xc = Lx / 2
   sphere_yc = Ly / 2
   sphere_zc = -Lz / 2
   ## spiral meas ##
   do_spiral_measurements = True
   #radius_spiral = 1.025 * sphere_R  # 25 cm above surface sphere.
   #radius_spiral = 1.05 * sphere_R  # 50 cm above surface sphere.
   radius_spiral = 1.1 * sphere_R  # 1 m above surface sphere.
   npts_spiral = 101  # keep odd
   #nqdim = 6
   ## plane meas ##
   do_plane_measurements = False
   plane_x0 = -Lx / 2
   plane_y0 = -Ly / 2
   plane_z0 = 0.4
   plane_Lx = 2 * Lx
   plane_Ly = 2 * Ly
   plane_nnx = 30
   plane_nny = 30
   do_line_measurements = False
   do_path_measurements = False
   remove_zerotopo = False
   compute_analytical = True

if benchmark == '4':
   Lx = 10
   Ly = 10
   Lz = 10
   nelx = int(Lx)
   nely = int(Ly)
   nelz = 10
   Mx0 = 0
   My0 = 0
   Mz0 = 200
   nqdim = 6
   do_line_measurements = True
   #xstart = 6.00001
   #ystart = -24.999999
   #zstart = 0.00001
   #xend = 6.00001
   #yend = 24.999999
   #zend = 0.00001
   xstart = 6
   ystart = -25
   zstart = 0
   xend = 6
   yend = 25
   zend = 0
   line_nmeas = 21
   sphere_R = 0
   sphere_xc = 0
   sphere_yc = 0
   sphere_zc = 0
   do_plane_measurements = False
   do_spiral_measurements = False
   do_path_measurements = False
   remove_zerotopo = False
   compute_analytical = False
   pathfile = 'sites/B.dat'
   with open(pathfile, 'r') as path:
        lines_path = path.readlines()
   print(f"{pathfile} counts {len(lines_path)} lines")
   BxB4, ByB4, BzB4  = np.zeros((3, len(lines_path)), dtype=np.float64)  # Bx, By, Bz from Ren.
   data = np.array([list(map(float, line.split())) for line in lines_path])
   BxB4, ByB4, BzB4 = data[:, 0], data[:, 1], data[:, 2]

if benchmark == '5':
   #Lx = 50
   #Ly = 50
   #Lz = 20
   Lx = 250
   Ly = 250
   Lz = 10
   nelx = int(Lx * 1.5)
   nely = int(Ly * 1.5)
   #nelx = int(Lx * 3)
   #nely = int(Ly * 3)
   nelz = 10
   Mx0 = 0
   My0 = 4.085
   Mz0 = -6.29
   nqdim = 4
   ## topography parameters ##
   af = 6
   #wavelength = 0
   wavelength = 25
   #A = 0
   A = 4
   do_plane_measurements = False
   #plane_x0 = -Lx / 2
   #plane_y0 = -Ly / 2
   plane_x0 = 0
   plane_y0 = 0
   plane_z0 = 1
   plane_Lx = Lx
   plane_Ly = Ly
   #plane_Lx = Lx * 2
   #plane_Ly = Ly * 2
   plane_nnx = 20
   plane_nnx = 20
   plane_nny = 20

   do_line_measurements = True

   zstart = 1
   zend = 1
   line_nmeas = 47

   #ystart = Ly / 2
   #xstart = Lx / 2 - 25
   #yend = Ly / 2
   #xend = Lx / 2 + 25

   ystart = Ly / 2 - 0.221
   yend = Ly / 2 - 0.221
   xstart = 0.23 + ((Lx - 50) / 2)
   xend = 49.19 + ((Ly - 50) / 2)

   sphere_R = 0
   sphere_xc = 0
   sphere_yc = 0
   sphere_zc = 0
   do_spiral_measurements = False
   do_path_measurements = False
   compute_analytical = False

   #from flanksim import *

   if subbench == 'east':
      slopex = np.tan(-af / 180 * np.pi)
      slopey = np.tan(0 / 180 * np.pi)
      direction = 90 / 180 * np.pi
      #xstart, ystart = ystart, xstart  # Automated shifting for each flank, only works if Lx = Ly.
      #xend, yend = yend, xend  # Automated shifting for each flank, only works if Lx = Ly.
      xstart = Lx / 2 - 0.221
      xend = Lx / 2 - 0.221
      ystart = 0.23 + ((Ly - 50) / 2)
      yend = 49.19 + ((Ly - 50) / 2)

   if subbench == 'north':
      slopex = np.tan(0 / 180 * np.pi)
      slopey = np.tan(-af / 180 * np.pi)
      direction = 0 / 180 * np.pi

   if subbench == 'west':
      slopex = np.tan(af / 180 * np.pi)
      slopey = np.tan(0 / 180 * np.pi)
      direction = 90 / 180 * np.pi
      #xstart, ystart = ystart, xstart  # Automated shifting for each flank, only works if Lx = Ly.
      #xend, yend = yend, xend  # Automated shifting for each flank, only works if Lx = Ly.
      xstart = Lx / 2 - 0.221
      xend = Lx / 2 - 0.221
      ystart = 0.23 + ((Ly - 50) / 2)
      yend = 49.19 + ((Ly - 50) / 2)

   if subbench == 'south':
      slopex = np.tan(0 / 180 * np.pi)
      slopey = np.tan(af / 180 * np.pi)
      direction = 0 / 180 * np.pi

   cos_dir = np.cos(direction)
   sin_dir = np.sin(direction)

   IGRF_E = 1561.2e-9
   IGRF_N = 26850.3e-9
   IGRF_D = 36305.7e-9
   IGRFx = IGRF_N
   IGRFy = IGRF_E
   IGRFz = IGRF_D
   IGRFint = np.sqrt(IGRFx**2 + IGRFy**2 + IGRFz**2)
   IGRFinc = np.arctan2(IGRFz, np.sqrt(IGRFx**2 + IGRFy**2)) / np.pi * 180
   IGRFdec = np.arctan2(IGRFy, IGRFx) / np.pi * 180

if benchmark == '-1':
   compute_analytical = False
   compute_vi = False

   if art_DEM:
      do_line_measurements = False
      do_plane_measurements = False
      do_spiral_measurements = False
      do_path_measurements = True
      topofile = 'DEMS/art_dem.ascii'
      print('reading from art_dem.ascii')
      nqdim = 2
      Lz = 20
      nelz = 10
      IGRFx = 18034.3 * 1e-9
      IGRFy = -4873.9 * 1e-9
      IGRFz = -11904.4 * 1e-9
      Mx0 = 0
      My0 = 3.1
      Mz0 = 6.2
      pathfile = 'sites/art_path.txt'
      print('reading from art_path.txt')
      with open(pathfile, 'r') as path:
         npath = len(path.readlines())
      zpath_height = 1
      ho = zpath_height
      #cellsize = 2
      #nnx = 127  # (ncols)
      #nny = 127  # (nrows)
      #xllcorner = 50
      #yllcorner = 100
      #nelx = nnx - 1
      #nely = nny - 1
      #Lx = nelx * cellsize
      #Ly = nely * cellsize
      #npath = 20
      with open(topofile, 'r') as topo:
           # Reading topofile as topo (needs to be assigned before).
           has_header, header = read_header(topo)

      if has_header:
         print(header)
         nnx = int(header['ncols'])
         nny = int(header['nrows'])
         cellsize = header['cellsize']

         nelx = nnx - 1
         nely = nny - 1
         Lx = nelx * cellsize
         Ly = nely * cellsize
   else:
      from etna import *


#------------------------------------------------------------------------------

nel = nelx * nely * nelz
nnx = nelx + 1  # Number of elements, x direction.
nny = nely + 1  # Number of elements, y direction.
nnz = nelz + 1  # Number of elements, z direction.
NV = nnx * nny * nnz  # Number of nodes.
###################################################################################################

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
print('do_spiral_measurements=', do_spiral_measurements)
if do_spiral_measurements:
   print('npts_spiral', npts_spiral)
   print('radius_spiral', radius_spiral)
print('do_path_measurements=', do_path_measurements)
if do_path_measurements:
   if not art_DEM:
      print('site=', site)
      print('path=', path)
      print('height=', ho, zpath_height)
      print('resolution DEM=', rDEM)
      print('size cut DEM=', sDEM)
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
## grid point setup ##
# If benchmark 2, a small random perturbation is added to the
# z coordinate of the interior nodes.
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
               x[counter] = i * Lx / float(nelx) - (Lx / 2)  # (centering)
               y[counter] = j * Ly / float(nely) - (Ly / 2)  # (centering)
            else:
               x[counter] = i * Lx / float(nelx)
               y[counter] = j * Ly / float(nely)
            z[counter] = k * Lz / float(nelz) - Lz
            if (benchmark == '-1' or benchmark == '5') and remove_zerotopo:
               xb[counter] = i * Lx / float(nelx)
               yb[counter] = j * Ly / float(nely)
               zb[counter] = k * Lz / float(nelz) - Lz + Lz / 2
               #zb[counter] = k * Lz / float(nelz) - Lz
            if i != 0 and j != 0 and k != 0 and i != nnx - 1 and j != nny - 1 and k != nnz - 1 and (benchmark == '2a' or benchmark == '2b'):
               z[counter] += random.uniform(-1, +1) * dz
            counter += 1
print("grid points setup: %.3f s" % (time.time() - start))

###################################################################################################
## connectivity ##
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
###################################################################################################
if benchmark == '5':
   start = time.time()

   # Compute the minimum topography elevation for all nodes.
   #min_topography = min([topography(x_val - Lx / 2, y_val - Ly / 2, A, wavelength, cos_dir, sin_dir, slopex, slopey)
   #                       for x_val, y_val in zip(x, y)])
   #print("min topo:", min_topography)

   if flat_bottom:
      # Flat bottom generates domain with a bottom surface flat at Lz below the middle
      # of the domain (underneath path in standard testing).

      counter = 0
      for i in range(0, nnx):
          for j in range(0, nny):
              for k in range(0, nnz):
                  #LLz = Lz + topography(x[counter] - Lx / 2, y[counter] - Ly / 2, A, wavelength, cos_dir, sin_dir, slopex, slopey) - min_topography
                  #z[counter] = k * LLz / float(nelz) - Lz + min_topography
                  LLz = Lz + topography(x[counter] - Lx / 2, y[counter] - Ly / 2, A, wavelength, cos_dir, sin_dir, slopex, slopey)
                  z[counter] = k * LLz / float(nelz) - Lz
                  counter += 1
   else:
      # Generates domain with a bottom surface at a depth constant Lz below the (top) topography.
      counter = 0
      for i in range(0, nnx):
          for j in range(0, nny):
              for k in range(0, nnz):
                  z[counter] += topography(x[counter] - Lx / 2, y[counter] - Ly / 2, A, wavelength, cos_dir, sin_dir, slopex, slopey)
                  counter += 1

   print("add synthetic topography: %.3f s" % (time.time() - start))

###################################################################################################
# Adding topography based on DEM, and reading in measurement points from field data
# uses "etna.py" for importing values.
###################################################################################################
if benchmark == '-1':
   # Topography based on DEM, measurement points from field data.
   start = time.time()
   with open(topofile, 'r') as topo:
        # Reading topofile as topo (needs to be assigned before).
        has_header, header = read_header(topo)
        lines_topo = topo.readlines()

   if has_header:
      # Extract header values for later use, if no header, the values should be assigned before.
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
   # Shift coordinates of the domain to the spatial coordinates of the DEM.
   x[:] += xllcorner
   y[:] += yllcorner

   counter = 0
   for i in range(0, nny):
       # Reading lines backwards bc of how file is built.
       line = lines_topo[nny - 1 - i].strip()
       columns = line.split()
       for j in range(0, nnx):
            ztopo[counter] = columns[j]
            counter += 1

   print('add in topofile ok')
   if flat_bottom:
      # Flat bottom generates domain with a bottom surface flat at Lz below the lowest value within the topography (DEM).
      counter = 0
      for i in range(0, nnx):
          for j in range(0, nny):
              for k in range(0, nnz):
                  zmax = Lz + ztopo[j * nnx + i]
                  zmin = min(ztopo)
                  z[counter] = k * (zmax - zmin) / float(nelz) + zmin - Lz
                  counter += 1
   else:
      # Generates domain with a bottom surface at a depth constant Lz below the (top) topography.
      counter = 0
      for i in range(0, nnx):
          for j in range(0, nny):
              for k in range(0, nnz):
                  zmax = Lz + ztopo[j * nnx + i]
                  zmin = 0 + ztopo[j * nnx + i]
                  z[counter] = k * (zmax - zmin) / float(nelz) + zmin - Lz
                  counter += 1

   if remove_zerotopo:
      # Shift zerotopography domain, height chosen at mean height of the DEM.
      # Please note: this only suffices if the DEM is on a slope that (within the full spatial extent of the domain)
      # dominates over the local topography differences along the path
      # and the field measurement path is roughly in the middle of the domain
      # (especially wrt the direction of the slope).
      # If not, this should be modified into better working function!.
      xb[:] += xllcorner
      yb[:] += yllcorner
      zb[:] += ((max(ztopo) - min(ztopo)) / 2) + min(ztopo)

   print("adding DEM topography to domain: %.3f s" % (time.time() - start))

   ## read in path ##

   path = open(pathfile, 'r')
   lines_path = path.readlines()
   nlines = np.size(lines_path)
   print(pathfile + ' counts ', nlines, ' lines')
   print(npath)
   print(nlines)
   xpath = np.zeros(npath, dtype=np.float64)  # x coordinates
   ypath = np.zeros(npath, dtype=np.float64)  # y coordinates
   zpath = np.zeros(npath, dtype=np.float64)  # z coordinates
   if remove_zerotopo:
      zbpath = np.zeros(npath, dtype=np.float64)  # z coordinates path zerotopo
   zpathO = np.zeros(npath, dtype=np.float64)  # z coordinates original
   Ic_m = np.zeros(npath, dtype=np.float64)  # measured inclination
   Dc_m = np.zeros(npath, dtype=np.float64)  # measured declination
   In_m = np.zeros(npath, dtype=np.float64)  # measured intensity (in microT)
   dmeas_m = np.zeros(npath, dtype=np.float64)  # measured intensity (in microT)
   for i in range(0, npath):
       # reading lines from pathfile
       line = lines_path[i].strip()
       columns = line.split()
       xpath[i] = columns[1]
       #xpath[i] -= xllcorner + (Lx / 2)  # (centering)
       ypath[i] = columns[2]
       #ypath[i] -= yllcorner + (Ly / 2)  # (centering)
       xpath[i], ypath[i], message = shift_observation_points_edge(x, y, Lx, Ly, nelx, nely, nelz, xpath[i], ypath[i])
       if not message == "No observation points were shifted.":
          print(counter, message)
       zpath[i] = columns[3]
       zpathO[i] = zpath[i]
       if remove_zerotopo:
          zbpath[i] = ((max(ztopo) - min(ztopo)) / 2) + min(ztopo) + ho
       Ic_m[i] = columns[4]
       Dc_m[i] = columns[5]
       In_m[i] = columns[6]
       dmeas_m[i] = columns[7]

   # Height values of measurement points are based on dem + zpath_height, as height differences are common.
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
                      ypath[i] < y[icon[2,iel]]:
                      r=((xpath[i] - x[icon[0,iel]]) / (x[icon[2,iel]] - x[icon[0,iel]]) - 0.5) * 2
                      s=((ypath[i] - y[icon[0,iel]]) / (y[icon[2,iel]] - y[icon[0,iel]]) - 0.5) * 2
                      N1 = 0.25 * (1 - r) * (1 - s)
                      N2 = 0.25 * (1 + r) * (1 - s)
                      N3 = 0.25 * (1 + r) * (1 + s)
                      N4 = 0.25 * (1 - r) * (1 + s)
                      zpath[i] = z[icon[4,iel]] * N1 +\
                               z[icon[5,iel]] * N2 +\
                               z[icon[6,iel]] * N3 +\
                               z[icon[7,iel]] * N4 +\
                               zpath_height
                   iel += 1

   print("creating path points above DEM: %.3f s" % (time.time() - start))
   print('xpath (min/max):', min(xpath), max(xpath))
   print('ypath (min/max):', min(ypath), max(ypath))
   print('zpath (min/max):', min(zpath), max(zpath))

   #export_mesh_1D(npath, xpath, ypath, zpath, 'path.vtu')

###################################################################################################
# prescribe M inside each cell
# for benchmarks 1 and 3, M is zero everywhere except inside
# a sphere of radius sphere_R at location (sphere_xc,sphere_yc,sphere_zc)
# we use the center of an element as a representative point.
# For benchmark 2a,2b,4 and Etna, M is constant in space and equal to (Mx0,My0,Mz0)
###################################################################################################
start = time.time()

Mx = np.zeros(nel, dtype=np.float64)
My = np.zeros(nel, dtype=np.float64)
Mz = np.zeros(nel, dtype=np.float64)

if benchmark == '1' or benchmark == '3':
   Mx[:] = 0
   My[:] = 0
   Mz[:] = 0
   for iel in range(0, nel):
       xc = (x[icon[0,iel]] + x[icon[6,iel]]) * 0.5
       yc = (y[icon[0,iel]] + y[icon[6,iel]]) * 0.5
       zc = (z[icon[0,iel]] + z[icon[6,iel]]) * 0.5
       if (xc - sphere_xc)**2 + (yc - sphere_yc)**2 + (zc - sphere_zc)**2 < sphere_R**2:
          Mx[iel] = Mx0
          My[iel] = My0
          Mz[iel] = Mz0


if benchmark == '2a' or benchmark == '2b' or benchmark == '4' or benchmark == '5' or benchmark == '-1':
   Mx[:] = Mx0
   My[:] = My0
   Mz[:] = Mz0

export_mesh_3D(NV, nel, x, y, z, icon, 'mesh.vtu', Mx, My, Mz, nnx, nny, nnz)
if (benchmark == '-1' or benchmark == '5') and remove_zerotopo:
   export_mesh_3D(NV, nel, xb, yb, zb, icon, 'mesh_zerotopo.vtu', Mx, My, Mz, nnx, nny, nnz)

print("prescribe M vector in domain: %.3f s" % (time.time() - start))

###################################################################################################
## plane measurements setup ##
# The plane originates at (plane_x0,plane_y0,plane_z0) and extends
# in the x,y directions by plane_Lx,plane_Ly
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

           x_meas[counter] = plane_x0 + (i) * plane_Lx / float(plane_nnx - 1)
           y_meas[counter] = plane_y0 + (j) * plane_Ly / float(plane_nny - 1)
           z_meas[counter] = plane_z0
           if benchmark == '5':
              z_meas[counter] += topography(x_meas[counter] - Lx / 2, y_meas[counter] - Ly / 2, A,\
                               wavelength, cos_dir, sin_dir, slopex, slopey)
           if benchmark == '5' or benchmark == '2a' or benchmark == '2b':
              x_meas[counter], y_meas[counter], message = shift_observation_points_edge(x, y, Lx,\
                                                                                        Ly, nelx, nely,\
                                                                                        nelz, x_meas[counter], y_meas[counter])
              if not message == "No observation points were shifted.":
                 print(counter, message)

           counter += 1

   icon_meas = np.zeros((4, plane_nel), dtype=np.int32)
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
## measuring B on a plane ##
# Nomenclature for variables/arrays:
# _vi: volume integral
# _si: surface integral
# _th: analytical value (if applicable)
# The volume integral is parameterised by the number of quadrature
# points per dimension nqdim.
# Because the integrand is not a polynomial, the volume integral
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

       if benchmark == '5' or benchmark == '2a' or benchmark == '2b':
          start = time.time()
          for iel in range(0, nel):
              B_si[:,i] += compute_B_surface_integral_wtopo(x_meas[i], y_meas[i], z_meas[i],\
                                                             x, y, z, icon[:,iel], Mx[iel], My[iel], Mz[iel])
          print("surf int: %.3f s" % (time.time() - start))
          #print('surf int   ->',B_si[:,i])
       else:
          start = time.time()
          for iel in range(0, nel):
              B_si[:,i] += compute_B_surface_integral_cuboid(x_meas[i], y_meas[i], z_meas[i],\
                                                              x, y, z, icon[:,iel], Mx[iel], My[iel], Mz[iel])
          print("surf int: %.3f s" % (time.time() - start))
          #print('surf int   ->',B_si[:,i])


       linefile.write("%e %e %e %e %e %e %e %e %e \n" %(x_meas[i], y_meas[i], z_meas[i],\
                                                                   B_vi[0,i], B_vi[1,i], B_vi[2,i],\
                                                                   B_si[0,i], B_si[1,i], B_si[2,i]))

   export_plane_measurements(plane_nmeas, plane_nel, x_meas, y_meas, z_meas, icon_meas,\
                              'plane_measurements.vtu', B_vi, B_si, B_th)

   print("all plane measurement done: %.3f s" % (time.time() - start_big))

###################################################################################################
## measuring B on a line ##
# The line starts at xstart,ystart,zstart and ends at
# xend,yend,zend, and is discretised by means of line_nmeas pts.
###################################################################################################

print('========================================')

if do_line_measurements:
   start_big = time.time()
   print('starting line measurement ...')

   ## open write files ##
   if benchmark == '5':
      linefile = open("measurements_line.ascii","w")
      linefile.write("# 1,2,3, 4    , 5    , 6    , 7    , 8    , 9     \n")
      linefile.write("# x,y,z, Bx_si, By_si, Bz_si, In_si, Ic_si, Dc_si \n")
      linefile1 = open("measurements_line_plotfile.ascii","w")
      linefile1.write("# 1 , 2 , 3 , 4      , 5      , 6      , 7      , 8      , 9      , 10 (pm), 11 (pm), 12 (pm)  \n")
      linefile1.write("# xm, ym, zm, IGRF_In, IGRF_Ic, IGRF_Dc, In_siB0, Ic_siB0, Dc_siB0, Bx_siB0, By_siB0, Bz_siB0  \n")
      if remove_zerotopo:
          linefile2 = open("measurements_line_zerotopo.ascii","w")
          linefile2.write("# 1, 2, 3, 4     , 5     , 6     , 7   , 8   , 9   , 10  \n")
          linefile2.write("# x, y, z, Bbx_si, Bby_si, Bbz_si, In_si, Ic_si, Dc_si, dmeas \n")
          linefile3 = open("measurements_line_plotfile_nozt.ascii","w")
          linefile3.write("# 1 , 2 , 3 , 4      , 5      , 6      , 7      , 8      , 9      , 10 (pm), 11 (pm), 12 (pm)  \n")
          linefile3.write("# xm, ym, zm, IGRF_In, IGRF_Ic, IGRF_Dc, In_siB0, Ic_siB0, Dc_siB0, Bx_siB0, By_siB0, Bz_siB0  \n")
   else:
      linefile = open("measurements_line.ascii","w")
      linefile.write("# 1,2,3, 4    , 5    , 6    , 7    , 8    , 9    , 10   , 11   , 12    \n")
      linefile.write("# x,y,z, Bx_vi, By_vi, Bz_vi, Bx_si, By_si, Bz_si, Bx_th, By_th, Bz_th \n")

   ## allocating arrays ##
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
   ## setup line measurements ##
   for i in range(0, line_nmeas):
       xm = xstart + (xend - xstart) / (line_nmeas - 1) * i
       ym = ystart + (yend - ystart) / (line_nmeas - 1) * i
       zm = zstart + (zend - zstart) / (line_nmeas - 1) * i

       if not benchmark == '1':
          xm, ym, message = shift_observation_points_edge(x, y, Lx, Ly, nelx, nely, nelz, xm, ym)
          if not message == "No observation points were shifted.":
             print(counter, message)

       x_meas[i] = xm
       y_meas[i] = ym
       z_meas[i] = zm

       #print(xm, ym, zm)

       if benchmark == '4':  # Values from Ren19.
          B_th[0,i], B_th[1,i], B_th[2,i] = BxB4[i] * 1e-9, ByB4[i] * 1e-9, BzB4[i] * 1e-9
       elif benchmark == '5':
          if remove_zerotopo:
             #zb_meas[i] = zm
             zb_meas[i] = zm + Lz / 2

          # shift observation points for flank simulations
          zm += topography(xm - Lx / 2, ym - Ly / 2, A, wavelength, cos_dir, sin_dir, slopex, slopey)
          z_meas[i] = zm

   ## computations ##
   if benchmark == '5' and remove_zerotopo:
      print('starting line measurement for zerotopo ...')
      Bb_si = np.zeros((3, line_nmeas), dtype=np.float64)

      for i in range(0, line_nmeas):  # Zero topography run for flank simulations
          print('doing zt for', (i + 1), 'out of ', line_nmeas)
          xm = x_meas[i]
          ym = y_meas[i]
          zm = zb_meas[i]  # zmeas for zt
          start = time.time()
          for iel in range(0, nel):
              Bb_si[:,i] += compute_B_surface_integral_wtopo(xm, ym, zm, xb, yb, zb, icon[:,iel], Mx[iel],\
                                                              My[iel], Mz[iel])  # TODO check if i can do cuboid here
          print("surf zt int: %.3f s" % (time.time() - start))
          #print('surf int   ->',B_si[:,i])

          In_si[i] = np.sqrt(Bb_si[0,i]**2 + Bb_si[1,i]**2 + Bb_si[2,i]**2)
          Ic_si[i] = np.arctan2(-Bb_si[2,i], np.sqrt(Bb_si[1,i]**2 + Bb_si[0,i]**2)) / np.pi * 180
          Dc_si[i] = np.arctan2(Bb_si[0,i], Bb_si[1,i]) / np.pi * 180

          linefile2.write("%e %e %e %e %e %e %e %e %e \n" %(xm, ym, zm,\
                                                             Bb_si[0,i], Bb_si[1,i], Bb_si[2,i],\
                                                             In_si[i], Ic_si[i], Dc_si[i])  )# Writing to: measurements_line_zerotopo.ascii.

      export_line_measurements(line_nmeas, x_meas, y_meas, zb_meas, 'line_measurements_zt.vtu', B_vi, Bb_si, B_th)

   print('starting line measurement...')
   for i in range(0, line_nmeas):
       print('doing', (i + 1), 'out of ', line_nmeas)
       xm = x_meas[i]
       ym = y_meas[i]
       zm = z_meas[i]

       if compute_vi:
          start = time.time()
          for iel in range(0, nel):
              B_vi[:,i] += compute_B_quadrature(xm, ym, zm, x, y, z, icon[:,iel], Mx[iel], My[iel], Mz[iel], nqdim)
          print("vol int: %.3f s" % (time.time() - start))
          #print('vol int    ->', B_vi[:,i])

       if compute_analytical:
          B_th[:,i] = compute_analytical_solution(xm, ym, zm, sphere_R, Mx0, My0, Mz0, sphere_xc, sphere_yc,\
                                                   sphere_zc, benchmark)

       #TODO add benchmark 1 no wtopo
       if benchmark == '1':
          start = time.time()
          for iel in range(0, nel):
              B_si[:,i] += compute_B_surface_integral_cuboid(xm, ym, zm, x, y, z, icon[:,iel], Mx[iel], My[iel], Mz[iel])
              print("surf int: %.3f s" % (time.time() - start))
              #print('surf int   ->', B_si[:,i])
       else:
          start = time.time()
          for iel in range(0, nel):
              B_si[:,i] += compute_B_surface_integral_wtopo(xm, ym, zm, x, y, z, icon[:,iel], Mx[iel], My[iel], Mz[iel])
              print("surf int: %.3f s" % (time.time() - start))
              #print('surf int   ->', B_si[:,i])

       if benchmark == '5':
          dmeas = np.zeros((line_nmeas), dtype=np.float64)  # not relevant, but add_ref req. TODO: add it?
          B0 = np.array([IGRFx,IGRFy,IGRFz])
          B0_name = "IGRF"
          if remove_zerotopo:
             B_siB0, In_siB0, Ic_siB0, Dc_siB0 = add_referencefield(B0_name, line_nmeas, dmeas, B0, B_si, benchmark)
             linefile3.write("%e %e %e %e %e %e %e %e %e %e %e %e \n" %(xm, ym, zm,\
                                                                         IGRFint, IGRFinc, IGRFdec,\
                                                                         In_siB0[i], Ic_siB0[i], Dc_siB0[i],\
                                                                         B_siB0[0,i], B_siB0[1,i], B_siB0[2,i]))
                                                                         # Writing to: measurements_line_plotfile_nozt.ascii.
             B_si[0,i] -= Bb_si[0,i]
             B_si[1,i] -= Bb_si[1,i]
             B_si[2,i] -= Bb_si[2,i]

          B_siB0, In_siB0, Ic_siB0, Dc_siB0 = add_referencefield(B0_name, line_nmeas, dmeas, B0, B_si, benchmark)
          linefile1.write("%e %e %e %e %e %e %e %e %e %e %e %e \n" %(xm, ym, zm,\
                                                             IGRFint, IGRFinc, IGRFdec,\
                                                             In_siB0[i], Ic_siB0[i], Dc_siB0[i],\
                                                             B_siB0[0,i], B_siB0[1,i], B_siB0[2,i]))

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

   export_line_measurements(line_nmeas, x_meas, y_meas, z_meas, 'line_measurements.vtu', B_vi, B_si, B_th)
   print("all line measurement done: %.3f s" % (time.time() - start_big))

print('========================================')

###################################################################################################
## measuring B on a path ##
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
              Bb_si[:,i]  += compute_B_surface_integral_wtopo(xm, ym, zm, xb, yb, zb, icon[:,iel], Mx[iel], My[iel], Mz[iel])
          print("surf int: %.3f s" % (time.time() - start))

          ## PROCESSING THE DATA, note converted to Pmag axis (N,E,D as X,Y,Z), pmag xyz /= model xyz, modified equations ##
          In_si[i] = np.sqrt(Bb_si[0,i]**2 + Bb_si[1,i]**2 + Bb_si[2,i]**2)
          Ic_si[i] = np.arctan2(-Bb_si[2,i], np.sqrt(Bb_si[1,i]**2 + Bb_si[0,i]**2)) / np.pi * 180
          Dc_si[i] = np.arctan2(Bb_si[0,i],Bb_si[1,i]) / np.pi * 180
          print('Obs point number=', (i + 1), "Bx (North)=", Bb_si[1,i], "By=", Bb_si[0,i], "Bz=", -Bb_si[2,i])
          print('Intensity Path:', In_si[i], 'Inclination Path:', Ic_si[i], 'Declination Path:', Dc_si[i])

          if i == 0:
             dmeas[i] = 0
          else:
             dmeas[i] = np.sqrt((xpath[i] - xpath[i - 1])**2 + (ypath[i] - ypath[i - 1])**2) + dmeas[i - 1]
          linefile2.write("%e %e %e %e %e %e %e %e %e %e \n" %(xm, ym, zm,\
                                                                Bb_si[1,i], Bb_si[0,i], -Bb_si[2,i],\
                                                                In_si[i], Ic_si[i], Dc_si[i],\
                                                                dmeas[i] ))
      print("all zerotopo surf int: %.3f s" % (time.time() - start_big))
      export_line_measurements(npath, xpath, ypath, zbpath, 'path_measurements_zerotopo.vtu', Bb_si, Bb_si, Bb_si)
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
                 Noise = random.uniform(-1, +1) * Nf
                 #print("element nr:", iel)
                 #print("Noise:", Noise)
              elif iel%nelz == 0:  # change noise value for each new "column" of the domain
                 Noise = random.uniform(-1, +1) * Nf
                 #print("element nr:", iel)
                 #print("Noise:", Noise)

              B_si[:,i] += compute_B_surface_integral_wtopo_noise(xm, ym, zm, x, y, z, icon[:,iel], Mx[iel], My[iel], Mz[iel], Noise)

           else:
              B_si[:,i] += compute_B_surface_integral_wtopo(xm, ym, zm, x, y, z, icon[:,iel], Mx[iel], My[iel], Mz[iel])
       print("surf int: %.3f s" % (time.time() - start))
       if remove_zerotopo:
          B_si[0,i] -= Bb_si[0,i]
          B_si[1,i] -= Bb_si[1,i]
          B_si[2,i] -= Bb_si[2,i]
       ## PROCESSING THE DATA, note converted to Pmag axis (N,E,D as X,Y,Z), pmag xyz /= model xyz, modified equations ##
       In_si[i] = np.sqrt(B_si[0,i]**2 + B_si[1,i]**2 + B_si[2,i]**2)
       Ic_si[i] = np.arctan2(-B_si[2,i], np.sqrt(B_si[1,i]**2 + B_si[0,i]**2)) / np.pi * 180
       Dc_si[i] = np.arctan2(B_si[0,i], B_si[1,i]) / np.pi * 180
       print('Obs point number=', (i + 1), "Bx=", B_si[1,i], "By=", B_si[0,i], "Bz=", -B_si[2,i])
       print('Intensity Path:', In_si[i], 'Inclination Path:', Ic_si[i], 'Declination Path:', Dc_si[i])

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
   print('starting processing: adding reference field and statistics ...')
   (B_siB0, In_siB0, Ic_siB0, Dc_siB0) = add_referencefield(B0_name, npath, dmeas, B0, B_si, benchmark)

   linefile1 = open("statistics_IGRF.ascii","w")
   linefile1.write("# 1   , 2   , 3    , 4          , 5          , 6    , 7     \n")
   linefile1.write("# data, Mean, stDEV, min In_siB0, max In_siB0, minus, maxus \n")
## INT ##
   MeanIn = np.mean(In_siB0)
   StdevIn = np.std(In_siB0)
   linefile1.write("int %e %e %e %e %e %e \n" %(MeanIn * 1e6, StdevIn * 1e6,\
                                                 min(In_siB0) * 1e6, max(In_siB0) * 1e6,\
                                                 -(MeanIn - min(In_siB0)) * 1e6, (max(In_siB0) - MeanIn) * 1e6 ))
   print('Mean Int IGRF added=', MeanIn)
   print('stDEV Int IGRF added=', StdevIn)
## INC ##
   MeanIc = np.mean(Ic_siB0)
   StdevIc = np.std(Ic_siB0)
   linefile1.write("inc %e %e %e %e %e %e \n" %(MeanIc, StdevIc,\
                                                 min(Ic_siB0), max(Ic_siB0),\
                                                 -(MeanIc - min(Ic_siB0)), max(Ic_siB0) - MeanIc))
   print('Mean Inc IGRF added=', MeanIc)
   print('stDEV Inc IGRF added=', StdevIc)
## DEC ##
   MeanDc = np.mean(Dc_siB0)
   StdevDc = np.std(Dc_siB0)
   linefile1.write("dec %e %e %e %e %e %e \n" %(MeanDc, StdevDc,\
                                                 min(Dc_siB0), max(Dc_siB0),\
                                                 -(MeanDc - min(Dc_siB0)), max(Dc_siB0) - MeanDc))
   print('Mean Dec IGRF added=', MeanDc)
   print('stDEV Dec IGRF added=', StdevDc)

   print("statistics: %.3f s" % (time.time() - start))
###################################################################################################
# write one plot file for nice vis

if do_path_measurements:
   start = time.time()

   if benchmark == '-1' and rDEM == 2:
      if site == 1 or site == 2 or site == 3 or site == 5:
         poh = 8.5  # offset from height of path to height of DEM
   elif benchmark == '-1' and rDEM == 5:
      if site == 1 or site == 2 or site == 5:
         poh = 7.5
      elif site == 4:
         poh = 3
      elif site == 6:
         poh = 8.5
   else:
      poh = 0


   linefile1=open("measurements_path_plotfile.ascii","w")
   linefile1.write("# 1      , 2      , 3      , 4    , 5     , 6      , 7      , 8      , 9              ,\
                    10  , 11  , 12  , 13    , 14      \n")
   linefile1.write("# IGRF_In, IGRF_Ic, IGRF_Dc, dmeas, height, In_siB0, Ic_siB0, Dc_siB0, height m (-poh),\
                    In_m, Ic_m, Dc_m, min hP, max hP  \n")

   IGRFint = np.sqrt(IGRFx**2 + IGRFy**2 + IGRFz**2)
   IGRFinc = np.arctan2(IGRFz, np.sqrt(IGRFx**2 + IGRFy**2)) / np.pi * 180
   IGRFdec = np.arctan2(IGRFy, IGRFx) / np.pi * 180
   for i in range(0, npath):
       linefile1.write("%e %e %e %e %e %e %e %e %e %e %e %e %e %e \n" %(IGRFint, IGRFinc, IGRFdec,\
                                                                         dmeas[i], zpath[i], In_siB0[i],\
                                                                         Ic_siB0[i], Dc_siB0[i], zpathO[i] - poh,\
                                                                         In_m[i], Ic_m[i], Dc_m[i], min(zpath),\
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
