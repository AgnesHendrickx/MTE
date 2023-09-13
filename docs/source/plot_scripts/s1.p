#urloc = ' ... ' 
urloc = '/home/agnes/MTE/fieldstone_138_copy/'
loc1 = urloc.'results_5m_site1_path1_sdem2_ho1/measurements_path_plotfile.ascii'
loc2 = urloc.'results_5m_site1_path1_sdem2_ho2/measurements_path_plotfile.ascii'
loc3 = urloc.'results_5m_site1_path2_sdem2_ho1/measurements_path_plotfile.ascii'
loc4 = urloc.'results_5m_site1_path2_sdem2_ho2/measurements_path_plotfile.ascii'
loc5 = urloc.'results_5m_site1_path3_sdem2_ho1/measurements_path_plotfile.ascii'
loc6 = urloc.'results_5m_site1_path3_sdem2_ho2/measurements_path_plotfile.ascii'

set terminal pngcairo size 1800,1200

set key default
set xlabel font "courier,14" 'distance (m)'
set y2label font "courier,14" 'height surface (m)' 
set autoscale xy
set y2tics 1600,1
set ytics nomirror
#set y2range[1614:1620
set y2range[1611:1619]
#set y2range[1609:1612]

set autoscale xy
set ytics nomirror
set style line 12 lc rgb '#aaaaaa' dt 2 lw 0.5
set grid back ytics ls 12
set tics out font "courier,14"
#dt (50,8,20,8)
#dt (50,8,20,8)
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
set style line 7 pt 10 ps 1.5 lw 3 lc rgb '#f0e442' #yellow

#lc rgb 0x000000
#lc rgb 0xe69f00 #orange
#lc rgb 0x56b4e9 #skyblue
#lc rgb 0x009e73 #bluish green
#lc rgb 0xf0e442 #yellow
#lc rgb 0x0072b2 #blue
#lc rgb 0xd55e00 #dark orange (vermillon)
#lc rgb 0xcc79a7 # reddish purple
#################################################################################################
set xrange [0:66]
set output 's1p1_int.png'
set key top left font "courier,14"
set ylabel font "courier,14" 'intensity ({/Symbol m}T)'

plot loc1 u 4:($1*1e6) w l ls 1 t "IGRF int" axis x1y1,\
     loc1 u 4:($5-1) w l ls 2 t "surface 5m DEM" axis x1y2,\
     loc1 u 4:($9) w l ls 3 t "field topography -h:100 " axis x1y2,\
     loc1 u 4:($6*1e6) w lp ls 5 t "5m 300 DEM + IGRF -h:100" axis x1y1,\
     loc2 u 4:($6*1e6) w lp ls 15 t "5m 300 DEM + IGRF -h:180" axis x1y1,\
     loc1 u 4:10 w lp ls 4 t "field measurements -h:100" axis x1y1,\
     loc2 u 4:10 w lp ls 14 t "field measurements -h:180" axis x1y1

set output 's1p1_ic.png'
set key top left font "courier,14"
set ylabel font "courier,14" 'inclination ({/Symbol \260})'
plot loc1 u 4:2 w l ls 1 t "IGRF inc" axis x1y1,\
     loc1 u 4:($5-1) w l ls 2 t "surface 5m DEM" axis x1y2,\
     loc1 u 4:($9) w l ls 3 t "field topography -h:100 " axis x1y2,\
     loc1 u 4:7 w lp ls 5 t "5m 300 DEM + IGRF -h:100" axis x1y1,\
     loc2 u 4:7 w lp ls 15 t "5m 300 DEM + IGRF -h:180" axis x1y1,\
     loc1 u 4:11 w lp ls 4 t "field measurements -h:100" axis x1y1,\
     loc2 u 4:11 w lp ls 14 t "field measurements -h:180" axis x1y1

set output 's1p1_dc.png'
set key top left font "courier,14"
set yrange[-4:7]
set ylabel font "courier,14" 'declination ({/Symbol \260})'
plot loc1 u 4:3 w l ls 1 t "IGRF dec" axis x1y1,\
     loc1 u 4:($5-1) w l ls 2 t "surface 5m DEM" axis x1y2,\
     loc1 u 4:($9) w l ls 3 t "field topography -h:100 " axis x1y2,\
     loc1 u 4:8 w lp ls 5 t "5m 300 DEM + IGRF -h:100" axis x1y1,\
     loc2 u 4:8 w lp ls 15 t "5m 300 DEM + IGRF -h:180" axis x1y1,\
     loc1 u 4:12 w lp ls 4 t "field measurements -h:100" axis x1y1,\
     loc2 u 4:12 w lp ls 14 t "field measurements -h:180" axis x1y1
################################################
set terminal pngcairo size 1200,1800
set output 's1p1_mp.png'
set yrange[*:*]
set multiplot layout 3,1
#unset title

set key bottom right font "courier,14"
set ylabel font "courier,14" 'intensity ({/Symbol m}T)'
plot loc1 u 4:($1*1e6) w l ls 1 t "IGRF int" axis x1y1,\
     loc1 u 4:($5-1) w l ls 2 t "surface 5m DEM" axis x1y2,\
     loc1 u 4:9 w l ls 3 t "field topography -h:100 " axis x1y2,\
     loc1 u 4:($6*1e6) w lp ls 5 t "5m 300 DEM + IGRF -h:100" axis x1y1,\
     loc2 u 4:($6*1e6) w lp ls 15 t "5m 300 DEM + IGRF -h:180" axis x1y1,\
     loc1 u 4:10 w lp ls 4 t "field measurements -h:100" axis x1y1,\
     loc2 u 4:10 w lp ls 14 t "field measurements -h:180" axis x1y1

unset key
set ylabel font "courier,14" 'inclination ({/Symbol \260})'
plot loc1 u 4:2 w l ls 1 t "IGRF inc" axis x1y1,\
     loc1 u 4:($5-1) w l ls 2 t "surface 5m DEM" axis x1y2,\
     loc1 u 4:9 w l ls 3 t "field topography -h:100 " axis x1y2,\
     loc1 u 4:7 w lp ls 5 t "5m 300 DEM + IGRF -h:100" axis x1y1,\
     loc2 u 4:7 w lp ls 15 t "5m 300 DEM + IGRF -h:180" axis x1y1,\
     loc1 u 4:11 w lp ls 4 t "field measurements -h:100" axis x1y1,\
     loc2 u 4:11 w lp ls 14 t "field measurements -h:180" axis x1y1


set yrange[-4:7]
set ylabel font "courier,14" 'declination ({/Symbol \260})'
plot loc1 u 4:3 w l ls 1 t "IGRF dec" axis x1y1,\
     loc1 u 4:($5-1) w l ls 2 t "surface 5m DEM" axis x1y2,\
     loc1 u 4:9 w l ls 3 t "field topography -h:100 " axis x1y2,\
     loc1 u 4:8 w lp ls 5 t "5m 300 DEM + IGRF -h:100" axis x1y1,\
     loc2 u 4:8 w lp ls 15 t "5m 300 DEM + IGRF -h:180" axis x1y1,\
     loc1 u 4:12 w lp ls 4 t "field measurements -h:100" axis x1y1,\
     loc2 u 4:12 w lp ls 14 t "field measurements -h:180" axis x1y1
unset multiplot
#################################################################################################
set terminal pngcairo size 1800,1200
set yrange[*:*]
set y2range[1610:1617]
set xrange [0:55]
set output 's1p2_int.png'
set key top left font "courier,14"
set ylabel font "courier,14" 'intensity ({/Symbol m}T)'

plot loc3 u 4:($1*1e6) w l ls 1 t "IGRF int" axis x1y1,\
     loc3 u 4:($5-1) w l ls 2 t "surface 5m DEM" axis x1y2,\
     loc3 u 4:9 w l ls 3 t "field topography -h:100 " axis x1y2,\
     loc3 u 4:($6*1e6) w lp ls 5 t "5m 300 DEM + IGRF -h:100" axis x1y1,\
     loc4 u 4:($6*1e6) w lp ls 15 t "5m 300 DEM + IGRF -h:180" axis x1y1,\
     loc3 u 4:10 w lp ls 4 t "field measurements -h:100" axis x1y1,\
     loc4 u 4:10 w lp ls 14 t "field measurements -h:180" axis x1y1

set output 's1p2_ic.png'
set key top left font "courier,14"
set ylabel font "courier,14" 'inclination ({/Symbol \260})'
plot loc3 u 4:2 w l ls 1 t "IGRF inc" axis x1y1,\
     loc3 u 4:($5-1) w l ls 2 t "surface 5m DEM" axis x1y2,\
     loc3 u 4:9 w l ls 3 t "field topography -h:100 " axis x1y2,\
     loc3 u 4:7 w lp ls 5 t "5m 300 DEM + IGRF -h:100" axis x1y1,\
     loc4 u 4:7 w lp ls 15 t "5m 300 DEM + IGRF -h:180" axis x1y1,\
     loc3 u 4:11 w lp ls 4 t "field measurements -h:100" axis x1y1,\
     loc4 u 4:11 w lp ls 14 t "field measurements -h:180" axis x1y1

set output 's1p2_dc.png'
set key top left font "courier,14"
set yrange[-3:6]
set ylabel font "courier,14" 'declination ({/Symbol \260})'
plot loc3 u 4:3 w l ls 1 t "IGRF dec" axis x1y1,\
     loc3 u 4:($5-1) w l ls 2 t "surface 5m DEM" axis x1y2,\
     loc3 u 4:9 w l ls 3 t "field topography -h:100 " axis x1y2,\
     loc3 u 4:8 w lp ls 5 t "5m 300 DEM + IGRF -h:100" axis x1y1,\
     loc4 u 4:8 w lp ls 15 t "5m 300 DEM + IGRF -h:180" axis x1y1,\
     loc3 u 4:12 w lp ls 4 t "field measurements -h:100" axis x1y1,\
     loc4 u 4:12 w lp ls 14 t "field measurements -h:180" axis x1y1
################################################
set terminal pngcairo size 1200,1800
set output 's1p2_mp.png'
set yrange[*:*]
set multiplot layout 3,1
#unset title

set key bottom right font "courier,14"
set ylabel font "courier,14" 'intensity ({/Symbol m}T)'
plot loc3 u 4:($1*1e6) w l ls 1 t "IGRF int" axis x1y1,\
     loc3 u 4:($5-1) w l ls 2 t "surface 5m DEM" axis x1y2,\
     loc3 u 4:9 w l ls 3 t "field topography -h:100 " axis x1y2,\
     loc3 u 4:($6*1e6) w lp ls 5 t "5m 300 DEM + IGRF -h:100" axis x1y1,\
     loc4 u 4:($6*1e6) w lp ls 15 t "5m 300 DEM + IGRF -h:180" axis x1y1,\
     loc3 u 4:10 w lp ls 4 t "field measurements -h:100" axis x1y1,\
     loc4 u 4:10 w lp ls 14 t "field measurements -h:180" axis x1y1

unset key
set ylabel font "courier,14" 'inclination ({/Symbol \260})'
plot loc3 u 4:2 w l ls 1 t "IGRF inc" axis x1y1,\
     loc3 u 4:($5-1) w l ls 2 t "surface 5m DEM" axis x1y2,\
     loc3 u 4:9 w l ls 3 t "field topography -h:100 " axis x1y2,\
     loc3 u 4:7 w lp ls 5 t "5m 300 DEM + IGRF -h:100" axis x1y1,\
     loc4 u 4:7 w lp ls 15 t "5m 300 DEM + IGRF -h:180" axis x1y1,\
     loc3 u 4:11 w lp ls 4 t "field measurements -h:100" axis x1y1,\
     loc4 u 4:11 w lp ls 14 t "field measurements -h:180" axis x1y1


set yrange[-3:6]
set ylabel font "courier,14" 'declination ({/Symbol \260})'
plot loc3 u 4:3 w l ls 1 t "IGRF dec" axis x1y1,\
     loc3 u 4:($5-1) w l ls 2 t "surface 5m DEM" axis x1y2,\
     loc3 u 4:9 w l ls 3 t "field topography -h:100 " axis x1y2,\
     loc3 u 4:8 w lp ls 5 t "5m 300 DEM + IGRF -h:100" axis x1y1,\
     loc4 u 4:8 w lp ls 15 t "5m 300 DEM + IGRF -h:180" axis x1y1,\
     loc3 u 4:12 w lp ls 4 t "field measurements -h:100" axis x1y1,\
     loc4 u 4:12 w lp ls 14 t "field measurements -h:180" axis x1y1
unset multiplot
#################################################################################################
set terminal pngcairo size 1800,1200
set yrange[*:*]

set y2range[1606:1612]
set xrange [0:60]
 

set output 's1p3_int.png'
set key top left font "courier,14"
set ylabel font "courier,14" 'intensity ({/Symbol m}T)'

plot loc5 u 4:($1*1e6) w l ls 1 t "IGRF int" axis x1y1,\
     loc5 u 4:($5-1) w l ls 2 t "surface 5m DEM" axis x1y2,\
     loc5 u 4:9 w l ls 3 t "field topography -h:100 " axis x1y2,\
     loc5 u 4:($6*1e6) w lp ls 5 t "5m 300 DEM + IGRF -h:100" axis x1y1,\
     loc6 u 4:($6*1e6) w lp ls 15 t "5m 300 DEM + IGRF -h:180" axis x1y1,\
     loc5 u 4:10 w lp ls 4 t "field measurements -h:100" axis x1y1,\
     loc6 u 4:10 w lp ls 14 t "field measurements -h:180" axis x1y1

set output 's1p3_ic.png'
set key top left font "courier,14"
set ylabel font "courier,14" 'inclination ({/Symbol \260})'
plot loc5 u 4:2 w l ls 1 t "IGRF inc" axis x1y1,\
     loc5 u 4:($5-1) w l ls 2 t "surface 5m DEM" axis x1y2,\
     loc5 u 4:9 w l ls 3 t "field topography -h:100 " axis x1y2,\
     loc5 u 4:7 w lp ls 5 t "5m 300 DEM + IGRF -h:100" axis x1y1,\
     loc6 u 4:7 w lp ls 15 t "5m 300 DEM + IGRF -h:180" axis x1y1,\
     loc5 u 4:11 w lp ls 4 t "field measurements -h:100" axis x1y1,\
     loc6 u 4:11 w lp ls 14 t "field measurements -h:180" axis x1y1

set output 's1p3_dc.png'
set key top left font "courier,14"
set yrange[-4:7]
set ylabel font "courier,14" 'declination ({/Symbol \260})'
plot loc5 u 4:3 w l ls 1 t "IGRF dec" axis x1y1,\
     loc5 u 4:($5-1) w l ls 2 t "surface 5m DEM" axis x1y2,\
     loc5 u 4:9 w l ls 3 t "field topography -h:100 " axis x1y2,\
     loc5 u 4:8 w lp ls 5 t "5m 300 DEM + IGRF -h:100" axis x1y1,\
     loc6 u 4:8 w lp ls 15 t "5m 300 DEM + IGRF -h:180" axis x1y1,\
     loc5 u 4:12 w lp ls 4 t "field measurements -h:100" axis x1y1,\
     loc6 u 4:12 w lp ls 14 t "field measurements -h:180" axis x1y1
################################################
set terminal pngcairo size 1200,1800
set output 's1p3_mp.png'
set yrange[*:*]
set multiplot layout 3,1
#unset title

set key bottom right font "courier,14"
set ylabel font "courier,14" 'intensity ({/Symbol m}T)'
plot loc5 u 4:($1*1e6) w l ls 1 t "IGRF int" axis x1y1,\
     loc5 u 4:($5-1) w l ls 2 t "surface 5m DEM" axis x1y2,\
     loc5 u 4:9 w l ls 3 t "field topography -h:100 " axis x1y2,\
     loc5 u 4:($6*1e6) w lp ls 5 t "5m 300 DEM + IGRF -h:100" axis x1y1,\
     loc6 u 4:($6*1e6) w lp ls 15 t "5m 300 DEM + IGRF -h:180" axis x1y1,\
     loc5 u 4:10 w lp ls 4 t "field measurements -h:100" axis x1y1,\
     loc6 u 4:10 w lp ls 14 t "field measurements -h:180" axis x1y1

unset key
set ylabel font "courier,14" 'inclination ({/Symbol \260})'
plot loc5 u 4:2 w l ls 1 t "IGRF inc" axis x1y1,\
     loc5 u 4:($5-1) w l ls 2 t "surface 5m DEM" axis x1y2,\
     loc5 u 4:9 w l ls 3 t "field topography -h:100 " axis x1y2,\
     loc5 u 4:7 w lp ls 5 t "5m 300 DEM + IGRF -h:100" axis x1y1,\
     loc6 u 4:7 w lp ls 15 t "5m 300 DEM + IGRF -h:180" axis x1y1,\
     loc5 u 4:11 w lp ls 4 t "field measurements -h:100" axis x1y1,\
     loc6 u 4:11 w lp ls 14 t "field measurements -h:180" axis x1y1

set yrange[-4:7]
set ylabel font "courier,14" 'declination ({/Symbol \260})'
plot loc5 u 4:3 w l ls 1 t "IGRF dec" axis x1y1,\
     loc5 u 4:($5-1) w l ls 2 t "surface 5m DEM" axis x1y2,\
     loc5 u 4:9 w l ls 3 t "field topography -h:100 " axis x1y2,\
     loc5 u 4:8 w lp ls 5 t "5m 300 DEM + IGRF -h:100" axis x1y1,\
     loc6 u 4:8 w lp ls 15 t "5m 300 DEM + IGRF -h:180" axis x1y1,\
     loc5 u 4:12 w lp ls 4 t "field measurements -h:100" axis x1y1,\
     loc6 u 4:12 w lp ls 14 t "field measurements -h:180" axis x1y1
unset multiplot
#################################################################################################
