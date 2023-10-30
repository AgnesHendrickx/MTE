loc = './'
set terminal epscairo enhanced size 9,4.5

set style line 1 pt 1 lw 2 ps 0.5 lc "black"
set style line 2 pt 2 lw 2 ps 0.5 lc 'grey20'
set style line 3 pt 7 lw 3 ps 0.6 lc "royalblue"
set style line 4 pt 5 lw 3 ps 0.5 lc "web-green" 
set style line 5 pt 9 lw 3 ps 0.5 lc "orange-red"
set style line 6 pt 11 lw 3 ps 0.5 lc "gold"

set style line 12 lc 'grey80' dt 2 lw 0.5


set key default font "times,14" box lc 'grey60' opaque fc 'grey90' vertical top right 

set xtics out font "times,14" 
set ytics out font "times,14" 

set grid back ytics ls 12

set xlabel font "times,14" 'index observation point'

######################################################################################
set output 'B3sphere_mp_all.eps'
set multiplot layout 1,3

set ylabel font "times,14" 'B_x [{/Symbol m}T]'

set yrange [-5:6]
set ytics -5,1,6

unset key
plot loc.'0_25_above/measurements_spiral.ascii' u 0:($7*1e6) w p ls 3 t '0.25 m \& 3 el/m' ,\
     loc.'0_25_2_above/measurements_spiral.ascii' u 0:($7*1e6) w p ls 4 t '0.25 m \& 6 el/m' ,\
     loc.'0_5_above/measurements_spiral.ascii' u 0:($7*1e6)w p ls 5 t '0.50 m \& 3 el/m',\
     loc.'0_5_2_above/measurements_spiral.ascii' u 0:($7*1e6) w p ls 6 t '0.50 m \& 6 el/m',\
     loc.'0_5_2_above/measurements_spiral.ascii' u 0:($10*1e6) w p ls 1 t 'analytical 0.50 m ',\
     loc.'0_25_above/measurements_spiral.ascii' u 0:($10*1e6) w p ls 2 t 'analytical 0.25 m'

set ylabel font "times,12" 'B_y [({/Symbol m}T]'
plot loc.'0_25_above/measurements_spiral.ascii' u 0:($8*1e6) w p ls 3 t '0.25 m & 3 el/m' ,\
     loc.'0_25_2_above/measurements_spiral.ascii' u 0:($8*1e6) w p ls 4 t '0.25 m \& 6 el/m' ,\
     loc.'0_5_above/measurements_spiral.ascii' u 0:($8*1e6) w p ls 5 t '0.50 m \& 3 el/m',\
     loc.'0_5_2_above/measurements_spiral.ascii' u 0:($8*1e6) w p ls 6 t '0.50 m \& 6 el/m',\
     loc.'0_5_2_above/measurements_spiral.ascii' u 0:($11*1e6) w p ls 1 t 'analytical 0.50 m ',\
     loc.'0_25_above/measurements_spiral.ascii' u 0:($11*1e6) w p ls 2 t 'analytical 0.25 m'


set key default font "times,14" box lc 'grey60' opaque fc 'grey90' horizontal top center height 0.5
set ylabel font "times,12" 'B_z [({/Symbol m}T]'
plot loc.'0_25_above/measurements_spiral.ascii' u 0:($9*1e6) w p ls 3 t '0.25 m & 3 el/m' ,\
     loc.'0_25_2_above/measurements_spiral.ascii' u 0:($9*1e6) w p ls 4 t '0.25 m & 6 el/m' ,\
     loc.'0_5_above/measurements_spiral.ascii' u 0:($9*1e6) w p ls 5 t '0.50 m & 3 el/m',\
     loc.'0_5_2_above/measurements_spiral.ascii' u 0:($9*1e6)w p ls 6 t '0.50 m & 6 el/m',\
     loc.'0_5_2_above/measurements_spiral.ascii' u 0:($12*1e6) w p ls 1 t 'analytical 0.50 m ',\
     loc.'0_25_above/measurements_spiral.ascii' u 0:($12*1e6) w p ls 2 t 'analytical 0.25 m'
unset multiplot

######################################################################################
set output 'B3sphere_mp_05.eps'
set multiplot layout 1,3
unset key

set ylabel font "times,14" 'B_x [({/Symbol m}T]'
plot loc.'0_5_above/measurements_spiral.ascii' u 0:($7*1e6)w p ls 5 t '0.50 m \& 3 el/m',\
     loc.'0_5_2_above/measurements_spiral.ascii' u 0:($7*1e6) w p ls 6 t '0.50 m \& 6 el/m',\
     loc.'0_5_2_above/measurements_spiral.ascii' u 0:($10*1e6) w p ls 1 t 'analytical 0.50 m '


set ylabel font "times,12" 'B_y [({/Symbol m}T]'
plot loc.'0_5_above/measurements_spiral.ascii' u 0:($8*1e6) w p ls 5 t '0.50 m \& 3 el/m',\
     loc.'0_5_2_above/measurements_spiral.ascii' u 0:($8*1e6) w p ls 6 t '0.50 m \& 6 el/m',\
     loc.'0_25_above/measurements_spiral.ascii' u 0:($11*1e6) w p ls 1 t 'analytical 0.50 m '

set key default font "times,14" box lc 'grey60' opaque fc 'grey90' horizontal top center height 0.5
set ylabel font "times,12" 'B_z [({/Symbol m}T]'
plot loc.'0_5_above/measurements_spiral.ascii' u 0:($9*1e6) w p ls 5 t '0.50 m \& 3 el/m',\
     loc.'0_5_2_above/measurements_spiral.ascii' u 0:($9*1e6)w p ls 6 t '0.50 m \& 6 el/m',\
     loc.'0_5_2_above/measurements_spiral.ascii' u 0:($12*1e6) w p ls 1 t 'analytical 0.50 m '
unset multiplot

######################################################################################
set output 'B3sphere_mp_025.eps'
set multiplot layout 1,3

set ylabel font "times,14" 'B_x [({/Symbol m}T]'

unset key
plot loc.'0_25_above/measurements_spiral.ascii' u 0:($7*1e6) w p ls 3 t '0.25 m \& 3 el/m' ,\
     loc.'0_25_2_above/measurements_spiral.ascii' u 0:($7*1e6) w p ls 4 t '0.25 m \& 6 el/m' ,\
     loc.'0_25_above/measurements_spiral.ascii' u 0:($10*1e6) w p ls 2 t 'analytical 0.25 m'

set ylabel font "times,12" 'B_y [({/Symbol m}T]'
plot loc.'0_25_above/measurements_spiral.ascii' u 0:($8*1e6) w p ls 3 t '0.25 m \& 3 el/m' ,\
     loc.'0_25_2_above/measurements_spiral.ascii' u 0:($8*1e6) w p ls 4 t '0.25 m \& 6 el/m' ,\
     loc.'0_25_above/measurements_spiral.ascii' u 0:($11*1e6) w p ls 2 t 'analytical 0.25 m'

set key default font "times,14" box lc 'grey60' opaque fc 'grey90' horizontal top center height 0.5
set ylabel font "times,12" 'B_z [({/Symbol m}T]'
plot loc.'0_25_above/measurements_spiral.ascii' u 0:($9*1e6) w p ls 3 t '0.25 m \& 3 el/m' ,\
     loc.'0_25_2_above/measurements_spiral.ascii' u 0:($9*1e6) w p ls 4 t '0.25 m \& 6 el/m' ,\
     loc.'0_25_above/measurements_spiral.ascii' u 0:($12*1e6) w p ls 2 t 'analytical 0.25 m'
unset multiplot

######################################################################################

set output 'B3sphere_dif_mag_all.eps'
set autoscale

set ylabel font "times,14" '|{/Symbol D}B| [({/Symbol m}T]'
set key default font "times,14" box lc 'grey60' opaque fc 'grey90' vertical top right
plot loc.'0_25_above/measurements_spiral.ascii' u 0:(sqrt(($10-$7)**2+($11-$8)**2+($12-$9)**2)*1e6) w p ls 3 t '0.25 m \& 3 el/m' ,\
     loc.'0_25_2_above/measurements_spiral.ascii' u 0:(sqrt(($10-$7)**2+($11-$8)**2+($12-$9)**2)*1e6) w p ls 4 t '0.25 m \& 6 el/m',\
     loc.'0_5_above/measurements_spiral.ascii' u 0:(sqrt(($10-$7)**2+($11-$8)**2+($12-$9)**2)*1e6) w p ls 5 t '0.50 m \& 3 el/m',\
     loc.'0_5_2_above/measurements_spiral.ascii' u 0:(sqrt(($10-$7)**2+($11-$8)**2+($12-$9)**2)*1e6) w p ls 6 t '0.50 m \& 6 el/m'

#####################################
set output 'B3sphere_dif_mp_splitcase_all.eps'
set multiplot layout 1,4
set yrange [-5:4]
set ytics -5,1,4
set ylabel font "times,14" '{/Symbol D}B_i [({/Symbol m}T]'


unset key
set title font "times,14" '0.25 m \& 3 el/m' 
plot loc.'0_25_above/measurements_spiral.ascii' u 0:(($10-$7)*1e6) w p ls 4 t '{Bx_{a}-Bx_{c}' ,\
     loc.'0_25_above/measurements_spiral.ascii' u 0:(($11-$8)*1e6) w p ls 3 t '{By_{a}-By_{c}' ,\
     loc.'0_25_above/measurements_spiral.ascii' u 0:(($12-$9)*1e6) w p ls 5 t '{Bz_{a}-Bz_{c}'
set title font "times,14" '0.25 m \& 6 el/m' 
plot loc.'0_25_2_above/measurements_spiral.ascii' u 0:(($10-$7)*1e6) w p ls 4 t '{Bx_{a}-Bx_{c}',\
     loc.'0_25_2_above/measurements_spiral.ascii' u 0:(($11-$8)*1e6) w p ls 3 t '{By_{a}-By_{c}',\
     loc.'0_25_2_above/measurements_spiral.ascii' u 0:(($12-$9)*1e6) w p ls 5 t '{Bz_{a}-Bz_{c}'
set title font "times,14" '0.50 m \& 3 el/m' 
plot loc.'0_5_above/measurements_spiral.ascii' u 0:(($10-$7)*1e6) w p ls 4 t '{Bx_{a}-Bx_{c}',\
     loc.'0_5_above/measurements_spiral.ascii' u 0:(($11-$8)*1e6) w p ls 3 t '{By_{a}-By_{c}',\
     loc.'0_5_above/measurements_spiral.ascii' u 0:(($12-$9)*1e6) w p ls 5 t '{Bz_{a}-Bz_{c}'
set title font "times,14" '0.50 m \& 6 el/m' 
set key default font "times,14" box lc 'grey60' opaque fc 'grey90' vertical top right height 0.5
plot loc.'0_5_2_above/measurements_spiral.ascii' u 0:(($10-$7)*1e6) w p ls 4 t '{Bx_{a}-Bx_{c}',\
     loc.'0_5_2_above/measurements_spiral.ascii' u 0:(($11-$8)*1e6) w p ls 3 t '{By_{a}-By_{c}',\
     loc.'0_5_2_above/measurements_spiral.ascii' u 0:(($12-$9)*1e6) w p ls 5 t '{Bz_{a}-Bz_{c}'

unset multiplot
##################################
set output 'B3sphere_dif_mp_all.eps'
set multiplot layout 1,3

set ylabel font "times,14" '{/Symbol D}B_x [({/Symbol m}T]'
set yrange [-5:5]
set ytics -5,1,5
unset title
unset key
plot loc.'0_25_above/measurements_spiral.ascii' u 0:(($10-$7)*1e6) w p ls 3 t '0.25 m \& 3 el/m' ,\
     loc.'0_25_2_above/measurements_spiral.ascii' u 0:(($10-$7)*1e6) w p ls 4 t '0.25 m \& 6 el/m' ,\
     loc.'0_5_above/measurements_spiral.ascii' u 0:(($10-$7)*1e6) w p ls 5 t '0.50 m \& 3 el/m',\
     loc.'0_5_2_above/measurements_spiral.ascii' u 0:(($10-$7)*1e6) w p ls 6 t '0.50 m \& 6 el/m'

set ylabel font "times,12" '{/Symbol D}B_y [({/Symbol m}T]'
plot loc.'0_25_above/measurements_spiral.ascii' u 0:(($11-$8)*1e6) w p ls 3 t '0.25 m \& 3 el/m' ,\
     loc.'0_25_2_above/measurements_spiral.ascii' u 0:(($11-$8)*1e6) w p ls 4 t '0.25 m \& 6 el/m' ,\
     loc.'0_5_above/measurements_spiral.ascii' u 0:(($11-$8)*1e6) w p ls 5 t '0.50 m \& 3 el/m',\
     loc.'0_5_2_above/measurements_spiral.ascii' u 0:(($11-$8)*1e6) w p ls 6 t '0.50 m \& 6 el/m'
set key default font "times,14" box lc 'grey60' opaque fc 'grey90' vertical top right height 0.5
set ylabel font "times,12" '{/Symbol D}B_z [({/Symbol m}T]'
plot loc.'0_25_above/measurements_spiral.ascii' u 0:(($12-$9)*1e6) w p ls 3 t '0.25 m \& 3 el/m' ,\
    loc.'0_25_2_above/measurements_spiral.ascii' u 0:(($12-$9)*1e6) w p ls 4 t '0.25 m \& 6 el/m' ,\
     loc.'0_5_above/measurements_spiral.ascii' u 0:(($12-$9)*1e6) w p ls 5 t '0.50 m \& 3 el/m',\
     loc.'0_5_2_above/measurements_spiral.ascii' u 0:(($12-$9)*1e6) w p ls 6 t '0.50 m \& 6 el/m'
unset multiplot

########################################################################################################################################

loc = './'
set terminal pngcairo enhanced size 1800,900

set style line 1 pt 1 lw 2 ps 1 lc "black"
set style line 2 pt 2 lw 2 ps 1 lc 'grey20'
set style line 3 pt 7 lw 2 ps 1 lc "royalblue"
set style line 4 pt 5 lw 2 ps 1 lc "web-green" 
set style line 5 pt 9 lw 2 ps 1 lc "orange-red"
set style line 6 pt 11 lw 3 ps 1 lc "gold"

set style line 12 lc 'grey80' dt 2 lw 0.5


set key default font "times,14" box lc 'grey60' opaque fc 'grey90' vertical top right 

set xtics out font "times,14" 
set ytics out font "times,14" 

set grid back ytics ls 12

set xlabel font "times,14" 'index observation point'

######################################################################################
set output 'B3sphere_mp_all.png'
set multiplot layout 1,3

set ylabel font "times,14" 'B_x [{/Symbol m}T]'

set yrange [-5:6]
set ytics -5,1,6

unset key
plot loc.'0_25_above/measurements_spiral.ascii' u 0:($7*1e6) w p ls 3 t '0.25 m \& 3 el/m' ,\
     loc.'0_25_2_above/measurements_spiral.ascii' u 0:($7*1e6) w p ls 4 t '0.25 m \& 6 el/m' ,\
     loc.'0_5_above/measurements_spiral.ascii' u 0:($7*1e6)w p ls 5 t '0.50 m \& 3 el/m',\
     loc.'0_5_2_above/measurements_spiral.ascii' u 0:($7*1e6) w p ls 6 t '0.50 m \& 6 el/m',\
     loc.'0_5_2_above/measurements_spiral.ascii' u 0:($10*1e6) w p ls 1 t 'analytical 0.50 m ',\
     loc.'0_25_above/measurements_spiral.ascii' u 0:($10*1e6) w p ls 2 t 'analytical 0.25 m'

set ylabel font "times,12" 'B_y [({/Symbol m}T]'
plot loc.'0_25_above/measurements_spiral.ascii' u 0:($8*1e6) w p ls 3 t '0.25 m & 3 el/m' ,\
     loc.'0_25_2_above/measurements_spiral.ascii' u 0:($8*1e6) w p ls 4 t '0.25 m \& 6 el/m' ,\
     loc.'0_5_above/measurements_spiral.ascii' u 0:($8*1e6) w p ls 5 t '0.50 m \& 3 el/m',\
     loc.'0_5_2_above/measurements_spiral.ascii' u 0:($8*1e6) w p ls 6 t '0.50 m \& 6 el/m',\
     loc.'0_5_2_above/measurements_spiral.ascii' u 0:($11*1e6) w p ls 1 t 'analytical 0.50 m ',\
     loc.'0_25_above/measurements_spiral.ascii' u 0:($11*1e6) w p ls 2 t 'analytical 0.25 m'


set key default font "times,14" box lc 'grey60' opaque fc 'grey90' horizontal top center height 0.5
set ylabel font "times,12" 'B_z [({/Symbol m}T]'
plot loc.'0_25_above/measurements_spiral.ascii' u 0:($9*1e6) w p ls 3 t '0.25 m & 3 el/m' ,\
     loc.'0_25_2_above/measurements_spiral.ascii' u 0:($9*1e6) w p ls 4 t '0.25 m & 6 el/m' ,\
     loc.'0_5_above/measurements_spiral.ascii' u 0:($9*1e6) w p ls 5 t '0.50 m & 3 el/m',\
     loc.'0_5_2_above/measurements_spiral.ascii' u 0:($9*1e6)w p ls 6 t '0.50 m & 6 el/m',\
     loc.'0_5_2_above/measurements_spiral.ascii' u 0:($12*1e6) w p ls 1 t 'analytical 0.50 m ',\
     loc.'0_25_above/measurements_spiral.ascii' u 0:($12*1e6) w p ls 2 t 'analytical 0.25 m'
unset multiplot

######################################################################################
set output 'B3sphere_mp_05.png'
set multiplot layout 1,3
unset key

set ylabel font "times,14" 'B_x [({/Symbol m}T]'
plot loc.'0_5_above/measurements_spiral.ascii' u 0:($7*1e6)w p ls 5 t '0.50 m \& 3 el/m',\
     loc.'0_5_2_above/measurements_spiral.ascii' u 0:($7*1e6) w p ls 6 t '0.50 m \& 6 el/m',\
     loc.'0_5_2_above/measurements_spiral.ascii' u 0:($10*1e6) w p ls 1 t 'analytical 0.50 m '


set ylabel font "times,12" 'B_y [({/Symbol m}T]'
plot loc.'0_5_above/measurements_spiral.ascii' u 0:($8*1e6) w p ls 5 t '0.50 m \& 3 el/m',\
     loc.'0_5_2_above/measurements_spiral.ascii' u 0:($8*1e6) w p ls 6 t '0.50 m \& 6 el/m',\
     loc.'0_25_above/measurements_spiral.ascii' u 0:($11*1e6) w p ls 1 t 'analytical 0.50 m '

set key default font "times,14" box lc 'grey60' opaque fc 'grey90' horizontal top center height 0.5
set ylabel font "times,12" 'B_z [({/Symbol m}T]'
plot loc.'0_5_above/measurements_spiral.ascii' u 0:($9*1e6) w p ls 5 t '0.50 m \& 3 el/m',\
     loc.'0_5_2_above/measurements_spiral.ascii' u 0:($9*1e6)w p ls 6 t '0.50 m \& 6 el/m',\
     loc.'0_5_2_above/measurements_spiral.ascii' u 0:($12*1e6) w p ls 1 t 'analytical 0.50 m '
unset multiplot

######################################################################################
set output 'B3sphere_mp_025.png'
set multiplot layout 1,3

set ylabel font "times,14" 'B_x [({/Symbol m}T]'

unset key
plot loc.'0_25_above/measurements_spiral.ascii' u 0:($7*1e6) w p ls 3 t '0.25 m \& 3 el/m' ,\
     loc.'0_25_2_above/measurements_spiral.ascii' u 0:($7*1e6) w p ls 4 t '0.25 m \& 6 el/m' ,\
     loc.'0_25_above/measurements_spiral.ascii' u 0:($10*1e6) w p ls 2 t 'analytical 0.25 m'

set ylabel font "times,12" 'B_y [({/Symbol m}T]'
plot loc.'0_25_above/measurements_spiral.ascii' u 0:($8*1e6) w p ls 3 t '0.25 m \& 3 el/m' ,\
     loc.'0_25_2_above/measurements_spiral.ascii' u 0:($8*1e6) w p ls 4 t '0.25 m \& 6 el/m' ,\
     loc.'0_25_above/measurements_spiral.ascii' u 0:($11*1e6) w p ls 2 t 'analytical 0.25 m'

set key default font "times,14" box lc 'grey60' opaque fc 'grey90' horizontal top center height 0.5
set ylabel font "times,12" 'B_z [({/Symbol m}T]'
plot loc.'0_25_above/measurements_spiral.ascii' u 0:($9*1e6) w p ls 3 t '0.25 m \& 3 el/m' ,\
     loc.'0_25_2_above/measurements_spiral.ascii' u 0:($9*1e6) w p ls 4 t '0.25 m \& 6 el/m' ,\
     loc.'0_25_above/measurements_spiral.ascii' u 0:($12*1e6) w p ls 2 t 'analytical 0.25 m'
unset multiplot

######################################################################################

set output 'B3sphere_dif_mag_all.png'
set autoscale

set ylabel font "times,14" '|{/Symbol D}B| [({/Symbol m}T]'
set key default font "times,14" box lc 'grey60' opaque fc 'grey90' vertical top right
plot loc.'0_25_above/measurements_spiral.ascii' u 0:(sqrt(($10-$7)**2+($11-$8)**2+($12-$9)**2)*1e6) w p ls 3 t '0.25 m \& 3 el/m' ,\
     loc.'0_25_2_above/measurements_spiral.ascii' u 0:(sqrt(($10-$7)**2+($11-$8)**2+($12-$9)**2)*1e6) w p ls 4 t '0.25 m \& 6 el/m',\
     loc.'0_5_above/measurements_spiral.ascii' u 0:(sqrt(($10-$7)**2+($11-$8)**2+($12-$9)**2)*1e6) w p ls 5 t '0.50 m \& 3 el/m',\
     loc.'0_5_2_above/measurements_spiral.ascii' u 0:(sqrt(($10-$7)**2+($11-$8)**2+($12-$9)**2)*1e6) w p ls 6 t '0.50 m \& 6 el/m'

#####################################
set output 'B3sphere_dif_mp_splitcase_all.png'
set multiplot layout 1,4
set yrange [-5:4]
set ytics -5,1,4
set ylabel font "times,14" '{/Symbol D}B_i [({/Symbol m}T]'


unset key
set title font "times,14" '0.25 m \& 3 el/m' 
plot loc.'0_25_above/measurements_spiral.ascii' u 0:(($10-$7)*1e6) w p ls 4 t '{Bx_{a}-Bx_{c}' ,\
     loc.'0_25_above/measurements_spiral.ascii' u 0:(($11-$8)*1e6) w p ls 3 t '{By_{a}-By_{c}' ,\
     loc.'0_25_above/measurements_spiral.ascii' u 0:(($12-$9)*1e6) w p ls 5 t '{Bz_{a}-Bz_{c}'
set title font "times,14" '0.25 m \& 6 el/m' 
plot loc.'0_25_2_above/measurements_spiral.ascii' u 0:(($10-$7)*1e6) w p ls 4 t '{Bx_{a}-Bx_{c}',\
     loc.'0_25_2_above/measurements_spiral.ascii' u 0:(($11-$8)*1e6) w p ls 3 t '{By_{a}-By_{c}',\
     loc.'0_25_2_above/measurements_spiral.ascii' u 0:(($12-$9)*1e6) w p ls 5 t '{Bz_{a}-Bz_{c}'
set title font "times,14" '0.50 m \& 3 el/m' 
plot loc.'0_5_above/measurements_spiral.ascii' u 0:(($10-$7)*1e6) w p ls 4 t '{Bx_{a}-Bx_{c}',\
     loc.'0_5_above/measurements_spiral.ascii' u 0:(($11-$8)*1e6) w p ls 3 t '{By_{a}-By_{c}',\
     loc.'0_5_above/measurements_spiral.ascii' u 0:(($12-$9)*1e6) w p ls 5 t '{Bz_{a}-Bz_{c}'
set title font "times,14" '0.50 m \& 6 el/m' 
set key default font "times,14" box lc 'grey60' opaque fc 'grey90' vertical top right height 0.5
plot loc.'0_5_2_above/measurements_spiral.ascii' u 0:(($10-$7)*1e6) w p ls 4 t '{Bx_{a}-Bx_{c}',\
     loc.'0_5_2_above/measurements_spiral.ascii' u 0:(($11-$8)*1e6) w p ls 3 t '{By_{a}-By_{c}',\
     loc.'0_5_2_above/measurements_spiral.ascii' u 0:(($12-$9)*1e6) w p ls 5 t '{Bz_{a}-Bz_{c}'

unset multiplot
##################################
set output 'B3sphere_dif_mp_all.png'
set multiplot layout 1,3

set ylabel font "times,14" '{/Symbol D}B_x [({/Symbol m}T]'
set yrange [-5:5]
set ytics -5,1,5
unset title
unset key
plot loc.'0_25_above/measurements_spiral.ascii' u 0:(($10-$7)*1e6) w p ls 3 t '0.25 m \& 3 el/m' ,\
     loc.'0_25_2_above/measurements_spiral.ascii' u 0:(($10-$7)*1e6) w p ls 4 t '0.25 m \& 6 el/m' ,\
     loc.'0_5_above/measurements_spiral.ascii' u 0:(($10-$7)*1e6) w p ls 5 t '0.50 m \& 3 el/m',\
     loc.'0_5_2_above/measurements_spiral.ascii' u 0:(($10-$7)*1e6) w p ls 6 t '0.50 m \& 6 el/m'

set ylabel font "times,12" '{/Symbol D}B_y [({/Symbol m}T]'
plot loc.'0_25_above/measurements_spiral.ascii' u 0:(($11-$8)*1e6) w p ls 3 t '0.25 m \& 3 el/m' ,\
     loc.'0_25_2_above/measurements_spiral.ascii' u 0:(($11-$8)*1e6) w p ls 4 t '0.25 m \& 6 el/m' ,\
     loc.'0_5_above/measurements_spiral.ascii' u 0:(($11-$8)*1e6) w p ls 5 t '0.50 m \& 3 el/m',\
     loc.'0_5_2_above/measurements_spiral.ascii' u 0:(($11-$8)*1e6) w p ls 6 t '0.50 m \& 6 el/m'
set key default font "times,14" box lc 'grey60' opaque fc 'grey90' vertical top right height 0.5
set ylabel font "times,12" '{/Symbol D}B_z [({/Symbol m}T]'
plot loc.'0_25_above/measurements_spiral.ascii' u 0:(($12-$9)*1e6) w p ls 3 t '0.25 m \& 3 el/m' ,\
    loc.'0_25_2_above/measurements_spiral.ascii' u 0:(($12-$9)*1e6) w p ls 4 t '0.25 m \& 6 el/m' ,\
     loc.'0_5_above/measurements_spiral.ascii' u 0:(($12-$9)*1e6) w p ls 5 t '0.50 m \& 3 el/m',\
     loc.'0_5_2_above/measurements_spiral.ascii' u 0:(($12-$9)*1e6) w p ls 6 t '0.50 m \& 6 el/m'
unset multiplot






