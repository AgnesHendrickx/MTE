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

set output 'flanksim_mp_zt_180_block.eps'
set multiplot layout 2,2
unset key
set autoscale xy
set ytics autofreq
set ytics nomirror
set xrange[100:149.4]
set xtics 100,10
set rmargin 4.8
set lmargin 5
set tmargin 0.5
set bmargin 2.3

set yrange [42:48]
set ytics 42,2
set ylabel font "times,12" 'intensity [{/Symbol m}T]' offset 1.2
plot loc1 u 1:($4*1e6) w l ls 2 t "IGRF" axis x1y1,\
     loc1 u 1:($3-1) w filledc x1 ls 1 t "surface" axis x1y2,\
     loc1 u 1:($7*1e6) w l ls 3 t "north flank" axis x1y1,\
     loc2 u 2:($7*1e6) w l ls 6 t "east flank" axis x1y1,\
     loc3 u 1:($7*1e6) w l ls 5 t "south flank" axis x1y1,\
     loc4 u 2:($7*1e6) w l ls 4 t "west flank" axis x1y1,\
     loc10 u 1:($7*1e6) w l ls 30 t "1.8m, north flank" axis x1y1,\
     loc20 u 2:($7*1e6) w l ls 60 t "1.8m, east flank" axis x1y1,\
     loc30 u 1:($7*1e6) w l ls 50 t "1.8m, south flank" axis x1y1,\
     loc40 u 2:($7*1e6) w l ls 40 t "1.8m, west flank" axis x1y1

set yrange [49:57]
set ytics 49,2
set ylabel font "times,12" 'inclination [{/Symbol \260}]' offset 1.2
plot loc1 u 1:5 w l ls 2 t "IGRF" axis x1y1,\
     loc1 u 1:($3-1) w filledc x1 ls 1 t "surface" axis x1y2,\
     loc1 u 1:8 w l ls 3 t "north flank" axis x1y1,\
     loc2 u 2:8 w l ls 6 t "east flank" axis x1y1,\
     loc3 u 1:8 w l ls 5 t "south flank" axis x1y1,\
     loc4 u 2:8 w l ls 4 t "west flank" axis x1y1,\
     loc10 u 1:8 w l ls 30 t "1.8m, north flank" axis x1y1,\
     loc20 u 2:8 w l ls 60 t "1.8m, east flank" axis x1y1,\
     loc30 u 1:8 w l ls 50 t "1.8m, south flank" axis x1y1,\
     loc40 u 2:8 w l ls 40 t "1.8m, west flank" axis x1y1


set ytics auto
set key font "times,12" box lc 'grey60' opaque at screen 0.75,screen 0.25 center center height 0.5 width 1.5
set ylabel font "times,12" 'declination [{/Symbol \260}]' offset 1.8
set yrange[-2:9]
set ytics -2,2
plot loc1 u 1:6 w l ls 2 t "IGRF" axis x1y1,\
     loc1 u 1:($3-1) w filledc x1 ls 1 t "surface" axis x1y2,\
     loc1 u 1:9 w l ls 3 t "north flank" axis x1y1,\
     loc2 u 2:9 w l ls 6 t "east flank" axis x1y1,\
     loc3 u 1:9 w l ls 5 t "south flank" axis x1y1,\
     loc4 u 2:9 w l ls 4 t "west flank" axis x1y1,\
     loc10 u 1:9 w l ls 30 t "1.8m, north flank" axis x1y1,\
     loc20 u 2:9 w l ls 60 t "1.8m, east flank" axis x1y1,\
     loc30 u 1:9 w l ls 50 t "1.8m, south flank" axis x1y1,\
     loc40 u 2:9 w l ls 40 t "1.8m, west flank" axis x1y1
unset multiplot
######################################################################################
set output 'flanksim_mp_zt_block.eps'
#set autoscale xy
set ytics autofreq
set ytics nomirror

set multiplot layout 2,2
unset key
set yrange[42:48]
set ytics 42,2
set rmargin 4.8
set lmargin 5
set tmargin 0.5
set bmargin 2.3


set ylabel font "times,12" 'intensity [{/Symbol m}T]'
plot loc1 u 1:($4*1e6) w l ls 2 t "IGRF" axis x1y1,\
     loc1 u 1:($3-1) w filledc x1 ls 1 t "surface" axis x1y2,\
     loc1 u 1:($7*1e6) w l ls 3 t "north flank" axis x1y1,\
     loc2 u 2:($7*1e6) w l ls 6 t "east flank" axis x1y1,\
     loc3 u 1:($7*1e6) w l ls 5 t "south flank" axis x1y1,\
     loc4 u 2:($7*1e6) w l ls 4 t "west flank" axis x1y1

set yrange[49:57]
set ytics 49,2
set ylabel font "times,12" 'inclination [{/Symbol \260}]'
plot loc1 u 1:5 w l ls 2 t "IGRF" axis x1y1,\
     loc1 u 1:($3-1) w filledc x1 ls 1 t "surface" axis x1y2,\
     loc1 u 1:8 w l ls 3 t "north flank" axis x1y1,\
     loc2 u 2:8 w l ls 6 t "east flank" axis x1y1,\
     loc3 u 1:8 w l ls 5 t "south flank" axis x1y1,\
     loc4 u 2:8 w l ls 4 t "west flank" axis x1y1

set yrange[-2:9]
set ytics -2,2
set key font "times,12" box lc 'grey60' opaque at screen 0.75,screen 0.25 center center height 0.5 width 1.5
set ylabel font "times,12" 'declination [{/Symbol \260}]'
plot loc1 u 1:6 w l ls 2 t "IGRF" axis x1y1,\
     loc1 u 1:($3-1) w filledc x1 ls 1 t "surface" axis x1y2,\
     loc1 u 1:9 w l ls 3 t "north flank" axis x1y1,\
     loc2 u 2:9 w l ls 6 t "east flank" axis x1y1,\
     loc3 u 1:9 w l ls 5 t "south flank" axis x1y1,\
     loc4 u 2:9 w l ls 4 t "west flank" axis x1y1
unset multiplot
######################################################################################
set terminal epscairo size 16cm,22cm

set output 'flanksim_mp_zt.eps'
#set autoscale xy
set ytics autofreq
set ytics nomirror

set multiplot layout 3,1
unset key
set yrange[42:48]
set ytics 42,2

set ylabel font "times,12" 'intensity [{/Symbol m}T]'
plot loc1 u 1:($4*1e6) w l ls 2 t "IGRF" axis x1y1,\
     loc1 u 1:($3-1) w filledc x1 ls 1 t "surface" axis x1y2,\
     loc1 u 1:($7*1e6) w l ls 3 t "north flank" axis x1y1,\
     loc2 u 2:($7*1e6) w l ls 6 t "east flank" axis x1y1,\
     loc3 u 1:($7*1e6) w l ls 5 t "south flank" axis x1y1,\
     loc4 u 2:($7*1e6) w l ls 4 t "west flank" axis x1y1

set yrange[49:57]
set ytics 49,2
set ylabel font "times,12" 'inclination [{/Symbol \260}]'
plot loc1 u 1:5 w l ls 2 t "IGRF" axis x1y1,\
     loc1 u 1:($3-1) w filledc x1 ls 1 t "surface" axis x1y2,\
     loc1 u 1:8 w l ls 3 t "north flank" axis x1y1,\
     loc2 u 2:8 w l ls 6 t "east flank" axis x1y1,\
     loc3 u 1:8 w l ls 5 t "south flank" axis x1y1,\
     loc4 u 2:8 w l ls 4 t "west flank" axis x1y1

set yrange[-3:9]
set ytics -2,2
set key font "times,12" at graph 1,0 bottom right width 0 height 0.3
set ylabel font "times,12" 'declination [{/Symbol \260}]'
plot loc1 u 1:6 w l ls 2 t "IGRF" axis x1y1,\
     loc1 u 1:($3-1) w filledc x1 ls 1 t "surface" axis x1y2,\
     loc1 u 1:9 w l ls 3 t "north flank" axis x1y1,\
     loc2 u 2:9 w l ls 6 t "east flank" axis x1y1,\
     loc3 u 1:9 w l ls 5 t "south flank" axis x1y1,\
     loc4 u 2:9 w l ls 4 t "west flank" axis x1y1
unset multiplot

######################################################################################

set output 'flanksim_mp_zt_180.eps'
set multiplot layout 3,1
unset key
set autoscale xy
set ytics autofreq
set ytics nomirror
set xrange[100:149.4]

set ylabel font "times,12" 'intensity [{/Symbol m}T]'
plot loc1 u 1:($4*1e6) w l ls 2 t "IGRF" axis x1y1,\
     loc1 u 1:($3-1) w filledc x1 ls 1 t "surface" axis x1y2,\
     loc1 u 1:($7*1e6) w l ls 3 t "north flank" axis x1y1,\
     loc2 u 2:($7*1e6) w l ls 6 t "east flank" axis x1y1,\
     loc3 u 1:($7*1e6) w l ls 5 t "south flank" axis x1y1,\
     loc4 u 2:($7*1e6) w l ls 4 t "west flank" axis x1y1,\
     loc10 u 1:($7*1e6) w l ls 30 t "1.8m, north flank" axis x1y1,\
     loc20 u 2:($7*1e6) w l ls 60 t "1.8m, east flank" axis x1y1,\
     loc30 u 1:($7*1e6) w l ls 50 t "1.8m, south flank" axis x1y1,\
     loc40 u 2:($7*1e6) w l ls 40 t "1.8m, west flank" axis x1y1


set ylabel font "times,12" 'inclination [{/Symbol \260}]'
plot loc1 u 1:5 w l ls 2 t "IGRF" axis x1y1,\
     loc1 u 1:($3-1) w filledc x1 ls 1 t "surface" axis x1y2,\
     loc1 u 1:8 w l ls 3 t "north flank" axis x1y1,\
     loc2 u 2:8 w l ls 6 t "east flank" axis x1y1,\
     loc3 u 1:8 w l ls 5 t "south flank" axis x1y1,\
     loc4 u 2:8 w l ls 4 t "west flank" axis x1y1,\
     loc10 u 1:8 w l ls 30 t "1.8m, north flank" axis x1y1,\
     loc20 u 2:8 w l ls 60 t "1.8m, east flank" axis x1y1,\
     loc30 u 1:8 w l ls 50 t "1.8m, south flank" axis x1y1,\
     loc40 u 2:8 w l ls 40 t "1.8m, west flank" axis x1y1

set key font "times,12" at graph 1,0 bottom width 0.5 height 0.3
set ylabel font "times,12" 'declination [{/Symbol \260}]'
set yrange[-3:9]
set ytics -2,2
plot loc1 u 1:6 w l ls 2 t "IGRF" axis x1y1,\
     loc1 u 1:($3-1) w filledc x1 ls 1 t "surface" axis x1y2,\
     loc1 u 1:9 w l ls 3 t "north flank" axis x1y1,\
     loc2 u 2:9 w l ls 6 t "east flank" axis x1y1,\
     loc3 u 1:9 w l ls 5 t "south flank" axis x1y1,\
     loc4 u 2:9 w l ls 4 t "west flank" axis x1y1,\
     loc10 u 1:9 w l ls 30 t "1.8m, north flank" axis x1y1,\
     loc20 u 2:9 w l ls 60 t "1.8m, east flank" axis x1y1,\
     loc30 u 1:9 w l ls 50 t "1.8m, south flank" axis x1y1,\
     loc40 u 2:9 w l ls 40 t "1.8m, west flank" axis x1y1
unset multiplot

set terminal pngcairo enhanced size 1600,1000

set output 'flanksim_mp_zt_180_block.png'
set multiplot layout 2,2
unset key
set autoscale xy
set ytics autofreq
set ytics nomirror
set xrange[100:149.4]
set rmargin 4.8
set lmargin 5
set tmargin 0.5
set bmargin 2.3

set ylabel font "times,12" 'intensity [{/Symbol m}T]' offset 1.2
plot loc1 u 1:($4*1e6) w l ls 2 t "IGRF" axis x1y1,\
     loc1 u 1:($3-1) w filledc x1 ls 1 t "surface" axis x1y2,\
     loc1 u 1:($7*1e6) w l ls 3 t "north flank" axis x1y1,\
     loc2 u 2:($7*1e6) w l ls 6 t "east flank" axis x1y1,\
     loc3 u 1:($7*1e6) w l ls 5 t "south flank" axis x1y1,\
     loc4 u 2:($7*1e6) w l ls 4 t "west flank" axis x1y1,\
     loc10 u 1:($7*1e6) w l ls 30 t "1.8m, north flank" axis x1y1,\
     loc20 u 2:($7*1e6) w l ls 60 t "1.8m, east flank" axis x1y1,\
     loc30 u 1:($7*1e6) w l ls 50 t "1.8m, south flank" axis x1y1,\
     loc40 u 2:($7*1e6) w l ls 40 t "1.8m, west flank" axis x1y1


set ylabel font "times,12" 'inclination [{/Symbol \260}]' offset 1.2
plot loc1 u 1:5 w l ls 2 t "IGRF" axis x1y1,\
     loc1 u 1:($3-1) w filledc x1 ls 1 t "surface" axis x1y2,\
     loc1 u 1:8 w l ls 3 t "north flank" axis x1y1,\
     loc2 u 2:8 w l ls 6 t "east flank" axis x1y1,\
     loc3 u 1:8 w l ls 5 t "south flank" axis x1y1,\
     loc4 u 2:8 w l ls 4 t "west flank" axis x1y1,\
     loc10 u 1:8 w l ls 30 t "1.8m, north flank" axis x1y1,\
     loc20 u 2:8 w l ls 60 t "1.8m, east flank" axis x1y1,\
     loc30 u 1:8 w l ls 50 t "1.8m, south flank" axis x1y1,\
     loc40 u 2:8 w l ls 40 t "1.8m, west flank" axis x1y1

set key font "times,12" box lc 'grey60' opaque at screen 0.75,screen 0.25 center center height 0.5 width 1.5
set ylabel font "times,12" 'declination [{/Symbol \260}]' offset 1.8
set yrange[-2:9]
set ytics -2,2
plot loc1 u 1:6 w l ls 2 t "IGRF" axis x1y1,\
     loc1 u 1:($3-1) w filledc x1 ls 1 t "surface" axis x1y2,\
     loc1 u 1:9 w l ls 3 t "north flank" axis x1y1,\
     loc2 u 2:9 w l ls 6 t "east flank" axis x1y1,\
     loc3 u 1:9 w l ls 5 t "south flank" axis x1y1,\
     loc4 u 2:9 w l ls 4 t "west flank" axis x1y1,\
     loc10 u 1:9 w l ls 30 t "1.8m, north flank" axis x1y1,\
     loc20 u 2:9 w l ls 60 t "1.8m, east flank" axis x1y1,\
     loc30 u 1:9 w l ls 50 t "1.8m, south flank" axis x1y1,\
     loc40 u 2:9 w l ls 40 t "1.8m, west flank" axis x1y1
unset multiplot
