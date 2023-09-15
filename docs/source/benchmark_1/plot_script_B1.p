loc = '/home/agnes/MTE/docs/source/Benchmark 1/'
set terminal pngcairo size 1800,900
set key default
set key font "courier,14"

set style line 1 pt 1 lw 2 ps 0.2 lc "royalblue"
set style line 2 pt 3 lw 2 ps 0.2 lc "green" 
set style line 3 pt 5 lw 2 ps 0.5 lc "coral"
set style line 12 lc rgb '#aaaaaa' dt 2 lw 0.5
set xtics font "courier,14"
set ytics font "courier,14"

set xlabel font "courier,14" 'distance to sphere (m)'
set ylabel font "courier,14" 'B_z ({/Symbol m}T)'


##############################
set output 'B1dipole.png'
set log xy
set autoscale xy
set format y "%.0e"
plot loc.'measurements_line.ascii' u 3:($6*1e7) w lp ls 1 t 'computed' ,\
loc.'measurements_line.ascii' u 3:9 w lp ls 2 t 'analytical' 

##############################
set output 'B1dipole_zoom.png'
unset log xy
set autoscale xy
set format y
plot loc.'results_zoom/measurements_line.ascii' u 3:($6*1e7) w lp ls 1 t 'computed' ,\
loc.'results_zoom/measurements_line.ascii' u 3:9 w lp  ls 2 t 'analytical' 

##############################
set output 'B1dipole_dif.png'
set autoscale xy

set tics out
set grid back ytics ls 12
set grid back xtics ls 12

set ylabel font "courier,14" '{/Symbol D}Bz ({/Symbol m}T)' offset 1,0
plot loc.'measurements_line.ascii' u 3:(($9*1e-1)-($6*1e6)) w lp ls 3 t '(Bz_{analytical} - Bz_{computed})' 

##############################
set output 'B1dipole_dif_zoom.png'
set xrange [0:2]
set yrange [-0.05:0.2]

set xzeroaxis lt 3 lc "black" lw 1 dt (50,10)
set xtics font "courier,14" 0,0.2,2
set ytics font "courier,14" -0.05,0.05,0.2

plot loc.'results_zoom/measurements_line.ascii' u 3:(($9*1e-1)-($6*1e6)) w lp ls 3 t '(Bz_{analytical} - Bz_{computed})' 

##############################
set output 'B1dipole_dif_zoom_withlines.png'

set arrow from 0.25,-0.0093181 to -0.008,-0.0093181 nohead lc "grey20" lw 0.5
set arrow from 0.25,-0.0093181 to 0.25,-0.052 nohead lc "grey20" lw 0.5
set label font "courier,12" "-0.0093" right at 0,-0.009 offset -0.9, 0
set label font "courier,12" "  0.25" center at 0.25,-0.05 offset 0,-0.75

plot loc.'results_zoom/measurements_line.ascii' u 3:(($9*1e-1)-($6*1e6)) w lp ls 3 t '(Bz_{analytical} - Bz_{computed})' 

##############################

