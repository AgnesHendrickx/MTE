#! /bin/bash

#######################################################
#######################################################

for subbenchs in 1 2 3 4; do
    echo '********************************************************'
    echo subbenchs= $subbenchs

    sed -i "s/subbenchs=.*/subbenchs="$subbenchs"/" flanksim.py

    python3 MTE.py  > log.txt 

    if test -f "log.txt"; then
                   mkdir results
                   mv *.vtu results/
                   mv *.ascii results/
                   mv log.txt results/
                   mv results flanksim_parameters/results_${subbenchs}_250_250_20_180
    fi

    rm -f *.vtu
    rm -f *.ascii

done
