set terminal pngcairo size 1800,900
set output 'B1dipole.png'
set log xy
set pointsize 0.5
set autoscale xy
#set xrange [0.5:]
#set yrange [1e-2:1e2]
set format y "%.0e"


#set xtics 0,0.5,2



set title font "Arial,16"  'dipole benchmark' 
set xlabel font "arial,12" 'distance to sphere (m)'
set ylabel font "arial,12" '|B_z| ({/Symbol m}T)'
plot 'measurements_line.ascii' u 3:($6*1e7) w lp lw 2 ps 0.2 lc "coral" t 'computed' ,\
'measurements_line.ascii' u 3:9 w lp lw 2 lc "green" ps 0.2 t 'analytical' 





