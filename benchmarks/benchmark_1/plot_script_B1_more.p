######################################################################################################################################################
loc = './'
set terminal pngcairo enhanced size 900,600

set style line 1 lw 2 lc "black"
set style line 2 lw 1 lc 'grey40'
set style line 3 pt 7 lw 3 ps 1 lc "royalblue"
set style line 4 pt 5 lw 2 ps 1 lc "web-green" 
set style line 5 pt 9 lw 3 ps 1 lc "orange-red"
set style line 6 pt 11 ps 2 lw 2 lc "gold"

set style line 12 lc 'grey80' dt 2 lw 0.5

set key default font "times,14" box lc 'grey60' opaque fc 'grey90' vertical top right 

set xtics out font "times,14"
set ytics out font "times,14"
set grid back ytics ls 12

set xlabel font "times,14" 'distance to sphere [m]'
set ylabel font "times,14" 'B_z [{/Symbol m}T]'


##############################
set terminal pngcairo enhanced size 1400,600
set output 'B1dipole_mp.png'
set multiplot layout 1,2
set key height 0.5

set yrange [*:*]
set ytics
set log xy
set autoscale xy
set format y "%.0e"

plot loc.'measurements_line.ascii' u 3:($9*1e6) w l ls 3 t 'computed' ,\
loc.'measurements_line.ascii' u 3:($12*1e6) w l ls 4 t 'analytical' 

unset log xy
set grid back xtics ls 12
set ylabel font "times,14" '{/Symbol D}B_z [{/Symbol m}T]' offset 1,0
set xrange [0:2]
set format y "%.2f"
set format x "%.1f"
set xtics font "times,14" 0,0.2,2
set xzeroaxis lt 3 lc "black" lw 1 
set yrange [-0.05:0.20]
set ytics font "times,14" -0.05,0.05,0.2

set arrow from 0.25,-0.0093181 to -0.008,-0.0093181 nohead lc "grey20" lw 0.5
set arrow from 0.25,-0.0093181 to 0.25,-0.052 nohead lc "grey20" lw 0.5
set label font "times,12" "-0.0093" right at 0,-0.009 offset -0.9, 0
set label font "times,12" "  0.25" center at 0.25,-0.05 offset 0,-0.75

plot loc.'results_zoom/measurements_line.ascii' u 3:(($12*1e6)-($9*1e6)) w l ls 5 t 'B@_z^{analytical} - B@_z^{computed}' 

unset multiplot
#####################

