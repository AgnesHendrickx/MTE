loc1 = './restest/25_25_10/measurements_line.ascii'
loc4 = './restest/100_100_10/measurements_line.ascii'
loc7 = './restest/200_200_10/measurements_line.ascii'
loc9 = './restest/375_375_10/measurements_line.ascii'

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

set key default font "times,14" box lc 'grey60' opaque fc 'grey90' top right height 0.2 width 1

set xtics out font "times,14"
set ytics out font "times,14"
set grid back ytics ls 12

set autoscale xy
set ytics nomirror

set xlabel font "times,14" 'index observation point'
set ylabel font "times,14" 'B_x (North) [{/Symbol m}T]'

set format y "%.1f"

set xrange[0:46]

set label 1 'W' front at graph -0.02,-0.1 font "times,20"
set label 2 'E' front at graph 0.98,-0.1 font "times,20"

###################################
set output 'restest_zt_all.png'
set multiplot layout 1,3
set format y "%.1f"

set size 0.33,1
set yrange[-0.4:0.8]
set ytics -1,0.2
unset key
plot loc1 u 0:($5*1e6) w lp ls 3 t "25x25x10" axis x1y1,\
     loc4 u 0:($5*1e6) w lp ls 4 t "100x100x10" axis x1y1,\
     loc7 u 0:($5*1e6) w lp ls 5 t "200x200x10" axis x1y1,\
     loc9 u 0:($5*1e6) w lp ls 6 t "375x375x10" axis x1y1

set ylabel font "times,14" 'B_y (East) [{/Symbol m}T]' offset 0,0
#set ytics -0.02,0.01
#set yrange[-0.02:0.02]
set key default font "times,14" box lc 'grey60' opaque fc 'grey90' height 0.5 width 0.5 top right 
#set yrange[-1:1]
plot loc1 u 0:($4*1e6) w lp ls 3 t "25x25x10" axis x1y1,\
     loc4 u 0:($4*1e6) w lp ls 4 t "100x100x10" axis x1y1,\
     loc7 u 0:($4*1e6) w lp ls 5 t "200x200x10" axis x1y1,\
     loc9 u 0:($4*1e6) w lp ls 6 t "375x375x10" axis x1y1

unset key
set ylabel font "times,14" 'B_z (Down) [{/Symbol m}T]' offset 0,0
#set yrange[0.5:0.6]
#set ytics 0.5,0.02
plot loc1 u 0:(-$6*1e6)  w lp ls 3 t "25x25x10" axis x1y1,\
     loc4 u 0:(-$6*1e6)  w lp ls 4 t "100x100x10" axis x1y1,\
     loc7 u 0:(-$6*1e6)  w lp ls 5 t "200x200x10" axis x1y1,\
     loc9 u 0:(-$6*1e6)  w lp ls 6 t "375x375x10" axis x1y1

unset multiplot


