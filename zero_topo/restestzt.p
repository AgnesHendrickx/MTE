loc1 = './restest/25_25_10/measurements_line.ascii'
loc2 = './restest/50_50_10/measurements_line.ascii'
loc3 = './restest/75_75_10/measurements_line.ascii'
loc4 = './restest/100_100_10/measurements_line.ascii'
loc5 = './restest/125_125_10/measurements_line.ascii'
loc6 = './restest/150_150_10/measurements_line.ascii'
loc7 = './restest/200_200_10/measurements_line.ascii'
loc8 = './restest/250_250_10/measurements_line.ascii'
loc9 = './restest/375_375_10/measurements_line.ascii'
loc10 = './restest/500_500_10/measurements_line.ascii'

set terminal pngcairo size 1800,900

set key default
set key box
set key opaque
set key horizontal
set key font "courier,14"
set xlabel font "courier,14" 'index'
#set y2label font "courier,14" 'height surface (m)' 
set autoscale xy
#set ytics nomirror
set style line 12 lc rgb '#aaaaaa' dt 2 lw 0.5
set grid back ytics ls 12
set tics out font "courier,14"
set xrange[0:46]
#set y2range[-2:2]
set y2tics -2,2


set style line 1 lw 2 lc "grey40"
set style line 2 pt 13 ps 1.5 lw 2 lc 'purple'
set style line 20 pt 14 ps 1.5 lw 3 lc 'red'
set style line 3 pt 12 ps 1.5 lw 2 lc 'orchid4'

set style line 4 pt 7 ps 1.5 lw 2 lc 'light-green'
set style line 5 pt 6 ps 2 lw 2 lc 'web-green' 
set style line 6 pt 6 ps 1 lw 2 lc 'dark-green'

set style line 107 pt 12 ps 1.5 lw 2 lc 'steelblue'
set style line 7 pt 11 ps 1.5 lw 2 lc 'skyblue'
set style line 170 pt 10 ps 1.5 lw 2 lc 'web-blue'

set style line 17 pt 6 ps 1.5 lw 2 lc 'orange'
set style line 8 pt 9 ps 1.5 lw 2 lc 'royalblue'
set style line 80 pt 7 lw 1 lc 'red'
set style line 800 pt 8 ps 1.5 lw 2 lc 'navy'

#set style line 9 pt 9 ps 2 lw 2 lc 'aquamarine'
#set style line 90 pt 10 ps 2 lw 2 lc 'cyan'
#set style line 10 pt 8 lw 2 lc 'dark-turquoise'

set style line 9 pt 15 ps 2 lw 2 lc 'salmon'
set style line 90 pt 14 ps 1 lw 2 lc 'orange'
set style line 10 pt 14 ps 2 lw 2 lc 'red'


set style line 11 pt 13 ps 1.5 lw 2 lc 'olive'
set style line 110 pt 12 ps 1.5 lw 2 lc 'sienna4'

set style line 13 pt 5 ps 1 lw 2 lc 'gold'

###################################
set terminal pngcairo size 1800,900
set output 'restest_zt_all.png'
set multiplot layout 1,3
set size 0.35,1
#unset title
set key font "courier,14"
set ylabel font "courier,14" 'Bx_a (North) ({/Symbol m}T)'
set grid back ytics ls 12
unset key
#set key center bottom
#set key opaque
#set yrange[-0.2:-0.1]
set yrange[-1:1]
plot loc1 u 0:($5*1e6) w lp ls 2 t "25x25x10" axis x1y1,\
     loc2 u 0:($5*1e6) w lp ls 3 t "50x50x10" axis x1y1,\
     loc3 u 0:($5*1e6) w lp ls 4 t "75x75x10" axis x1y1,\
     loc4 u 0:($5*1e6) w lp ls 5 t "100x100x10" axis x1y1,\
     loc5 u 0:($5*1e6) w lp ls 6 t "125x125x10" axis x1y1,\
     loc6 u 0:($5*1e6) w lp ls 7 t "150x150x10" axis x1y1,\
     loc7 u 0:($5*1e6) w lp ls 8 t "200x200x10" axis x1y1,\
     loc8 u 0:($5*1e6) w lp ls 9 t "250x250x10" axis x1y1,\
     loc9 u 0:($5*1e6) w lp ls 10 t "375x375x10" axis x1y1

set autoscale y
set key right top vertical
set size 0.35,1
set ylabel font "courier,14" 'By_a (East) ({/Symbol m}T)'
#set yrange[-0.02:0.02]
set yrange[-1:1]
plot loc1 u 0:($4*1e6) w lp ls 2 t "25x25x10" axis x1y1,\
     loc2 u 0:($4*1e6) w lp ls 3 t "50x50x10" axis x1y1,\
     loc3 u 0:($4*1e6) w lp ls 4 t "75x75x10" axis x1y1,\
     loc4 u 0:($4*1e6) w lp ls 5 t "100x100x10" axis x1y1,\
     loc5 u 0:($4*1e6) w lp ls 6 t "125x125x10" axis x1y1,\
     loc6 u 0:($4*1e6) w lp ls 7 t "150x150x10" axis x1y1,\
     loc7 u 0:($4*1e6) w lp ls 8 t "200x200x10" axis x1y1,\
     loc8 u 0:($4*1e6) w lp ls 9 t "250x250x10" axis x1y1,\
     loc9 u 0:($4*1e6) w lp ls 10 t "375x375x10" axis x1y1

#set yrange[0:5]
unset key
#set key center top
set size 0.35,1
set ylabel font "courier,14" 'Bz_a (Down) ({/Symbol m}T)'
#set yrange[0.5:0.6]
set yrange[-1:1]
plot loc1 u 0:(-$6*1e6)  w lp ls 2 t "25x25x10" axis x1y1,\
     loc2 u 0:(-$6*1e6)  w lp ls 3 t "50x50x10" axis x1y1,\
     loc3 u 0:(-$6*1e6)  w lp ls 4 t "75x75x10" axis x1y1,\
     loc4 u 0:(-$6*1e6)  w lp ls 5 t "100x100x10" axis x1y1,\
     loc5 u 0:(-$6*1e6)  w lp ls 6 t "125x125x10" axis x1y1,\
     loc6 u 0:(-$6*1e6)  w lp ls 7 t "150x150x10" axis x1y1,\
     loc7 u 0:(-$6*1e6)  w lp ls 8 t "200x200x10" axis x1y1,\
     loc8 u 0:(-$6*1e6)  w lp ls 9 t "250x250x10" axis x1y1,\
     loc9 u 0:(-$6*1e6)  w lp ls 10 t "375x375x10" axis x1y1

unset multiplot
###################################

