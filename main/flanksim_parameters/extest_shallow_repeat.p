loc1 = '/home/agnes/MTE/main/flanksim_parameters/south/extest/50_50_120/measurements_line.ascii'
loc6 = '/home/agnes/MTE/main/flanksim_parameters/south/deptest/50_50_20/measurements_line.ascii'
loc2 = '/home/agnes/MTE/main/flanksim_parameters/south/extest/100_100_240/measurements_line.ascii'
loc3 = '/home/agnes/MTE/main/flanksim_parameters/south/extest/250_250_40/measurements_line.ascii'
loc4 = '/home/agnes/MTE/main/flanksim_parameters/south/extest/250_250_600/measurements_line.ascii'
loc5 = '/home/agnes/MTE/main/flanksim_parameters/south/extest/500_500_1200/measurements_line.ascii'
loc7 = '/home/agnes/MTE/main/flanksim_parameters/south/extest/1000_1000_2400/measurements_line.ascii'
loc8 = '/home/agnes/MTE/main/flanksim_parameters/south/extest/250_250_20/measurements_line.ascii'
loc9 = '/home/agnes/MTE/main/flanksim_parameters/south/extest/250_250_10/measurements_line.ascii'
loc10 = '/home/agnes/MTE/main/flanksim_parameters/south/extest/250_250_5/measurements_line.ascii'
loc11 = '/home/agnes/MTE/main/flanksim_parameters/south/extest/250_250_20_el5/measurements_line.ascii'
loc12 = '/home/agnes/MTE/main/flanksim_parameters/south/extest/250_250_10_5/measurements_line.ascii'
set terminal pngcairo size 2200,1200

set key default
set key box
set xlabel font "courier,14" 'index'
set y2label font "courier,14" 'height surface (m)' 
set autoscale xy
set ytics nomirror
set style line 16 lc rgb '#aaaaaa' dt 2 lw 0.5
set grid back ytics ls 16
set tics out font "courier,14"
set xrange[0:50]
set y2range[-6:6]
set y2tics -6,1
set style line 1 lw 1.5 lc "grey40"
set style line 2 pt 12 lw 2 lc rgb '#000000' 
set style line 3 pt 10 lw 2 lc rgb '#e69f00' 
set style line 4 pt 2 lw 2 lc rgb '#0072b2'
set style line 5 pt 4 lw 2 lc rgb '#009e73' 
set style line 6 pt 6 lw 2 lc rgb '#d55e00'
set style line 7 pt 8 lw 2 lc "red"
set style line 8 pt 14 lw 2 lc rgb '#cc79a7'
set style line 9 pt 16 lw 2 lc rgb '#56b4e9'
set style line 10 pt 18 lw 2 lc "orchid4"
set style line 11 pt 20 lw 2 lc "cyan"
set style line 12 pt 22 lw 2 lc "dark-olivegreen"
set style line 13 pt 24 lw 2 lc "spring-green"


#(sqrt(($4)**2+($5)**2+($6)**2)*1e6)

#lc rgb 0x000000
#lc rgb 0xe69f00 #orange
#lc rgb 0x56b4e9 #skyblue
#lc rgb 0x009e73 #bluish green
#lc rgb 0xf0e442 #yellow
#lc rgb 0x0072b2 #blue
#lc rgb 0xd55e00 #dark orange (vermillon)
#lc rgb 0xcc79a7 # reddish purple

set output 'extest_mag_rep.png'
set key bottom left
set key opaque
set ylabel font "courier,14" '|B_{a}| ({/Symbol m}T)'

plot loc1 u 0:($3-1) w l ls 1 t "surface" axis x1y2,\
     loc9 u 0:(sqrt(($4)**2+($5)**2+($6)**2)*1e6) w lp ls 11 t "250x250x10" axis x1y1,\
     loc12 u 0:(sqrt(($4)**2+($5)**2+($6)**2)*1e6) w lp ls 13 t "250x250x10 nelz=5" axis x1y1,\
     loc8 u 0:(sqrt(($4)**2+($5)**2+($6)**2)*1e6) w lp ls 9 t "250x250x20" axis x1y1,\
     loc11 u 0:(sqrt(($4)**2+($5)**2+($6)**2)*1e6) w lp ls 12 t "250x250x20 nelx/nely=5" axis x1y1,\
     

set output 'extest_comp_rep.png'
set multiplot layout 1,3
#unset title
set xrange[0:46]
set xlabel font "courier,14" 'index'
set ylabel font "courier,14" 'Bx_a (North) ({/Symbol m}T)'
set grid back ytics ls 16


plot loc1 u 0:($3-1) w l ls 1 t "surface" axis x1y2,\
     loc9 u 0:($5*1e6) w lp ls 11 t "250x250x10" axis x1y1,\
     loc12 u 0:($5*1e6) w lp ls 13 t "250x250x10 nelz=5" axis x1y1,\
     loc8 u 0:($5*1e6) w lp ls 9 t "250x250x20" axis x1y1,\
     loc11 u 0:($5*1e6) w lp ls 12 t "250x250x20 nelx/nely=5" axis x1y1,\

set ylabel font "courier,14" 'By_a (East) ({/Symbol m}T)'
plot loc1 u 0:($3-1) w l ls 1 t "surface" axis x1y2,\
     loc9 u 0:($4*1e6) w lp ls 11 t "250x250x10" axis x1y1,\
     loc12 u 0:($4*1e6) w lp ls 13 t "250x250x10 nelz=5" axis x1y1,\
     loc8 u 0:($4*1e6) w lp ls 9 t "250x250x20" axis x1y1,\
     loc11 u 0:($4*1e6) w lp ls 12 t "250x250x20 nelx/nely=5" axis x1y1,\

set ylabel font "courier,14" 'Bz_a (Down) ({/Symbol m}T)'
plot loc1 u 0:($3-1) w l ls 1 t "surface" axis x1y2,\
     loc9 u 0:(-$6*1e6) w lp ls 11 t "250x250x10" axis x1y1,\
     loc12 u 0:(-$6*1e6) w lp ls 13 t "250x250x10 nelz=5" axis x1y1,\
     loc8 u 0:(-$6*1e6) w lp ls 9 t "250x250x20" axis x1y1,\
     loc11 u 0:(-$6*1e6) w lp ls 12 t "250x250x20 nelx/nely=5" axis x1y1,\

unset multiplot
#################################

