loc = './'
set terminal pngcairo size 1800,900
set key default
set key font "courier,14"

set style line 1 pt 1 lw 4 ps 2 lc "royalblue"
set style line 2 pt 3 lw 2 ps 0.2 lc "green" 
set style line 3 pt 5 lw 2 ps 0.5 lc "coral"
set style line 4 pt 5 lw 2 ps 0.5 lc "olive"
set style line 5 pt 5 lw 2 ps 0.5 lc "gold"
set style line 12 lc rgb '#aaaaaa' dt 2 lw 0.5
set xtics font "courier,14"
set ytics font "courier,14"



##############################
set output 'B4.png'
#set log xy
set autoscale xy
#set format y "%.0e"
set multiplot layout 1,3
#unset title

set ylabel font "courier,14" 'Bx_a ({/Symbol m}T)'
set grid back ytics ls 12
set size 0.35,1
unset key
#set key center bottom
#set key opaque
#set yrange[-1.6:0]
plot loc.'measurements_line.ascii' u 0:($4*1e-3) w lp ls 1 t 'computed' ,\
     loc.'measurements_line.ascii' u 0:($7*1e-3) w lp ls 2 t 'analytical' 

set autoscale y
set key right top vertical
set size 0.35,1
set ylabel font "courier,14" 'By_a ({/Symbol m}T)'
plot loc.'measurements_line.ascii' u 0:($5*1e-3) w lp ls 1 t 'computed' ,\
     loc.'measurements_line.ascii' u 0:($8*1e-3) w lp ls 2 t 'analytical' 


#set yrange[0:5]
unset key
#set key center top
set size 0.35,1
set ylabel font "courier,14" 'Bz_a ({/Symbol m}T)'
plot loc.'measurements_line.ascii' u 0:($6*1e-3) w lp ls 1 t 'computed' ,\
     loc.'measurements_line.ascii' u 0:($9*1e-3) w lp ls 2 t 'analytical' 

unset multiplot

##############################
set output 'B4_dif.png'
set autoscale xy

set tics out
set grid back ytics ls 12
set grid back xtics ls 12
set key default opaque box
set key right top vertical
set ylabel font "courier,14" '{/Symbol D}Bz ({/Symbol m}T)' offset 1,0
plot loc.'measurements_line.ascii' u 0:($7-$4)*1e-3 w lp ls 3 t '(Bx_{analytical} - Bx_{computed})',\
     loc.'measurements_line.ascii' u 0:($8-$5)*1e-3 w lp ls 4 t '(By_{analytical} - By_{computed})',\
     loc.'measurements_line.ascii' u 0:($9-$6)*1e-3 w lp ls 5 t '(Bz_{analytical} - Bz_{computed})'  

##############################


