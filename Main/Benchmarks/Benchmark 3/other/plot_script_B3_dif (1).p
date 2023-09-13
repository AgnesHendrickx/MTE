loc = '/home/agnes/MTE/fieldstone_138/Benchmark 3/'
set terminal pngcairo size 1800,900
set output 'B3sphere_dif.png'
#set log xy
#set pointsize 0.5
set autoscale xy
#set xrange [0.01:0.25]
#set yrange [45:65]
#set format y "%.0e"
set key default
set key box opaque

set style line 1 lw 2 lc "grey40"
set style line 2 lw 3 lc rgb '#e69f00' dt (50,4,2,4)
set style line 3 lw 3 lc rgb '#d55e00' dt (50,4,2,4)
set style line 4 pt 3 lw 2 lc rgb '#0072b2'
set style line 5 pt 4 lw 2 lc rgb '#009e73' 
set style line 6 pt 5 lw 2 lc rgb '#cc79a7'
set style line 7 pt 6 lw 2 lc rgb '#f0e442'

($10*1e-7-$7)*1e6
($11*1e-7-$8)*1e6
($12*1e-7-$9)*1e6

#(sqrt(($10*1e-7-$7)**2+($11*1e-7-$8)**2+($12*1e-7-$9)**2)*1e6) t '{/Symbol D}B_i ({/Symbol m}T)'
#(($11*1e-7-$8)*1e6) t '{/Symbol D}B_i ({/Symbol m}T)'
#(($12*1e-7-$9)*1e6) t '{/Symbol D}B_i ({/Symbol m}T)'

#set xtics 0,0.5,2

#       In_si[i]=sqrt(($7)*2+($8)**2+($9)**2)
#       Ic_si[i]=np.arctan2(-B_si[2,i],np.sqrt(B_si[1,i]**2+B_si[0,i]**2))/pi*180
#       Dc_si[i]=np.arctan2(B_si[0,i],B_si[1,i])/np.pi*180   

set title font "courier,16"  'sphere benchmark, fibonacci spiral' 
set xlabel font "courier,12" 'point ID'
set ylabel font "courier,12" '{/Symbol D}B_i ({/Symbol m}T)'
plot loc.'0_25_above/measurements_spiral.ascii' u 0:(sqrt(($10*1e-7-$7)**2+($11*1e-7-$8)**2+($12*1e-7-$9)**2)*1e6) w p ps 3 pt 1 lc rgb '#cc79a7' t '25 cm & 3 el/m' ,\
     loc.'0_5_above/measurements_spiral.ascii' u 0:(sqrt(($10*1e-7-$7)**2+($11*1e-7-$8)**2+($12*1e-7-$9)**2)*1e6) w p ps 3 pt 2 lc rgb '#0072b2' t '50 cm & 3 el/m',\
     loc.'0_5_2_above/measurements_spiral.ascii' u 0:(sqrt(($10*1e-7-$7)**2+($11*1e-7-$8)**2+($12*1e-7-$9)**2)*1e6) w p ps 3 pt 3 lc rgb '#009e73' t '50 cm & 6 el/m'

#0:sqrt(($7)*2+($8)**2+($9)**2)




