#! /bin/bash

#######################################################
rdem=5
#######################################################



######################################################
for site in 6 ; do
     for sdem in 4 ; do
        for ipath in 1 ; do
            for ho in 1 ; do

                echo '********************************************************'
                echo site= $site path=$ipath sDEM=$sdem ho=$ho rDEM=$rdem

                sed -i "s/path =.*/path = "$ipath"/" etna.py
                sed -i "s/site =.*/site = "$site"/" etna.py
                sed -i "s/ho =.*/ho = "$ho"/" etna.py
                sed -i "s/sDEM =.*/sDEM = "$sdem"/" etna.py
                sed -i "s/rDEM =.*/rDEM = "$rdem"/" etna.py

                python3 -u MTE.py | tee log.txt

                if test -f "log.txt"; then
                   mkdir -p results
                   mv *.vtu results/
                   mv *.ascii results/
                   mv log.txt results/
                   mv results path_results/results_${rdem}m_site${site}_path${ipath}_sdem${sdem}_ho${ho}_fb_zt_mag_13_noise_1_5
                fi

                rm -f *.vtu
                rm -f *.ascii

            done

        done

     done

done
######################################################
