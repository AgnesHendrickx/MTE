loc20 = './250_250_10_wvi/measurements_line.ascii'
loc6 = './250_250_20_wvi/measurements_line.ascii'
loc1 = './500_500_20_wvi/measurements_line.ascii'
loc15 = './500_500_40_wvi/measurements_line.ascii'


set terminal pngcairo size 1400,800


set style line 1 pt 1 lw 2 ps 0.5 lc "black"
set style line 2 pt 2 lw 1 ps 0.5 lc 'grey20' dt 2
set style line 3 pt 7 lw 2 ps 2 lc "royalblue"
set style line 4 pt 5 lw 2 ps 1 lc "web-green" 
set style line 5 pt 9 lw 2 ps 1.5 lc "orange-red"
set style line 6 pt 11 lw 2 ps 1.5 lc "gold"

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


set key default font "times,14" box lc 'grey60' opaque fc 'grey90' vertical top right height 0.5

set xtics out font "times,14"
set ytics out font "times,14"
#set y2tics out font "times,14"
set grid back ytics ls 12

set autoscale xy
#set ytics nomirror

set xlabel font "times,14" 'index observation point'
set ylabel font "times,14" 'B_z [{/Symbol m}T]'
#set y2label font "times,14" 'height surface [m]' 

set format y "%.2f"

set xrange[0:46]
#set y2range[-6:6]
#set y2tics -6,2

###################################

set output 'zt_sivi.png'
#unset title

set multiplot layout 2,2
set lmargin 10
set rmargin 8
set ylabel font "times,14" 'B_x (North) [{/Symbol m}T]' offset 0.5,0 

set size 0.5,0.5

unset key
set yrange[-0.20:-0.08]
set ytics -0.20,0.04
set mytics 2
plot loc20 u 0:($5*1e6) w lp ls 17 t "250x250x10 VI" axis x1y1,\
     loc20 u 0:($8*1e6) w lp ls 177 t "250x250x10 SI" axis x1y1,\
     loc6 u 0:($5*1e-1) w lp ls 1777 t "250x250x20 VI" axis x1y1,\
     loc6 u 0:($8*1e6) w lp ls 17777 t "250x250x20 SI" axis x1y1,\
     loc1 u 0:($5*1e6) w lp ls 14 t "500x500x20 VI" axis x1y1,\
     loc1 u 0:($8*1e6) w lp ls 144 t "500x500x20 SI" axis x1y1,\
     loc15 u 0:($5*1e-1) w lp ls 1444 t "500x500x40 VI" axis x1y1,\
     loc15 u 0:($8*1e6) w lp ls 14444 t "500x500x40 SI" axis x1y1

set format y "%.3f"
set autoscale y
set size 0.5,0.5
set yrange[-0.015:0.015]
set ytics -0.015,0.01
set mytics 2
set ylabel font "times,14" 'B_y (East) [{/Symbol m}T]' offset 0,0
plot loc20 u 0:($4*1e6) w lp ls 17 t "250x250x10 VI" axis x1y1,\
     loc20 u 0:($7*1e6) w lp ls 177 t "250x250x10 SI" axis x1y1,\
     loc6 u 0:($4*1e-1) w lp ls 1777 t "250x250x20 VI" axis x1y1,\
     loc6 u 0:($7*1e6) w lp ls 17777 t "250x250x20 SI" axis x1y1,\
     loc1 u 0:($4*1e6) w lp ls 14 t "500x500x20 VI" axis x1y1,\
     loc1 u 0:($7*1e6) w lp ls 144 t "500x500x20 SI" axis x1y1,\
     loc15 u 0:($4*1e-1) w lp ls 1444 t "500x500x40 VI" axis x1y1,\
     loc15 u 0:($7*1e6) w lp ls 14444 t "500x500x40 SI" axis x1y1

set format y "%.2f"
set key default font "times,14" box lc 'grey60' opaque fc 'grey90' height 0.5 at screen 0.75,screen 0.25 center center
set autoscale y
set yrange[0.2:0.6]
set ytics 0.2,0.2
set mytics 2
set size 0.5,0.5
set ylabel font "times,14" 'B_z (Down) [{/Symbol m}T]' offset 0,0
plot loc20 u 0:(-$6*1e6) w lp ls 17 t "250x250x10 VI" axis x1y1,\
     loc20 u 0:(-$9*1e6) w lp ls 177 t "250x250x10 SI" axis x1y1,\
     loc6 u 0:(-$6*1e-1) w lp ls 1777 t "250x250x20 VI" axis x1y1,\
     loc6 u 0:(-$9*1e6) w lp ls 17777 t "250x250x20 SI" axis x1y1,\
     loc1 u 0:(-$6*1e6) w lp ls 14 t "500x500x20 VI" axis x1y1,\
     loc1 u 0:(-$9*1e6) w lp ls 144 t "500x500x20 SI" axis x1y1,\
     loc15 u 0:(-$6*1e-1) w lp ls 1444 t "500x500x40 VI" axis x1y1,\
     loc15 u 0:(-$9*1e6) w lp ls 14444 t "500x500x40 SI" axis x1y1
unset multiplot
#####################################

