import random

import numpy as np
from scipy.ndimage import gaussian_filter

def generate_fractal_map(size, roughness, sigma, seed=None):
    """
    Generates a square fractal map using the diamond-square algorithm, followed by Gaussian filtering.

    The diamond-square algorithm is a fractal method used to generate random landscapes or textures.
    The algorithm works by dividing the map into squares and diamonds, then randomly displacing the midpoint
    of each to create roughness. Gaussian filtering is applied at the end to smooth out the map for a more
    natural look.

    :param size: Determines the size of the map which will be `(2^size) + 1`.
    :type size: scalar(int)
    :param roughness: The initial roughness factor for the diamond-square algorithm.
    :type roughness: scalar(float)
    :param sigma: Standard deviation for Gaussian filter, affecting the smoothness.
    :type sigma: scalar(float)
    :param seed: Optional seed for the random number generator.
    :type seed: (optional(scalar(int)))

    :return: **dem** *(array_like(float))* - A 2D numpy array representing the fractal map.
    """

    # Print out the parameters for the map generation
    print(f"size art DEM (2^n-1 nodes): {2**size-1}")
    print(f"roughness art DEM: {roughness}")
    print(f"filter sigma: {sigma}")
    def diamond_square(map_, stepsize, roughness):
        """
        Perform the diamond square procedure on a map to generate terrain elevation.

        The function takes a 2D numpy array representing an elevation map, a step size, and a roughness factor.
        It updates the map in place, adding randomness to create a fractal pattern.

        Parameters:
        :param map_: The elevation map, a 2D numpy array that is modified in place.
        :type map_: array_like(float)
        :param stepsize: The size of the square or diamond step in the algorithm. It determines the distance between points that will be updated.
        :type stepsize: scalar(int)
        :param roughness: A roughness factor determining the range of random values added to the midpoints.
        :type roughness: scalar(float)

        :return: None: The function modifies the input array `map_` in place and has no return value.
        """

        # Calculate half of the stepsize, which will be used to offset coordinates
        half_step = int(stepsize / 2)

        # Perform the diamond step
        for y in range(half_step, len(map_), stepsize):
            for x in range(half_step, len(map_[0]), stepsize):
                # Calculate the average of the corners of the square
                square_averages = np.mean(
                    [
                        map_[y - half_step][x - half_step],
                        map_[y - half_step][x + half_step],
                        map_[y + half_step][x - half_step],
                        map_[y + half_step][x + half_step],
                    ]
                )
                # Set the middle of the square to average plus some randomness based on roughness
                map_[y][x] = square_averages + random.uniform(-roughness, roughness)

        # Perform the square step
        for y in range(0, len(map_), half_step):
            for x in range((y + half_step) % stepsize, len(map_[0]), stepsize):
                # Calculate the average of the points of the diamond
                #  (considering wrap-around for edges)
                diamond_averages = np.mean(
                    [
                        map_[y][x],
                        map_[(y - half_step) % len(map_)][x],
                        map_[(y + half_step) % len(map_)][x],
                        map_[y][(x - half_step) % len(map_[0])],
                        map_[y][(x + half_step) % len(map_[0])],
                    ]
                )

                # Only update the point if it is within the bounds of the map
                if y < len(map_) and x < len(map_[0]):
                    # Set the diamond point to the average plus some randomness based on roughness
                    map_[y][x] = diamond_averages + random.uniform(-roughness, roughness)

    # Set the random seed if provided for reproducibility
    if seed is not None:
        random.seed(seed)
        print(f"random seed: {seed}")

    # Calculate the actual size of the map
    size = 2 ** size + 1

    # Initialize the map with zeros and set the corner values with initial roughness
    map_ = [[0] * size for _ in range(size)]
    map_[0][0] = map_[0][size-1] = map_[size-1][0] = map_[size-1][size-1] \
        = random.uniform(-roughness, roughness)

    # Set the initial step size to the size of the map minus one
    stepsize = size - 1

    # A flag for determining how to decrease roughness, can be toggled for different effects
    linear = False

    # Loop through the diamond-square steps to create terrain until the step size is small enough
    while stepsize >= 2:
        # Apply the diamond-square algorithm with current step size and roughness

        diamond_square(map_, stepsize, roughness)
        # Decrease the step size for the next iteration
        stepsize = int(stepsize / 2)

        # Decrease roughness as the features become smaller, this can be linear or exponential
        if linear:
           roughness *= 0.5
        else:
           roughness *= np.exp(-1 / stepsize)

    # Once the fractal generation is complete, apply a Gaussian filter to smooth the map
    map_ = gaussian_filter(map_, sigma=sigma)

    return map_

###################################################################################################


def write_dem_to_ascii(dem, ncol, nrow, cellsize, xllcorner, yllcorner, filename="art_dem.ascii"):
    """
    Writes the digital elevation model (DEM) data to an ASCII file in grid format.

    The ASCII format is a simple text-based format for storing raster data which is widely used in GIS
    software. Each line contains the data for a single row of the grid, with values separated by spaces.

    :param dem: 2D array containing elevation data.
    :type dem: array_like(float)
    :param ncol: Number of columns in the DEM grid.
    :type ncol: scalar(int)
    :param nrow: Number of rows in the DEM grid.
    :type ncol: scalar(int)
    :param cellsize: Size of each cell in the grid.
    :type cellsize: scalar(float)
    :param xllcorner: The western x-coordinate of the lower left corner of the DEM grid.
    :type xllcorner: scalar(float)
    :param yllcorner: The southern y-coordinate of the lower left corner of the DEM grid.
    :type yllcorner: scalar(float)
    :param filename: The name of the ASCII file to write.
    :type filename: string
    """
    # Open file to write in
    with open(filename, "w") as f:
        # Write all information as header
        f.write(f"ncols         {ncol}\n")
        f.write(f"nrows         {nrow}\n")
        f.write(f"xllcorner     {xllcorner}\n")
        f.write(f"yllcorner     {yllcorner}\n")
        f.write(f"cellsize      {cellsize}\n")
        f.write("NODATA_value  -9999\n")
        # Write DEM
        for row in dem:
            f.write(" ".join(map(str, row)) + "\n")

###################################################################################################


def generate_pathfile(xllcorner, yllcorner, Lx, rough_length, npath, seed=None,\
                       filename="art_path.txt"):
    """
    Generate a path file for artifical data sampling paths in an ASCII format.

    :param xllcorner: The western x-coordinate of the lower left corner of the grid.
    :type xllcorner: scalar(float)
    :param yllcorner: The southern y-coordinate of the lower left corner of the grid.
    :type yllcorner: scalar(float)
    :param Lx: The length of the domain along the x-axis.
    :type Lx: scalar(float)
    :param rough_length: The rough length of the path, minor changes will happen through this function, so length is eventually different to passed length.
    :type rough_length: scalar(float)
    :param npath: Number of points in the path.
    :type npath: scalar(int)
    :param seed: Optional seed for the random number generator.
    :type seed: scalar(int)
    :param filename: The name of the text file to write the path coordinates.
    :type filename: string

    """

    # Set the random seed if provided for reproducibility
    if seed is not None:
       random.seed(seed)
       print(f"random seed: {seed}")
    # Size of domain
    Ly = Lx
    counter = 1

    # Calculate start and end coordinates for the path, adding some randomness
    xstart = Lx / 2 + random.uniform(-1, 1) - rough_length / 2
    xend = Lx / 2 + random.uniform(-2, 2) + rough_length / 2
    ystart = Ly / 2 + random.uniform(-5, 5)
    yend = Ly / 2 + random.uniform(-5, 5)

    # Initialize arrays to hold the path coordinates and the measurement of distance along the path
    path = np.zeros((npath, 8), dtype=np.float64)
    dmeas = np.zeros((npath), dtype=np.float64)
    xpath = np.zeros((npath), dtype=np.float64)
    ypath = np.zeros((npath), dtype=np.float64)

    # Loop to calculate the path coordinates and cumulative distance
    for i in range(0, npath):
        # Calculate the current point coordinates
        xm = xstart + (xend - xstart) / (npath - 1) * i + xllcorner
        ym = ystart + (yend - ystart) / (npath - 1) * i + yllcorner
        xpath[i] = xm
        ypath[i] = ym

        # Calculate the cumulative distance for each point
        if i == 0:
           dmeas[i] = 0
        else:
           dmeas[i] = np.sqrt((xpath[i] - xpath[i - 1])**2 + (ypath[i] - ypath[i - 1])**2)\
              + dmeas[i - 1]

        # Store the point data in the path array
        path[i,:] = counter, xm, ym, 0, 0, 0, 0, dmeas[i]
        counter += 1

    # Write the path data to a text file
    with open(filename, "w") as f:
        for row in path:
            f.write(' '.join(map(str, row)) + '\n')

###################################################################################################
# In this section, any comments are on a new line outlined to the = sign, to avoid removal with sed
# statement in the run script.
###################################################################################################

if __name__ == "__main__":  # avoids module running when imported (sphinx)

   # Parameters for generation
   ncol = 127
        # must be a power of 2 minus 1: 2^n - 1, e.g., 3, 7, 15, 31, 63, 127, 255, 511, 1023 ...
   nrow = 127
        # must be the same as ncol

   cellsize = 2
            # Change this value if you want a different cell size
   afx = 5
       # angle of flank in x-direction
   afy = 12
       # angle ""
   xllcorner = 50
             # x-coordinate of the lower left corner (most south-western node)
   yllcorner = 100
             # y-coordinate of ""
   sigma = 2
         # sigma for Gaussian filter
   #seed = 546  # if seed is chosen, make sure to uncomment related lines below (including seed)

   # Test if ncol != nrow, or not right size (see above)
   if ncol != nrow or ((ncol + 1) & (ncol + 1 - 1) != 0):
      raise ValueError(f"Incompatible array size: {ncol,nrow}")

   # A flag for either combining a rougher and a more detailed DEM into one (more realistic), or not
   # combine simply generates one DEM from two separate calls of the function to generate.
   combine = True

   # Printing the chosen parameters
   print(f"cellsize: {cellsize}")
   print(f"angle flanks in x,y-direction (afx, afy): {afx, afy}")
   print(f"lower left corner x,y-coordinates (xllcorner, yllcorner): {xllcorner, yllcorner}")

   if combine:
      roughness1 = 20
                 # can be adjusted for desired level of detail
      roughness2 = 5
      dem1 = generate_fractal_map(int(ncol).bit_length() - 1 + 1, roughness1, sigma)
      dem2 = generate_fractal_map(int(ncol).bit_length() - 1 + 1, roughness2, sigma)
      dem = np.array(dem1) + np.array(dem2)  # adding two DEMS
      #dem1 = generate_fractal_map(int(ncol).bit_length()-1+1, roughness1, sigma, seed)
      #dem2 = generate_fractal_map(int(ncol).bit_length()-1+1, roughness2, sigma, seed)
   else:
      roughness = 12
                # can be adjusted for desired level of detail
      dem = generate_fractal_map(int(ncol).bit_length() - 1 + 1, roughness, sigma)
      #dem = generate_fractal_map(int(ncol).bit_length() - 1 + 1, roughness, sigma, seed)


   # Make the DEM sloped
   av_val = np.mean(dem)
   for y in range(len(dem)):
       for x in range(len(dem[y])):
           dem[y][x] -= av_val
           dem[y][x] += y * cellsize * np.tan(afy / 180 * np.pi) + yllcorner
                                       # add the y slope adjustment
           dem[y][x] += x * cellsize * np.tan(afx / 180 * np.pi) + xllcorner
                                       # add the x slope adjustment
           dem[y][x] = round(dem[y][x], 2)  # decreases the DEM size (faster to read)

   write_dem_to_ascii(dem, ncol, nrow, cellsize, xllcorner, yllcorner)

   # Parameters for the path
   rough_length = 30
                # this value determines the length of the path, however, the exact length
                # might differ, since random values are used to shift path points.
   npath = 30
         # amount of observations points on the path

   # Printing the chosen parameters
   print(f"~ length of the path: {rough_length}")
   print(f"amount of observation points on the path: {npath}")

   generate_pathfile(xllcorner, yllcorner, (ncol - 1) * cellsize, rough_length, npath)
   #generate_pathfile(xllcorner, yllcorner, (ncol - 1) * cellsize, rough_length, npath, seed)

