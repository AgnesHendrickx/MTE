#! /bin/bash

# Define the name of the folder here
folder_name="250_250_20_fb_180"

for subbenchs in 1 2 3 4; do
    echo '********************************************************'
    echo subbenchs= $subbenchs

    sed -i "s/subbenchs = .*/subbenchs = "$subbenchs"/" flanksim.py

    python3 -u MTE.py | tee log.txt

    if test -f "log.txt"; then
       mkdir -p results  # -p flag to avoid error if directory already exists
       mv *.vtu results/
       mv *.ascii results/
       mv log.txt results/
       #mv results flanksim_parameters/results_${subbenchs}_50_50_120

       case $subbenchs in
         1)
           mv results flanksim_parameters/south/$folder_name
           ;;
         2)
           mv results flanksim_parameters/east/$folder_name
           ;;
         3)
           mv results flanksim_parameters/north/$folder_name
           ;;
         4)
           mv results flanksim_parameters/west/$folder_name
           ;;
       esac
    fi

    rm -f *.vtu
    rm -f *.ascii
    #rm -r results

done

sed -i "s/subbenchs = .*/subbenchs = "1"/" flanksim.py  # Reset to default

