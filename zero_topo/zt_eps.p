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
loc20 = './250_250_10/measurements_line.ascii'
loc21 = './250_250_5/measurements_line.ascii'
loc22 = './250_250_1/measurements_line.ascii'

set terminal pngcairo size 1800,900

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
set style line 8 pt 9 ps 1.5 lw 2 lc 'royalblue'
set style line 80 pt 7 lw 1 lc 'red'
set style line 800 pt 8 ps 1.5 lw 2 lc 'navy'
set style line 9 pt 15 ps 2 lw 2 lc 'salmon'
set style line 90 pt 14 ps 1 lw 2 lc 'orange'
set style line 10 pt 14 ps 2 lw 2 lc 'red'
set style line 11 pt 13 ps 1.5 lw 2 lc 'olive'
set style line 110 pt 12 ps 1.5 lw 2 lc 'sienna4'
set style line 13 pt 5 ps 1 lw 2 lc 'gold'
set style line 12 lc 'grey80' dt 2 lw 0.5

set key default font "times,14" box lc 'grey60' opaque fc 'grey90' top right

set xtics out font "times,14"
set ytics out font "times,14"

set grid back ytics ls 12

set autoscale xy
set xlabel font "times,14" 'index observation point'
set ylabel font "times,14" 'intensity [{/Symbol m}T]'

set format y "%.0f"
set xrange[0:46]


###################################
set output 'zt_low.png'
set multiplot layout 1,3
#unset title
set size 0.33,1
set ylabel font "times,14" 'B_x (North) [{/Symbol m}T]'
set grid back ytics ls 12
unset key
#set key center bottom
#set key opaque
#set yrange[-1.6:0]
plot loc1 u 0:($5*1e6) w lp ls 2 t "50x50x20" axis x1y1,\
     loc2 u 0:($5*1e6) w lp ls 3 t "50x50x120" axis x1y1,\
     loc3 u 0:($5*1e6) w lp ls 4 t "100x100x20" axis x1y1,\
     loc4 u 0:($5*1e6) w lp ls 5 t "100x100x120" axis x1y1,\
     loc5 u 0:($5*1e6) w lp ls 6 t "100x100x240" axis x1y1,\
     loc21 u 0:($5*1e6) w lp ls 1070 t "250x250x5" axis x1y1,\
     loc20 u 0:($5*1e6) w lp ls 107 t "250x250x10" axis x1y1,\
     loc6 u 0:($5*1e6) w lp ls 7 t "250x250x20" axis x1y1,\
     loc18 u 0:($5*1e6) w lp ls 170 t "250x250x40" axis x1y1,\
     loc7 u 0:($5*1e6) w lp ls 8 t "250x250x600" axis x1y1,\
     loc19 u 0:($5*1e6) w lp ls 800 t "250x250x1200" axis x1y1

set autoscale y
set yrange[-4:4.5]
set size 0.33,1
set key right top vertical
set ylabel font "times,14" 'B_y (East) [{/Symbol m}T]'
plot loc1 u 0:($4*1e6) w lp ls 2 t "50x50x20" axis x1y1,\
     loc2 u 0:($4*1e6) w lp ls 3 t "50x50x120" axis x1y1,\
     loc3 u 0:($4*1e6) w lp ls 4 t "100x100x20" axis x1y1,\
     loc4 u 0:($4*1e6) w lp ls 5 t "100x100x120" axis x1y1,\
     loc5 u 0:($4*1e6) w lp ls 6 t "100x100x240" axis x1y1,\
     loc21 u 0:($4*1e6) w lp ls 1070 t "250x250x5" axis x1y1,\
     loc20 u 0:($4*1e6) w lp ls 107 t "250x250x10" axis x1y1,\
     loc6 u 0:($4*1e6) w lp ls 7 t "250x250x20" axis x1y1,\
     loc18 u 0:($4*1e6) w lp ls 170 t "250x250x40" axis x1y1,\
     loc7 u 0:($4*1e6) w lp ls 8 t "250x250x600" axis x1y1,\
     loc19 u 0:($4*1e6) w lp ls 800 t "250x250x1200" axis x1y1

#set yrange[0:5]
set autoscale y
set size 0.33,1
unset key
#set key center top
set ylabel font "times,14" 'B_z (Down) [{/Symbol m}T]'
plot loc1 u 0:(-$6*1e6) w lp ls 2 t "50x50x20" axis x1y1,\
     loc2 u 0:(-$6*1e6) w lp ls 3 t "50x50x120" axis x1y1,\
     loc3 u 0:(-$6*1e6) w lp ls 4 t "100x100x20" axis x1y1,\
     loc4 u 0:(-$6*1e6) w lp ls 5 t "100x100x120" axis x1y1,\
     loc5 u 0:(-$6*1e6) w lp ls 6 t "100x100x240" axis x1y1,\
     loc21 u 0:(-$6*1e6) w lp ls 1070 t "250x250x5" axis x1y1,\
     loc20 u 0:(-$6*1e6) w lp ls 107 t "250x250x10" axis x1y1,\
     loc6 u 0:(-$6*1e6) w lp ls 7 t "250x250x20" axis x1y1,\
     loc18 u 0:(-$6*1e6) w lp ls 170 t "250x250x40" axis x1y1,\
     loc7 u 0:(-$6*1e6) w lp ls 8 t "250x250x600" axis x1y1,\
     loc19 u 0:(-$6*1e6) w lp ls 800 t "250x250x1200" axis x1y1

unset multiplot

###################################

set output 'zt_high_sizedepth.png'
set multiplot layout 1,3
#unset title

set ylabel font "times,14" 'B_x (North) [{/Symbol m}T]'
set grid back ytics ls 12
set size 0.33,1
unset key
#set key center bottom
#set key opaque
#set yrange[-1.6:0]
plot loc22 u 0:($5*1e6) w lp ls 17 t "250x250x1" axis x1y1,\
     loc21 u 0:($5*1e6) w lp ls 1070 t "250x250x5" axis x1y1,\
     loc20 u 0:($5*1e6) w lp ls 107 t "250x250x10" axis x1y1,\
     loc6 u 0:($5*1e6) w lp ls 7 t "250x250x20" axis x1y1,\
     loc8 u 0:($5*1e6) w lp ls 4 t "500x500x20" axis x1y1,\
     loc15 u 0:($5*1e6) w lp ls 5 t "500x500x40" axis x1y1
set autoscale y
set key right top vertical
set size 0.33,1
set ylabel font "times,14" 'B_y (East) [{/Symbol m}T]'
plot loc22 u 0:($4*1e6) w lp ls 17 t "250x250x1" axis x1y1,\
     loc21 u 0:($4*1e6) w lp ls 1070 t "250x250x5" axis x1y1,\
     loc20 u 0:($4*1e6) w lp ls 107 t "250x250x10" axis x1y1,\
     loc6 u 0:($4*1e6) w lp ls 7 t "250x250x20" axis x1y1,\
     loc8 u 0:($4*1e6) w lp ls 4 t "500x500x20" axis x1y1,\
     loc15 u 0:($4*1e6) w lp ls 5 t "500x500x40" axis x1y1

#set yrange[0:5]
unset key
#set key center top
set size 0.33,1
set ylabel font "times,14" 'B_z (Down) [{/Symbol m}T]'
plot loc22 u 0:(-$6*1e6) w lp ls 17 t "250x250x1" axis x1y1,\
     loc21 u 0:(-$6*1e6) w lp ls 1070 t "250x250x5" axis x1y1,\
     loc20 u 0:(-$6*1e6) w lp ls 107 t "250x250x10" axis x1y1,\
     loc6 u 0:(-$6*1e6) w lp ls 7 t "250x250x20" axis x1y1,\
     loc8 u 0:(-$6*1e6) w lp ls 4 t "500x500x20" axis x1y1,\
     loc15 u 0:(-$6*1e6) w lp ls 5 t "500x500x40" axis x1y1
unset multiplot
###################
###################################
###################################

set output 'zt_high_sizedepth_factor.png'
set multiplot layout 1,3
#unset title

set ylabel font "times,14" 'B_x (North) [{/Symbol m}T]'
set grid back ytics ls 12
set size 0.33,1
unset key
#set key center bottom
#set key opaque
#set yrange[-1.6:0]
plot loc22 u 0:($5*1e6*20) w lp ls 17 t "250x250x1" axis x1y1,\
     loc21 u 0:($5*1e6*4) w lp ls 1070 t "250x250x5" axis x1y1,\
     loc20 u 0:($5*1e6*2) w lp ls 107 t "250x250x10" axis x1y1,\
     loc6 u 0:($5*1e6) w lp ls 7 t "250x250x20" axis x1y1,\
     loc8 u 0:($5*1e6*2) w lp ls 4 t "500x500x20" axis x1y1,\
     loc15 u 0:($5*1e6) w lp ls 5 t "500x500x40" axis x1y1
set autoscale y
set key right top vertical
set size 0.33,1
set ylabel font "times,14" 'B_y (East) [{/Symbol m}T]'
plot loc22 u 0:($4*1e6*20) w lp ls 17 t "250x250x1" axis x1y1,\
     loc21 u 0:($4*1e6*4) w lp ls 1070 t "250x250x5" axis x1y1,\
     loc20 u 0:($4*1e6*2) w lp ls 107 t "250x250x10" axis x1y1,\
     loc6 u 0:($4*1e6) w lp ls 7 t "250x250x20" axis x1y1,\
     loc8 u 0:($4*1e6*2) w lp ls 4 t "500x500x20" axis x1y1,\
     loc15 u 0:($4*1e6) w lp ls 5 t "500x500x40" axis x1y1

#set yrange[0:5]
unset key
#set key center top
set size 0.33,1
set ylabel font "times,14" 'B_z (Down) [{/Symbol m}T]'
plot loc22 u 0:(-$6*1e6*20) w lp ls 17 t "250x250x1" axis x1y1,\
     loc21 u 0:(-$6*1e6*4) w lp ls 1070 t "250x250x5" axis x1y1,\
     loc20 u 0:(-$6*1e6*2) w lp ls 107 t "250x250x10" axis x1y1,\
     loc6 u 0:(-$6*1e6) w lp ls 7 t "250x250x20" axis x1y1,\
     loc8 u 0:(-$6*1e6*2) w lp ls 4 t "500x500x20" axis x1y1,\
     loc15 u 0:(-$6*1e6) w lp ls 5 t "500x500x40" axis x1y1
unset multiplot
###################
###################################

set output 'zt_high_dif.png'
set multiplot layout 1,3
#unset title

set ylabel font "times,14" 'B_x (North) [{/Symbol m}T]'
set grid back ytics ls 12
set size 0.33,1
unset key
#set key center bottom
#set key opaque
#set yrange[-1.6:0]
plot loc21 u 0:($5*1e6) w lp ls 1070 t "250x250x5" axis x1y1,\
     loc20 u 0:($5*1e6) w lp ls 107 t "250x250x10" axis x1y1,\
     loc6 u 0:($5*1e6) w lp ls 7 t "250x250x20" axis x1y1,\
     loc18 u 0:($5*1e6) w lp ls 170 t "250x250x40" axis x1y1,\
     loc8 u 0:($5*1e6) w lp ls 4 t "500x500x20" axis x1y1,\
     loc15 u 0:($5*1e6) w lp ls 5 t "500x500x40" axis x1y1,\
     loc9 u 0:($5*1e6) w lp ls 6 t "500x500x1200" axis x1y1,\
     loc11 u 0:($5*1e6) w lp ls 11 t "750x750x20" axis x1y1,\
     loc14 u 0:($5*1e6) w lp ls 110 t "750x750x1800" axis x1y1,\
     loc12 u 0:($5*1e6) w lp ls 13 t "1000x1000x20" axis x1y1

set autoscale y
set key right top vertical
set size 0.33,1
set ylabel font "times,14" 'B_y (East) [{/Symbol m}T]'
plot loc21 u 0:($4*1e6) w lp ls 1070 t "250x250x5" axis x1y1,\
     loc20 u 0:($4*1e6) w lp ls 107 t "250x250x10" axis x1y1,\
     loc6 u 0:($4*1e6) w lp ls 7 t "250x250x20" axis x1y1,\
     loc18 u 0:($4*1e6) w lp ls 170 t "250x250x40" axis x1y1,\
     loc8 u 0:($4*1e6) w lp ls 4 t "500x500x20" axis x1y1,\
     loc15 u 0:($4*1e6) w lp ls 5 t "500x500x40" axis x1y1,\
     loc9 u 0:($4*1e6) w lp ls 6 t "500x500x1200" axis x1y1,\
     loc11 u 0:($4*1e6) w lp ls 11 t "750x750x20" axis x1y1,\
     loc14 u 0:($4*1e6) w lp ls 110 t "750x750x1800" axis x1y1,\
     loc12 u 0:($4*1e6) w lp ls 13 t "1000x1000x20" axis x1y1

#set yrange[0:5]
unset key
#set key center top
set size 0.33,1
set ylabel font "times,14" 'B_z (Down) [{/Symbol m}T]'
plot loc21 u 0:(-$6*1e6) w lp ls 1070 t "250x250x5" axis x1y1,\
     loc20 u 0:(-$6*1e6) w lp ls 107 t "250x250x10" axis x1y1,\
     loc6 u 0:(-$6*1e6) w lp ls 7 t "250x250x20" axis x1y1,\
     loc18 u 0:(-$6*1e6) w lp ls 170 t "250x250x40" axis x1y1,\
     loc8 u 0:(-$6*1e6) w lp ls 4 t "500x500x20" axis x1y1,\
     loc15 u 0:(-$6*1e6) w lp ls 5 t "500x500x40" axis x1y1,\
     loc9 u 0:(-$6*1e6) w lp ls 6 t "500x500x1200" axis x1y1,\
     loc11 u 0:(-$6*1e6) w lp ls 11 t "750x750x20" axis x1y1,\
     loc14 u 0:(-$6*1e6) w lp ls 110 t "750x750x1800" axis x1y1,\
     loc12 u 0:(-$6*1e6) w lp ls 13 t "1000x1000x20" axis x1y1

unset multiplot
#####################################
###################################

set output 'zt_high_less.png'
set multiplot layout 1,3
#unset title

set ylabel font "times,14" 'B_x (North) [{/Symbol m}T]'
set grid back ytics ls 12
set size 0.33,1
unset key
#set key center bottom
#set key opaque
#set yrange[-1.6:0]
plot loc20 u 0:($5*1e6) w lp ls 107 t "250x250x10" axis x1y1,\
     loc6 u 0:($5*1e6) w lp ls 7 t "250x250x20" axis x1y1,\
     loc18 u 0:($5*1e6) w lp ls 170 t "250x250x40" axis x1y1,\
     loc8 u 0:($5*1e6) w lp ls 4 t "500x500x20" axis x1y1,\
     loc15 u 0:($5*1e6) w lp ls 5 t "500x500x40" axis x1y1,\
     loc11 u 0:($5*1e6) w lp ls 11 t "750x750x20" axis x1y1,\
     loc12 u 0:($5*1e6) w lp ls 13 t "1000x1000x20" axis x1y1

set autoscale y
set key right top vertical
set size 0.33,1
set ylabel font "times,14" 'B_y (East) [{/Symbol m}T]'
plot loc20 u 0:($4*1e6) w lp ls 107 t "250x250x10" axis x1y1,\
     loc6 u 0:($4*1e6) w lp ls 7 t "250x250x20" axis x1y1,\
     loc18 u 0:($4*1e6) w lp ls 170 t "250x250x40" axis x1y1,\
     loc8 u 0:($4*1e6) w lp ls 4 t "500x500x20" axis x1y1,\
     loc15 u 0:($4*1e6) w lp ls 5 t "500x500x40" axis x1y1,\
     loc11 u 0:($4*1e6) w lp ls 11 t "750x750x20" axis x1y1,\
     loc12 u 0:($4*1e6) w lp ls 13 t "1000x1000x20" axis x1y1

#set yrange[0:5]
unset key
#set key center top
set size 0.33,1
set ylabel font "times,14" 'B_z (Down) [{/Symbol m}T]'
plot loc20 u 0:(-$6*1e6) w lp ls 107 t "250x250x10" axis x1y1,\
     loc6 u 0:(-$6*1e6) w lp ls 7 t "250x250x20" axis x1y1,\
     loc18 u 0:(-$6*1e6) w lp ls 170 t "250x250x40" axis x1y1,\
     loc8 u 0:(-$6*1e6) w lp ls 4 t "500x500x20" axis x1y1,\
     loc15 u 0:(-$6*1e6) w lp ls 5 t "500x500x40" axis x1y1,\
     loc11 u 0:(-$6*1e6) w lp ls 11 t "750x750x20" axis x1y1,\
     loc12 u 0:(-$6*1e6) w lp ls 13 t "1000x1000x20" axis x1y1

unset multiplot
set output 'zt_high_less_2.png'
set multiplot layout 1,3
#unset title

set ylabel font "times,14" 'B_x (North) [{/Symbol m}T]'
set grid back ytics ls 12
set size 0.33,1
unset key
#set key center bottom
#set key opaque
#set yrange[-1.6:0]
plot loc20 u 0:($5*1e6) w lp ls 107 t "250x250x10" axis x1y1,\
     loc6 u 0:($5*1e6) w lp ls 7 t "250x250x20" axis x1y1,\
     loc8 u 0:($5*1e6) w lp ls 4 t "500x500x20" axis x1y1,\
     loc15 u 0:($5*1e6) w lp ls 5 t "500x500x40" axis x1y1,\
     loc11 u 0:($5*1e6) w lp ls 11 t "750x750x20" axis x1y1,\
     loc12 u 0:($5*1e6) w lp ls 13 t "1000x1000x20" axis x1y1

set autoscale y
set key right top vertical
set size 0.33,1
set ylabel font "times,14" 'B_y (East) [{/Symbol m}T]'
plot loc20 u 0:($4*1e6) w lp ls 107 t "250x250x10" axis x1y1,\
     loc6 u 0:($4*1e6) w lp ls 7 t "250x250x20" axis x1y1,\
     loc8 u 0:($4*1e6) w lp ls 4 t "500x500x20" axis x1y1,\
     loc15 u 0:($4*1e6) w lp ls 5 t "500x500x40" axis x1y1,\
     loc11 u 0:($4*1e6) w lp ls 11 t "750x750x20" axis x1y1,\
     loc12 u 0:($4*1e6) w lp ls 13 t "1000x1000x20" axis x1y1

#set yrange[0:5]
unset key
#set key center top
set size 0.33,1
set ylabel font "times,14" 'B_z (Down) [{/Symbol m}T]'
plot loc20 u 0:(-$6*1e6) w lp ls 107 t "250x250x10" axis x1y1,\
     loc6 u 0:(-$6*1e6) w lp ls 7 t "250x250x20" axis x1y1,\
     loc8 u 0:(-$6*1e6) w lp ls 4 t "500x500x20" axis x1y1,\
     loc15 u 0:(-$6*1e6) w lp ls 5 t "500x500x40" axis x1y1,\
     loc11 u 0:(-$6*1e6) w lp ls 11 t "750x750x20" axis x1y1,\
     loc12 u 0:(-$6*1e6) w lp ls 13 t "1000x1000x20" axis x1y1

unset multiplot
###################################
set terminal pngcairo size 2200,900
set output 'zt_all.png'
set multiplot layout 1,3
set size 0.33,1
#unset title
set key font "times,14"
set ylabel font "times,14" 'B_x (North) [{/Symbol m}T]'
set grid back ytics ls 12
unset key
#set key center bottom
#set key opaque
#set yrange[-1.6:0]
plot loc1 u 0:($5*1e6) w lp ls 2 t "50x50x20" axis x1y1,\
     loc2 u 0:($5*1e6) w lp ls 3 t "50x50x120" axis x1y1,\
     loc3 u 0:($5*1e6) w lp ls 4 t "100x100x20" axis x1y1,\
     loc4 u 0:($5*1e6) w lp ls 5 t "100x100x120" axis x1y1,\
     loc5 u 0:($5*1e6) w lp ls 6 t "100x100x240" axis x1y1,\
     loc6 u 0:($5*1e6) w lp ls 7 t "250x250x20" axis x1y1,\
     loc18 u 0:($5*1e6) w lp ls 170 t "250x250x40" axis x1y1,\
     loc7 u 0:($5*1e6) w lp ls 8 t "250x250x600" axis x1y1,\
     loc19 u 0:($5*1e6) w lp ls 800 t "250x250x1200" axis x1y1,\
     loc8 u 0:($5*1e6) w lp ls 9 t "500x500x20" axis x1y1,\
     loc15 u 0:($5*1e6) w lp ls 90 t "500x500x40" axis x1y1,\
     loc9 u 0:($5*1e6) w lp ls 10 t "500x500x1200" axis x1y1,\
     loc11 u 0:($5*1e6) w lp ls 11 t "750x750x20" axis x1y1,\
     loc14 u 0:($5*1e6) w lp ls 110 t "750x750x1800" axis x1y1,\
     loc12 u 0:($5*1e6) w lp ls 13 t "1000x1000x20" axis x1y1

set autoscale y
set key right top horizontal
set size 0.33,1
set ylabel font "times,14" 'B_y (East) [{/Symbol m}T]'
plot loc1 u 0:($4*1e6) w lp ls 2 t "50x50x20" axis x1y1,\
     loc2 u 0:($4*1e6) w lp ls 3 t "50x50x120" axis x1y1,\
     loc3 u 0:($4*1e6) w lp ls 4 t "100x100x20" axis x1y1,\
     loc4 u 0:($4*1e6) w lp ls 5 t "100x100x120" axis x1y1,\
     loc5 u 0:($4*1e6) w lp ls 6 t "100x100x240" axis x1y1,\
     loc6 u 0:($4*1e6) w lp ls 7 t "250x250x20" axis x1y1,\
     loc18 u 0:($4*1e6) w lp ls 170 t "250x250x40" axis x1y1,\
     loc7 u 0:($4*1e6) w lp ls 8 t "250x250x600" axis x1y1,\
     loc19 u 0:($4*1e6) w lp ls 800 t "250x250x1200" axis x1y1,\
     loc8 u 0:($4*1e6) w lp ls 9 t "500x500x20" axis x1y1,\
     loc15 u 0:($4*1e6) w lp ls 90 t "500x500x40" axis x1y1,\
     loc9 u 0:($4*1e6) w lp ls 10 t "500x500x1200" axis x1y1,\
     loc11 u 0:($4*1e6) w lp ls 11 t "750x750x20" axis x1y1,\
     loc14 u 0:($4*1e6) w lp ls 110 t "750x750x1800" axis x1y1,\
     loc12 u 0:($4*1e6) w lp ls 13 t "1000x1000x20" axis x1y1

#set yrange[0:5]
unset key
#set key center top
set size 0.33,1
set ylabel font "times,14" 'B_z (Down) [{/Symbol m}T]'
plot loc1 u 0:(-$6*1e6) w lp ls 2 t "50x50x20" axis x1y1,\
     loc2 u 0:(-$6*1e6) w lp ls 3 t "50x50x120" axis x1y1,\
     loc3 u 0:(-$6*1e6) w lp ls 4 t "100x100x20" axis x1y1,\
     loc4 u 0:(-$6*1e6) w lp ls 5 t "100x100x120" axis x1y1,\
     loc5 u 0:(-$6*1e6) w lp ls 6 t "100x100x240" axis x1y1,\
     loc6 u 0:(-$6*1e6) w lp ls 7 t "250x250x20" axis x1y1,\
     loc18 u 0:(-$6*1e6) w lp ls 170 t "250x250x40" axis x1y1,\
     loc7 u 0:(-$6*1e6) w lp ls 8 t "250x250x600" axis x1y1,\
     loc19 u 0:(-$6*1e6) w lp ls 800 t "250x250x1200" axis x1y1,\
     loc8 u 0:(-$6*1e6) w lp ls 9 t "500x500x20" axis x1y1,\
     loc15 u 0:(-$6*1e6) w lp ls 90 t "500x500x40" axis x1y1,\
     loc9 u 0:(-$6*1e6) w lp ls 10 t "500x500x1200" axis x1y1,\
     loc11 u 0:(-$6*1e6) w lp ls 11 t "750x750x20" axis x1y1,\
     loc14 u 0:(-$6*1e6) w lp ls 110 t "750x750x1800" axis x1y1,\
     loc12 u 0:(-$6*1e6) w lp ls 13 t "1000x1000x20" axis x1y1

unset multiplot
###################################
###################################
set terminal pngcairo size 1800,900

set output 'zt_c.png'
set multiplot layout 1,3
#unset title
set size 0.33,1
set ylabel font "times,14" 'B_x (North) [{/Symbol m}T]'
set grid back ytics ls 12
unset key
#set key center bottom
#set key opaque
#set yrange[-1.6:0]
plot loc6 u 0:($5*1e6) w lp ls 7 t "250x250x20" axis x1y1,\
     loc16 u 0:($5*1e6) w lp ls 170 t "250x250x20 centered" axis x1y1,\
     loc7 u 0:($5*1e6) w lp ls 8 t "250x250x600" axis x1y1,\
     loc17 u 0:($5*1e6) w lp ls 800 t "250x250x600 centered, Lz^+" axis x1y1


set autoscale y
set size 0.33,1
set key right top vertical
set ylabel font "times,14" 'B_y (East) [{/Symbol m}T]'
plot loc6 u 0:($4*1e6) w lp ls 7 t "250x250x20" axis x1y1,\
     loc16 u 0:($4*1e6) w lp ls 170 t "250x250x20 centered" axis x1y1,\
     loc7 u 0:($4*1e6) w lp ls 8 t "250x250x600" axis x1y1,\
     loc17 u 0:($4*1e6) w lp ls 800 t "250x250x600 centered, Lz^+" axis x1y1

#set yrange[0:5]
unset key
#set key center top
set size 0.33,1
set ylabel font "times,14" 'B_z (Down) [{/Symbol m}T]'
plot loc6 u 0:(-$6*1e6) w lp ls 7 t "250x250x20" axis x1y1,\
     loc16 u 0:(-$6*1e6) w lp ls 170 t "250x250x20 centered" axis x1y1,\
     loc7 u 0:(-$6*1e6) w lp ls 8 t "250x250x600" axis x1y1,\
     loc17 u 0:(-$6*1e6) w lp ls 800 t "250x250x600 centered, Lz^+" axis x1y1

unset multiplot
###################################
set output 'zt_c_more.png'
set multiplot layout 1,3
#unset title
set size 0.33,1
set ylabel font "times,14" 'B_x (North) [{/Symbol m}T]'
set grid back ytics ls 12
unset key
#set key center bottom
#set key opaque
#set yrange[-1.6:0]
plot loc6 u 0:($5*1e6) w lp ls 7 t "250x250x20" axis x1y1,\
     loc16 u 0:($5*1e6) w lp ls 170 t "250x250x20 centered" axis x1y1,\
     loc7 u 0:($5*1e6) w lp ls 8 t "250x250x600" axis x1y1,\
     loc17 u 0:($5*1e6) w lp ls 800 t "250x250x600 centered, Lz^+" axis x1y1,\
     loc9 u 0:($5*1e6) w lp ls 4 t "500x500x1200" axis x1y1,\
     loc13 u 0:($5*1e6) w lp ls 5 t "500x500x1200 centered" axis x1y1

set autoscale y
set key right top vertical
set size 0.33,1
set ylabel font "times,14" 'B_y (East) [{/Symbol m}T]'
plot loc6 u 0:($4*1e6) w lp ls 7 t "250x250x20" axis x1y1,\
     loc16 u 0:($4*1e6) w lp ls 170 t "250x250x20 centered" axis x1y1,\
     loc7 u 0:($4*1e6) w lp ls 8 t "250x250x600" axis x1y1,\
     loc17 u 0:($4*1e6) w lp ls 800 t "250x250x600 centered, Lz^+" axis x1y1,\
     loc9 u 0:($4*1e6) w lp ls 4 t "500x500x1200" axis x1y1,\
     loc13 u 0:($4*1e6) w lp ls 5 t "500x500x1200 centered" axis x1y1

#set yrange[0:5]
unset key
#set key center top
set size 0.33,1
set ylabel font "times,14" 'B_z (Down) [{/Symbol m}T]'
plot loc6 u 0:(-$6*1e6) w lp ls 7 t "250x250x20" axis x1y1,\
     loc16 u 0:(-$6*1e6) w lp ls 170 t "250x250x20 centered" axis x1y1,\
     loc7 u 0:(-$6*1e6) w lp ls 8 t "250x250x600" axis x1y1,\
     loc17 u 0:(-$6*1e6) w lp ls 800 t "250x250x600 centered, Lz^+" axis x1y1,\
     loc9 u 0:(-$6*1e6) w lp ls 4 t "500x500x1200" axis x1y1,\
     loc13 u 0:(-$6*1e6) w lp ls 5 t "500x500x1200 centered" axis x1y1
unset multiplot




set terminal pngcairo size 1800,900

####################################
set output 'zt_s.png'
set multiplot layout 1,3
#unset title
set size 0.33,1
set ylabel font "times,14" 'B_x (North) [{/Symbol m}T]'
set autoscale y
set grid back ytics ls 12
unset key
plot loc1 u 0:($5*1e6) w lp ls 2 t "50x50x20" axis x1y1,\
     loc2 u 0:($5*1e6) w lp ls 3 t "50x50x120" axis x1y1,\
     loc3 u 0:($5*1e6) w lp ls 4 t "100x100x20" axis x1y1,\
     loc5 u 0:($5*1e6) w lp ls 6 t "100x100x240" axis x1y1,\
     loc6 u 0:($5*1e6) w lp ls 8 t "250x250x20" axis x1y1,\
     loc7 u 0:($5*1e6) w lp ls 800 t "250x250x600" axis x1y1,\
     loc8 u 0:($5*1e6) w lp ls 9 t "500x500x20" axis x1y1,\
     loc9 u 0:($5*1e6) w lp ls 10 t "500x500x1200" axis x1y1,\
     loc12 u 0:($5*1e6) w lp ls 13 t "1000x1000x20" axis x1y1

set key right top horizontal
set size 0.33,1
set ylabel font "times,14" 'B_y (East) [{/Symbol m}T]'
plot loc1 u 0:($4*1e6) w lp ls 2 t "50x50x20" axis x1y1,\
     loc2 u 0:($4*1e6) w lp ls 3 t "50x50x120" axis x1y1,\
     loc3 u 0:($4*1e6) w lp ls 4 t "100x100x20" axis x1y1,\
     loc5 u 0:($4*1e6) w lp ls 6 t "100x100x240" axis x1y1,\
     loc6 u 0:($4*1e6) w lp ls 8 t "250x250x20" axis x1y1,\
     loc7 u 0:($4*1e6) w lp ls 800 t "250x250x600" axis x1y1,\
     loc8 u 0:($4*1e6) w lp ls 9 t "500x500x20" axis x1y1,\
     loc9 u 0:($4*1e6) w lp ls 10 t "500x500x1200" axis x1y1,\
     loc12 u 0:($4*1e6) w lp ls 13 t "1000x1000x20" axis x1y1

unset key
set size 0.33,1
set ylabel font "times,14" 'B_z (Down) [{/Symbol m}T]'
plot loc1 u 0:(-$6*1e6)  w lp ls 2 t "50x50x20" axis x1y1,\
     loc2 u 0:(-$6*1e6)  w lp ls 3 t "50x50x120" axis x1y1,\
     loc3 u 0:(-$6*1e6)  w lp ls 4 t "100x100x20" axis x1y1,\
     loc5 u 0:(-$6*1e6)  w lp ls 6 t "100x100x240" axis x1y1,\
     loc6 u 0:(-$6*1e6)  w lp ls 8 t "250x250x20" axis x1y1,\
     loc7 u 0:(-$6*1e6)  w lp ls 800 t "250x250x600" axis x1y1,\
     loc8 u 0:(-$6*1e6)  w lp ls 9 t "500x500x20" axis x1y1,\
     loc9 u 0:(-$6*1e6)  w lp ls 10 t "500x500x1200" axis x1y1,\
     loc12 u 0:(-$6*1e6)  w lp ls 13 t "1000x1000x20" axis x1y1

unset multiplot
###################################
####################################
set output 'zt_s_h.png'
set multiplot layout 1,3
#unset title
set size 0.33,1
set ylabel font "times,14" 'B_x (North) [{/Symbol m}T]'
set autoscale y
set grid back ytics ls 12
unset key
plot loc3 u 0:($5*1e6) w lp ls 4 t "100x100x20" axis x1y1,\
     loc5 u 0:($5*1e6) w lp ls 6 t "100x100x240" axis x1y1,\
     loc6 u 0:($5*1e6) w lp ls 8 t "250x250x20" axis x1y1,\
     loc7 u 0:($5*1e6) w lp ls 800 t "250x250x600" axis x1y1,\
     loc8 u 0:($5*1e6) w lp ls 9 t "500x500x20" axis x1y1,\
     loc9 u 0:($5*1e6) w lp ls 10 t "500x500x1200" axis x1y1,\
     loc12 u 0:($5*1e6) w lp ls 13 t "1000x1000x20" axis x1y1

set key right top horizontal
set size 0.33,1
set ylabel font "times,14" 'B_y (East) [{/Symbol m}T]'
plot loc3 u 0:($4*1e6) w lp ls 4 t "100x100x20" axis x1y1,\
     loc5 u 0:($4*1e6) w lp ls 6 t "100x100x240" axis x1y1,\
     loc6 u 0:($4*1e6) w lp ls 8 t "250x250x20" axis x1y1,\
     loc7 u 0:($4*1e6) w lp ls 800 t "250x250x600" axis x1y1,\
     loc8 u 0:($4*1e6) w lp ls 9 t "500x500x20" axis x1y1,\
     loc9 u 0:($4*1e6) w lp ls 10 t "500x500x1200" axis x1y1,\
     loc12 u 0:($4*1e6) w lp ls 13 t "1000x1000x20" axis x1y1

unset key
set size 0.33,1
set ylabel font "times,14" 'B_z (Down) [{/Symbol m}T]'
plot loc3 u 0:(-$6*1e6)  w lp ls 4 t "100x100x20" axis x1y1,\
     loc5 u 0:(-$6*1e6)  w lp ls 6 t "100x100x240" axis x1y1,\
     loc6 u 0:(-$6*1e6)  w lp ls 8 t "250x250x20" axis x1y1,\
     loc7 u 0:(-$6*1e6)  w lp ls 800 t "250x250x600" axis x1y1,\
     loc8 u 0:(-$6*1e6)  w lp ls 9 t "500x500x20" axis x1y1,\
     loc9 u 0:(-$6*1e6)  w lp ls 10 t "500x500x1200" axis x1y1,\
     loc12 u 0:(-$6*1e6)  w lp ls 13 t "1000x1000x20" axis x1y1

unset multiplot
###################################
