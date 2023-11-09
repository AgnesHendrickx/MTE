#! /bin/bash

generate_DEM=false  # no capital on statmement!!

# Domain parameters
ncol=127  # must be a power of 2 minus 1: 2^n - 1, e.g., 3, 7, 15, 31, 63, 127, 255, 511, 1023 ...
nrow=127  # amount of rows (must be equal to amount of columns, ncol)
cellsize=2  # Change this value if you want a different cell size
afx=5  # angle of flank in x-direction
afy=12  # angle ""      in y-direction
xllcorner=50  # x-coordinate of the lower left corner (most south-western node)
yllcorner=100  # y-coordinate of ""
sigma=2  # sigma for Gaussian filter

roughness1=12  # can be adjusted for desired level of detail
roughness2=2  # can be adjusted for desired level of detail

# Path parameters
rough_length=30  # rough length of the path, but due to shifting length might be slighlt more/less
npath=30  # amount of observation points on path

size=$(( (ncol - 1) * cellsize ))

folder_name="${size}_r${roughness1}_r${roughness2}_afx${afx}_afy${afy}_s${sigma}_noise_nf1_180"

declare -A params=(
    [ncol]=$ncol
    [nrow]=$nrow
    [cellsize]=$cellsize
    [afx]=$afx
    [afy]=$afy
    [xllcorner]=$xllcorner
    [yllcorner]=$yllcorner
    [sigma]=$sigma
    [rough_length]=$rough_length
    [npath]=$npath
    [roughness1]=$roughness1
    [roughness2]=$roughness2
)

for param in "${!params[@]}"; do
    sed -i "s/$param = .*/$param = ${params[$param]}/" art_DEM.py
done

if [ "$generate_DEM" = true ] ; then
   python3 art_DEM.py

   cp art_dem.ascii DEMS/
   cp art_path.txt sites/
fi

python3 -u MTE.py | tee log.txt

if test -f "log.txt"; then
   mkdir -p results  # -p flag to avoid error if directory already exists
   mv *.vtu results/
   mv *.ascii results/
   mv log.txt results/
   mv art_path.txt results/
fi

mv results path_results/art_DEM/$folder_name

