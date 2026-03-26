#! /bin/bash

# Define the name of the folder here
folder_name="250_250_20_fb_ztr"

# 1 = south, 2 = east, 3 =  north, 4 = west
for lat in -90 -75 -60 -45 -30 -15 0 15 30 45 60 75 90; do  # lat range

    echo lat= $lat
    
    sed -i "s/lat = .*/lat = "$lat"/" MTE.py

    for subbenchs in 1 2 3 4; do  # by default does flanks
        echo '********************************************************'
        echo subbenchs= $subbenchs

        sed -i "s/subbenchs = .*/subbenchs = "$subbenchs"/" flanksim.py

        python3 -u MTE.py | tee log.txt

        if test -f "log.txt"; then
           mkdir -p results  # -p flag to avoid error if directory already exists
           mv *.vtu results/
           mv *.ascii results/
           mv log.txt results/

           # Move the results folder to the appropriate path based on latitude and flank
           case $subbenchs in
             1)
               mkdir -p global_flanksim/lats/$lat/south/$folder_name
               rsync -a results/ global_flanksim/lats/$lat/south/$folder_name/
               ;;
             2)
               mkdir -p global_flanksim/lats/$lat/east/$folder_name
               rsync -a results/ global_flanksim/lats/$lat/east/$folder_name/
               ;;
             3)
               mkdir -p global_flanksim/lats/$lat/north/$folder_name
               rsync -a results/ global_flanksim/lats/$lat/north/$folder_name/
               ;;
             4)
               mkdir -p global_flanksim/lats/$lat/west/$folder_name
               rsync -a results/ global_flanksim/lats/$lat/west/$folder_name/
               ;;
           esac
        fi

        # Clean up unnecessary files
        rm -f *.vtu
        rm -f *.ascii

    done

    sed -i "s/subbenchs = .*/subbenchs = "1"/" flanksim.py  # Reset to default

done

