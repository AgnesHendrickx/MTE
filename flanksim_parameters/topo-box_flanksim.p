
loc1 = '../box/250_250_5/measurements_line.ascii'
loc2 = './south/extest/250_250_5/measurements_line.ascii'

loc3 = '../box/250_250_10/measurements_line.ascii'
loc4 = './south/extest/250_250_10/measurements_line.ascii'

loc5 = '../box/250_250_20/measurements_line.ascii'
loc6 = './south/extest/250_250_20/measurements_line.ascii'

loc7 = '../box/250_250_40/measurements_line.ascii'
loc8 = './south/extest/250_250_40/measurements_line.ascii'

loc9 = '../box/500_500_20/measurements_line.ascii'
loc10 = './south/extest/500_500_20/measurements_line.ascii'

loc11 = '../box/1000_1000_20/measurements_line.ascii'
loc12 = './south/extest/1000_1000_20/measurements_line.ascii'


loc22 = '../box/250_250_1/measurements_line.ascii'
loc15 = '../box/500_500_40/measurements_line.ascii'



set terminal pngcairo size 1800,900

set key default
set key box
set key opaque
set key horizontal
set key font "courier,14"
set xlabel font "courier,14" 'index'
set y2label font "courier,14" 'height surface (m)' 
set autoscale xy
set ytics nomirror
set style line 12 lc rgb '#aaaaaa' dt 2 lw 0.5
set grid back ytics ls 12
set tics out font "courier,14"
set xrange[0:46]
set y2range[-6:6]
set y2tics -6,1


set style line 1 lw 2 lc "grey40"
set style line 2 pt 13 ps 1.5 lw 2 lc 'purple'
set style line 20 pt 14 ps 1.5 lw 3 lc 'red'
set style line 3 pt 12 ps 1.5 lw 2 lc 'orchid4'

set style line 4 pt 7 ps 1 lw 2 lc 'light-green'
set style line 5 pt 6 ps 2 lw 2 lc 'web-green' 
set style line 6 pt 6 ps 1 lw 2 lc 'dark-green'

set style line 1070 pt 13 ps 2 lw 2 lc 'slategray'
set style line 107 pt 12 ps 2 lw 2 lc 'steelblue'
set style line 7 pt 11 ps 1.5 lw 2 lc 'skyblue'
set style line 170 pt 10 ps 1.5 lw 2 lc 'web-blue'

set style line 17 pt 6 ps 1.5 lw 2 lc 'orange'
set style line 1700 pt 7 ps 1.5 lw 2 lc 'red'

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

#(sqrt(($4)**2+($5)**2+($6)**2)*1e6)

#lc rgb 0x000000
#lc rgb 0xe69f00 #orange
#lc rgb 0x56b4e9 #skyblue
#lc rgb 0x009e73 #bluish green
#lc rgb 0xf0e442 #yellow
#lc rgb 0x0072b2 #blue
#lc rgb 0xd55e00 #dark orange (vermillon)
#lc rgb 0xcc79a7 # reddish purple

#plot loc1 u 0:($5*1e6) w lp ls 1070 t "250x250x5 box" axis x1y1,\
#     loc2 u 0:($5*1e6) w lp ls 170 t "250x250x5 topo" axis x1y1,\
###################################

set output 'topo_box.png'
set multiplot layout 1,3
#unset title

set ylabel font "courier,14" 'Bx_a (North) ({/Symbol m}T)'
set grid back ytics ls 12
set size 0.35,1
unset key
#set key center bottom
#set key opaque
#set yrange[-1.6:0]
plot '< exec bash -c "paste <(cat ../box/250_250_5/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_5/measurements_line.ascii)"' u 0:(($14-$5)*1e6) w lp ls 1070 t "250x250x5" axis x1y1,\
     '< exec bash -c "paste <(cat ../box/250_250_10/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_10/measurements_line.ascii)"' u 0:(($14-$5)*1e6) w lp ls 107 t "250x250x10" axis x1y1,\
     '< exec bash -c "paste <(cat ../box/250_250_20/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_20/measurements_line.ascii)"' u 0:(($14-$5)*1e6) w lp ls 7 t "250x250x20" axis x1y1,\
     '< exec bash -c "paste <(cat ./south/box/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_20/measurements_line.ascii)"' u 0:(($14-$5)*1e6) w lp ls 17 t "250x250x20" axis x1y1,\
     '< exec bash -c "paste <(cat ./south/box_sb/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_20/measurements_line.ascii)"' u 0:(($14-$5)*1e6) w lp ls 1700 t "250x250x20" axis x1y1,\
     '< exec bash -c "paste <(cat ../box/250_250_40/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_40/measurements_line.ascii)"' u 0:(($14-$5)*1e6) w lp ls 170 t "250x250x40" axis x1y1,\
     '< exec bash -c "paste <(cat ../box/500_500_20/measurements_line.ascii) <(head -n 200 ./south/extest/500_500_20/measurements_line.ascii)"' u 0:(($14-$5)*1e6) w lp ls 4 t "500x500x20" axis x1y1,\
     '< exec bash -c "paste <(cat ../box/1000_1000_20/measurements_line.ascii) <(head -n 200 ./south/extest/1000_1000_20/measurements_line.ascii)"' u 0:(($14-$5)*1e6) w lp ls 13 t "1000x1000x20" axis x1y1

set autoscale y
set key right top vertical
set size 0.35,1
set ylabel font "courier,14" 'By_a (East) ({/Symbol m}T)'
plot '< exec bash -c "paste <(cat ../box/250_250_5/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_5/measurements_line.ascii)"' u 0:(($13-$4)*1e6) w lp ls 1070 t "250x250x5" axis x1y1,\
     '< exec bash -c "paste <(cat ../box/250_250_10/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_10/measurements_line.ascii)"' u 0:(($13-$4)*1e6) w lp ls 107 t "250x250x10" axis x1y1,\
     '< exec bash -c "paste <(cat ../box/250_250_20/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_20/measurements_line.ascii)"' u 0:(($13-$4)*1e6) w lp ls 7 t "250x250x20" axis x1y1,\
     '< exec bash -c "paste <(cat ./south/box/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_20/measurements_line.ascii)"' u 0:(($13-$4)*1e6) w lp ls 17 t "250x250x20" axis x1y1,\
     '< exec bash -c "paste <(cat ./south/box_sb/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_20/measurements_line.ascii)"' u 0:(($13-$4)*1e6) w lp ls 1700 t "250x250x20" axis x1y1,\
     '< exec bash -c "paste <(cat ../box/250_250_40/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_40/measurements_line.ascii)"' u 0:(($13-$4)*1e6) w lp ls 170 t "250x250x40" axis x1y1,\
     '< exec bash -c "paste <(cat ../box/500_500_20/measurements_line.ascii) <(head -n 200 ./south/extest/500_500_20/measurements_line.ascii)"' u 0:(($13-$4)*1e6) w lp ls 4 t "500x500x20" axis x1y1,\
     '< exec bash -c "paste <(cat ../box/1000_1000_20/measurements_line.ascii) <(head -n 200 ./south/extest/1000_1000_20/measurements_line.ascii)"' u 0:(($13-$4)*1e6) w lp ls 13 t "1000x1000x20" axis x1y1

#set yrange[0:5]
unset key
#set key center top
set size 0.35,1
set ylabel font "courier,14" 'Bz_a (Down) ({/Symbol m}T)'
plot '< exec bash -c "paste <(cat ../box/250_250_5/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_5/measurements_line.ascii)"' u 0:(-($15-$6)*1e6) w lp ls 1070 t "250x250x5" axis x1y1,\
     '< exec bash -c "paste <(cat ../box/250_250_10/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_10/measurements_line.ascii)"' u 0:(-($15-$6)*1e6) w lp ls 107 t "250x250x10" axis x1y1,\
     '< exec bash -c "paste <(cat ../box/250_250_20/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_20/measurements_line.ascii)"' u 0:(-($15-$6)*1e6) w lp ls 7 t "250x250x20" axis x1y1,\
     '< exec bash -c "paste <(cat ./south/box/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_20/measurements_line.ascii)"' u 0:(-($15-$6)*1e6) w lp ls 17 t "250x250x20" axis x1y1,\
     '< exec bash -c "paste <(cat ./south/box_sb/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_20/measurements_line.ascii)"' u 0:(-($15-$6)*1e6) w lp ls 1700 t "250x250x20" axis x1y1,\
     '< exec bash -c "paste <(cat ../box/250_250_40/measurements_line.ascii) <(head -n 200 ./south/extest/250_250_40/measurements_line.ascii)"' u 0:(-($15-$6)*1e6) w lp ls 170 t "250x250x40" axis x1y1,\
     '< exec bash -c "paste <(cat ../box/500_500_20/measurements_line.ascii) <(head -n 200 ./south/extest/500_500_20/measurements_line.ascii)"' u 0:(-($15-$6)*1e6) w lp ls 4 t "500x500x20" axis x1y1,\
     '< exec bash -c "paste <(cat ../box/1000_1000_20/measurements_line.ascii) <(head -n 200 ./south/extest/1000_1000_20/measurements_line.ascii)"' u 0:(-($15-$6)*1e6) w lp ls 13 t "1000x1000x20" axis x1y1

unset multiplot

