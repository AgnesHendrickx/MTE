#! /bin/bash

# Domain parameters, see
ncol=31  # amount of columns (must be )
nrow=31  # amount of rows (must be equal to ncol)
cellsize=2
afx=5
afy=12
xllcorner=50
yllcorner=100
sigma=2

roughness1=20
roughness2=5

rough_length=30
npath=30


size=$(( (ncol - 1) * cellsize ))

folder_name="${size}_r${roughness1}_r${roughness2}_afx${afx}_afy${afy}_s${sigma}"

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
sed -r -i "s/(ncol = ).*#(.*)/\1$ncol  #\2/" art_DEM.py
sed -r -i "s/(nrow = ).*#(.*)/\1$nrow  #\2/" art_DEM.py


#sed -r -i 'h;s/[^#]*//1;x;s/#.*//;s/ncol = .*/ncol = "$ncol"  /;G;s/(.*)\n/\1/' art_DEM.py
#sed -r -i 'h;s/[^#]*//1;x;s/#.*//;s/nrow = .*/nrow = "$nrow"  /;G;s/(.*)\n/\1/' art_DEM.py


python3 art_DEM.py

cp art_dem.ascii DEMS/
cp art_path.txt sites/

python3 -u MTE.py | tee log.txt
s
if test -f "log.txt"; then
   mkdir -p results  # -p flag to avoid error if directory already exists
   mv *.vtu results/
   mv *.ascii results/
   mv log.txt results/
   cp art_dem.ascii results/
   cp art_path.txt results/
fi

mv results path_results/art_DEM/$folder_name




#sed -i "s/ncol = .*/ncol = "$ncol"/" art_DEM.py
#sed -i -r "s/^\(ncol = \).*\(#.*\)/\1$ncol \2/" art_DEM.py
#sed -i -r "s/^\(nrow = \).*\(#.*\)/\1$nrow \2/" art_DEM.py

#sed -r 'h;s/[^#]*//1;x;s/#.*//;s/$param = .*/$param = ${params[$param]}/;G;s/(.*)\n/\1/' art_DEM.py

#sed -i "s/$param = .*/$param = ${params[$param]}/" art_DEM.py

#for param in "${!params[@]}"; do
#    sed -i "s/^\($param = \).*\(\s*#.*\)/\1${params[$param]}\2/" art_DEM.py
#    sed -i "s/$param = .*/$param = ${params[$param]}/" art_DEM.py
#done


sed -r -i 'h;s/[^#]*//1;x;s/#.*//;s/ncol = .*/ncol = "$ncol"  /;G;s/(.*)\n/\1/' art_DEM.py
sed -r -i 'h;s/[^#]*//1;x;s/#.*//;s/nrow = .*/nrow = "$nrow"  /;G;s/(.*)\n/\1/' art_DEM.py



#for param in "${!params[@]}"; do
#    sed -i -r 'h;s/[^#]*//1;x;s/#.*//;s/$param = .*/$param = ${params[$param]}/g;G;s/(.*)\n/\1/' art_DEM.py
#done
