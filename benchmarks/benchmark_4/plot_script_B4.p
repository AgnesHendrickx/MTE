loc = './'
set terminal pngcairo size 1800,900

set style line 1 pt 1 lw 2 ps 0.5 lc "black"
set style line 2 pt 2 lw 2 ps 0.5 lc 'grey20'
set style line 3 pt 7 lw 4 ps 1.5 lc "royalblue"
set style line 4 pt 5 lw 2 ps 0.8 lc "web-green" 
set style line 5 pt 9 lw 2 ps 0.8 lc "orange-red"
set style line 6 pt 11 lw 2 ps 0.8 lc "gold"

set style line 12 lc 'grey80' dt 2 lw 0.5


set key default font "times,14" box lc 'grey60' opaque fc 'grey90' vertical top right height 0.5

set xtics out font "times,14"
set ytics out font "times,14"
set grid back ytics ls 12

set xlabel font "times,14" 'distance to sphere [m]'
set ylabel font "times,14" 'B_z [{/Symbol m}T]'



##############################
set output 'B4.png'
set autoscale xy
set multiplot layout 1,3


set ylabel font "times,14" 'B_x [{/Symbol m}T]'
set xlabel font "times,14" 'index observation point'

set grid back ytics ls 12

set size 0.33,1
unset key
plot loc.'measurements_line.ascii' u 0:($7*1e6) w lp ls 3 t 'computed' ,\
     loc.'measurements_line.ascii' u 0:($10*1e6) w lp ls 4 t 'analytical' 

set size 0.33,1
set ylabel font "times,14" 'B_y [{/Symbol m}T]'
plot loc.'measurements_line.ascii' u 0:($8*1e6) w lp ls 3 t 'computed' ,\
     loc.'measurements_line.ascii' u 0:($11*1e6) w lp ls 4 t 'analytical' 



set size 0.33,1
set ylabel font "times,14" 'B_z [{/Symbol m}T]'
set key font "times,14" box lc 'grey60' opaque fc 'grey90' vertical top right height 0.5
plot loc.'measurements_line.ascii' u 0:($9*1e6) w lp ls 3 t 'computed' ,\
     loc.'measurements_line.ascii' u 0:($12*1e6) w lp ls 4 t 'analytical' 

unset multiplot

##############################
set output 'B4_dif.png'
set autoscale xy

set grid back xtics ls 12

set key font "times,14" box lc 'grey60' opaque fc 'grey90' vertical top right height 0.8

set ylabel font "times,14" '{/Symbol D}B_i [{/Symbol m}T]' offset 1,0
plot loc.'measurements_line.ascii' u 0:($10-$7)*1e6 w lp ls 4 t 'B@_x^{analytical} - B@_x^{computed}'  ,\
     loc.'measurements_line.ascii' u 0:($11-$8)*1e6 w lp ls 5 t 'B@_y^{analytical} - B@_y^{computed}'  ,\
     loc.'measurements_line.ascii' u 0:($12-$9)*1e6 w lp ls 6 t 'B@_z^{analytical} - B@_z^{computed}'  

##############################
loc = './'
set terminal epscairo size 9,4.5

set style line 1 pt 1 lw 2 ps 0.5 lc "black"
set style line 2 pt 2 lw 2 ps 0.5 lc 'grey20'
set style line 3 pt 7 lw 3 ps 1 lc "royalblue"
set style line 4 pt 5 lw 2 ps 0.5 lc "web-green" 
set style line 5 pt 9 lw 2 ps 0.5 lc "orange-red"
set style line 6 pt 11 lw 2 ps 0.5 lc "gold"

set style line 12 lc 'grey80' dt 2 lw 0.5

set key default
set key font "times,14" box lc 'grey60' opaque fc 'grey90' vertical top right height 1.5

unset grid

set grid back ytics ls 12

set xlabel font "times,14" 'distance to sphere [m]'
set ylabel font "times,14" 'B_z [{/Symbol m}T]'



##############################
set output 'B4.eps'
set autoscale xy
set multiplot layout 1,3


set ylabel font "times,14" 'B_x [{/Symbol m}T]'
set xlabel font "times,14" 'index observation point'

set grid back ytics ls 12

set size 0.33,1
unset key
plot loc.'measurements_line.ascii' u 0:($7*1e6) w lp ls 3 t 'computed' ,\
     loc.'measurements_line.ascii' u 0:($10*1e6) w lp ls 4 t 'analytical' 

set size 0.33,1
set ylabel font "times,14" 'B_y [{/Symbol m}T]'
plot loc.'measurements_line.ascii' u 0:($8*1e6) w lp ls 3 t 'computed' ,\
     loc.'measurements_line.ascii' u 0:($11*1e6) w lp ls 4 t 'analytical' 



set size 0.33,1
set ylabel font "times,14" 'B_z [{/Symbol m}T]'
set key font "times,14" box lc 'grey60' opaque fc 'grey90' vertical top right height 0.5
plot loc.'measurements_line.ascii' u 0:($9*1e6) w lp ls 3 t 'computed' ,\
     loc.'measurements_line.ascii' u 0:($12*1e6) w lp ls 4 t 'analytical' 

unset multiplot

##############################
set output 'B4_dif.eps'
set autoscale xy

set grid back xtics ls 12

set key font "times,14" box lc 'grey60' opaque fc 'grey90' vertical top right height 0.8

set ylabel font "times,14" '{/Symbol D}B_i [{/Symbol m}T]' offset 1,0
plot loc.'measurements_line.ascii' u 0:($10-$7)*1e6 w lp ls 4 t 'B@_x^{analytical} - B@_x^{computed}'  ,\
     loc.'measurements_line.ascii' u 0:($11-$8)*1e6 w lp ls 5 t 'B@_y^{analytical} - B@_y^{computed}'  ,\
     loc.'measurements_line.ascii' u 0:($12-$9)*1e6 w lp ls 6 t 'B@_z^{analytical} - B@_z^{computed}'  

##############################

set output 'B4_dif_rel.eps'
set autoscale xy

set grid back xtics ls 12

set key font "times,14" box lc 'grey60' opaque fc 'grey90' vertical top right height 2

set ylabel font "times,14" '{/Symbol D}B@_i^rel [%]' offset 1,0
plot loc.'measurements_line.ascii' u 0:(($10-$7)*1e6/($7*1e6)*100) w l ls 4 t 'B@_x^{analytical} - B@_x^{computed}'  ,\
     loc.'measurements_line.ascii' u 0:(($11-$8)*1e6/($8*1e6)*100) w l ls 5 t 'B@_y^{analytical} - B@_y^{computed}'  ,\
     loc.'measurements_line.ascii' u 0:(($12-$9)*1e6/($9*1e6)*100) w l ls 6 t 'B@_z^{analytical} - B@_z^{computed}'  

##############################


