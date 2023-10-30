
loc1 = '../zt/250_250_5/measurements_line.ascii'
loc2 = './south/extest/250_250_5/measurements_line.ascii'

loc3 = '../zt/250_250_10/measurements_line.ascii'
loc4 = './south/extest/250_250_10/measurements_line.ascii'

loc5 = '../zt/250_250_20/measurements_line.ascii'
loc6 = './south/extest/250_250_20/measurements_line.ascii'

loc7 = '../zt/250_250_40/measurements_line.ascii'
loc8 = './south/extest/250_250_40/measurements_line.ascii'

loc9 = '../zt/500_500_20/measurements_line.ascii'
loc10 = './south/extest/500_500_20/measurements_line.ascii'

loc11 = '../zt/1000_1000_20/measurements_line.ascii'
loc12 = './south/extest/1000_1000_20/measurements_line.ascii'


loc22 = '../zt/250_250_1/measurements_line.ascii'
loc15 = './south/250_250_20_zt_fb_aut/measurements_line.ascii'

loc16 = './250_250_20_36/measurements_line.ascii'
loc17 = './250_250_10_36/measurements_line.ascii'

set terminal epscairo size 12,6

set style line 1 pt 1 lw 2 ps 0.5 lc "black"
set style line 2 pt 2 lw 2 ps 0.5 lc 'grey20'
set style line 3 pt 7 lw 2 ps 1 lc "royalblue"
set style line 4 pt 5 lw 2 ps 0.5 lc "web-green" 
set style line 5 pt 9 lw 2 ps 1 lc "orange-red"
set style line 6 pt 11 lw 2 ps 1 lc "gold"

set style line 14 pt 7 ps 1 lw 2 lc 'light-green'
set style line 144 pt 6 ps 1 lw 2 lc 'web-green' 
set style line 1444 pt 7 ps 0.5 lw 2 lc 'dark-green'
set style line 14444 pt 6 ps 0.5 lw 2 lc 'olive'
set style line 144444 pt 7 ps 1 lw 2 dt 1 lc 'sienna4'


set style line 17 pt 13 ps 1 lw 2 lc 'slategray'
set style line 177 pt 12 ps 1 lw 2 lc 'steelblue'
set style line 1777 pt 11 ps 0.5 lw 2 lc 'skyblue'
set style line 17777 pt 10 ps 0.5 lw 2 lc 'web-blue'
set style line 177777 pt 9 ps 0.5 lw 2 lc 'royalblue'
set style line 1777777 pt 8 ps 0.5 lw 2 lc 'medium-blue'
set style line 17777777 pt 11 ps 1.5 lw 2 lc 'midnight-blue'
set style line 177777777 pt 10 ps 1.5 lw 2 lc 'cyan'
set style line 1777777777 pt 9 ps 1 lw 2 lc 'aquamarine'
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
###################################
set output 'topo_zt_sb.eps'

set multiplot layout 1,3
set yrange [*:*]

set ylabel font "times,14" 'B_x (North) [{/Symbol m}T]'
set format y "%.1f"
set size 0.33,1
unset key

plot loc6 u 0:($3-1) w l ls 2 t "surface" axis x1y2,\
     '< exec bash -c "paste <(cat ../zt/250_250_5/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_5/measurements_line.ascii)"' u 0:(($14-$5)*1e6) w lp ls 17 t "sb - zt, 250x250x5" axis x1y1,\
     '< exec bash -c "paste <(cat ../zt/250_250_10/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_10/measurements_line.ascii)"' u 0:(($14-$5)*1e6) w lp ls 177 t "sb - zt, 250x250x10" axis x1y1,\
    '< exec bash -c "paste <(cat ./south/250_250_10_zt_sb/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_10/measurements_line.ascii)"' u 0:(($14-$5)*1e6) w lp ls 14 t "sb - zt sb sloped, 250x250x10" axis x1y1,\
     '< exec bash -c "paste <(cat ../zt/250_250_20/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_20/measurements_line.ascii)"' u 0:(($14-$5)*1e6) w lp ls 1777 t "sb - zt, 250x250x20" axis x1y1,\
     '< exec bash -c "paste <(cat ./south/250_250_20_zt_sb/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_20/measurements_line.ascii)"' u 0:(($14-$5)*1e6) w lp ls 144 t "sb - zt sb sloped, 250x250x20" axis x1y1,\
     '< exec bash -c "paste <(cat ../zt/250_250_40/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_40/measurements_line.ascii)"' u 0:(($14-$5)*1e6) w lp ls 17777 t "sb - zt, 250x250x40" axis x1y1,\
     '< exec bash -c "paste <(cat ./south/250_250_40_zt_sb/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_40/measurements_line.ascii)"' u 0:(($14-$5)*1e6) w lp ls 1444 t "sb - zt sb sloped, 250x250x40" axis x1y1,\
     '< exec bash -c "paste <(cat ../zt/500_500_20/measurements_line.ascii) <(head -n 200 ./south/extest/500_500_20/measurements_line.ascii)"' u 0:(($14-$5)*1e6) w lp ls 5 t "sb - zt, 500x500x20" axis x1y1,\
     '< exec bash -c "paste <(cat ../zt/1000_1000_20/measurements_line.ascii) <(head -n 200 ./south/extest/1000_1000_20/measurements_line.ascii)"' u 0:(($14-$5)*1e6) w lp ls 6 t "sb - zt, 1000x1000x20" axis x1y1

set autoscale y

set size 0.33,1
set ylabel font "times,14" 'B_y (East) [{/Symbol m}T]'
plot loc6 u 0:($3-1) w l ls 2 t "surface" axis x1y2,\
     '< exec bash -c "paste <(cat ../zt/250_250_5/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_5/measurements_line.ascii)"' u 0:(($13-$4)*1e6) w lp ls 17 t "sb - zt, 250x250x5" axis x1y1,\
     '< exec bash -c "paste <(cat ../zt/250_250_10/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_10/measurements_line.ascii)"' u 0:(($13-$4)*1e6) w lp ls 177 t "sb - zt, 250x250x10" axis x1y1,\
    '< exec bash -c "paste <(cat ./south/250_250_10_zt_sb/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_10/measurements_line.ascii)"' u 0:(($13-$4)*1e6) w lp ls 14 t "sb - zt sb sloped, 250x250x10" axis x1y1,\
     '< exec bash -c "paste <(cat ../zt/250_250_20/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_20/measurements_line.ascii)"' u 0:(($13-$4)*1e6) w lp ls 1777 t "sb - zt, 250x250x20" axis x1y1,\
     '< exec bash -c "paste <(cat ./south/250_250_20_zt_sb/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_20/measurements_line.ascii)"' u 0:(($13-$4)*1e6) w lp ls 144 t "sb - zt sb sloped, 250x250x20" axis x1y1,\
     '< exec bash -c "paste <(cat ../zt/250_250_40/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_40/measurements_line.ascii)"' u 0:(($13-$4)*1e6) w lp ls 17777 t "sb - zt, 250x250x40" axis x1y1,\
     '< exec bash -c "paste <(cat ./south/250_250_40_zt_sb/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_40/measurements_line.ascii)"' u 0:(($13-$4)*1e6) w lp ls 1444 t "sb - zt sb sloped, 250x250x40" axis x1y1,\
     '< exec bash -c "paste <(cat ../zt/500_500_20/measurements_line.ascii) <(head -n 200 ./south/extest/500_500_20/measurements_line.ascii)"' u 0:(($13-$4)*1e6) w lp ls 5 t "sb - zt, 500x500x20" axis x1y1,\
     '< exec bash -c "paste <(cat ../zt/1000_1000_20/measurements_line.ascii) <(head -n 200 ./south/extest/1000_1000_20/measurements_line.ascii)"' u 0:(($13-$4)*1e6) w lp ls 6 t "sb - zt, 1000x1000x20" axis x1y1



set key default font "times,14" box lc 'grey60' opaque fc 'grey90' top right horizontal height 0.2 
set size 0.33,1
set ylabel font "times,14" 'B_z (Down) [{/Symbol m}T]'
plot loc6 u 0:($3-1) w l ls 2 t "surface" axis x1y2,\
     '< exec bash -c "paste <(cat ../zt/250_250_5/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_5/measurements_line.ascii)"' u 0:(-($15-$6)*1e6) w lp ls 17 t "sb - zt, 250x250x5" axis x1y1,\
     '< exec bash -c "paste <(cat ../zt/250_250_10/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_10/measurements_line.ascii)"' u 0:(-($15-$6)*1e6) w lp ls 177 t "sb - zt, 250x250x10" axis x1y1,\
    '< exec bash -c "paste <(cat ./south/250_250_10_zt_sb/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_10/measurements_line.ascii)"' u 0:(-($15-$6)*1e6) w lp ls 14 t "sb - zt sb sloped, 250x250x10" axis x1y1,\
     '< exec bash -c "paste <(cat ../zt/250_250_20/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_20/measurements_line.ascii)"' u 0:(-($15-$6)*1e6) w lp ls 1777 t "sb - zt, 250x250x20" axis x1y1,\
     '< exec bash -c "paste <(cat ./south/250_250_20_zt_sb/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_20/measurements_line.ascii)"' u 0:(-($15-$6)*1e6) w lp ls 144 t "sb - zt sb sloped, 250x250x20" axis x1y1,\
     '< exec bash -c "paste <(cat ../zt/250_250_40/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_40/measurements_line.ascii)"' u 0:(-($15-$6)*1e6) w lp ls 17777 t "sb - zt, 250x250x40" axis x1y1,\
     '< exec bash -c "paste <(cat ./south/250_250_40_zt_sb/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_40/measurements_line.ascii)"' u 0:(-($15-$6)*1e6) w lp ls 1444 t "sb - zt sb sloped, 250x250x40" axis x1y1,\
     '< exec bash -c "paste <(cat ../zt/500_500_20/measurements_line.ascii) <(head -n 200 ./south/extest/500_500_20/measurements_line.ascii)"' u 0:(-($15-$6)*1e6) w lp ls 5 t "sb - zt, 500x500x20" axis x1y1,\
     '< exec bash -c "paste <(cat ../zt/1000_1000_20/measurements_line.ascii) <(head -n 200 ./south/extest/1000_1000_20/measurements_line.ascii)"' u 0:(-($15-$6)*1e6) w lp ls 6 t "sb - zt, 1000x1000x20" axis x1y1

unset multiplot
##################


set output 'topo_zt.eps'

set multiplot layout 2,2

set ylabel font "times,14" 'B_x (North) [{/Symbol m}T]'

unset key
set format y "%.1f"
set size 0.5,0.5
set yrange [0.1:0.7]
set ytics -0.5,0.2
set mytics 2

plot loc6 u 0:($3-1) w l ls 2 t "surface" axis x1y2,\
     '< exec bash -c "paste <(cat ../zt/250_250_5/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_5/measurements_line.ascii)"' u 0:(($14-$5)*1e6) w lp ls 17 t "fb - zt, 250x250x5" axis x1y1,\
     '< exec bash -c "paste <(cat ../zt/250_250_10/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_10/measurements_line.ascii)"' u 0:(($14-$5)*1e6) w lp ls 177 t "fb - zt, 250x250x10" axis x1y1,\
     '< exec bash -c "paste <(cat ../zt/250_250_20/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_20/measurements_line.ascii)"' u 0:(($14-$5)*1e6) w lp ls 1777 t "fb - zt, 250x250x20" axis x1y1,\
     '< exec bash -c "paste <(cat ../zt/250_250_40/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_40/measurements_line.ascii)"' u 0:(($14-$5)*1e6) w lp ls 17777 t "fb - zt, 250x250x40" axis x1y1,\
     '< exec bash -c "paste <(cat ../zt/500_500_20/measurements_line.ascii) <(head -n 200 ./south/extest/500_500_20/measurements_line.ascii)"' u 0:(($14-$5)*1e6) w lp ls 5 t "fb - zt, 500x500x20" axis x1y1,\
     '< exec bash -c "paste <(cat ../zt/1000_1000_20/measurements_line.ascii) <(head -n 200 ./south/extest/1000_1000_20/measurements_line.ascii)"' u 0:(($14-$5)*1e6) w lp ls 6 t "fb - zt, 1000x1000x20" axis x1y1

set autoscale y
set size 0.5,0.5
set format y "%0.0f"
set yrange [-3:3]
set ytics -3,1
set mytics 2
set ylabel font "times,14" 'B_y (East) [{/Symbol m}T]'
plot loc6 u 0:($3-1) w l ls 2 t "surface" axis x1y2,\
     '< exec bash -c "paste <(cat ../zt/250_250_5/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_5/measurements_line.ascii)"' u 0:(($13-$4)*1e6) w lp ls 17 t "fb - zt, 250x250x5" axis x1y1,\
     '< exec bash -c "paste <(cat ../zt/250_250_10/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_10/measurements_line.ascii)"' u 0:(($13-$4)*1e6) w lp ls 177 t "fb - zt, 250x250x10" axis x1y1,\
     '< exec bash -c "paste <(cat ../zt/250_250_20/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_20/measurements_line.ascii)"' u 0:(($13-$4)*1e6) w lp ls 1777 t "fb - zt, 250x250x20" axis x1y1,\
     '< exec bash -c "paste <(cat ../zt/250_250_40/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_40/measurements_line.ascii)"' u 0:(($13-$4)*1e6) w lp ls 17777 t "fb - zt, 250x250x40" axis x1y1,\
     '< exec bash -c "paste <(cat ../zt/500_500_20/measurements_line.ascii) <(head -n 200 ./south/extest/500_500_20/measurements_line.ascii)"' u 0:(($13-$4)*1e6) w lp ls 5 t "fb - zt, 500x500x20" axis x1y1,\
     '< exec bash -c "paste <(cat ../zt/1000_1000_20/measurements_line.ascii) <(head -n 200 ./south/extest/1000_1000_20/measurements_line.ascii)"' u 0:(($13-$4)*1e6) w lp ls 6 t "fb - zt, 1000x1000x20" axis x1y1



set key default font "times,14" box lc 'grey60' opaque fc 'grey90' height 0.5 at screen 0.75,screen 0.25 center center
set size 0.5,0.5
set yrange [-3:3]
set ytics -3,1
set mytics 2
set ylabel font "times,14" 'B_z (Down) [{/Symbol m}T]'
plot loc6 u 0:($3-1) w l ls 2 t "surface" axis x1y2,\
     '< exec bash -c "paste <(cat ../zt/250_250_5/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_5/measurements_line.ascii)"' u 0:(-($15-$6)*1e6) w lp ls 17 t "fb - zt, 250x250x5" axis x1y1,\
     '< exec bash -c "paste <(cat ../zt/250_250_10/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_10/measurements_line.ascii)"' u 0:(-($15-$6)*1e6) w lp ls 177 t "fb - zt, 250x250x10" axis x1y1,\
     '< exec bash -c "paste <(cat ../zt/250_250_20/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_20/measurements_line.ascii)"' u 0:(-($15-$6)*1e6) w lp ls 1777 t "fb - zt, 250x250x20" axis x1y1,\
     '< exec bash -c "paste <(cat ../zt/250_250_40/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_40/measurements_line.ascii)"' u 0:(-($15-$6)*1e6) w lp ls 17777 t "fb - zt, 250x250x40" axis x1y1,\
     '< exec bash -c "paste <(cat ../zt/500_500_20/measurements_line.ascii) <(head -n 200 ./south/extest/500_500_20/measurements_line.ascii)"' u 0:(-($15-$6)*1e6) w lp ls 5 t "fb - zt, 500x500x20" axis x1y1,\
     '< exec bash -c "paste <(cat ../zt/1000_1000_20/measurements_line.ascii) <(head -n 200 ./south/extest/1000_1000_20/measurements_line.ascii)"' u 0:(-($15-$6)*1e6) w lp ls 6 t "fb - zt, 1000x1000x20" axis x1y1

unset multiplot

###################################



set output 'topo_zt_fb.eps'

set multiplot layout 2,2

set ylabel font "times,14" 'B_x (North) [{/Symbol m}T]'

unset key
set format y "%.1f"
set size 0.5,0.5
set yrange [-0.4:0.7]
set ytics -0.6,0.2
set mytics 2

plot loc6 u 0:($3-1) w l ls 2 t "surface" axis x1y2,\
     '< exec bash -c "paste <(cat ../zt/250_250_5/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_5/measurements_line.ascii)"' u 0:(($14-$5)*1e6) w lp ls 17 t "fb - zt, 250x250x5" axis x1y1,\
     '< exec bash -c "paste <(cat ../zt/250_250_10/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_10/measurements_line.ascii)"' u 0:(($14-$5)*1e6) w lp ls 177 t "fb - zt, 250x250x10" axis x1y1,\
    '< exec bash -c "paste <(cat ./south/250_250_10_zt_fb/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_10/measurements_line.ascii)"' u 0:(($14-$5)*1e6) w lp ls 14 t "fb - zt fb sloped, 250x250x10" axis x1y1,\
     '< exec bash -c "paste <(cat ../zt/250_250_20/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_20/measurements_line.ascii)"' u 0:(($14-$5)*1e6) w lp ls 1777 t "fb - zt, 250x250x20" axis x1y1,\
     '< exec bash -c "paste <(cat ./south/250_250_20_zt_fb/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_20/measurements_line.ascii)"' u 0:(($14-$5)*1e6) w lp ls 144 t "fb - zt fb sloped, 250x250x20" axis x1y1,\
     '< exec bash -c "paste <(cat ../zt/250_250_40/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_40/measurements_line.ascii)"' u 0:(($14-$5)*1e6) w lp ls 17777 t "fb - zt, 250x250x40" axis x1y1,\
     '< exec bash -c "paste <(cat ./south/250_250_40_zt_fb/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_40/measurements_line.ascii)"' u 0:(($14-$5)*1e6) w lp ls 1444 t "fb - zt fb sloped, 250x250x40" axis x1y1,\
     '< exec bash -c "paste <(cat ../zt/500_500_20/measurements_line.ascii) <(head -n 200 ./south/extest/500_500_20/measurements_line.ascii)"' u 0:(($14-$5)*1e6) w lp ls 5 t "fb - zt, 500x500x20" axis x1y1,\
     '< exec bash -c "paste <(cat ../zt/1000_1000_20/measurements_line.ascii) <(head -n 200 ./south/extest/1000_1000_20/measurements_line.ascii)"' u 0:(($14-$5)*1e6) w lp ls 6 t "fb - zt, 1000x1000x20" axis x1y1

set autoscale y
set size 0.5,0.5
set format y "%0.0f"
set yrange [-3:3]
set ytics -3,1
set mytics 2
set ylabel font "times,14" 'B_y (East) [{/Symbol m}T]'
plot loc6 u 0:($3-1) w l ls 2 t "surface" axis x1y2,\
     '< exec bash -c "paste <(cat ../zt/250_250_5/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_5/measurements_line.ascii)"' u 0:(($13-$4)*1e6) w lp ls 17 t "fb - zt, 250x250x5" axis x1y1,\
     '< exec bash -c "paste <(cat ../zt/250_250_10/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_10/measurements_line.ascii)"' u 0:(($13-$4)*1e6) w lp ls 177 t "fb - zt, 250x250x10" axis x1y1,\
    '< exec bash -c "paste <(cat ./south/250_250_10_zt_fb/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_10/measurements_line.ascii)"' u 0:(($13-$4)*1e6) w lp ls 14 t "fb - zt fb sloped, 250x250x10" axis x1y1,\
     '< exec bash -c "paste <(cat ../zt/250_250_20/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_20/measurements_line.ascii)"' u 0:(($13-$4)*1e6) w lp ls 1777 t "fb - zt, 250x250x20" axis x1y1,\
     '< exec bash -c "paste <(cat ./south/250_250_20_zt_fb/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_20/measurements_line.ascii)"' u 0:(($13-$4)*1e6) w lp ls 144 t "fb - zt fb sloped, 250x250x20" axis x1y1,\
     '< exec bash -c "paste <(cat ../zt/250_250_40/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_40/measurements_line.ascii)"' u 0:(($13-$4)*1e6) w lp ls 17777 t "fb - zt, 250x250x40" axis x1y1,\
     '< exec bash -c "paste <(cat ./south/250_250_40_zt_fb/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_40/measurements_line.ascii)"' u 0:(($13-$4)*1e6) w lp ls 1444 t "fb - zt fb sloped, 250x250x40" axis x1y1,\
     '< exec bash -c "paste <(cat ../zt/500_500_20/measurements_line.ascii) <(head -n 200 ./south/extest/500_500_20/measurements_line.ascii)"' u 0:(($13-$4)*1e6) w lp ls 5 t "fb - zt, 500x500x20" axis x1y1,\
     '< exec bash -c "paste <(cat ../zt/1000_1000_20/measurements_line.ascii) <(head -n 200 ./south/extest/1000_1000_20/measurements_line.ascii)"' u 0:(($13-$4)*1e6) w lp ls 6 t "fb - zt, 1000x1000x20" axis x1y1



set key default font "times,14" box lc 'grey60' opaque fc 'grey90' height 0.5 at screen 0.75,screen 0.25 center center
set size 0.5,0.5
set yrange [-4:3]
set ytics -4,1
set mytics 2
set ylabel font "times,14" 'B_z (Down) [{/Symbol m}T]'
plot loc6 u 0:($3-1) w l ls 2 t "surface" axis x1y2,\
     '< exec bash -c "paste <(cat ../zt/250_250_5/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_5/measurements_line.ascii)"' u 0:(-($15-$6)*1e6) w lp ls 17 t "fb - zt, 250x250x5" axis x1y1,\
     '< exec bash -c "paste <(cat ../zt/250_250_10/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_10/measurements_line.ascii)"' u 0:(-($15-$6)*1e6) w lp ls 177 t "fb - zt, 250x250x10" axis x1y1,\
    '< exec bash -c "paste <(cat ./south/250_250_10_zt_fb/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_10/measurements_line.ascii)"' u 0:(-($15-$6)*1e6) w lp ls 14 t "fb - zt fb sloped, 250x250x10" axis x1y1,\
     '< exec bash -c "paste <(cat ../zt/250_250_20/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_20/measurements_line.ascii)"' u 0:(-($15-$6)*1e6) w lp ls 1777 t "fb - zt, 250x250x20" axis x1y1,\
     '< exec bash -c "paste <(cat ./south/250_250_20_zt_fb/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_20/measurements_line.ascii)"' u 0:(-($15-$6)*1e6) w lp ls 144 t "fb - zt fb sloped, 250x250x20" axis x1y1,\
     '< exec bash -c "paste <(cat ../zt/250_250_40/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_40/measurements_line.ascii)"' u 0:(-($15-$6)*1e6) w lp ls 17777 t "fb - zt, 250x250x40" axis x1y1,\
     '< exec bash -c "paste <(cat ./south/250_250_40_zt_fb/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_40/measurements_line.ascii)"' u 0:(-($15-$6)*1e6) w lp ls 1444 t "fb - zt fb sloped, 250x250x40" axis x1y1,\
     '< exec bash -c "paste <(cat ../zt/500_500_20/measurements_line.ascii) <(head -n 200 ./south/extest/500_500_20/measurements_line.ascii)"' u 0:(-($15-$6)*1e6) w lp ls 5 t "fb - zt, 500x500x20" axis x1y1,\
     '< exec bash -c "paste <(cat ../zt/1000_1000_20/measurements_line.ascii) <(head -n 200 ./south/extest/1000_1000_20/measurements_line.ascii)"' u 0:(-($15-$6)*1e6) w lp ls 6 t "fb - zt, 1000x1000x20" axis x1y1

unset multiplot
###################################

set output 'topo_zt_fb_sb.eps'
set multiplot layout 2,2
set format y "%0.1f"
set size 0.5,0.5
set yrange [-0.3:0.7]
set ytics -0.6,0.2
set mytics 2
set ylabel font "times,14" 'B_x (North) [{/Symbol m}T]'
unset key
plot loc6 u 0:($3-1) w l ls 2 t "surface" axis x1y2,\
     '< exec bash -c "paste <(cat ../zt/250_250_10/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_10/measurements_line.ascii)"' u 0:(($14-$5)*1e6) w lp ls 3 t "fb - zt, 250x250x10" axis x1y1,\
     '< exec bash -c "paste <(cat ../zt/250_250_20/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_20/measurements_line.ascii)"' u 0:(($14-$5)*1e6) w lp ls 4 t "fb - zt, 250x250x20" axis x1y1,\
     '< exec bash -c "paste <(cat ../zt/250_250_10/measurements_line.ascii) <(head -n 200 ./south/250_250_10_sb/measurements_line.ascii)"' u 0:(($14-$5)*1e6) w lp ls 5 t "sb - zt, 250x250x10" axis x1y1,\
     '< exec bash -c "paste <(cat ../zt/250_250_20/measurements_line.ascii) <(head -n 200 ./south/250_250_20_sb/measurements_line.ascii)"' u 0:(($14-$5)*1e6) w lp ls 6 t "sb - zt, 250x250x20" axis x1y1

set autoscale y
set size 0.5,0.5
set format y "%0.0f"
set yrange [-3:3]
set ytics -3,1
set mytics 2
set ylabel font "times,14" 'B_y (East) [{/Symbol m}T]'
set key default font "times,14" box lc 'grey60' opaque fc 'grey90' height 0.5 at screen 0.75,screen 0.25 center center
plot loc6 u 0:($3-1) w l ls 2 t "surface" axis x1y2,\
     '< exec bash -c "paste <(cat ../zt/250_250_10/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_10/measurements_line.ascii)"' u 0:(($13-$4)*1e6) w lp ls 3 t "fb - zt, 250x250x10" axis x1y1,\
     '< exec bash -c "paste <(cat ../zt/250_250_20/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_20/measurements_line.ascii)"' u 0:(($13-$4)*1e6) w lp ls 4 t "fb - zt, 250x250x20" axis x1y1,\
     '< exec bash -c "paste <(cat ../zt/250_250_10/measurements_line.ascii) <(head -n 200 ./south/250_250_10_sb/measurements_line.ascii)"' u 0:(($13-$4)*1e6) w lp ls 5 t "sb - zt, 250x250x10" axis x1y1,\
     '< exec bash -c "paste <(cat ../zt/250_250_20/measurements_line.ascii) <(head -n 200 ./south/250_250_20_sb/measurements_line.ascii)"' u 0:(($13-$4)*1e6) w lp ls 6 t "sb - zt, 250x250x20" axis x1y1

set size 0.5,0.5
set yrange [-4:3]
set ytics -4,1
set mytics 2
set ylabel font "times,14" 'B_z (Down) [{/Symbol m}T]'
unset key
plot loc6 u 0:($3-1) w l ls 2 t "surface" axis x1y2,\
     '< exec bash -c "paste <(cat ../zt/250_250_10/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_10/measurements_line.ascii)"' u 0:(-($15-$6)*1e6)  w lp ls 3 t "fb - zt, 250x250x10" axis x1y1,\
     '< exec bash -c "paste <(cat ../zt/250_250_20/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_20/measurements_line.ascii)"' u 0:(-($15-$6)*1e6)  w lp ls 4 t "fb - zt, 250x250x20" axis x1y1,\
     '< exec bash -c "paste <(cat ../zt/250_250_10/measurements_line.ascii) <(head -n 200 ./south/250_250_10_sb/measurements_line.ascii)"' u 0:(-($15-$6)*1e6)  w lp ls 5 t "sb - zt, 250x250x10" axis x1y1,\
     '< exec bash -c "paste <(cat ../zt/250_250_20/measurements_line.ascii) <(head -n 200 ./south/250_250_20_sb/measurements_line.ascii)"' u 0:(-($15-$6)*1e6)  w lp ls 6 t "sb - zt, 250x250x20" axis x1y1


unset multiplot

###################################

set output 'topo_zt_fb_steep.eps'
set multiplot layout 2,2
set format y "%0.1f"
set size 0.5,0.5
set yrange [-2.5:2.5]
set ytics -3,1
set mytics 2
set ylabel font "times,14" 'B_x (North) [{/Symbol m}T]'
unset key
plot loc6 u 0:($3-1) w l ls 2 t "surface" axis x1y2,\
     '< exec bash -c "paste <(cat ../zt/250_250_10/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_10/measurements_line.ascii)"' u 0:(($14-$5)*1e6) w lp ls 3 t "fb - zt, 250x250x10" axis x1y1,\
     loc15 u 0:($5*1e6) w lp ls 4 t "fb - zt, 250x250x20" axis x1y1,\
     loc16 u 0:($5*1e6) w lp ls 5 t "fb af 36 - zt, 250x250x20" axis x1y1,\
     loc17 u 0:($5*1e6) w lp ls 6 t "fb af 36 - zt, 250x250x10" axis x1y1

set autoscale y
set size 0.5,0.5
set format y "%0.0f"
set yrange [-3:4]
set ytics -3,1
set mytics 2
set ylabel font "times,14" 'B_y (East) [{/Symbol m}T]'
set key default font "times,14" box lc 'grey60' opaque fc 'grey90' height 0.5 at screen 0.75,screen 0.25 center center
plot loc6 u 0:($3-1) w l ls 2 t "surface" axis x1y2,\
     '< exec bash -c "paste <(cat ../zt/250_250_10/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_10/measurements_line.ascii)"' u 0:(($13-$4)*1e6) w lp ls 3 t "fb - zt, 250x250x10" axis x1y1,\
     loc15 u 0:($4*1e6) w lp ls 4 t "fb - zt, 250x250x20" axis x1y1,\
     loc16 u 0:($4*1e6) w lp ls 5 t "fb af 36 - zt, 250x250x20" axis x1y1,\
     loc17 u 0:($4*1e6) w lp ls 6 t "fb af 36 - zt, 250x250x10" axis x1y1

set size 0.5,0.5
set yrange [-4:3]
set ytics -4,1
set mytics 2
set ylabel font "times,14" 'B_z (Down) [{/Symbol m}T]'
unset key
plot loc6 u 0:($3-1) w l ls 2 t "surface" axis x1y2,\
     '< exec bash -c "paste <(cat ../zt/250_250_10/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_10/measurements_line.ascii)"' u 0:(-($15-$6)*1e6) w lp ls 3 t "fb - zt, 250x250x10" axis x1y1,\
     loc15 u 0:(-$6*1e6) w lp ls 4 t "fb - zt, 250x250x20" axis x1y1,\
     loc16 u 0:(-$6*1e6) w lp ls 5 t "fb af 36 - zt, 250x250x20" axis x1y1,\
     loc17 u 0:(-$6*1e6) w lp ls 6 t "fb af 36 - zt, 250x250x10" axis x1y1

