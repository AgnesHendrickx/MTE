set terminal pngcairo size 1800,900
set output 'B1dipole_dif.png'
#set log xy
set pointsize 0.5
#set autoscale xy
set xrange [0.01:]
set yrange [0.00000001:1]
set format y "%.0e"


#set xtics 0,0.5,2

set title font "Arial,16"  'dipole benchmark (Bz_{comp} - Bz_{anal})' 
set xlabel font "arial,12" 'distance to center sphere (m)'
set ylabel font "arial,12" '{/Symbol D}B_z ({/Symbol m}T)'
plot 'measurements_line.ascii' u 3:(($9*1e-1)-($6*1e6)) w lp pt 5 lw 2 ps 1 lc "coral" t '(Bz_{analytical} - Bz_{computed})' 
