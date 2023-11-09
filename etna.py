from set_measurement_parameters import *

do_line_measurements = False
do_plane_measurements = False
do_spiral_measurements = False
do_path_measurements = True

Mx0 = 0
My0 = 4.085
Mz0 = -6.290

nqdim = 2

###################################################################################################
# Setup for case study into Mt. Etna field measurements, reproducing sites.
# Site measurement locations were ~1m apart, three paths per site.
# 6 sites, nomenclature:
# rDEM: resolution of DEM (either 2m or 5m, but 5m does not exist for site 3).
# sDEM: size of DEM cuts (cuts were made with path kept ~ in the middle)
#       see docstrings set_measurement_parameters for more info.
# site: 1-6.
# path: the number allocated to each path on the sites (for 1-5: 3 paths, site 6: 1 path).
# ho: for site 1-4 there are 2, ho = 2
#     for site 5 there are 4, ho = 2

rDEM = 5
sDEM = 2
site = 1
path = 1
ho = 2

Lx, Ly, Lz, nelx, nely, nelz, xllcorner, yllcorner, npath, zpath_height,\
        pathfile, topofile, error, IGRFx, IGRFy, IGRFz = \
      set_measurement_parameters(rDEM, sDEM, site, path, ho)

#Lz = 10
if error:
   exit('combination does not exist -> terminate')

