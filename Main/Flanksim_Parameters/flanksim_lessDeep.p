loc1 = '/home/agnes/MTE/fieldstone_138/Benchmark 4/north/250_250_20/measurements_line_plotfile.ascii'
loc2 = '/home/agnes/MTE/fieldstone_138/Benchmark 4/east/250_250_20/measurements_line_plotfile.ascii'
loc3 = '/home/agnes/MTE/fieldstone_138/Benchmark 4/south/250_250_20/measurements_line_plotfile.ascii'
loc4 = '/home/agnes/MTE/fieldstone_138/Benchmark 4/west/250_250_20/measurements_line_plotfile.ascii'
loc5 = '/home/agnes/MTE/fieldstone_138/Benchmark 4/north/250_250_20/measurements_path_refFieldIGRF.ascii'
loc6 = '/home/agnes/MTE/fieldstone_138/Benchmark 4/east/250_250_20/measurements_path_refFieldIGRF.ascii'
loc7 = '/home/agnes/MTE/fieldstone_138/Benchmark 4/south/250_250_20/measurements_path_refFieldIGRF.ascii'
loc8 = '/home/agnes/MTE/fieldstone_138/Benchmark 4/west/250_250_20/measurements_path_refFieldIGRF.ascii'

#IGRFx=26850.3e-9
#IGRFy=1561.2e-9
#IGRFz=36305.7e-9  


set terminal pngcairo size 1800,1200

set key default
set key box
set xlabel font "courier,12" 'distance (m)'
set ylabel font "courier,12" 'intensity ({/Symbol m}T)'
set y2label font "courier,12" 'height surface (m)' 
set autoscale xy
set ytics nomirror
set style line 12 lc rgb '#aaaaaa' dt 2 lw 0.5
set grid back ytics ls 12
set y2range[-6:6]
set y2tics -6,1
set tics out font "courier,14"
set xrange[100:150]

set style line 1 lw 2 lc "grey40"
set style line 2 lw 3 lc rgb '#000000' dt (50,4,2,4)
set style line 3 lw 3 lc rgb '#d55e00' dt (50,4,2,4)
set style line 4 pt 2 lw 2 lc rgb '#0072b2'
set style line 5 pt 4 lw 2 lc rgb '#009e73' 
set style line 6 pt 6 lw 2 lc rgb '#d55e00'
set style line 15 pt 3 dt (50,4,2,4) lw 2 lc rgb '#009e73' 
set style line 16 pt 5 dt (50,4,2,4) lw 2 lc rgb '#d55e00'
set style line 7 pt 8 lw 2 lc rgb '#f0e442'


#lc rgb 0x000000
#lc rgb 0xe69f00 #orange
#lc rgb 0x56b4e9 #skyblue
#lc rgb 0x009e73 #bluish green
#lc rgb 0xf0e442 #yellow
#lc rgb 0x0072b2 #blue
#lc rgb 0xd55e00 #dark orange (vermillon)
#lc rgb 0xcc79a7 # reddish purple

set key top right

set output 'flanksimIn.png'
set ylabel font "courier,12" 'intensity ({/Symbol m}T)'

plot loc1 u 1:($4*1e6) w l ls 1 t "IGRF int" axis x1y1,\
     loc1 u 1:($3-1) w l ls 2 t "surface" axis x1y2,\
     loc1 u 1:($7*1e6) w lp ls 7 t "North flank" axis x1y1,\
     loc2 u 2:($7*1e6) w lp ls 6 t "East flank" axis x1y1,\
     loc3 u 1:($7*1e6) w lp ls 5 t "South flank" axis x1y1,\
     loc4 u 2:($7*1e6) w lp ls 4 t "West flank" axis x1y1

set output 'flanksimIc.png'
set ylabel font "courier,12" 'Inclination (degree)'

plot loc1 u 1:5 w l ls 1 t "IGRF inc" axis x1y1,\
     loc1 u 1:($3-1) w l ls 2 t "surface" axis x1y2,\
     loc1 u 1:8 w lp ls 7 t "North flank" axis x1y1,\
     loc2 u 2:8 w lp ls 6 t "East flank" axis x1y1,\
     loc3 u 1:8 w lp ls 5 t "South flank" axis x1y1,\
     loc4 u 2:8 w lp ls 4 t "West flank" axis x1y1


set output 'flanksimDc.png'

set ylabel font "courier,12" 'Declination (degree)'

plot loc1 u 1:6 w l ls 1 t "IGRF dec" axis x1y1,\
     loc1 u 1:($3-1) w l ls 2 t "surface" axis x1y2,\
     loc1 u 1:9 w lp ls 7 t "North flank" axis x1y1,\
     loc2 u 2:9 w lp ls 6 t "East flank" axis x1y1,\
     loc3 u 1:9 w lp ls 5 t "South flank" axis x1y1,\
     loc4 u 2:9 w lp ls 4 t "West flank" axis x1y1
###########################################
set terminal pngcairo size 1200,1800
set output 'flanksim_mp.png'
set multiplot layout 3,1

set ylabel font "courier,12" 'intensity ({/Symbol m}T)'
plot loc1 u 1:($4*1e6) w l ls 1 t "IGRF int" axis x1y1,\
     loc1 u 1:($3-1) w l ls 2 t "surface" axis x1y2,\
     loc1 u 1:($7*1e6) w lp ls 7 t "North flank" axis x1y1,\
     loc2 u 2:($7*1e6) w lp ls 6 t "East flank" axis x1y1,\
     loc3 u 1:($7*1e6) w lp ls 5 t "South flank" axis x1y1,\
     loc4 u 2:($7*1e6) w lp ls 4 t "West flank" axis x1y1

set ylabel font "courier,12" 'Inclination (degree)'
plot loc1 u 1:5 w l ls 1 t "IGRF inc" axis x1y1,\
     loc1 u 1:($3-1) w l ls 2 t "surface" axis x1y2,\
     loc1 u 1:8 w lp ls 7 t "North flank" axis x1y1,\
     loc2 u 2:8 w lp ls 6 t "East flank" axis x1y1,\
     loc3 u 1:8 w lp ls 5 t "South flank" axis x1y1,\
     loc4 u 2:8 w lp ls 4 t "West flank" axis x1y1

set ylabel font "courier,12" 'Declination (degree)'
plot loc1 u 1:6 w l ls 1 t "IGRF dec" axis x1y1,\
     loc1 u 1:($3-1) w l ls 2 t "surface" axis x1y2,\
     loc1 u 1:9 w lp ls 7 t "North flank" axis x1y1,\
     loc2 u 2:9 w lp ls 6 t "East flank" axis x1y1,\
     loc3 u 1:9 w lp ls 5 t "South flank" axis x1y1,\
     loc4 u 2:9 w lp ls 4 t "West flank" axis x1y1
unset multiplot
###########################################
set terminal pngcairo size 1200,1800
set output 'flanksim_comp_mp.png'
set xlabel font "courier,12" 'index'
set xrange [0:47]
set multiplot layout 3,1
set title font "courier,14" 'flanksim components + IGRF'
set ylabel font "courier,12" 'Bx (Northing) ({/Symbol m}T)'
plot (26850.3e-3) w l ls 1 t "IGRFx" axis x1y1,\
     loc1 u 0:($3-1) w l ls 2 t "surface" axis x1y2,\
     loc5 u 0:($1*1e6) w lp ls 7 t "North flank" axis x1y1,\
     loc6 u 0:($1*1e6) w lp ls 6 t "East flank" axis x1y1,\
     loc7 u 0:($1*1e6) w lp ls 5 t "South flank" axis x1y1,\
     loc8 u 0:($1*1e6) w lp ls 4 t "West flank" axis x1y1

set ylabel font "courier,12" 'By (Easting) ({/Symbol m}T)'
plot (1561.2e-3) w l ls 1 t "IGRFy" axis x1y1,\
     loc1 u 0:($3-1) w l ls 2 t "surface" axis x1y2,\
     loc5 u 0:($2*1e6) w lp ls 7 t "North flank" axis x1y1,\
     loc6 u 0:($2*1e6) w lp ls 6 t "East flank" axis x1y1,\
     loc7 u 0:($2*1e6) w lp ls 5 t "South flank" axis x1y1,\
     loc8 u 0:($2*1e6) w lp ls 4 t "West flank" axis x1y1

set ylabel font "courier,12" 'Bz (Downing) ({/Symbol m}T)'
plot (36305.7e-3) w l ls 1 t "IGRF z" axis x1y1,\
     loc1 u 0:($3-1) w l ls 2 t "surface" axis x1y2,\
     loc5 u 0:($3*1e6) w lp ls 7 t "North flank" axis x1y1,\
     loc6 u 0:($3*1e6) w lp ls 6 t "East flank" axis x1y1,\
     loc7 u 0:($3*1e6) w lp ls 5 t "South flank" axis x1y1,\
     loc8 u 0:($3*1e6) w lp ls 4 t "West flank" axis x1y1


unset multiplot
