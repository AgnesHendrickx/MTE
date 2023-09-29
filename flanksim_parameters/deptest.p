loc8 = './south/deptest/50_50_10/measurements_line.ascii'
loc1 = './south/deptest/50_50_20/measurements_line.ascii'
loc2 = './south/deptest/50_50_40/measurements_line.ascii'
loc3 = './south/deptest/50_50_60/measurements_line.ascii'

loc5 = './south/deptest/50_50_100/measurements_line.ascii'

loc7 = './south/deptest/50_50_140/measurements_line.ascii'



set terminal pngcairo size 1800,900

set key default
set key box
set xlabel font "courier,14" 'distance (m)'
set y2label font "courier,14" 'height surface (m)' 
set autoscale xy
set ytics nomirror
set style line 12 lc rgb '#aaaaaa' dt 2 lw 0.5
set grid back ytics ls 12
set tics out font "courier,14"
set xrange[0:50]
set y2range[-6:6]
set y2tics -6,1

set style line 1 lw 2 lc "grey40"
set style line 2 pt 12 lw 2 lc rgb '#000000' 
set style line 3 pt 10 lw 2 lc rgb '#e69f00' 
set style line 4 pt 2 lw 2 lc rgb '#0072b2'
set style line 5 pt 4 lw 2 lc rgb '#009e73' 
set style line 6 pt 6 lw 2 lc rgb '#d55e00'
set style line 7 pt 8 lw 2 lc rgb '#f0e442'
set style line 8 pt 8 lw 2 lc rgb '#cc79a7'
set style line 9 pt 16 lw 2 lc rgb '#56b4e9'

#(sqrt(($4)**2+($5)**2+($6)**2)*1e6)

#lc rgb 0x000000
#lc rgb 0xe69f00 #orange
#lc rgb 0x56b4e9 #skyblue
#lc rgb 0x009e73 #bluish green
#lc rgb 0xf0e442 #yellow
#lc rgb 0x0072b2 #blue
#lc rgb 0xd55e00 #dark orange (vermillon)
#lc rgb 0xcc79a7 # reddish purple

set output 'deptest_mag.png'
set key top right
set ylabel font "courier,14" '|B_{a}| ({/Symbol m}T)'

plot loc1 u 1:($3-1) w l ls 1 t "surface" axis x1y2,\
     loc8 u 1:(sqrt(($4)**2+($5)**2+($6)**2)*1e6) w lp ls 9 t "50x50x10" axis x1y1,\
     loc1 u 1:(sqrt(($4)**2+($5)**2+($6)**2)*1e6) w lp ls 3 t "50x50x20" axis x1y1,\
     loc2 u 1:(sqrt(($4)**2+($5)**2+($6)**2)*1e6) w lp ls 4 t "50x50x40" axis x1y1,\
     loc3 u 1:(sqrt(($4)**2+($5)**2+($6)**2)*1e6) w lp ls 5 t "50x50x60" axis x1y1,\
     loc5 u 1:(sqrt(($4)**2+($5)**2+($6)**2)*1e6) w lp ls 6 t "50x50x100" axis x1y1,\
     loc7 u 1:(sqrt(($4)**2+($5)**2+($6)**2)*1e6) w lp ls 8 t "50x50x140" axis x1y1
####################################
set output 'deptest_comp.png'
set multiplot layout 1,3
#unset title

set xlabel font "courier,14" 'distance (m)'
set ylabel font "courier,14" 'Bx_a (North) ({/Symbol m}T)'
set grid back ytics ls 12
set key right bottom 
set key opaque
plot loc1 u 1:($3-1) w l ls 1 t "surface" axis x1y2,\
     loc8 u 1:($5*1e6) w lp ls 9 t "50x50x10" axis x1y1,\
     loc1 u 1:($5*1e6) w lp ls 3 t "50x50x20" axis x1y1,\
     loc2 u 1:($5*1e6) w lp ls 4 t "50x50x40" axis x1y1,\
     loc3 u 1:($5*1e6) w lp ls 5 t "50x50x60" axis x1y1,\
     loc5 u 1:($5*1e6) w lp ls 6 t "50x50x100" axis x1y1,\
     loc7 u 1:($5*1e6) w lp ls 8 t "50x50x140" axis x1y1

set key left bottom 
set ylabel font "courier,14" 'By_a (East) ({/Symbol m}T)'
plot loc1 u 1:($3-1) w l ls 1 t "surface" axis x1y2,\
     loc8 u 1:($4*1e6) w lp ls 9 t "50x50x10" axis x1y1,\
     loc1 u 1:($4*1e6) w lp ls 3 t "50x50x20" axis x1y1,\
     loc2 u 1:($4*1e6) w lp ls 4 t "50x50x40" axis x1y1,\
     loc3 u 1:($4*1e6) w lp ls 5 t "50x50x60" axis x1y1,\
     loc5 u 1:($4*1e6) w lp ls 6 t "50x50x100" axis x1y1,\
     loc7 u 1:($4*1e6) w lp ls 8 t "50x50x140" axis x1y1

set key right bottom 
set ylabel font "courier,14" 'Bz_a (Down) ({/Symbol m}T)'
plot loc1 u 1:($3-1) w l ls 1 t "surface" axis x1y2,\
     loc8 u 1:(-$6*1e6) w lp ls 9 t "50x50x10" axis x1y1,\
     loc1 u 1:(-$6*1e6) w lp ls 3 t "50x50x20" axis x1y1,\
     loc2 u 1:(-$6*1e6) w lp ls 4 t "50x50x40" axis x1y1,\
     loc3 u 1:(-$6*1e6) w lp ls 5 t "50x50x60" axis x1y1,\
     loc5 u 1:(-$6*1e6) w lp ls 6 t "50x50x100" axis x1y1,\
     loc7 u 1:(-$6*1e6) w lp ls 8 t "50x50x140" axis x1y1
unset multiplot
###################################
set output 'deptest_comp_scaled.png'
set multiplot layout 1,3
#unset title
set yrange[-4:6]
set xlabel font "courier,14" 'distance (m)'
set ylabel font "courier,14" 'Bx_a (North) ({/Symbol m}T)'
set grid back ytics ls 12

plot loc1 u 1:($3-1) w l ls 1 t "surface" axis x1y2,\
     loc8 u 1:($5*1e6) w lp ls 9 t "50x50x10" axis x1y1,\
     loc1 u 1:($5*1e6) w lp ls 3 t "50x50x20" axis x1y1,\
     loc2 u 1:($5*1e6) w lp ls 4 t "50x50x40" axis x1y1,\
     loc3 u 1:($5*1e6) w lp ls 5 t "50x50x60" axis x1y1,\
     loc5 u 1:($5*1e6) w lp ls 6 t "50x50x100" axis x1y1,\
     loc7 u 1:($5*1e6) w lp ls 8 t "50x50x140" axis x1y1

set key left bottom 
set ylabel font "courier,14" 'By_a (East) ({/Symbol m}T)'
plot loc1 u 1:($3-1) w l ls 1 t "surface" axis x1y2,\
     loc8 u 1:($4*1e6) w lp ls 9 t "50x50x10" axis x1y1,\
     loc1 u 1:($4*1e6) w lp ls 3 t "50x50x20" axis x1y1,\
     loc2 u 1:($4*1e6) w lp ls 4 t "50x50x40" axis x1y1,\
     loc3 u 1:($4*1e6) w lp ls 5 t "50x50x60" axis x1y1,\
     loc5 u 1:($4*1e6) w lp ls 6 t "50x50x100" axis x1y1,\
     loc7 u 1:($4*1e6) w lp ls 8 t "50x50x140" axis x1y1

set key right bottom 
set ylabel font "courier,14" 'Bz_a (Down) ({/Symbol m}T)'
plot loc1 u 1:($3-1) w l ls 1 t "surface" axis x1y2,\
     loc8 u 1:(-$6*1e6) w lp ls 9 t "50x50x10" axis x1y1,\
     loc1 u 1:(-$6*1e6) w lp ls 3 t "50x50x20" axis x1y1,\
     loc2 u 1:(-$6*1e6) w lp ls 4 t "50x50x40" axis x1y1,\
     loc3 u 1:(-$6*1e6) w lp ls 5 t "50x50x60" axis x1y1,\
     loc5 u 1:(-$6*1e6) w lp ls 6 t "50x50x100" axis x1y1,\
     loc7 u 1:(-$6*1e6) w lp ls 8 t "50x50x140" axis x1y1
unset multiplot



