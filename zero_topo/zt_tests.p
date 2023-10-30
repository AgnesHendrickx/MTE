loc1 = './50_50_20/measurements_line.ascii'
loc10 = './50_50_120_c/measurements_line.ascii'
loc2 = './50_50_120/measurements_line.ascii'
loc3 = './100_100_20/measurements_line.ascii'
loc4 = './100_100_120/measurements_line.ascii'
loc5 = './100_100_240/measurements_line.ascii'
loc6 = './250_250_20/measurements_line.ascii'
loc16 = './250_250_20_c/measurements_line.ascii'
loc7 = './250_250_600/measurements_line.ascii'
loc8 = './500_500_20/measurements_line.ascii'
loc9 = './500_500_1200/measurements_line.ascii'
loc11 = './750_750_20/measurements_line.ascii'
loc12 = './1000_1000_20/measurements_line.ascii'


loc13 = './500_500_1200_c/measurements_line.ascii'
loc14 = './750_750_1800/measurements_line.ascii'
loc15 = './500_500_40/measurements_line.ascii'
loc17 = './250_250_600_cd/measurements_line.ascii'
loc18 = './250_250_40/measurements_line.ascii'
loc19 = './250_250_1200/measurements_line.ascii'

set terminal pngcairo size 2200,900

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
set style line 2 pt 13 lw 2 lc 'purple'
set style line 20 pt 14 ps 1.5 lw 3 lc 'red'
set style line 3 pt 12 lw 2 lc 'orchid4'
set style line 4 pt 5 lw 2 lc 'light-green'
set style line 5 pt 44 lw 2 lc 'web-green' 
set style line 6 pt 4 lw 2 lc 'dark-green'
set style line 7 pt 7 ps 2 lw 2 lc 'web-green'
set style line 17 pt 6 ps 2 lw 1 lc 'royalblue'
set style line 170 pt 5 ps 1.5 lw 2 lc 'magenta'
set style line 8 pt 9 ps 2 lw 2 lc 'gold'
set style line 80 pt 8 ps 2 lw 1 lc 'red'
set style line 800 pt 11 ps 2 lw 2 lc 'sienna4'
set style line 9 pt 9 ps 2 lw 2 lc 'skyblue'
set style line 90 pt 10 ps 3 lw 2 lc 'web-blue'
set style line 10 pt 8 lw 2 lc 'royalblue'
set style line 100 pt 12 lw 2 lc 'navy'
set style line 11 pt 11 ps 2 lw 2 lc 'coral'
set style line 110 pt 13 ps 2 lw 2 lc 'sienna4'
set style line 13 pt 3 ps 1 lw 2 lc 'magenta'

#(sqrt(($4)**2+($5)**2+($6)**2)*1e6)

#lc rgb 0x000000
#lc rgb 0xe69f00 #orange
#lc rgb 0x56b4e9 #skyblue
#lc rgb 0x009e73 #bluish green
#lc rgb 0xf0e442 #yellow
#lc rgb 0x0072b2 #blue
#lc rgb 0xd55e00 #dark orange (vermillon)
#lc rgb 0xcc79a7 # reddish purple

set output 'box_mag_all.png'
set key top right
set ylabel font "courier,14" '|B_{a}| ({/Symbol m}T)'

plot loc1 u 0:(sqrt(($4)**2+($5)**2+($6)**2)*1e6) w lp ls 2 t "50x50x20" axis x1y1,\
     loc2 u 0:(sqrt(($4)**2+($5)**2+($6)**2)*1e6) w lp ls 3 t "50x50x120" axis x1y1,\
     loc10 u 0:(sqrt(($4)**2+($5)**2+($6)**2)*1e6) w lp ls 20 t "50x50x120_c" axis x1y1,\
     loc3 u 0:(sqrt(($4)**2+($5)**2+($6)**2)*1e6) w lp ls 4 t "100x100x20" axis x1y1,\
     loc4 u 0:(sqrt(($4)**2+($5)**2+($6)**2)*1e6) w lp ls 5 t "100x100x120" axis x1y1,\
     loc5 u 0:(sqrt(($4)**2+($5)**2+($6)**2)*1e6) w lp ls 6 t "100x100x240" axis x1y1,\
     loc6 u 0:(sqrt(($4)**2+($5)**2+($6)**2)*1e6) w lp ls 7 t "250x250x20" axis x1y1,\
     loc16 u 0:(sqrt(($4)**2+($5)**2+($6)**2)*1e6) w lp ls 17 t "250x250x20_c" axis x1y1,\
     loc7 u 0:(sqrt(($4)**2+($5)**2+($6)**2)*1e6) w lp ls 8 t "250x250x600" axis x1y1,\
     loc17 u 0:(sqrt(($4)**2+($5)**2+($6)**2)*1e6) w lp ls 80 t "250x250x600_cd" axis x1y1,\
     loc8 u 0:(sqrt(($4)**2+($5)**2+($6)**2)*1e6) w lp ls 9 t "500x500x20" axis x1y1,\
     loc15 u 0:(sqrt(($4)**2+($5)**2+($6)**2)*1e6) w lp ls 90 t "500x500x40" axis x1y1,\
     loc9 u 0:(sqrt(($4)**2+($5)**2+($6)**2)*1e6) w lp ls 10 t "500x500x1200" axis x1y1,\
     loc13 u 0:(sqrt(($4)**2+($5)**2+($6)**2)*1e6) w lp ls 100 t "500x500x1200_c" axis x1y1,\
     loc11 u 0:(sqrt(($4)**2+($5)**2+($6)**2)*1e6) w lp ls 11 t "750x750x20" axis x1y1,\
     loc14 u 0:(sqrt(($4)**2+($5)**2+($6)**2)*1e6) w lp ls 110 t "750x750x1800" axis x1y1,\
     loc12 u 0:(sqrt(($4)**2+($5)**2+($6)**2)*1e6) w lp ls 13 t "1000x1000x20" axis x1y1

####################################
set output 'box_all.png'
set multiplot layout 1,3
#unset title

set ylabel font "courier,14" 'Bx_a (North) ({/Symbol m}T)'
set grid back ytics ls 12
unset key
#set key center bottom
#set key opaque
#set yrange[-1.6:0]
plot loc1 u 0:($5*1e6) w lp ls 2 t "50x50x20" axis x1y1,\
     loc2 u 0:($5*1e6) w lp ls 3 t "50x50x120" axis x1y1,\
     loc10 u 0:($5*1e6) w lp ls 20 t "50x50x120_c" axis x1y1,\
     loc3 u 0:($5*1e6) w lp ls 4 t "100x100x20" axis x1y1,\
     loc4 u 0:($5*1e6) w lp ls 5 t "100x100x120" axis x1y1,\
     loc5 u 0:($5*1e6) w lp ls 6 t "100x100x240" axis x1y1,\
     loc6 u 0:($5*1e6) w lp ls 7 t "250x250x20" axis x1y1,\
     loc16 u 0:($5*1e6) w lp ls 17 t "250x250x20_c" axis x1y1,\
     loc7 u 0:($5*1e6) w lp ls 8 t "250x250x600" axis x1y1,\
     loc17 u 0:($5*1e6) w lp ls 80 t "250x250x600_(cd)" axis x1y1,\
     loc8 u 0:($5*1e6) w lp ls 9 t "500x500x20" axis x1y1,\
     loc15 u 0:($5*1e6) w lp ls 90 t "500x500x40" axis x1y1,\
     loc9 u 0:($5*1e6) w lp ls 10 t "500x500x1200" axis x1y1,\
     loc13 u 0:($5*1e6) w lp ls 100 t "500x500x1200_c" axis x1y1,\
     loc11 u 0:($5*1e6) w lp ls 11 t "750x750x20" axis x1y1,\
     loc14 u 0:($5*1e6) w lp ls 110 t "750x750x1800" axis x1y1,\
     loc12 u 0:($5*1e6) w lp ls 13 t "1000x1000x20" axis x1y1

set autoscale y
set key right top horizontal
set ylabel font "courier,14" 'By_a (East) ({/Symbol m}T)'
plot loc1 u 0:($4*1e6) w lp ls 2 t "50x50x20" axis x1y1,\
     loc2 u 0:($4*1e6) w lp ls 3 t "50x50x120" axis x1y1,\
     loc10 u 0:($4*1e6) w lp ls 20 t "50x50x120_c" axis x1y1,\
     loc3 u 0:($4*1e6) w lp ls 4 t "100x100x20" axis x1y1,\
     loc4 u 0:($4*1e6) w lp ls 5 t "100x100x120" axis x1y1,\
     loc5 u 0:($4*1e6) w lp ls 6 t "100x100x240" axis x1y1,\
     loc6 u 0:($4*1e6) w lp ls 7 t "250x250x20" axis x1y1,\
     loc16 u 0:($4*1e6) w lp ls 17 t "250x250x20_c" axis x1y1,\
     loc7 u 0:($4*1e6) w lp ls 8 t "250x250x600" axis x1y1,\
     loc17 u 0:($4*1e6) w lp ls 80 t "250x250x600_(cd)" axis x1y1,\
     loc8 u 0:($4*1e6) w lp ls 9 t "500x500x20" axis x1y1,\
     loc15 u 0:($4*1e6) w lp ls 90 t "500x500x40" axis x1y1,\
     loc9 u 0:($4*1e6) w lp ls 10 t "500x500x1200" axis x1y1,\
     loc13 u 0:($4*1e6) w lp ls 100 t "500x500x1200_c" axis x1y1,\
     loc11 u 0:($4*1e6) w lp ls 11 t "750x750x20" axis x1y1,\
     loc14 u 0:($4*1e6) w lp ls 110 t "750x750x1800" axis x1y1,\
     loc12 u 0:($4*1e6) w lp ls 13 t "1000x1000x20" axis x1y1

#set yrange[0:5]
unset key
#set key center top
set ylabel font "courier,14" 'Bz_a (Down) ({/Symbol m}T)'
plot loc1 u 0:(-$6*1e6) w lp ls 2 t "50x50x20" axis x1y1,\
     loc2 u 0:(-$6*1e6) w lp ls 3 t "50x50x120" axis x1y1,\
     loc10 u 0:(-$6*1e6) w lp ls 20 t "50x50x120_c" axis x1y1,\
     loc3 u 0:(-$6*1e6) w lp ls 4 t "100x100x20" axis x1y1,\
     loc4 u 0:(-$6*1e6) w lp ls 5 t "100x100x120" axis x1y1,\
     loc5 u 0:(-$6*1e6) w lp ls 6 t "100x100x240" axis x1y1,\
     loc6 u 0:(-$6*1e6) w lp ls 7 t "250x250x20" axis x1y1,\
     loc16 u 0:(-$6*1e6) w lp ls 17 t "250x250x20_c" axis x1y1,\
     loc7 u 0:(-$6*1e6) w lp ls 8 t "250x250x600" axis x1y1,\
     loc17 u 0:(-$6*1e6) w lp ls 80 t "250x250x600_(cd)" axis x1y1,\
     loc8 u 0:(-$6*1e6) w lp ls 9 t "500x500x20" axis x1y1,\
     loc15 u 0:(-$6*1e6) w lp ls 90 t "500x500x40" axis x1y1,\
     loc9 u 0:(-$6*1e6) w lp ls 10 t "500x500x1200" axis x1y1,\
     loc13 u 0:(-$6*1e6) w lp ls 100 t "500x500x1200_c" axis x1y1,\
     loc11 u 0:(-$6*1e6) w lp ls 11 t "750x750x20" axis x1y1,\
     loc14 u 0:(-$6*1e6) w lp ls 110 t "750x750x1800" axis x1y1,\
     loc12 u 0:(-$6*1e6) w lp ls 13 t "1000x1000x20" axis x1y1

unset multiplot
###################################
set output 'box_c.png'
set multiplot layout 1,3
#unset title

set ylabel font "courier,14" 'Bx_a (North) ({/Symbol m}T)'
set grid back ytics ls 12
unset key
#set key center bottom
#set key opaque
#set yrange[-1.6:0]
plot loc6 u 0:($5*1e6) w lp ls 7 t "250x250x20" axis x1y1,\
     loc16 u 0:($5*1e6) w lp ls 17 t "250x250x20 centered" axis x1y1,\
     loc7 u 0:($5*1e6) w lp ls 8 t "250x250x600" axis x1y1,\
     loc17 u 0:($5*1e6) w lp ls 80 t "250x250x600 centered, Lz^+" axis x1y1

set autoscale y
set key right top vertical
set ylabel font "courier,14" 'By_a (East) ({/Symbol m}T)'
plot loc6 u 0:($4*1e6) w lp ls 7 t "250x250x20" axis x1y1,\
     loc16 u 0:($4*1e6) w lp ls 17 t "250x250x20 centered" axis x1y1,\
     loc7 u 0:($4*1e6) w lp ls 8 t "250x250x600" axis x1y1,\
     loc17 u 0:($4*1e6) w lp ls 80 t "250x250x600 centered, Lz^+" axis x1y1

#set yrange[0:5]
unset key
#set key center top
set ylabel font "courier,14" 'Bz_a (Down) ({/Symbol m}T)'
plot loc6 u 0:(-$6*1e6) w lp ls 7 t "250x250x20" axis x1y1,\
     loc16 u 0:(-$6*1e6) w lp ls 17 t "250x250x20 centered" axis x1y1,\
     loc7 u 0:(-$6*1e6) w lp ls 8 t "250x250x600" axis x1y1,\
     loc17 u 0:(-$6*1e6) w lp ls 80 t "250x250x600 centered, Lz^+)" axis x1y1

unset multiplot
###################################

###################################
set output 'box_c_more.png'
set multiplot layout 1,3
#unset title

set ylabel font "courier,14" 'Bx_a (North) ({/Symbol m}T)'
set grid back ytics ls 12
unset key
#set key center bottom
#set key opaque
#set yrange[-1.6:0]
plot loc6 u 0:($5*1e6) w lp ls 7 t "250x250x20" axis x1y1,\
     loc16 u 0:($5*1e6) w lp ls 17 t "250x250x20 centered" axis x1y1,\
     loc18 u 0:($5*1e6) w lp ls 170 t "250x250x40" axis x1y1,\
     loc7 u 0:($5*1e6) w lp ls 8 t "250x250x600" axis x1y1,\
     loc17 u 0:($5*1e6) w lp ls 80 t "250x250x600 centered, Lz^+" axis x1y1,\
     loc19 u 0:($5*1e6) w lp ls 800 t "250x250x1200" axis x1y1

set autoscale y
set key right top vertical
set ylabel font "courier,14" 'By_a (East) ({/Symbol m}T)'
plot loc6 u 0:($4*1e6) w lp ls 7 t "250x250x20" axis x1y1,\
     loc16 u 0:($4*1e6) w lp ls 17 t "250x250x20 centered" axis x1y1,\
     loc18 u 0:($4*1e6) w lp ls 170 t "250x250x40" axis x1y1,\
     loc7 u 0:($4*1e6) w lp ls 8 t "250x250x600" axis x1y1,\
     loc17 u 0:($4*1e6) w lp ls 80 t "250x250x600 centered, Lz^+" axis x1y1,\
     loc19 u 0:($4*1e6) w lp ls 800 t "250x250x1200" axis x1y1

#set yrange[0:5]
unset key
#set key center top
set ylabel font "courier,14" 'Bz_a (Down) ({/Symbol m}T)'
plot loc6 u 0:(-$6*1e6) w lp ls 7 t "250x250x20" axis x1y1,\
     loc16 u 0:(-$6*1e6) w lp ls 17 t "250x250x20 centered" axis x1y1,\
     loc18 u 0:(-$6*1e6) w lp ls 170 t "250x250x40" axis x1y1,\
     loc7 u 0:(-$6*1e6) w lp ls 8 t "250x250x600" axis x1y1,\
     loc17 u 0:(-$6*1e6) w lp ls 80 t "250x250x600 centered, Lz^+)" axis x1y1,\
     loc19 u 0:(-$6*1e6) w lp ls 800 t "250x250x1200" axis x1y1

unset multiplot
###################################


set output 'box_comp_scaled_all.png'
set multiplot layout 1,3
#unset title
set yrange[-4:5]
set ylabel font "courier,14" 'Bx_a (North) ({/Symbol m}T)'
set grid back ytics ls 12
unset key
#set key center bottom
#set key opaque
#set yrange[-1.6:0]
plot loc1 u 0:($5*1e6) w lp ls 2 t "50x50x20" axis x1y1,\
     loc2 u 0:($5*1e6) w lp ls 3 t "50x50x120" axis x1y1,\
     loc10 u 0:($5*1e6) w lp ls 20 t "50x50x120_c" axis x1y1,\
     loc3 u 0:($5*1e6) w lp ls 4 t "100x100x20" axis x1y1,\
     loc4 u 0:($5*1e6) w lp ls 5 t "100x100x120" axis x1y1,\
     loc5 u 0:($5*1e6) w lp ls 6 t "100x100x240" axis x1y1,\
     loc6 u 0:($5*1e6) w lp ls 7 t "250x250x20" axis x1y1,\
     loc16 u 0:($5*1e6) w lp ls 17 t "250x250x20_c" axis x1y1,\
     loc7 u 0:($5*1e6) w lp ls 8 t "250x250x600" axis x1y1,\
     loc17 u 0:($5*1e6) w lp ls 80 t "250x250x600_(cd)" axis x1y1,\
     loc8 u 0:($5*1e6) w lp ls 9 t "500x500x20" axis x1y1,\
     loc15 u 0:($5*1e6) w lp ls 90 t "500x500x40" axis x1y1,\
     loc9 u 0:($5*1e6) w lp ls 10 t "500x500x1200" axis x1y1,\
     loc13 u 0:($5*1e6) w lp ls 100 t "500x500x1200_c" axis x1y1,\
     loc11 u 0:($5*1e6) w lp ls 11 t "750x750x20" axis x1y1,\
     loc14 u 0:($5*1e6) w lp ls 110 t "750x750x1800" axis x1y1,\
     loc12 u 0:($5*1e6) w lp ls 13 t "1000x1000x20" axis x1y1

set autoscale y
set key right top horizontal
set ylabel font "courier,14" 'By_a (East) ({/Symbol m}T)'
plot loc1 u 0:($4*1e6) w lp ls 2 t "50x50x20" axis x1y1,\
     loc2 u 0:($4*1e6) w lp ls 3 t "50x50x120" axis x1y1,\
     loc10 u 0:($4*1e6) w lp ls 20 t "50x50x120_c" axis x1y1,\
     loc3 u 0:($4*1e6) w lp ls 4 t "100x100x20" axis x1y1,\
     loc4 u 0:($4*1e6) w lp ls 5 t "100x100x120" axis x1y1,\
     loc5 u 0:($4*1e6) w lp ls 6 t "100x100x240" axis x1y1,\
     loc6 u 0:($4*1e6) w lp ls 7 t "250x250x20" axis x1y1,\
     loc16 u 0:($4*1e6) w lp ls 17 t "250x250x20_c" axis x1y1,\
     loc7 u 0:($4*1e6) w lp ls 8 t "250x250x600" axis x1y1,\
     loc17 u 0:($4*1e6) w lp ls 80 t "250x250x600_(cd)" axis x1y1,\
     loc8 u 0:($4*1e6) w lp ls 9 t "500x500x20" axis x1y1,\
     loc15 u 0:($4*1e6) w lp ls 90 t "500x500x40" axis x1y1,\
     loc9 u 0:($4*1e6) w lp ls 10 t "500x500x1200" axis x1y1,\
     loc13 u 0:($4*1e6) w lp ls 100 t "500x500x1200_c" axis x1y1,\
     loc11 u 0:($4*1e6) w lp ls 11 t "750x750x20" axis x1y1,\
     loc14 u 0:($4*1e6) w lp ls 110 t "750x750x1800" axis x1y1,\
     loc12 u 0:($4*1e6) w lp ls 13 t "1000x1000x20" axis x1y1

#set yrange[0:5]
unset key
#set key center top
set ylabel font "courier,14" 'Bz_a (Down) ({/Symbol m}T)'
plot loc1 u 0:(-$6*1e6) w lp ls 2 t "50x50x20" axis x1y1,\
     loc2 u 0:(-$6*1e6) w lp ls 3 t "50x50x120" axis x1y1,\
     loc10 u 0:(-$6*1e6) w lp ls 20 t "50x50x120_c" axis x1y1,\
     loc3 u 0:(-$6*1e6) w lp ls 4 t "100x100x20" axis x1y1,\
     loc4 u 0:(-$6*1e6) w lp ls 5 t "100x100x120" axis x1y1,\
     loc5 u 0:(-$6*1e6) w lp ls 6 t "100x100x240" axis x1y1,\
     loc6 u 0:(-$6*1e6) w lp ls 7 t "250x250x20" axis x1y1,\
     loc16 u 0:(-$6*1e6) w lp ls 17 t "250x250x20_c" axis x1y1,\
     loc7 u 0:(-$6*1e6) w lp ls 8 t "250x250x600" axis x1y1,\
     loc17 u 0:(-$6*1e6) w lp ls 80 t "250x250x600_(cd)" axis x1y1,\
     loc8 u 0:(-$6*1e6) w lp ls 9 t "500x500x20" axis x1y1,\
     loc15 u 0:(-$6*1e6) w lp ls 90 t "500x500x40" axis x1y1,\
     loc9 u 0:(-$6*1e6) w lp ls 10 t "500x500x1200" axis x1y1,\
     loc13 u 0:(-$6*1e6) w lp ls 100 t "500x500x1200_c" axis x1y1,\
     loc11 u 0:(-$6*1e6) w lp ls 11 t "750x750x20" axis x1y1,\
     loc14 u 0:(-$6*1e6) w lp ls 110 t "750x750x1800" axis x1y1,\
     loc12 u 0:(-$6*1e6) w lp ls 13 t "1000x1000x20" axis x1y1

unset multiplot
