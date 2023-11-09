loc1 = './50_50_20/measurements_line.ascii'
loc2 = './50_50_120/measurements_line.ascii'

loc3 = './100_100_20/measurements_line.ascii'
loc4 = './100_100_120/measurements_line.ascii'
loc5 = './100_100_240/measurements_line.ascii'

loc21 = './250_250_5/measurements_line.ascii'
loc20 = './250_250_10/measurements_line.ascii'
loc6 = './250_250_20/measurements_line.ascii'
loc18 = './250_250_40/measurements_line.ascii'
loc7 = './250_250_600/measurements_line.ascii'
loc19 = './250_250_1200/measurements_line.ascii'

loc8 = './500_500_20/measurements_line.ascii'
loc15 = './500_500_40/measurements_line.ascii'
loc9 = './500_500_1200/measurements_line.ascii'

loc11 = './750_750_20/measurements_line.ascii'
loc14 = './750_750_1800/measurements_line.ascii'

loc12 = './1000_1000_20/measurements_line.ascii'


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
set xlabel font "times,14" 'index observation point'
set ylabel font "times,14" 'intensity [{/Symbol m}T]'

set format y "%.1f"
set xrange[0:46]

set label 1 'W' front at graph -0.02,-0.1 font "times,20"
set label 2 'E' front at graph 0.98,-0.1 font "times,20"

###################################
set output 'zt_low.png'
set multiplot layout 1,3
#unset title
set size 0.33,1
set ylabel font "times,14" 'B_x (North) [{/Symbol m}T]'
unset key
plot loc1 u 0:($5*1e6) w l ls 155555 t "50x50x20" axis x1y1,\
     loc2 u 0:($5*1e6) w l ls 1555555 t "50x50x120" axis x1y1,\
     loc3 u 0:($5*1e6) w l ls 14 t "100x100x20" axis x1y1,\
     loc4 u 0:($5*1e6) w l ls 144 t "100x100x120" axis x1y1,\
     loc5 u 0:($5*1e6) w l ls 1444 t "100x100x240" axis x1y1,\
     loc21 u 0:($5*1e6) w l ls 17 t "250x250x5" axis x1y1,\
     loc20 u 0:($5*1e6) w l ls 177 t "250x250x10" axis x1y1,\
     loc6 u 0:($5*1e6) w l ls 1777 t "250x250x20" axis x1y1,\
     loc18 u 0:($5*1e6) w l ls 17777 t "250x250x40" axis x1y1,\
     loc7 u 0:($5*1e6) w l ls 177777 t "250x250x600" axis x1y1,\
     loc19 u 0:($5*1e6) w l ls 1777777 t "250x250x1200" axis x1y1

set autoscale y
set yrange[-4:4.5]
set ytics -4,1
set format y "%.0f"
set size 0.33,1
set key right top vertical
set ylabel font "times,14" 'B_y (East) [{/Symbol m}T]'
plot loc1 u 0:($4*1e6) w l ls 155555 t "50x50x20" axis x1y1,\
     loc2 u 0:($4*1e6) w l ls 1555555 t "50x50x120" axis x1y1,\
     loc3 u 0:($4*1e6) w l ls 14 t "100x100x20" axis x1y1,\
     loc4 u 0:($4*1e6) w l ls 144 t "100x100x120" axis x1y1,\
     loc5 u 0:($4*1e6) w l ls 1444 t "100x100x240" axis x1y1,\
     loc21 u 0:($4*1e6) w l ls 17 t "250x250x5" axis x1y1,\
     loc20 u 0:($4*1e6) w l ls 177 t "250x250x10" axis x1y1,\
     loc6 u 0:($4*1e6) w l ls 1777 t "250x250x20" axis x1y1,\
     loc18 u 0:($4*1e6) w l ls 17777 t "250x250x40" axis x1y1,\
     loc7 u 0:($4*1e6) w l ls 177777 t "250x250x600" axis x1y1,\
     loc19 u 0:($4*1e6) w l ls 1777777 t "250x250x1200" axis x1y1

set autoscale y
set format y "%.0f"
set size 0.33,1
set yrange [0:4]
set ytics 0,1
unset key
set ylabel font "times,14" 'B_z (Down) [{/Symbol m}T]'
plot loc1 u 0:(-$6*1e6) w l ls 155555 t "50x50x20" axis x1y1,\
     loc2 u 0:(-$6*1e6) w l ls 1555555 t "50x50x120" axis x1y1,\
     loc3 u 0:(-$6*1e6) w l ls 14 t "100x100x20" axis x1y1,\
     loc4 u 0:(-$6*1e6) w l ls 144 t "100x100x120" axis x1y1,\
     loc5 u 0:(-$6*1e6) w l ls 1444 t "100x100x240" axis x1y1,\
     loc21 u 0:(-$6*1e6) w l ls 17 t "250x25s0x5" axis x1y1,\
     loc20 u 0:(-$6*1e6) w l ls 177 t "250x250x10" axis x1y1,\
     loc6 u 0:(-$6*1e6) w l ls 1777 t "250x250x20" axis x1y1,\
     loc18 u 0:(-$6*1e6) w l ls 17777 t "250x250x40" axis x1y1,\
     loc7 u 0:(-$6*1e6) w l ls 177777 t "250x250x600" axis x1y1,\
     loc19 u 0:(-$6*1e6) w l ls 1777777 t "250x250x1200" axis x1y1

unset multiplot
###################################
set format y "%.1f"
set output 'zt_high_dif.png'
set multiplot layout 1,3
set yrange [-1.4:0]
set ytics -1.4,0.2
set ylabel font "times,14" 'B_x (North) [{/Symbol m}T]'
unset key
plot loc21 u 0:($5*1e6) w lp ls 17 t "250x250x5" axis x1y1,\
     loc20 u 0:($5*1e6) w lp ls 177 t "250x250x10" axis x1y1,\
     loc6 u 0:($5*1e6) w lp ls 1777 t "250x250x20" axis x1y1,\
     loc18 u 0:($5*1e6) w lp ls 17777 t "250x250x40" axis x1y1,\
     loc8 u 0:($5*1e6) w lp ls 14 t "500x500x20" axis x1y1,\
     loc15 u 0:($5*1e6) w lp ls 144 t "500x500x40" axis x1y1,\
     loc9 u 0:($5*1e6) w lp ls 1444 t "500x500x1200" axis x1y1,\
     loc11 u 0:($5*1e6) w lp ls 14444 t "750x750x20" axis x1y1,\
     loc14 u 0:($5*1e6) w lp ls 144444 t "750x750x1800" axis x1y1,\
     loc12 u 0:($5*1e6) w lp ls 6 t "1000x1000x20" axis x1y1

set format y "%.1f"
set yrange [-0.2:0.2]
set ytics -0.2,0.1
set key right top vertical
set ylabel font "times,14" 'B_y (East) [{/Symbol m}T]'
plot loc21 u 0:($4*1e6) w lp ls 17 t "250x250x5" axis x1y1,\
     loc20 u 0:($4*1e6) w lp ls 177 t "250x250x10" axis x1y1,\
     loc6 u 0:($4*1e6) w lp ls 1777 t "250x250x20" axis x1y1,\
     loc18 u 0:($4*1e6) w lp ls 17777 t "250x250x40" axis x1y1,\
     loc8 u 0:($4*1e6) w lp ls 14 t "500x500x20" axis x1y1,\
     loc15 u 0:($4*1e6) w lp ls 144 t "500x500x40" axis x1y1,\
     loc9 u 0:($4*1e6) w lp ls 1444 t "500x500x1200" axis x1y1,\
     loc11 u 0:($4*1e6) w lp ls 14444 t "750x750x20" axis x1y1,\
     loc14 u 0:($4*1e6) w lp ls 144444 t "750x750x1800" axis x1y1,\
     loc12 u 0:($4*1e6) w lp ls 6 t "1000x1000x20" axis x1y1

set format y "%.0f"
set yrange [0:4]
set ytics 0,1
unset key
set ylabel font "times,14" 'B_z (Down) [{/Symbol m}T]'
plot loc21 u 0:(-$6*1e6) w lp ls 17 t "250x250x5" axis x1y1,\
     loc20 u 0:(-$6*1e6) w lp ls 177 t "250x250x10" axis x1y1,\
     loc6 u 0:(-$6*1e6) w lp ls 1777 t "250x250x20" axis x1y1,\
     loc18 u 0:(-$6*1e6) w lp ls 17777 t "250x250x40" axis x1y1,\
     loc8 u 0:(-$6*1e6) w lp ls 14 t "500x500x20" axis x1y1,\
     loc15 u 0:(-$6*1e6) w lp ls 144 t "500x500x40" axis x1y1,\
     loc9 u 0:(-$6*1e6) w lp ls 1444 t "500x500x1200" axis x1y1,\
     loc11 u 0:(-$6*1e6) w lp ls 14444 t "750x750x20" axis x1y1,\
     loc14 u 0:(-$6*1e6) w lp ls 144444 t "750x750x1800" axis x1y1,\
     loc12 u 0:(-$6*1e6) w lp ls 6 t "1000x1000x20" axis x1y1

unset multiplot
