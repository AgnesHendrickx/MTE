set terminal pngcairo size 1800,900
set output 'B3sphere.png'
#set log xy
set pointsize 0.5
set autoscale xy
#set xrange [0.01:0.25]
#set yrange [45:65]
#set format y "%.0e"


#set xtics 0,0.5,2

       In_si[i]=sqrt(($7)*2+($8)**2+($9)**2)
       Ic_si[i]=np.arctan2(-B_si[2,i],np.sqrt(B_si[1,i]**2+B_si[0,i]**2))/pi*180
       Dc_si[i]=np.arctan2(B_si[0,i],B_si[1,i])/np.pi*180   

set title font "courier,16"  'sphere benchmark' 
set xlabel font "courier,12" 'point ID'
set ylabel font "courier,12" 'Bx ({/Symbol m}T)'
plot 'measurements_spiral.ascii' u 0:(($7*1e7)) w lp lw 2 ps 0.2 lc "coral" t 'computed' ,\
'measurements_spiral.ascii' u 0:10 w lp lw 2 lc "green" ps 0.2 t 'analytical' 

0:sqrt(($7)*2+($8)**2+($9)**2)




