loc1 = './north/250_250_20_fb/measurements_line_plotfile.ascii'
loc2 = './east/250_250_20_fb/measurements_line_plotfile.ascii'
loc3 = './south/250_250_20_fb/measurements_line_plotfile.ascii'
loc4 = './west/250_250_20_fb/measurements_line_plotfile.ascii'

loc5 = './north/250_250_20_fb/measurements_path_refFieldIGRF.ascii'
loc6 = './east/250_250_20_fb/measurements_path_refFieldIGRF.ascii'
loc7 = './south/250_250_20_fb/measurements_path_refFieldIGRF.ascii'
loc8 = './west/250_250_20_fb/measurements_path_refFieldIGRF.ascii'

loc10 = './north/250_250_20_fb_180/measurements_line_plotfile.ascii'
loc20 = './east/250_250_20_fb_180/measurements_line_plotfile.ascii'
loc30 = './south/250_250_20_fb_180/measurements_line_plotfile.ascii'
loc40 = './west/250_250_20_fb_180/measurements_line_plotfile.ascii'

loc50 = './north/250_250_20_fb_180/measurements_path_refFieldIGRF.ascii'
loc60 = './east/250_250_20_fb_180/measurements_path_refFieldIGRF.ascii'
loc70 = './south/250_250_20_fb_180/measurements_path_refFieldIGRF.ascii'
loc80 = './west/250_250_20_fb_180/measurements_path_refFieldIGRF.ascii'


set terminal pngcairo enhanced size 2000,1000


set style line 1 pt 1 lw 1 ps 0.5 lc "black"
set style line 2 pt 2 lw 2 ps 0.5 lc 'grey20' dt 2
set style line 3 pt 7 lw 3 ps 1.5 lc "royalblue"
set style line 4 pt 5 lw 3 ps 1 lc "web-green"
set style line 5 pt 9 lw 3 ps 1.5 lc "orange-red"
set style line 6 pt 11 lw 3 ps 1.5 lc "gold"

set style line 30 pt 6 lw 3 ps 1 lc "skyblue" dt 4
set style line 40 pt 4 lw 3 ps 0.5 lc "light-green" dt 4
set style line 50 pt 8 lw 3 ps 1 lc "salmon" dt 4
set style line 60 pt 10 lw 3 ps 1 lc "light-goldenrod" dt 4


set style line 14 pt 7 ps 2 lw 2 lc 'light-green'
set style line 144 pt 6 ps 2 lw 2 lc 'web-green'
set style line 1444 pt 7 ps 0.5 lw 2 lc 'dark-green'
set style line 14444 pt 6 ps 0.5 lw 2 lc 'olive'
set style line 144444 pt 7 ps 1 lw 2 dt 1 lc 'sienna4'

set style line 17 pt 13 ps 2 lw 2 lc 'slategray'
set style line 177 pt 12 ps 2 lw 2 lc 'steelblue'
set style line 1777 pt 11 ps 1.5 lw 2 lc 'skyblue'
set style line 17777 pt 10 ps 1.5 lw 2 lc 'web-blue'
set style line 177777 pt 9 ps 1.5 lw 2 lc 'royalblue'
set style line 1777777 pt 8 ps 1.5 lw 2 lc 'medium-blue'
set style line 17777777 pt 11 ps 2.5 lw 2 lc 'midnight-blue'
set style line 177777777 pt 10 ps 2.5 lw 2 lc 'cyan'
set style line 1777777777 pt 9 ps 2 lw 2 lc 'aquamarine'
set style line 17777777777 pt 6 lw 2 lc 'dark-turquoise'

set style line 15 pt 5 ps 0.5 lw 8 lc 'salmon'
set style line 155 pt 5 ps 0.5 lw 8 lc 'orange'
set style line 1555 pt 5 ps 2 lw 2 lc 'red'
set style line 15555 pt 4 ps 2 lw 2 lc 'magenta'
set style line 155555 pt 2 ps 2 lw 2 lc 'purple'
set style line 1555555 pt 3 ps 2 lw 2 lc 'orchid4'


set style line 12 lc 'grey80' dt 2 lw 0.5

set key default font "times,14" box lc 'grey60' opaque fc 'grey90' top right

set xtics out font "times,14"
set ytics out font "times,14"
set y2tics out font "times,14"
set grid back ytics ls 12

set autoscale xy
set ytics nomirror

set xlabel font "times,14" 'distance (m)'
set ylabel font "times,14" 'intensity [{/Symbol m}T]'
set y2label font "times,14" 'height surface [m]'

set format y "%.0f"

set xrange[100:149.4]
set y2range[-6:6]
set y2tics -6,2

###########################################
set output 'flanksimIn_zt.png'
set ylabel font "times,12" 'intensity [{/Symbol m}T]'
plot loc1 u 0:($4*1e6) w l ls 2 t "IGRF int" axis x1y1,\
     loc1 u 1:($3-1) w l ls 1 t "surface" axis x1y2,\
     loc1 u 1:($7*1e6) w l ls 3 t "North flank" axis x1y1,\
     loc2 u 2:($7*1e6) w l ls 6 t "East flank" axis x1y1,\
     loc3 u 1:($7*1e6) w l ls 5 t "South flank" axis x1y1,\
     loc4 u 2:($7*1e6) w l ls 4 t "West flank" axis x1y1


set output 'flanksimIc_zt.png'
set ylabel font "times,12" 'inclination [{/Symbol \260}]'
plot loc1 u 0:5 w l ls 2 t "IGRF inc" axis x1y1,\
     loc1 u 1:($3-1) w l ls 1 t "surface" axis x1y2,\
     loc1 u 1:8 w l ls 3 t "North flank" axis x1y1,\
     loc2 u 2:8 w l ls 6 t "East flank" axis x1y1,\
     loc3 u 1:8 w l ls 5 t "South flank" axis x1y1,\
     loc4 u 2:8 w l ls 4 t "West flank" axis x1y1


set output 'flanksimDc_zt.png'
set ylabel font "times,12" 'declination [{/Symbol \260}]'
set yrange[-2:9]
set ytics -2,2
plot loc1 u 1:6 w l ls 2 t "IGRF dec" axis x1y1,\
     loc1 u 1:($3-1) w l ls 1 t "surface" axis x1y2,\
     loc1 u 1:9 w l ls 3 t "North flank" axis x1y1,\
     loc2 u 2:9 w l ls 6 t "East flank" axis x1y1,\
     loc3 u 1:9 w l ls 5 t "South flank" axis x1y1,\
     loc4 u 2:9 w l ls 4 t "West flank" axis x1y1

set output 'flanksimDc_zt_lines.png'
set arrow from 106.25,-2 to 106.25,9 nohead lc "grey20" lw 0.5
set arrow from 118.75,-2 to 118.75,9 nohead lc "grey20" lw 0.5
set arrow from 131.25,-2 to 131.25,9 nohead lc "grey20" lw 0.5
set arrow from 143.75,-2 to 143.75,9 nohead lc "grey20" lw 0.5


set ylabel font "times,12" 'declination [{/Symbol \260}]'
set yrange[-2:9]
set ytics -2,2
plot loc1 u 1:6 w l ls 2 t "IGRF dec" axis x1y1,\
     loc1 u 1:($3-1) w l ls 1 t "surface" axis x1y2,\
     loc1 u 1:9 w l ls 3 t "North flank" axis x1y1,\
     loc2 u 2:9 w l ls 6 t "East flank" axis x1y1,\
     loc3 u 1:9 w l ls 5 t "South flank" axis x1y1,\
     loc4 u 2:9 w l ls 4 t "West flank" axis x1y1

unset arrow
###########################################
set output 'flanksimIn_zt_180.png'
set autoscale xy
set xrange[100:149.4]

set ytics autofreq
set ytics nomirror

set ylabel font "times,12" 'intensity [{/Symbol m}T]'
plot loc1 u 1:($4*1e6) w l ls 2 t "IGRF int" axis x1y1,\
     loc1 u 1:($3-1) w l ls 1 t "surface" axis x1y2,\
     loc1 u 1:($7*1e6) w l ls 3 t "North flank" axis x1y1,\
     loc2 u 2:($7*1e6) w l ls 6 t "East flank" axis x1y1,\
     loc3 u 1:($7*1e6) w l ls 5 t "South flank" axis x1y1,\
     loc4 u 2:($7*1e6) w l ls 4 t "West flank" axis x1y1,\
     loc10 u 1:($7*1e6) w l ls 30 t "180 North flank" axis x1y1,\
     loc20 u 2:($7*1e6) w l ls 60 t "180 East flank" axis x1y1,\
     loc30 u 1:($7*1e6) w l ls 50 t "180 South flank" axis x1y1,\
     loc40 u 2:($7*1e6) w l ls 40 t "180 West flank" axis x1y1

set output 'flanksimIc_zt_180.png'
set ylabel font "times,12" 'inclination [{/Symbol \260}]'
plot loc1 u 1:5 w l ls 2 t "IGRF inc" axis x1y1,\
     loc1 u 1:($3-1) w l ls 1 t "surface" axis x1y2,\
     loc1 u 1:8 w l ls 3 t "North flank" axis x1y1,\
     loc2 u 2:8 w l ls 6 t "East flank" axis x1y1,\
     loc3 u 1:8 w l ls 5 t "South flank" axis x1y1,\
     loc4 u 2:8 w l ls 4 t "West flank" axis x1y1,\
     loc10 u 1:8 w l ls 30 t "180 North flank" axis x1y1,\
     loc20 u 2:8 w l ls 60 t "180 East flank" axis x1y1,\
     loc30 u 1:8 w l ls 50 t "180 South flank" axis x1y1,\
     loc40 u 2:8 w l ls 40 t "180 West flank" axis x1y1

set output 'flanksimDc_zt_180.png'
set ylabel font "times,12" 'declination [{/Symbol \260}]'
set yrange[-2:9]
set ytics -2,2
plot loc1 u 1:6 w l ls 2 t "IGRF dec" axis x1y1,\
     loc1 u 1:($3-1) w l ls 1 t "surface" axis x1y2,\
     loc1 u 1:9 w l ls 3 t "North flank" axis x1y1,\
     loc2 u 2:9 w l ls 6 t "East flank" axis x1y1,\
     loc3 u 1:9 w l ls 5 t "South flank" axis x1y1,\
     loc4 u 2:9 w l ls 4 t "West flank" axis x1y1,\
     loc10 u 1:9 w l ls 30 t "180 North flank" axis x1y1,\
     loc20 u 2:9 w l ls 60 t "180 East flank" axis x1y1,\
     loc30 u 1:9 w l ls 50 t "180 South flank" axis x1y1,\
     loc40 u 2:9 w l ls 40 t "180 West flank" axis x1y1

###########################################
#set style line 3 pt 7 lw 2 ps 1 lc "royalblue"
#set style line 4 pt 5 lw 2 ps 0.5 lc "web-green"
#set style line 5 pt 9 lw 2 ps 1 lc "orange-red"
#set style line 6 pt 11 lw 2 ps 1 lc "gold"

set output 'flanksim_mp_zt_180.png'
set multiplot layout 2,2
unset key
set autoscale xy
set ytics autofreq
set ytics nomirror
set xrange[100:149.4]

set ylabel font "times,12" 'intensity [{/Symbol m}T]'
plot loc1 u 1:($4*1e6) w l ls 2 t "IGRF" axis x1y1,\
     loc1 u 1:($3-1) w l ls 1 t "surface" axis x1y2,\
     loc1 u 1:($7*1e6) w l ls 3 t "North flank" axis x1y1,\
     loc2 u 2:($7*1e6) w l ls 6 t "East flank" axis x1y1,\
     loc3 u 1:($7*1e6) w l ls 5 t "South flank" axis x1y1,\
     loc4 u 2:($7*1e6) w l ls 4 t "West flank" axis x1y1,\
     loc10 u 1:($7*1e6) w l ls 30 t "180 North flank" axis x1y1,\
     loc20 u 2:($7*1e6) w l ls 60 t "180 East flank" axis x1y1,\
     loc30 u 1:($7*1e6) w l ls 50 t "180 South flank" axis x1y1,\
     loc40 u 2:($7*1e6) w l ls 40 t "180 West flank" axis x1y1


set ylabel font "times,12" 'inclination [{/Symbol \260}]'
plot loc1 u 1:5 w l ls 2 t "IGRF" axis x1y1,\
     loc1 u 1:($3-1) w l ls 1 t "surface" axis x1y2,\
     loc1 u 1:8 w l ls 3 t "North flank" axis x1y1,\
     loc2 u 2:8 w l ls 6 t "East flank" axis x1y1,\
     loc3 u 1:8 w l ls 5 t "South flank" axis x1y1,\
     loc4 u 2:8 w l ls 4 t "West flank" axis x1y1,\
     loc10 u 1:8 w l ls 30 t "180 North flank" axis x1y1,\
     loc20 u 2:8 w l ls 60 t "180 East flank" axis x1y1,\
     loc30 u 1:8 w l ls 50 t "180 South flank" axis x1y1,\
     loc40 u 2:8 w l ls 40 t "180 West flank" axis x1y1

set key default font "times,14" box lc 'grey60' opaque fc 'grey90' at screen 0.75,screen 0.25 center center
set ylabel font "times,12" 'declination [{/Symbol \260}]'
set yrange[-2:9]
set ytics -2,2
plot loc1 u 1:6 w l ls 2 t "IGRF" axis x1y1,\
     loc1 u 1:($3-1) w l ls 1 t "surface" axis x1y2,\
     loc1 u 1:9 w l ls 3 t "North flank" axis x1y1,\
     loc2 u 2:9 w l ls 6 t "East flank" axis x1y1,\
     loc3 u 1:9 w l ls 5 t "South flank" axis x1y1,\
     loc4 u 2:9 w l ls 4 t "West flank" axis x1y1,\
     loc10 u 1:9 w l ls 30 t "180 North flank" axis x1y1,\
     loc20 u 2:9 w l ls 60 t "180 East flank" axis x1y1,\
     loc30 u 1:9 w l ls 50 t "180 South flank" axis x1y1,\
     loc40 u 2:9 w l ls 40 t "180 West flank" axis x1y1
unset multiplot
###########################################
set output 'flanksim_mp_zt.png'
#set autoscale xy
set ytics autofreq
set ytics nomirror

set multiplot layout 2,2
unset key
set yrange[42:48]
set ytics 42,2

set ylabel font "times,12" 'intensity [{/Symbol m}T]'
plot loc1 u 1:($4*1e6) w l ls 2 t "IGRF" axis x1y1,\
     loc1 u 1:($3-1) w l ls 1 t "surface" axis x1y2,\
     loc1 u 1:($7*1e6) w l ls 3 t "North flank" axis x1y1,\
     loc2 u 2:($7*1e6) w l ls 6 t "East flank" axis x1y1,\
     loc3 u 1:($7*1e6) w l ls 5 t "South flank" axis x1y1,\
     loc4 u 2:($7*1e6) w l ls 4 t "West flank" axis x1y1

set yrange[49:57]
set ytics 49,2
set ylabel font "times,12" 'inclination [{/Symbol \260}]'
plot loc1 u 1:5 w l ls 2 t "IGRF" axis x1y1,\
     loc1 u 1:($3-1) w l ls 1 t "surface" axis x1y2,\
     loc1 u 1:8 w l ls 3 t "North flank" axis x1y1,\
     loc2 u 2:8 w l ls 6 t "East flank" axis x1y1,\
     loc3 u 1:8 w l ls 5 t "South flank" axis x1y1,\
     loc4 u 2:8 w l ls 4 t "West flank" axis x1y1

set yrange[-2:9]
set ytics -2,2
set key default font "times,14" box lc 'grey60' opaque fc 'grey90' at screen 0.75,screen 0.25 center center
set ylabel font "times,12" 'declination [{/Symbol \260}]'
plot loc1 u 1:6 w l ls 2 t "IGRF" axis x1y1,\
     loc1 u 1:($3-1) w l ls 1 t "surface" axis x1y2,\
     loc1 u 1:9 w l ls 3 t "North flank" axis x1y1,\
     loc2 u 2:9 w l ls 6 t "East flank" axis x1y1,\
     loc3 u 1:9 w l ls 5 t "South flank" axis x1y1,\
     loc4 u 2:9 w l ls 4 t "West flank" axis x1y1
unset multiplot
###########################################
set output 'flanksim_comp_mp_zt.png'
set xlabel font "times,14" 'index observation point'
set autoscale xy
set ytics autofreq
set ytics nomirror
set xrange [0:46]
set multiplot layout 2,2

set yrange[24:30]
set ytics 24,2
set ylabel font "times,12" 'B_x (North) [{/Symbol m}T]'
set key
plot (26850.3e-3) w l ls 2 t "IGRF" axis x1y1,\
     loc1 u 0:($3-1) w l ls 1 t "surface" axis x1y2,\
     loc5 u 0:($2*1e6) w l ls 3 t "North flank" axis x1y1,\
     loc6 u 0:($2*1e6) w l ls 6 t "East flank" axis x1y1,\
     loc7 u 0:($2*1e6) w l ls 5 t "South flank" axis x1y1,\
     loc8 u 0:($2*1e6) w l ls 4 t "West flank" axis x1y1

set yrange[-1:4]
set ytics -1,1
set format y "%.0f"
set ylabel font "times,12" 'B_y (East) [{/Symbol m}T]'
plot (1561.2e-3) w l ls 2 t "IGRF" axis x1y1,\
     loc1 u 0:($3-1) w l ls 1 t "surface" axis x1y2,\
     loc5 u 0:($3*1e6) w l ls 3 t "North flank" axis x1y1,\
     loc6 u 0:($3*1e6) w l ls 6 t "East flank" axis x1y1,\
     loc7 u 0:($3*1e6) w l ls 5 t "South flank" axis x1y1,\
     loc8 u 0:($3*1e6) w l ls 4 t "West flank" axis x1y1

set yrange[33:39]
set ytics 33,2
set format y "%.0f"
set ylabel font "times,12" 'B_z (Down) [{/Symbol m}T]'
plot (36305.7e-3) w l ls 2 t "IGRF" axis x1y1,\
     loc1 u 0:($3-1) w l ls 1 t "surface" axis x1y2,\
     loc5 u 0:($4*1e6) w l ls 3 t "North flank" axis x1y1,\
     loc6 u 0:($4*1e6) w l ls 6 t "East flank" axis x1y1,\
     loc7 u 0:($4*1e6) w l ls 5 t "South flank" axis x1y1,\
     loc8 u 0:($4*1e6) w l ls 4 t "West flank" axis x1y1


unset multiplot
###########################################



