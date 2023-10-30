import random

import numpy as np
from scipy.ndimage import gaussian_filter


def generate_fractal_map(size, roughness, sigma, seed=None):
    print(f"size art DEM (2^n-1 nodes): {2**size-1}")
    print(f"roughness art DEM: {roughness}")
    print(f"filter sigma: {sigma}")
    def diamond_square(map_, stepsize, roughness):
        half_step = int(stepsize / 2)
        for y in range(half_step, len(map_), stepsize):
            for x in range(half_step, len(map_[0]), stepsize):
                square_averages = np.mean(
                    [
                        map_[y - half_step][x - half_step],
                        map_[y - half_step][x + half_step],
                        map_[y + half_step][x - half_step],
                        map_[y + half_step][x + half_step],
                    ]
                )
                map_[y][x] = square_averages + random.uniform(-roughness, roughness)

        for y in range(0, len(map_), half_step):
            for x in range((y + half_step) % stepsize, len(map_[0]), stepsize):
                diamond_averages = np.mean(
                    [
                        map_[y][x],
                        map_[(y - half_step) % len(map_)][x],
                        map_[(y + half_step) % len(map_)][x],
                        map_[y][(x - half_step) % len(map_[0])],
                        map_[y][(x + half_step) % len(map_[0])],
                    ]
                )
                map_[y][x] = diamond_averages + random.uniform(-roughness, roughness)

    if seed is not None:
        random.seed(seed)
        print(f"random seed: {seed}")

    size = 2 ** size + 1
    map_ = [[0] * size for _ in range(size)]
    map_[0][0] = map_[0][size-1] = map_[size-1][0] = map_[size-1][size-1] = random.uniform(-roughness, roughness)
    stepsize = size - 1

    linear = False

    while stepsize >= 2:
        diamond_square(map_, stepsize, roughness)
        stepsize = int(stepsize / 2)
        if linear:
           roughness *= 0.5
        else:
           roughness *= np.exp(-1 / stepsize)

    map_ = gaussian_filter(map_, sigma=sigma)

    return map_

def write_dem_to_ascii(dem, ncol, nrow, cellsize, xllcorner, yllcorner, filename="art_dem.ascii"):
    with open(filename, "w") as f:
        f.write(f"ncols         {ncol}\n")
        f.write(f"nrows         {nrow}\n")
        f.write(f"xllcorner     {xllcorner}\n")
        f.write(f"yllcorner     {yllcorner}\n")
        f.write(f"cellsize      {cellsize}\n")
        f.write("NODATA_value  -9999\n")
        for row in dem:
            f.write(" ".join(map(str, row)) + "\n")


def generate_pathfile(xllcorner, yllcorner, Lx, rough_length, npath, seed=None, filename="art_path.txt"):
    if seed is not None:
       random.seed(seed)
       print(f"random seed: {seed}")
    Ly = Lx
    counter = 1
    xstart = Lx / 2 + random.uniform(-1, 1) - rough_length / 2
    xend = Lx / 2 + random.uniform(-2, 2) + rough_length / 2
    ystart = Ly / 2 + random.uniform(-5, 5)
    yend = Ly / 2 + random.uniform(-5, 5)
    path = np.zeros((npath, 8), dtype=np.float64)
    dmeas = np.zeros((npath), dtype=np.float64)
    xpath = np.zeros((npath), dtype=np.float64)
    ypath = np.zeros((npath), dtype=np.float64)

    for i in range(0, npath):
        xm = xstart + (xend - xstart) / (npath - 1) * i + xllcorner
        ym = ystart + (yend - ystart) / (npath - 1) * i + yllcorner
        xpath[i] = xm
        ypath[i] = ym

        if i == 0:
           dmeas[i] = 0
        else:
           dmeas[i] = np.sqrt((xpath[i] - xpath[i - 1])**2 + (ypath[i] - ypath[i - 1])**2) + dmeas[i - 1]

        path[i,:] = counter, xm, ym, 0, 0, 0, 0, dmeas[i]
        counter += 1

    with open(filename, "w") as f:
        for row in path:
            f.write(' '.join(map(str, row)) + '\n')

# Example usage:
ncol = 127  # must be a power of 2 minus 1: 2^n - 1, e.g., 3, 7, 15, 31, 63, 127, 255 ...
nrow = 127

cellsize = 2  # Change this value if you want a different cell size
afx = 26
afy = 12
xllcorner = 50
yllcorner = 100
sigma = 2
#seed = 546

if ncol != nrow or ((ncol + 1) & (ncol + 1 - 1) != 0):
   raise ValueError(f"Incompatable array size: {ncol,nrow}")

combine = True

if combine:
   roughness1 = 20  # can be adjusted for desired level of detail
   roughness2 = 10
   dem1 = generate_fractal_map(int(ncol).bit_length() - 1 + 1, roughness1, sigma)
   dem2 = generate_fractal_map(int(ncol).bit_length() - 1 + 1, roughness2, sigma)
   dem = np.array(dem1) + np.array(dem2)
   #dem1 = generate_fractal_map(int(ncol).bit_length()-1+1, roughness1, sigma, seed)
   #dem2 = generate_fractal_map(int(ncol).bit_length()-1+1, roughness2, sigma, seed)
else:
   roughness = 10  # can be adjusted for desired level of detail
   dem = generate_fractal_map(int(ncol).bit_length() - 1 + 1, roughness)


av_val = np.mean(dem)
for y in range(len(dem)):
    for x in range(len(dem[y])):
        dem[y][x] -= av_val
        dem[y][x] += y * cellsize * np.tan(-afy / 180 * np.pi) + yllcorner  # Add the y slope adjustment
        dem[y][x] += x * cellsize * np.tan(-afx / 180 * np.pi) + xllcorner # Add the x slope adjustment
        dem[y][x] = round(dem[y][x], 2)

write_dem_to_ascii(dem, ncol, nrow, cellsize, xllcorner, yllcorner)

rough_length = 20
npath = 20

print((ncol - 1) * cellsize)
generate_pathfile(xllcorner, yllcorner, (ncol - 1) * cellsize, rough_length, npath)
#generate_pathfile(xllcorner, yllcorner, (ncol - 1) * cellsize, rough_length, npath, seed)

