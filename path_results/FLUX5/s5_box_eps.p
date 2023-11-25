
loc1 = './results_5m_site5_path1_sdem2_ho1_fb_zt/measurements_path_plotfile.ascii'
loc2 = './results_5m_site5_path1_sdem2_ho2_fb_zt/measurements_path_plotfile.ascii'
loc7 = './results_5m_site5_path1_sdem2_ho3_fb_zt/measurements_path_plotfile.ascii'
loc8 = './results_5m_site5_path1_sdem2_ho4_fb_zt/measurements_path_plotfile.ascii'

loc3 = './results_5m_site5_path2_sdem2_ho1_fb_zt/measurements_path_plotfile.ascii'
loc4 = './results_5m_site5_path2_sdem2_ho2_fb_zt/measurements_path_plotfile.ascii'
loc9 = './results_5m_site5_path2_sdem2_ho3_fb_zt/measurements_path_plotfile.ascii'
loc10 = './results_5m_site5_path2_sdem2_ho4_fb_zt/measurements_path_plotfile.ascii'

loc5 = './results_5m_site5_path3_sdem2_ho1_fb_zt/measurements_path_plotfile.ascii'
loc6 = './results_5m_site5_path3_sdem2_ho2_fb_zt/measurements_path_plotfile.ascii'
loc11 = './results_5m_site5_path3_sdem2_ho3_fb_zt/measurements_path_plotfile.ascii'
loc12 = './results_5m_site5_path3_sdem2_ho4_fb_zt/measurements_path_plotfile.ascii'



set terminal epscairo enhanced size 16cm,22cm

set style line 1 pt 2 lw 3 ps 0.5 lc 'grey20' dt 2

set style fill transparent solid 0.15 noborder
#set style line 2 lw 1.5 lc "black"
#set style line 3 lw 1.5 lc "grey50"

set style line 2 lw 1.5 lc "steelblue"
set style line 3 lw 1.5 lc rgb '#CD5C5C'

set style line 4 pt 7 ps 1.5 lw 3 lc "dark-red"
set style line 14 pt 6 dt (50,8,20,8) ps 1.5 lw 3 lc "red"
set style line 24 pt 9 dt 2 ps 1.5 lw 3 lc "coral"
set style line 34 pt 8 dt (1,1,1,1) ps 1.5 lw 3 lc "tan1"

set style line 5 pt 5 ps 1.5 lw 3 lc "dark-blue"
set style line 15 pt 4 dt (50,8,20,8) ps 1.5 lw 3 lc "royalblue"
set style line 25 pt 3 dt 2 ps 1.5 lw 3 lc "dark-cyan"
set style line 35 pt 2 dt (1,1,1,1) ps 1.5 lw 3 lc "skyblue"
set style line 6 pt 11 lw 4 ps 1.5 lc "web-green"

set style line 12 lc 'grey80' dt 2 lw 0.5

set key default font "times,12" box lc 'grey60' opaque vertical top right height 0.5 width 1.5

set xtics out font "times,12"
set ytics out font "times,12"
set y2tics out font "times,12"
set grid back ytics ls 12

set autoscale xy
set ytics nomirror

set xlabel font "times,12" 'distance [m]'
set ylabel font "times,12" 'B_z [{/Symbol m}T]'
set y2label font "times,12" 'height surface [m]'

set format y "%.0f"

set y2tics 1600,2

set label 1 'W' front at graph -0.02,-0.15 font "times,20"
set label 2 'E' front at graph 0.98,-0.15 font "times,20"

set datafile missing '0.00000000000000000'
#################################################################################################
set autoscale xy
set y2range[1816:1822]
set xrange [0:22]

set output 's5p1_mp_ztr.eps'
set yrange[*:*]
set multiplot layout 3,1
#unset title
unset key

set ylabel font "times,12" 'intensity [{/Symbol m}T]'
plot loc1 u 4:($1*1e6) w l ls 1 t "IGRF" axis x1y1,\
     loc1 u 4:($5-1) w  filledc x1 ls 2 t "DEM" axis x1y2,\
     loc1 u 4:9 w  filledc x1 ls 3 t "25cm, field topo" axis x1y2,\
     loc1 u 4:($6*1e6) w l ls 5 t "25cm, DEM + IGRF" axis x1y1,\
     loc2 u 4:($6*1e6) w l ls 15 t "75cm, DEM + IGRF" axis x1y1,\
     loc7 u 4:($6*1e6) w l ls 25 t "125cm, DEM + IGRF" axis x1y1,\
     loc8 u 4:($6*1e6) w l ls 35 t "175cm, DEM + IGRF" axis x1y1,\
     loc1 u 4:10 w l ls 4 t "25cm, field data" axis x1y1,\
     loc2 u 4:10 w l ls 14 t "75cm, field data" axis x1y1,\
     loc7 u 4:10 w l ls 24 t "125cm, field data" axis x1y1,\
     loc8 u 4:10 w l ls 34 t "175cm, field data" axis x1y1

unset key
set ylabel font "times,12" 'inclination [{/Symbol \260}]'
plot loc1 u 4:2 w l ls 1 t "IGRF" axis x1y1,\
     loc1 u 4:($5-1) w  filledc x1 ls 2 t "DEM" axis x1y2,\
     loc1 u 4:9 w  filledc x1 ls 3 t "25cm, field topo" axis x1y2,\
     loc1 u 4:7 w l ls 5 t "25cm, DEM + IGRF" axis x1y1,\
     loc2 u 4:7 w l ls 15 t "75cm, DEM + IGRF" axis x1y1,\
     loc7 u 4:7 w l ls 25 t "125cm, DEM + IGRF" axis x1y1,\
     loc8 u 4:7 w l ls 35 t "175cm, DEM + IGRF" axis x1y1,\
     loc1 u 4:11 w l ls 4 t "25cm, field data" axis x1y1,\
     loc2 u 4:11 w l ls 14 t "75cm, field data" axis x1y1,\
     loc7 u 4:11 w l ls 24 t "125cm, field data" axis x1y1,\
     loc8 u 4:11 w l ls 34 t "175cm, field data" axis x1y1

set ylabel font "times,12" 'declination [{/Symbol \260}]'
set yrange[-13:12]
set key bottom right font "times,10" height 0

plot loc1 u 4:3 w l ls 1 t "IGRF" axis x1y1,\
     loc1 u 4:($5-1) w  filledc x1 ls 2 t "DEM" axis x1y2,\
     loc1 u 4:9 w  filledc x1 ls 3 t "25cm, field topo" axis x1y2,\
     loc1 u 4:8 w l ls 5 t "25cm, DEM + IGRF" axis x1y1,\
     loc2 u 4:8 w l ls 15 t "75cm, DEM + IGRF" axis x1y1,\
     loc7 u 4:8 w l ls 25 t "125cm, DEM + IGRF" axis x1y1,\
     loc8 u 4:8 w l ls 35 t "175cm, DEM + IGRF" axis x1y1,\
     loc1 u 4:12 w l ls 4 t "25cm, field data" axis x1y1,\
     loc2 u 4:12 w l ls 14 t "75cm, field data" axis x1y1,\
     loc7 u 4:12 w l ls 24 t "125cm, field data" axis x1y1,\
     loc8 u 4:12 w l ls 34 t "175cm, field data" axis x1y1
unset multiplot

#################################################################################################
set label 1 'E' front at graph -0.02,-0.15 font "times,20"
set label 2 'W' front at graph 0.98,-0.15 font "times,20"
sh=0
set yrange[*:*]
set y2range[1815:1824]
set xrange [0:26.9+sh]

set output 's5p2_mp_ztr.eps'
set yrange[*:*]
set multiplot layout 3,1
#unset title
unset key

set ylabel font "times,12" 'intensity [{/Symbol m}T]'
plot loc3 u 4:($1*1e6) w l ls 1 t "IGRF" axis x1y1,\
     loc3 u ($4+sh):($5-1) w  filledc x1 ls 2 t "DEM" axis x1y2,\
     loc3 u 4:9 w  filledc x1 ls 3 t "25cm, field topo" axis x1y2,\
     loc3 u ($4+sh):($6*1e6) w l ls 5 t "25cm, DEM + IGRF" axis x1y1,\
     loc4 u ($4+sh):($6*1e6) w l ls 15 t "75cm, DEM + IGRF" axis x1y1,\
     loc9 u ($4+sh):($6*1e6) w l ls 25 t "125cm, DEM + IGRF" axis x1y1,\
     loc10 u ($4+sh):($6*1e6) w l ls 35 t "175cm, DEM + IGRF" axis x1y1,\
     loc3 u 4:10 w l ls 4 t "25cm, field data" axis x1y1,\
     loc4 u 4:10 w l ls 14 t "75cm, field data" axis x1y1,\
     loc9 u 4:10 w l ls 24 t "125cm, field data" axis x1y1,\
     loc10 u 4:10 w l ls 34 t "175cm, field data" axis x1y1

set key bottom right font "times,11"

set ylabel font "times,12" 'inclination [{/Symbol \260}]'
plot loc3 u 4:2 w l ls 1 t "IGRF" axis x1y1,\
     loc3 u ($4+sh):($5-1) w  filledc x1 ls 2 t "DEM" axis x1y2,\
     loc3 u 4:9 w  filledc x1 ls 3 t "25cm, field topo" axis x1y2,\
     loc3 u ($4+sh):7 w l ls 5 t "25cm, DEM + IGRF" axis x1y1,\
     loc4 u ($4+sh):7 w l ls 15 t "75cm, DEM + IGRF" axis x1y1,\
     loc9 u ($4+sh):7 w l ls 25 t "125cm, DEM + IGRF" axis x1y1,\
     loc10 u ($4+sh):7 w l ls 35 t "175cm, DEM + IGRF" axis x1y1,\
     loc3 u 4:11 w l ls 4 t "25cm, field data" axis x1y1,\
     loc4 u 4:11 w l ls 14 t "75cm, field data" axis x1y1,\
     loc9 u 4:11 w l ls 24 t "125cm, field data" axis x1y1,\
     loc10 u 4:11 w l ls 34 t "175cm, field data" axis x1y1

unset key
set yrange[-11:19]
set ylabel font "times,12" 'declination [{/Symbol \260}]'
plot loc3 u 4:3 w l ls 1 t "IGRF" axis x1y1,\
     loc3 u ($4+sh):($5-1) w  filledc x1 ls 2 t "DEM" axis x1y2,\
     loc3 u 4:9 w  filledc x1 ls 3 t "25cm, field topo" axis x1y2,\
     loc3 u ($4+sh):8 w l ls 5 t "25cm, DEM + IGRF" axis x1y1,\
     loc4 u ($4+sh):8 w l ls 15 t "75cm, DEM + IGRF" axis x1y1,\
     loc9 u ($4+sh):8 w l ls 25 t "125cm, DEM + IGRF" axis x1y1,\
     loc10 u ($4+sh):8 w l ls 35 t "175cm, DEM + IGRF" axis x1y1,\
     loc3 u 4:12 w l ls 4 t "25cm, field data" axis x1y1,\
     loc4 u 4:12 w l ls 14 t "75cm, field data" axis x1y1,\
     loc9 u 4:12 w l ls 24 t "125cm, field data" axis x1y1,\
     loc10 u 4:12 w l ls 34 t "175cm, field data" axis x1y1

unset multiplot
#################################################################################################
set label 1 'W' front at graph -0.02,-0.15 font "times,20"
set label 2 'E' front at graph 0.98,-0.15 font "times,20"

set yrange[*:*]
sh=0
set y2range[1813:1822]
set xrange [0+sh:24.5]


set output 's5p3_mp_ztr.eps'
set yrange[*:*]
set multiplot layout 3,1
unset key
#unset title
set ylabel font "times,12" 'intensity [{/Symbol m}T]'
plot loc5 u 4:($1*1e6) w l ls 1 t "IGRF" axis x1y1,\
     loc5 u ($4+sh):($5-1) w  filledc x1 ls 2 t "DEM" axis x1y2,\
     loc5 u 4:9 w  filledc x1 ls 3 t "25cm, field topo" axis x1y2,\
     loc5 u ($4+sh):($6*1e6) w l ls 5 t "25cm, DEM + IGRF" axis x1y1,\
     loc6 u ($4+sh):($6*1e6) w l ls 15 t "75cm, DEM + IGRF" axis x1y1,\
     loc11 u ($4+sh):($6*1e6) w l ls 25 t "125cm, DEM + IGRF" axis x1y1,\
     loc12 u ($4+sh):($6*1e6) w l ls 35 t "175cm, DEM + IGRF" axis x1y1,\
     loc5 u 4:10 w l ls 4 t "25cm, field data" axis x1y1,\
     loc6 u 4:10 w l ls 14 t "75cm, field data" axis x1y1,\
     loc11 u 4:10 w l ls 24 t "125cm, field data" axis x1y1,\
     loc12 u 4:10 w l ls 34 t "175cm, field data" axis x1y1

unset key
set ylabel font "times,12" 'inclination [{/Symbol \260}]'
plot loc5 u 4:2 w l ls 1 t "IGRF" axis x1y1,\
     loc5 u ($4+sh):($5-1) w  filledc x1 ls 2 t "DEM" axis x1y2,\
     loc5 u 4:9 w  filledc x1 ls 3 t "25cm, field topo" axis x1y2,\
     loc5 u ($4+sh):7 w l ls 5 t "25cm, DEM + IGRF" axis x1y1,\
     loc6 u ($4+sh):7 w l ls 15 t "75cm, DEM + IGRF" axis x1y1,\
     loc11 u ($4+sh):7 w l ls 25 t "125cm, DEM + IGRF" axis x1y1,\
     loc12 u ($4+sh):7 w l ls 35 t "175cm, DEM + IGRF" axis x1y1,\
     loc5 u 4:11 w l ls 4 t "25cm, field data" axis x1y1,\
     loc6 u 4:11 w l ls 14 t "75cm, field data" axis x1y1,\
     loc11 u 4:11 w l ls 24 t "125cm, field data" axis x1y1,\
     loc12 u 4:11 w l ls 34 t "175cm, field data" axis x1y1

set key bottom right font "times,11"
set yrange[-12:12]
set ylabel font "times,12" 'declination [{/Symbol \260}]'
plot loc5 u 4:3 w l ls 1 t "IGRF" axis x1y1,\
     loc5 u ($4+sh):($5-1) w  filledc x1 ls 2 t "DEM" axis x1y2,\
     loc5 u 4:9 w  filledc x1 ls 3 t "25cm, field topo" axis x1y2,\
     loc5 u ($4+sh):8 w l ls 5 t "25cm, DEM + IGRF" axis x1y1,\
     loc6 u ($4+sh):8 w l ls 15 t "75cm, DEM + IGRF" axis x1y1,\
     loc11 u ($4+sh):8 w l ls 25 t "125cm, DEM + IGRF" axis x1y1,\
     loc12 u ($4+sh):8 w l ls 35 t "175cm, DEM + IGRF" axis x1y1,\
     loc5 u 4:12 w l ls 4 t "25cm, field data" axis x1y1,\
     loc6 u 4:12 w l ls 14 t "75cm, field data" axis x1y1,\
     loc11 u 4:12 w l ls 24 t "125cm, field data" axis x1y1,\
     loc12 u 4:12 w l ls 34 t "175cm, field data" axis x1y1
unset multiplot
#################################################################################################
set label 1 'E' front at graph -0.02,-0.15 font "times,20"
set label 2 'W' front at graph 0.98,-0.15 font "times,20"
sh=-2
set yrange[*:*]
set y2range[1815:1824]
set xrange [0:26.9+sh]

set output 's5p2_mp_ztr_sh.eps'
set yrange[*:*]
set multiplot layout 3,1
#unset title

unset key
set ylabel font "times,12" 'intensity [{/Symbol m}T]'
plot loc3 u 4:($1*1e6) w l ls 1 t "IGRF" axis x1y1,\
     loc3 u ($4+sh):($5-1) w  filledc x1 ls 2 t "DEM" axis x1y2,\
     loc3 u 4:9 w  filledc x1 ls 3 t "25cm, field topo" axis x1y2,\
     loc3 u ($4+sh):($6*1e6) w l ls 5 t "25cm, DEM + IGRF" axis x1y1,\
     loc4 u ($4+sh):($6*1e6) w l ls 15 t "75cm, DEM + IGRF" axis x1y1,\
     loc9 u ($4+sh):($6*1e6) w l ls 25 t "125cm, DEM + IGRF" axis x1y1,\
     loc10 u ($4+sh):($6*1e6) w l ls 35 t "175cm, DEM + IGRF" axis x1y1,\
     loc3 u 4:10 w l ls 4 t "25cm, field data" axis x1y1,\
     loc4 u 4:10 w l ls 14 t "75cm, field data" axis x1y1,\
     loc9 u 4:10 w l ls 24 t "125cm, field data" axis x1y1,\
     loc10 u 4:10 w l ls 34 t "175cm, field data" axis x1y1

set key bottom right font "times,11"

set ylabel font "times,12" 'inclination [{/Symbol \260}]'
plot loc3 u 4:2 w l ls 1 t "IGRF" axis x1y1,\
     loc3 u ($4+sh):($5-1) w  filledc x1 ls 2 t "DEM" axis x1y2,\
     loc3 u 4:9 w  filledc x1 ls 3 t "25cm, field topo" axis x1y2,\
     loc3 u ($4+sh):7 w l ls 5 t "25cm, DEM + IGRF" axis x1y1,\
     loc4 u ($4+sh):7 w l ls 15 t "75cm, DEM + IGRF" axis x1y1,\
     loc9 u ($4+sh):7 w l ls 25 t "125cm, DEM + IGRF" axis x1y1,\
     loc10 u ($4+sh):7 w l ls 35 t "175cm, DEM + IGRF" axis x1y1,\
     loc3 u 4:11 w l ls 4 t "25cm, field data" axis x1y1,\
     loc4 u 4:11 w l ls 14 t "75cm, field data" axis x1y1,\
     loc9 u 4:11 w l ls 24 t "125cm, field data" axis x1y1,\
     loc10 u 4:11 w l ls 34 t "175cm, field data" axis x1y1
unset key
set yrange[-11:19]
set ylabel font "times,12" 'declination [{/Symbol \260}]'
plot loc3 u 4:3 w l ls 1 t "IGRF" axis x1y1,\
     loc3 u ($4+sh):($5-1) w  filledc x1 ls 2 t "DEM" axis x1y2,\
     loc3 u 4:9 w  filledc x1 ls 3 t "25cm, field topo" axis x1y2,\
     loc3 u ($4+sh):8 w l ls 5 t "25cm, DEM + IGRF" axis x1y1,\
     loc4 u ($4+sh):8 w l ls 15 t "75cm, DEM + IGRF" axis x1y1,\
     loc9 u ($4+sh):8 w l ls 25 t "125cm, DEM + IGRF" axis x1y1,\
     loc10 u ($4+sh):8 w l ls 35 t "175cm, DEM + IGRF" axis x1y1,\
     loc3 u 4:12 w l ls 4 t "25cm, field data" axis x1y1,\
     loc4 u 4:12 w l ls 14 t "75cm, field data" axis x1y1,\
     loc9 u 4:12 w l ls 24 t "125cm, field data" axis x1y1,\
     loc10 u 4:12 w l ls 34 t "175cm, field data" axis x1y1

unset multiplot
#################################################################################################
set label 1 'W' front at graph -0.02,-0.15 font "times,20"
set label 2 'E' front at graph 0.98,-0.15 font "times,20"

set yrange[*:*]
sh=2
set y2range[1813:1822]
set xrange [0+sh:26.5-sh]

set output 's5p3_mp_ztr_sh.eps'
set yrange[*:*]
set multiplot layout 3,1
#unset title
unset key
set ylabel font "times,12" 'intensity [{/Symbol m}T]'
plot loc5 u 4:($1*1e6) w l ls 1 t "IGRF" axis x1y1,\
     loc5 u ($4+sh):($5-1) w  filledc x1 ls 2 t "DEM" axis x1y2,\
     loc5 u 4:9 w  filledc x1 ls 3 t "25cm, field topo" axis x1y2,\
     loc5 u ($4+sh):($6*1e6) w l ls 5 t "25cm, DEM + IGRF" axis x1y1,\
     loc6 u ($4+sh):($6*1e6) w l ls 15 t "75cm, DEM + IGRF" axis x1y1,\
     loc11 u ($4+sh):($6*1e6) w l ls 25 t "125cm, DEM + IGRF" axis x1y1,\
     loc12 u ($4+sh):($6*1e6) w l ls 35 t "175cm, DEM + IGRF" axis x1y1,\
     loc5 u 4:10 w l ls 4 t "25cm, field data" axis x1y1,\
     loc6 u 4:10 w l ls 14 t "75cm, field data" axis x1y1,\
     loc11 u 4:10 w l ls 24 t "125cm, field data" axis x1y1,\
     loc12 u 4:10 w l ls 34 t "175cm, field data" axis x1y1

unset key
set ylabel font "times,12" 'inclination [{/Symbol \260}]'
plot loc5 u 4:2 w l ls 1 t "IGRF" axis x1y1,\
     loc5 u ($4+sh):($5-1) w  filledc x1 ls 2 t "DEM" axis x1y2,\
     loc5 u 4:9 w  filledc x1 ls 3 t "25cm, field topo" axis x1y2,\
     loc5 u ($4+sh):7 w l ls 5 t "25cm, DEM + IGRF" axis x1y1,\
     loc6 u ($4+sh):7 w l ls 15 t "75cm, DEM + IGRF" axis x1y1,\
     loc11 u ($4+sh):7 w l ls 25 t "125cm, DEM + IGRF" axis x1y1,\
     loc12 u ($4+sh):7 w l ls 35 t "175cm, DEM + IGRF" axis x1y1,\
     loc5 u 4:11 w l ls 4 t "25cm, field data" axis x1y1,\
     loc6 u 4:11 w l ls 14 t "75cm, field data" axis x1y1,\
     loc11 u 4:11 w l ls 24 t "125cm, field data" axis x1y1,\
     loc12 u 4:11 w l ls 34 t "175cm, field data" axis x1y1

set key bottom right font "times,11"
set yrange[-12:12]
set ylabel font "times,12" 'declination [{/Symbol \260}]'
plot loc5 u 4:3 w l ls 1 t "IGRF" axis x1y1,\
     loc5 u ($4+sh):($5-1) w  filledc x1 ls 2 t "DEM" axis x1y2,\
     loc5 u 4:9 w  filledc x1 ls 3 t "25cm, field topo" axis x1y2,\
     loc5 u ($4+sh):8 w l ls 5 t "25cm, DEM + IGRF" axis x1y1,\
     loc6 u ($4+sh):8 w l ls 15 t "75cm, DEM + IGRF" axis x1y1,\
     loc11 u ($4+sh):8 w l ls 25 t "125cm, DEM + IGRF" axis x1y1,\
     loc12 u ($4+sh):8 w l ls 35 t "175cm, DEM + IGRF" axis x1y1,\
     loc5 u 4:12 w l ls 4 t "25cm, field data" axis x1y1,\
     loc6 u 4:12 w l ls 14 t "75cm, field data" axis x1y1,\
     loc11 u 4:12 w l ls 24 t "125cm, field data" axis x1y1,\
     loc12 u 4:12 w l ls 34 t "175cm, field data" axis x1y1
unset multiplot
#################################################################################################

set autoscale xy
set y2range[1816:1822]
set xrange [sh:22]

set output 's5p1_mp_ztr_sh.eps'
set yrange[*:*]
set multiplot layout 3,1
#unset title
unset key

set ylabel font "times,12" 'intensity [{/Symbol m}T]'
plot loc1 u 4:($1*1e6) w l ls 1 t "IGRF" axis x1y1,\
     loc1 u ($4+sh):($5-1) w  filledc x1 ls 2 t "DEM" axis x1y2,\
     loc1 u 4:9 w  filledc x1 ls 3 t "25cm, field topo" axis x1y2,\
     loc1 u ($4+sh):($6*1e6) w l ls 5 t "25cm, DEM + IGRF" axis x1y1,\
     loc2 u ($4+sh):($6*1e6) w l ls 15 t "75cm, DEM + IGRF" axis x1y1,\
     loc7 u ($4+sh):($6*1e6) w l ls 25 t "125cm, DEM + IGRF" axis x1y1,\
     loc8 u ($4+sh):($6*1e6) w l ls 35 t "175cm, DEM + IGRF" axis x1y1,\
     loc1 u 4:10 w l ls 4 t "25cm, field data" axis x1y1,\
     loc2 u 4:10 w l ls 14 t "75cm, field data" axis x1y1,\
     loc7 u 4:10 w l ls 24 t "125cm, field data" axis x1y1,\
     loc8 u 4:10 w l ls 34 t "175cm, field data" axis x1y1

unset key
set ylabel font "times,12" 'inclination [{/Symbol \260}]'
plot loc1 u 4:2 w l ls 1 t "IGRF" axis x1y1,\
     loc1 u ($4+sh):($5-1) w  filledc x1 ls 2 t "DEM" axis x1y2,\
     loc1 u 4:9 w  filledc x1 ls 3 t "25cm, field topo" axis x1y2,\
     loc1 u ($4+sh):7 w l ls 5 t "25cm, DEM + IGRF" axis x1y1,\
     loc2 u ($4+sh):7 w l ls 15 t "75cm, DEM + IGRF" axis x1y1,\
     loc7 u ($4+sh):7 w l ls 25 t "125cm, DEM + IGRF" axis x1y1,\
     loc8 u ($4+sh):7 w l ls 35 t "175cm, DEM + IGRF" axis x1y1,\
     loc1 u 4:11 w l ls 4 t "25cm, field data" axis x1y1,\
     loc2 u 4:11 w l ls 14 t "75cm, field data" axis x1y1,\
     loc7 u 4:11 w l ls 24 t "125cm, field data" axis x1y1,\
     loc8 u 4:11 w l ls 34 t "175cm, field data" axis x1y1

set ylabel font "times,12" 'declination [{/Symbol \260}]'
set yrange[-13:12]
set key bottom right font "times,10" height 0

plot loc1 u 4:3 w l ls 1 t "IGRF" axis x1y1,\
     loc1 u ($4+sh):($5-1) w  filledc x1 ls 2 t "DEM" axis x1y2,\
     loc1 u 4:9 w  filledc x1 ls 3 t "25cm, field topo" axis x1y2,\
     loc1 u ($4+sh):8 w l ls 5 t "25cm, DEM + IGRF" axis x1y1,\
     loc2 u ($4+sh):8 w l ls 15 t "75cm, DEM + IGRF" axis x1y1,\
     loc7 u ($4+sh):8 w l ls 25 t "125cm, DEM + IGRF" axis x1y1,\
     loc8 u ($4+sh):8 w l ls 35 t "175cm, DEM + IGRF" axis x1y1,\
     loc1 u 4:12 w l ls 4 t "25cm, field data" axis x1y1,\
     loc2 u 4:12 w l ls 14 t "75cm, field data" axis x1y1,\
     loc7 u 4:12 w l ls 24 t "125cm, field data" axis x1y1,\
     loc8 u 4:12 w l ls 34 t "175cm, field data" axis x1y1
unset multiplot

#################################################################################################

