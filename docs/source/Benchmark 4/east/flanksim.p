loc1 = '/home/agnes/MTE/fieldstone_138/Benchmark_copy/north/measurements_line_plotfile.ascii'
loc2 = '/home/agnes/MTE/fieldstone_138/Benchmark_copy/east/measurements_line_plotfile.ascii'
loc3 = '/home/agnes/MTE/fieldstone_138/Benchmark_copy/south/measurements_line_plotfile.ascii'
loc4 = '/home/agnes/MTE/fieldstone_138/Benchmark_copy/west/measurements_line_plotfile.ascii'
set terminal pngcairo size 1800,900

set key default
set key box
set xlabel font "courier,12" 'distance (m)'
set ylabel font "courier,12" 'intensity (microT)'
set y2label font "courier,12" 'height surface (m)' 
set autoscale xy
set ytics nomirror
set style line 12 lc rgb '#aaaaaa' dt 2 lw 0.5
set grid back ytics ls 12

#set y2range[1534:1558]
#set y2range[1528:1558]



set style line 1 lw 2 lc "grey40"
set style line 2 lw 3 lc rgb '#e69f00' dt (50,4,2,4)
set style line 3 lw 3 lc rgb '#d55e00' dt (50,4,2,4)
set style line 4 pt 3 lw 2 lc rgb '#0072b2'
set style line 5 pt 4 lw 2 lc rgb '#009e73' 
set style line 6 pt 5 lw 2 lc rgb '#cc79a7'
set style line 7 pt 6 lw 2 lc rgb '#f0e442'


#lc rgb 0x000000
#lc rgb 0xe69f00 #orange
#lc rgb 0x56b4e9 #skyblue
#lc rgb 0x009e73 #bluish green
#lc rgb 0xf0e442 #yellow
#lc rgb 0x0072b2 #blue
#lc rgb 0xd55e00 #dark orange (vermillon)
#lc rgb 0xcc79a7 # reddish purple

set output 'flanksimDc.png'
set key top right
set ylabel font "courier,12" 'Declination (degree)'

plot loc u 0:6 w l ls 1 t "IGRF dec" axis x1y1, loc u 4:($5-1) w l ls 2 t "surface 5m DEM" axis x1y2, loc u 4:9 w l ls 3 t "field topography -h:100 " axis x1y2, loc u 4:8 w lp ls 7 t "Noise f2 5m 50r DEM + IGRF" axis x1y1, loc2.'measurements_path_refFieldIGRF.ascii' u 1:7 w lp ls 4 t "Noise f1 5m 50r DEM + IGRF" axis x1y1, loc3.'results_5m_site6_path1_sdem5_ho1/measurements_path_refFieldIGRF.ascii' u 1:7 w lp ls 5 t "5m 50r DEM + IGRF" axis x1y1,  loc u 4:12 w lp ls 6 t "field measurements -h:100" axis x1y1



#unset key
set output 'flanksimIn.png'
#set yrange[39:52]
set ylabel font "courier,12" 'intensity (microT)'

plot (45.20) w l ls 1 t "IGRF int" axis x1y1, loc2.'measurements_path.ascii' u 10:($3-1) w l ls 2 t "surface 5m DEM" axis x1y2, loc.'sites/6-1-1.txt' u 8:($4-8.5) w l ls 3 t "field topography" axis x1y2, loc.'results_noise_2_5m_site6_path1_sdem5_ho1/measurements_path_refFieldIGRF.ascii' u 1:($5*1e6) w lp ls 7 t "Noise f2 5m 50r DEM + IGRF" axis x1y1, loc2.'measurements_path_refFieldIGRF.ascii'  u 1:($5*1e6) w lp ls 4 t "Noise f1 5m 50r DEM + IGRF" axis x1y1, loc.'results_5m_site6_path1_sdem5_ho1/measurements_path_refFieldIGRF.ascii' u 1:($5*1e6) w lp ls 5 t "5m 50r DEM + IGRF" axis x1y1, loc.'sites/6-1-1.txt' u 8:($7) w lp ls 6 t "field measurements -h:100" axis x1y1 
#
set output 'flanksimIc.png'
#set yrange[46:66]
set ylabel font "courier,12" 'Inclination (degree)'

plot (53.53) w l ls 1 t "IGRF inc" axis x1y1, loc2.'measurements_path.ascii' u 10:($3-1) w l ls 2 t "surface 5m DEM" axis x1y2, loc.'sites/6-1-1.txt' u 8:($4-8.5) w l ls 3 t "field topography" axis x1y2, loc.'results_noise_2_5m_site6_path1_sdem5_ho1/measurements_path_refFieldIGRF.ascii'  u 1:6 w lp ls 7 t "Noise f2 5m 50r DEM + IGRF" axis x1y1, loc2.'measurements_path_refFieldIGRF.ascii' u 1:6 w lp ls 4 t "Noise f1 5m 50r DEM + IGRF" axis x1y1, loc.'results_5m_site6_path1_sdem5_ho1/measurements_path_refFieldIGRF.ascii' u 1:6 w lp ls 5 t "5m 50r DEM + IGRF" axis x1y1, loc.'sites/6-1-1.txt' u 8:($5) w lp ls 6 t "field measurements -h:100" axis x1y1



