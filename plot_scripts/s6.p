set terminal pngcairo size 1800,1200

set key default
set key box
set xlabel font "Cambria,12" 'distance (m)'
set ylabel font "Cambria,12" 'intensity (microT)'
set y2label font "Cambria,12" 'height surface (m)' 
set autoscale xy
set y2tics 1528,2
set ytics nomirror
set y2range[1534:1558]
set xrange [0:321]
set style line 12 lc rgb '#aaaaaa' dt 2 lw 0.5
set grid back ytics ls 12
#set title offset -75,-3


loc1 = '/home/agnes/MTE/fieldstone_138_copy/results_5m_site6_path1_sdem4_ho1/measurements_path_plotfile.ascii'
loc2 = '/home/agnes/MTE/fieldstone_138_copy/results_noise_5m_site6_path1_sdem4_ho1/measurements_path_plotfile.ascii'

loc3 = '/home/agnes/MTE/fieldstone_138_copy/results_noise_1_5m_site6_path1_sdem4_ho1/measurements_path_plotfile.ascii'
loc4 = '/home/agnes/MTE/fieldstone_138_copy/Results_Lz10/results_5m_site6_path1_sdem4_ho1/measurements_path_plotfile.ascii'
loc5 = '/home/agnes/MTE/fieldstone_138_copy/results_fb_5m_site6_path1_sdem4_ho1/measurements_path_plotfile.ascii'



set key default
#set style line 1 lw 2 lc "grey50"
set style line 1 lw 3 lc "web-green"
set style line 2 lw 2 lc "black" 
set style line 3 lw 2 lc "grey50" 
#set style line 2 lw 2 lc "web-green" 
#set style line 3 lw 2 lc "dark-olivegreen"
set style line 4 pt 7 ps 1.5 lw 3 lc "red"
set style line 14 pt 6 dt (50,8,20,8) ps 1.5 lw 3 lc "coral"
set style line 5 pt 5 ps 1.5 lw 3 lc "royalblue"
set style line 15 pt 4 dt (50,8,20,8) ps 1.5 lw 3 lc "skyblue"
set style line 6 pt 8 ps 1.5 lw 3 lc rgb '#cc79a7' # reddish purple
set style line 7 pt 12 ps 1.5 lw 3 lc "gold"

set style line 5 pt 5 ps 1.5 lw 3 lc "steelblue"
set style line 15 pt 4 ps 1.5 lw 3 lc "spring-green"
set style line 25 pt 3 ps 1.5 lw 3 lc "dark-cyan"
set style line 35 pt 2  ps 1.5 lw 3 lc "magenta"
set style line 45 pt 4 ps 1.5 lw 3 lc "goldenred"
set style line 5 pt 5 ps 1.5 lw 3 lc "royalblue"
#lc rgb 0x000000
#lc rgb 0xe69f00 #orange
#lc rgb 0x56b4e9 #skyblue
#lc rgb 0x009e73 #bluish green
#lc rgb 0xf0e442 #yellow
#lc rgb 0x0072b2 #blue
#lc rgb 0xd55e00 #dark orange (vermillon)
#lc rgb 0xcc79a7 # reddish purple


#unset key
set output 's6_IGRF_Int.png'
set yrange[39:52]
set ylabel font "courier,14" 'intensity ({/Symbol m}T)'
#set title font "courier,14"  's:6 p:1 - Intensity'
plot loc1 u 4:($1*1e6) w l ls 1 t "IGRF int" axis x1y1,\
     loc1 u 4:($5-1) w l ls 2 t "surface 5m DEM" axis x1y2,\
     loc1 u 4:9 w l ls 3 t "field topography" axis x1y2,\
     loc1 u 4:($6*1e6) w lp ls 5 t "5m 300 DEM + IGRF" axis x1y1,\
     loc1 u 4:10 w lp ls 4 t "field measurements -h:100" axis x1y1 
#
set output 's6_IGRF_Inc.png'
set yrange[46:66]
set ylabel font "courier,14" 'inclination ({/Symbol \260})'
#set title font "courier,14"  's:6 p:1 - inclination '
plot loc1 u 4:2 w l ls 1 t "IGRF inc" axis x1y1,\
     loc1 u 4:($5-1) w l ls 2 t "surface 5m DEM" axis x1y2,\
     loc1 u 4:9 w l ls 3 t "field topography" axis x1y2,\
     loc1 u 4:($7) w lp ls 5 t "5m 300 DEM + IGRF" axis x1y1,\
     loc1 u 4:11 w lp ls 4 t "field measurements -h:100" axis x1y1

set output 's6_IGRF_Dec.png'
set key top right
set yrange[-15:10]
set ylabel font "courier,14" 'declination ({/Symbol \260})'
#set title font "courier,14"  's:6 p:1 - declination'
plot loc1 u 4:3 w l ls 1 t "IGRF dec" axis x1y1,\
     loc1 u 4:($5-1) w l ls 2 t "surface 5m DEM" axis x1y2,\
     loc1 u 4:9 w l ls 3 t "field topography " axis x1y2,\
     loc1 u 4:8 w lp ls 5 t "5m 300 DEM + IGRF" axis x1y1,\
     loc1 u 4:12 w lp ls 4 t "field measurements -h:100" axis x1y1

################################################
set terminal pngcairo size 1200,1800
set output 's6_mp.png'
set yrange[*:*]
set multiplot layout 3,1
#unset title
set ylabel font "courier,14" 'intensity ({/Symbol m}T)'
plot loc1 u 4:($1*1e6) w l ls 1 t "IGRF int" axis x1y1,\
     loc1 u 4:($5-1) w l ls 2 t "surface 5m DEM" axis x1y2,\
     loc1 u 4:9 w l ls 3 t "field topography" axis x1y2,\
     loc1 u 4:($6*1e6) w lp ls 5 t "5m 300 DEM + IGRF" axis x1y1,\
     loc1 u 4:10 w lp ls 4 t "field measurements -h:100" axis x1y1 


set ylabel font "courier,14" 'inclination ({/Symbol \260})'
plot loc1 u 4:2 w l ls 1 t "IGRF inc" axis x1y1,\
     loc1 u 4:($5-1) w l ls 2 t "surface 5m DEM" axis x1y2,\
     loc1 u 4:9 w l ls 3 t "field topography" axis x1y2,\
     loc1 u 4:($7) w lp ls 5 t "5m 300 DEM + IGRF" axis x1y1,\
     loc1 u 4:11 w lp ls 4 t "field measurements -h:100" axis x1y1

set yrange[-15:10]
set ylabel font "courier,14" 'declination ({/Symbol \260})'
plot loc1 u 4:3 w l ls 1 t "IGRF dec" axis x1y1,\
     loc1 u 4:($5-1) w l ls 2 t "surface 5m DEM" axis x1y2,\
     loc1 u 4:9 w l ls 3 t "field topography " axis x1y2,\
     loc1 u 4:8 w lp ls 5 t "5m 300 DEM + IGRF" axis x1y1,\
     loc1 u 4:12 w lp ls 4 t "field measurements -h:100" axis x1y1

unset multiplot

