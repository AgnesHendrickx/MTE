#! /bin/bash

#######################################################
rdem=5
#######################################################

#rm -r results_site*

for site in 1; do
     for sdem in 2; do
        for ipath in 1; do
            for ho in 1 2; do

                echo '********************************************************'
                echo site= $site path=$ipath sDEM=$sdem ho=$ho rDEM=$rdem

                sed -i "s/path = .*/path = "$ipath"/" etna.py
                sed -i "s/site = .*/site = "$site"/" etna.py
                sed -i "s/ho = .*/ho = "$ho"/" etna.py
                sed -i "s/sDEM = .*/sDEM = "$sdem"/" etna.py
                sed -i "s/rDEM = .*/rDEM = "$rdem"/" etna.py

                python3 -u MTE.py | tee log.txt

                if test -f "log.txt"; then
                   mkdir -p results
                   mv *.vtu results/
                   mv *.ascii results/
                   mv log.txt results/
                   mv results path_results/results_${rdem}m_site${site}_path${ipath}_sdem${sdem}_ho${ho}_fb_zt
                fi

                rm -f *.vtu
                rm -f *.ascii

            done

        done

     done

done
