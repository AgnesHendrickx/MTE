loc1 = './north/250_250_20_fb_ztr_paraguay/measurements_line_plotfile.ascii'
loc2 = './east/250_250_20_fb_ztr_paraguay/measurements_line_plotfile.ascii'
loc3 = './south/250_250_20_fb_ztr_paraguay/measurements_line_plotfile.ascii'
loc4 = './west/250_250_20_fb_ztr_paraguay/measurements_line_plotfile.ascii'


set terminal pngcairo enhanced size 2000,1000


set style line 1 pt 1 lw 1 ps 0.5 lc "black"
set style line 2 pt 2 lw 4 ps 0.5 lc 'grey20' dt 2
set style line 3 pt 7 lw 4 ps 1.5 lc "royalblue"
set style line 4 pt 5 lw 4 ps 1 lc "web-green"
set style line 5 pt 9 lw 4 ps 1.5 lc "orange-red"
set style line 6 pt 11 lw 4 ps 1.5 lc "gold"

set style line 30 pt 6 lw 3 ps 1 lc rgb '#20B2AA'dt (1,1,1,1)
set style line 40 pt 4 lw 3 ps 0.5 lc "dark-olivegreen" dt (1,1,1,1)
set style line 50 pt 8 lw 3 ps 1 lc "coral" dt (1,1,1,1)
set style line 60 pt 10 lw 3 ps 1 lc "dark-violet" dt (1,1,1,1)

set style fill transparent solid 0.15 noborder

set style line 12 lc 'grey80' dt 2 lw 0.5

set key default font "times,12" box lc 'grey60' opaque vertical top right

set xtics out font "times,11" offset 0,0.5
set ytics out font "times,11" offset 0.5
set y2tics out font "times,11" offset -0.5
set grid back ytics ls 12

set autoscale xy
set ytics nomirror

set xlabel font "times,11" 'distance [m]' offset 0,1.2
set y2label font "times,11" 'height surface [m]' rotate by 90+180 offset -2

set format y "%.0f"

set xrange[100:149.4]
set y2range[-6:6]
set y2tics -6,2

######################################################################################
set terminal epscairo enhanced size 16cm,10cm

set output 'flanksim_mp_zt_paraguay_block.eps'
set autoscale y
set ytics autofreq
set ytics auto

set multiplot layout 2,2
unset key

set yrange[19.5:24.5]
set ytics 19,1

set rmargin 4.8
set lmargin 5
set tmargin 0.5
set bmargin 2.3


set ylabel font "times,12" 'intensity [{/Symbol m}T]' offset 1
plot loc1 u 1:($4*1e6) w l ls 2 t "IGRF" axis x1y1,\
     loc1 u 1:($3-1) w filledc x1 ls 1 t "surface" axis x1y2,\
     loc1 u 1:($7*1e6) w l ls 3 t "north flank" axis x1y1,\
     loc2 u 2:($7*1e6) w l ls 6 t "east flank" axis x1y1,\
     loc3 u 1:($7*1e6) w l ls 5 t "south flank" axis x1y1,\
     loc4 u 2:($7*1e6) w l ls 4 t "west flank" axis x1y1

set format y "%.0f"

set yrange[-38:-24]
set ytics -38,2
set ylabel font "times,12" 'inclination [{/Symbol \260}]' offset 2
plot loc1 u 1:5 w l ls 2 t "IGRF" axis x1y1,\
     loc1 u 1:($3-1) w filledc x1 ls 1 t "surface" axis x1y2,\
     loc1 u 1:8 w l ls 3 t "north flank" axis x1y1,\
     loc2 u 2:8 w l ls 6 t "east flank" axis x1y1,\
     loc3 u 1:8 w l ls 5 t "south flank" axis x1y1,\
     loc4 u 2:8 w l ls 4 t "west flank" axis x1y1

set yrange[-22:-8]
set ytics -22,2
set key font "times,12" box lc 'grey60' opaque at screen 0.75,screen 0.25 center center height 0.5 width 1.5
set ylabel font "times,12" 'declination [{/Symbol \260}]' offset 2
plot loc1 u 1:6 w l ls 2 t "IGRF" axis x1y1,\
     loc1 u 1:($3-1) w filledc x1 ls 1 t "surface" axis x1y2,\
     loc1 u 1:9 w l ls 3 t "north flank" axis x1y1,\
     loc2 u 2:9 w l ls 6 t "east flank" axis x1y1,\
     loc3 u 1:9 w l ls 5 t "south flank" axis x1y1,\
     loc4 u 2:9 w l ls 4 t "west flank" axis x1y1
unset multiplot
######################################################################################
######################################################################################
set terminal pngcairo enhanced size 2000,1000

set output 'flanksim_mp_zt_paraguay_block.png'
set autoscale y
set ytics autofreq
set ytics auto

set multiplot layout 2,2
unset key

set yrange[19.5:24.5]
set ytics 19,1

set rmargin 4.8
set lmargin 5
set tmargin 0.5
set bmargin 2.3


set ylabel font "times,12" 'intensity [{/Symbol m}T]' offset 1
plot loc1 u 1:($4*1e6) w l ls 2 t "IGRF" axis x1y1,\
     loc1 u 1:($3-1) w filledc x1 ls 1 t "surface" axis x1y2,\
     loc1 u 1:($7*1e6) w l ls 3 t "north flank" axis x1y1,\
     loc2 u 2:($7*1e6) w l ls 6 t "east flank" axis x1y1,\
     loc3 u 1:($7*1e6) w l ls 5 t "south flank" axis x1y1,\
     loc4 u 2:($7*1e6) w l ls 4 t "west flank" axis x1y1

set format y "%.0f"

set yrange[-38:-24]
set ytics -38,2
set ylabel font "times,12" 'inclination [{/Symbol \260}]' offset 2
plot loc1 u 1:5 w l ls 2 t "IGRF" axis x1y1,\
     loc1 u 1:($3-1) w filledc x1 ls 1 t "surface" axis x1y2,\
     loc1 u 1:8 w l ls 3 t "north flank" axis x1y1,\
     loc2 u 2:8 w l ls 6 t "east flank" axis x1y1,\
     loc3 u 1:8 w l ls 5 t "south flank" axis x1y1,\
     loc4 u 2:8 w l ls 4 t "west flank" axis x1y1

set yrange[-22:-8]
set ytics -22,2
set key font "times,12" box lc 'grey60' opaque at screen 0.75,screen 0.25 center center height 0.5 width 1.5
set ylabel font "times,12" 'declination [{/Symbol \260}]' offset 2
plot loc1 u 1:6 w l ls 2 t "IGRF" axis x1y1,\
     loc1 u 1:($3-1) w filledc x1 ls 1 t "surface" axis x1y2,\
     loc1 u 1:9 w l ls 3 t "north flank" axis x1y1,\
     loc2 u 2:9 w l ls 6 t "east flank" axis x1y1,\
     loc3 u 1:9 w l ls 5 t "south flank" axis x1y1,\
     loc4 u 2:9 w l ls 4 t "west flank" axis x1y1
unset multiplot
######################################################################################
