loc1 = './south/restest/10_10_10/measurements_line.ascii'
loc2 = './south/restest/10_10_10_DD/measurements_line.ascii'
loc3 = './south/restest/25_25_10/measurements_line.ascii'
loc4 = './south/restest/50_50_10/measurements_line.ascii'
loc5 = './south/restest/75_75_10/measurements_line.ascii'
loc6 = './south/restest/75_75_10_DD/measurements_line.ascii'
loc7 = './south/restest/75_75_100/measurements_line.ascii'


set terminal pngcairo size 1600,600

set style line 1 pt 1 lw 2 ps 0.5 lc "black"
set style line 2 pt 2 lw 1 ps 0.5 lc 'grey20' dt 2
set style line 3 pt 7 lw 2 ps 2 lc "royalblue"
set style line 4 pt 5 lw 2 ps 1 lc "web-green" 
set style line 5 pt 9 lw 2 ps 1.5 lc "orange-red"
set style line 6 pt 11 lw 2 ps 1.5 lc "gold"

set style line 14 pt 7 ps 2 lw 2 lc 'light-green'
set style line 144 pt 6 ps 2 lw 2 lc 'web-green' 
set style line 1444 pt 7 ps 0.5 lw 2 lc 'dark-green'
set style line 14444 pt 13 ps 1 lw 2 lc 'olive'
set style line 144444 pt 12 ps 1 lw 2 dt 1 lc 'sienna4'


set style line 17 pt 13 ps 2.5 lw 2 lc 'slategray'
set style line 177 pt 12 ps 2.5 lw 2 lc 'steelblue'
set style line 1777 pt 11 ps 1.5 lw 2 lc 'skyblue'
set style line 17777 pt 10 ps 1.5 lw 2 lc 'web-blue'
set style line 177777 pt 9 ps 1.5 lw 2 lc 'royalblue'
set style line 1777777 pt 8 ps 1.5 lw 2 lc 'medium-blue'
set style line 17777777 pt 11 ps 2 lw 2 lc 'midnight-blue'
set style line 177777777 pt 10 ps 2 lw 2 lc 'cyan'
set style line 1777777777 pt 9 ps 2 lw 2 lc 'aquamarine'
set style line 17777777777 pt 6 lw 2 lc 'dark-turquoise'

set style line 15 pt 5 ps 1 lw 2 lc 'salmon'
set style line 155 pt 4 ps 1 lw 2 lc 'orange'
set style line 1555 pt 5 ps 0.5 lw 2 lc 'red'
set style line 15555 pt 4 ps 0.5 lw 2 lc 'magenta'
set style line 155555 pt 2 ps 1.5 lw 2 lc 'purple'
set style line 1555555 pt 3 ps 1.5 lw 2 lc 'orchid4'

set style line 12 lc 'grey80' dt 2 lw 0.5


set key default font "times,14" box lc 'grey60' opaque fc 'grey90' vertical top right

set xtics out font "times,14"
set ytics out font "times,14"
set y2tics out font "times,14"
set grid back ytics ls 12

set autoscale xy
set ytics nomirror

set xlabel font "times,14" 'index observation point'
set ylabel font "times,14" 'B_z [{/Symbol m}T]'
set y2label font "times,14" 'height surface [m]' 

set format y "%.1f"

set xrange[0:46]
set y2range[-6:6]
set y2tics -6,2

set label 1 'W' front at graph -0.02,-0.1 font "times,20"
set label 2 'E' front at graph 0.98,-0.1 font "times,20"

#################################
set output 'restest_comp.png'
set multiplot layout 1,3

unset key
set ylabel font "times,14" 'B_x (North) [{/Symbol m}T]'
set size 0.33,1
set format y "%.1f"
set yrange[-1.3:-0.3]
set ytics -1.3,0.2

plot loc1 u 0:($3-1) w l ls 2 t "surface" axis x1y2,\
     loc1 u 0:($5*1e6) w l ls 144 t "10x10x10" axis x1y1,\
     loc2 u 0:($5*1e6) w l ls 1444 t "DD, 10x10x10" axis x1y1,\
     loc3 u 0:($5*1e6) w l ls 5 t "25x25x10" axis x1y1,\
     loc4 u 0:($5*1e6) w l ls 6 t "50x50x10" axis x1y1,\
     loc5 u 0:($5*1e6) w l ls 1777 t "75x75x10" axis x1y1,\
     loc6 u 0:($5*1e6) w l ls 17777 t "DD, 75x75x10" axis x1y1,\
     loc7 u 0:($5*1e6) w l ls 177777 t "75x75x100" axis x1y1


set format y "%.0f"
set yrange[-4:7]
set ytics -6,2
set key default font "times,14" box lc 'grey60' opaque fc 'grey90' height 0.1 width 0.5 top center horizontal
set ylabel font "times,14" 'B_y (East) [{/Symbol m}T]'
plot loc1 u 0:($3-1) w l ls 2 t "surface" axis x1y2,\
     loc1 u 0:($4*1e6) w l ls 144 t "10x10x10" axis x1y1,\
     loc2 u 0:($4*1e6) w l ls 1444 t "DD, 10x10x10" axis x1y1,\
     loc3 u 0:($4*1e6) w l ls 5 t "25x25x10" axis x1y1,\
     loc4 u 0:($4*1e6) w l ls 6 t "50x50x10" axis x1y1,\
     loc5 u 0:($4*1e6) w l ls 1777 t "75x75x10" axis x1y1,\
     loc6 u 0:($4*1e6) w l ls 17777 t "DD, 75x75x10" axis x1y1,\
     loc7 u 0:($4*1e6) w l ls 177777 t "75x75x100" axis x1y1

set yrange[0:6]
set xrange[0:46]
set ytics 0,2
unset key
set ylabel font "times,14" 'B_z (Down) [{/Symbol m}T]'
plot loc1 u 0:($3-1) w l ls 2 t "surface" axis x1y2,\
     loc1 u 0:(-$6*1e6) w l ls 144 t "10x10x10" axis x1y1,\
     loc2 u 0:(-$6*1e6) w l ls 1444 t "DD, 10x10x10" axis x1y1,\
     loc3 u 0:(-$6*1e6) w l ls 5 t "25x25x10" axis x1y1,\
     loc4 u 0:(-$6*1e6) w l ls 6 t "50x50x10" axis x1y1,\
     loc5 u 0:(-$6*1e6) w l ls 1777 t "75x75x10" axis x1y1,\
     loc6 u 0:(-$6*1e6) w l ls 17777 t "DD, 75x75x10" axis x1y1,\
     loc7 u 0:(-$6*1e6) w l ls 177777 t "75x75x100" axis x1y1
unset multiplot
#################################


