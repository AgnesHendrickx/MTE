loc = '/home/agnes/MTE/fieldstone_138/Benchmark 3/'
set terminal pngcairo size 1800,900

set autoscale xy
#set xrange [0.01:0.25]
#set format y "%.0e"
set tics out font "courier,14"
set key default
set key box opaque

set key font "courier,14"
#set key box
set style line 1 lw 2 lc "black"
set style line 2 ps 1 lw 2 pt 2 lc rgb '#cc79a7'
set style line 3 ps 1 lw 2 pt 4 lc rgb '#0072b2'
set style line 4 ps 1 lw 2 pt 8 lc rgb '#009e73'
set style line 5 ps 1 lw 2 pt 12 lc rgb '#d55e00'
set style line 12 lc rgb '#aaaaaa' dt 2 lw 0.5
set style line 11 lw 2 lc "grey40"



set output 'B3sphere_mp_all.png'
set multiplot layout 1,3
unset title
#set title font "courier,16"  'sphere benchmark, fibonacci spiral' 
set xlabel font "courier,14" 'point ID'
set ylabel font "courier,14" 'B_x ({/Symbol m}T)'
set yrange [-5:6]
set ytics -5,1,5
set grid back ytics ls 12

plot loc.'0_25_above/measurements_spiral.ascii' u 0:($7*1e6) w p ls 2 t '25 cm & 3 el/m' ,\
     loc.'0_25_2_above/measurements_spiral.ascii' u 0:($7*1e6) w p ls 5 t '25 cm & 6 el/m' ,\
     loc.'0_5_above/measurements_spiral.ascii' u 0:($7*1e6)w p ls 3 t '50 cm & 3 el/m',\
     loc.'0_5_2_above/measurements_spiral.ascii' u 0:($7*1e6) w p ls 4 t '50 cm & 6 el/m',\
     loc.'0_5_2_above/measurements_spiral.ascii' u 0:($10*1e-7*1e6) w p ls 11 t 'analytical 0.5 above',\
     loc.'0_25_above/measurements_spiral.ascii' u 0:($10*1e-7*1e6) w p ls 1 t 'analytical 0.25 above'

set ylabel font "courier,12" 'B_y ({/Symbol m}T)'
plot loc.'0_25_above/measurements_spiral.ascii' u 0:($8*1e6) w p ls 2 t '25 cm & 3 el/m' ,\
     loc.'0_25_2_above/measurements_spiral.ascii' u 0:($8*1e6) w p ls 5 t '25 cm & 6 el/m' ,\
     loc.'0_5_above/measurements_spiral.ascii' u 0:($8*1e6) w p ls 3 t '50 cm & 3 el/m',\
     loc.'0_5_2_above/measurements_spiral.ascii' u 0:($8*1e6) w p ls 4 t '50 cm & 6 el/m',\
     loc.'0_5_2_above/measurements_spiral.ascii' u 0:($11*1e-7*1e6) w p ls 11 t 'analytical 0.5 above',\
     loc.'0_25_above/measurements_spiral.ascii' u 0:($11*1e-7*1e6) w p ls 1 t 'analytical 0.25 above'

set ylabel font "courier,12" 'B_z ({/Symbol m}T)'
plot loc.'0_25_above/measurements_spiral.ascii' u 0:($9*1e6) w p ls 2 t '25 cm & 3 el/m' ,\
     loc.'0_25_2_above/measurements_spiral.ascii' u 0:($9*1e6) w p ls 5 t '25 cm & 6 el/m' ,\
     loc.'0_5_above/measurements_spiral.ascii' u 0:($9*1e6) w p ls 3 t '50 cm & 3 el/m',\
     loc.'0_5_2_above/measurements_spiral.ascii' u 0:($9*1e6)w p ls 4 t '50 cm & 6 el/m',\
     loc.'0_5_2_above/measurements_spiral.ascii' u 0:($12*1e-7*1e6) w p ls 11 t 'analytical 0.5 above',\
     loc.'0_25_above/measurements_spiral.ascii' u 0:($12*1e-7*1e6) w p ls 1 t 'analytical 0.25 above'
unset multiplot
######################################################################################
set output 'B3sphere_mp_05.png'
set multiplot layout 1,3
unset title
#set title font "courier,16"  'sphere benchmark, fibonacci spiral' 
set xlabel font "courier,14" 'point ID'
set ylabel font "courier,14" 'B_x ({/Symbol m}T)'
#set yrange [-5:5]
#set ytics -5,1,5
set grid back ytics ls 12

plot loc.'0_5_above/measurements_spiral.ascii' u 0:($7*1e6)w p ls 3 t '50 cm & 3 el/m',\
     loc.'0_5_2_above/measurements_spiral.ascii' u 0:($7*1e6) w p ls 4 t '50 cm & 6 el/m',\
     loc.'0_5_2_above/measurements_spiral.ascii' u 0:($10*1e-7*1e6) w p ls 11 t 'analytical 0.5 above'


set ylabel font "courier,12" 'B_y ({/Symbol m}T)'
plot loc.'0_5_above/measurements_spiral.ascii' u 0:($8*1e6) w p ls 3 t '50 cm & 3 el/m',\
     loc.'0_5_2_above/measurements_spiral.ascii' u 0:($8*1e6) w p ls 4 t '50 cm & 6 el/m',\
     loc.'0_25_above/measurements_spiral.ascii' u 0:($11*1e-7*1e6) w p ls 1 t 'analytical 0.25 above'

set ylabel font "courier,12" 'B_z ({/Symbol m}T)'
plot loc.'0_5_above/measurements_spiral.ascii' u 0:($9*1e6) w p ls 3 t '50 cm & 3 el/m',\
     loc.'0_5_2_above/measurements_spiral.ascii' u 0:($9*1e6)w p ls 4 t '50 cm & 6 el/m',\
     loc.'0_5_2_above/measurements_spiral.ascii' u 0:($12*1e-7*1e6) w p ls 11 t 'analytical 0.5 above'
unset multiplot
######################################################################################
set output 'B3sphere_mp_025.png'
set multiplot layout 1,3
#unset title
#set title font "courier,16"  'sphere benchmark, fibonacci spiral' 
set xlabel font "courier,14" 'point ID'
set ylabel font "courier,14" 'B_x ({/Symbol m}T)'
#set yrange [-5:5]
#set ytics -5,1,5
set grid back ytics ls 12

plot loc.'0_25_above/measurements_spiral.ascii' u 0:($7*1e6) w p ls 2 t '25 cm & 3 el/m' ,\
     loc.'0_25_2_above/measurements_spiral.ascii' u 0:($7*1e6) w p ls 5 t '25 cm & 6 el/m' ,\
     loc.'0_25_above/measurements_spiral.ascii' u 0:($10*1e-7*1e6) w p ls 1 t 'analytical 0.25 above'

set ylabel font "courier,12" 'B_y ({/Symbol m}T)'
plot loc.'0_25_above/measurements_spiral.ascii' u 0:($8*1e6) w p ls 2 t '25 cm & 3 el/m' ,\
     loc.'0_25_2_above/measurements_spiral.ascii' u 0:($8*1e6) w p ls 5 t '25 cm & 6 el/m' ,\
     loc.'0_25_above/measurements_spiral.ascii' u 0:($11*1e-7*1e6) w p ls 1 t 'analytical 0.25 above'

set ylabel font "courier,12" 'B_z ({/Symbol m}T)'
plot loc.'0_25_above/measurements_spiral.ascii' u 0:($9*1e6) w p ls 2 t '25 cm & 3 el/m' ,\
     loc.'0_25_2_above/measurements_spiral.ascii' u 0:($9*1e6) w p ls 5 t '25 cm & 6 el/m' ,\
     loc.'0_25_above/measurements_spiral.ascii' u 0:($12*1e-7*1e6) w p ls 1 t 'analytical 0.25 above'
unset multiplot




