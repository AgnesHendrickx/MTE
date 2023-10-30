loc1 = './d0/measurements_plane.ascii'
loc2 = './d0_1/measurements_plane.ascii'
loc3 = './d0_1_2_10_50/measurements_plane.ascii'
set terminal epscairo enhanced size 10,5


set style line 1 lw 2 lc "black"
set style line 2 lw 1 lc 'grey40'
set style line 3 pt 7 lw 3 ps 0.6 lc "royalblue"
set style line 4 pt 5 lw 2 ps 0.4 lc "web-green" 
set style line 5 pt 9 lw 3 ps 0.5 lc "orange-red"
set style line 6 pt 11 ps 2 lw 2 lc "gold"

set style line 12 lc 'grey80' dt 2 lw 0.5


set key default font "times,14" box lc 'grey60' opaque fc 'grey90' vertical top right height 0.5

set xtics out font "times,14" 
set ytics out font "times,14" 

set xlabel font "times,14" 'index observation point'
set ylabel font "times,14" 'B_z [{/Symbol m}T]'

##############################
set output 'B2difference_3D_mag.eps'

set autoscale xy
set dgrid3d 20,20
set hidden3d offset 0
set style data lines

set ticslevel 0.2

#set format z "%.0e"
#set zrange[-5e-9:3e-9]

set xtics font "times,14" offset -0.2,-0.2
set ytics font "times,14"
set ztics font "times,14" 

set xlabel font "times,14" 'x-coordinate [m]' offset -0.5,-0.5
set ylabel font "times,14" 'y-coordinate [m]'
set zlabel font "times,14" '|B| [{/Symbol m}T]' offset -4,0


splot '< exec bash -c "paste <(cat ./d0/measurements_plane.ascii) <(head -n 200 ./d0_1/measurements_plane.ascii)"' u 1:2:((sqrt($16**2+$17**2+$18**2)-sqrt($7**2+$8**2+$9**2))*1e6) w lp ls 3 t "setup 1 - base",\
      '< exec bash -c "paste <(cat ./d0/measurements_plane.ascii) <(head -n 200 ./d0_1_2_10_50/measurements_plane.ascii)"' u 1:2:((sqrt($16**2+$17**2+$18**2)-sqrt($7**2+$8**2+$9**2))*1e6) w lp ls 4 t "setup 2 - base"

##############################
set terminal epscairo size 15,5
set output 'B2difference_3D_mp.eps'
set multiplot layout 1,3
set autoscale xy
set format z "%.0e"
set zlabel font "times,14" 'B_x [{/Symbol m}T]' offset 3,9

set size 0.33,1
unset key

splot '< exec bash -c "paste <(cat ./d0/measurements_plane.ascii) <(head -n 200 ./d0_1/measurements_plane.ascii)"' u 1:2:(($16-$7)*1e6) w lp ls 3 t "setup 1 - base",\
      '< exec bash -c "paste <(cat ./d0/measurements_plane.ascii) <(head -n 200 ./d0_1_2_10_50/measurements_plane.ascii)"' u 1:2:(($16-$7)*1e6) w lp ls 4 t "setup 2 - base"


set autoscale y
set key default font "times,14" box lc 'grey60' opaque fc 'grey90' vertical top right height 0.5
set size 0.33,1
set zlabel font "times,14" 'B_y [{/Symbol m}T]' offset 3,9
splot '< exec bash -c "paste <(cat ./d0/measurements_plane.ascii) <(head -n 200 ./d0_1/measurements_plane.ascii)"' u 1:2:(($17-$8)*1e6) w lp ls 3 t "setup 1 - base",\
      '< exec bash -c "paste <(cat ./d0/measurements_plane.ascii) <(head -n 200 ./d0_1_2_10_50/measurements_plane.ascii)"' u 1:2:(($17-$8)*1e6) w lp ls 4 t "setup 2 - base" 


unset key
set size 0.33,1
set zlabel font "times,14" 'B_z [{/Symbol m}T]' offset 3,9
splot '< exec bash -c "paste <(cat ./d0/measurements_plane.ascii) <(head -n 200 ./d0_1/measurements_plane.ascii)"' u 1:2:(($18-$9)*1e6) w lp ls 3 t "setup 1 - base",\
      '< exec bash -c "paste <(cat ./d0/measurements_plane.ascii) <(head -n 200 ./d0_1_2_10_50/measurements_plane.ascii)"' u 1:2:(($18-$9)*1e6) w lp ls 4 t "setup 2 - base" 

unset multiplot

##########################################################################################
set terminal pngcairo size 1000,500


set style line 1 lw 2 lc "black"
set style line 2 lw 1 lc 'grey40'
set style line 3 pt 7 lw 3 ps 1 lc "royalblue"
set style line 4 pt 5 lw 2 ps 1 lc "web-green" 
set style line 5 pt 9 lw 3 ps 1 lc "orange-red"
set style line 6 pt 11 ps 2 lw 2 lc "gold"

set style line 12 lc 'grey80' dt 2 lw 0.5

set key default
set key font "times,14" box lc 'grey60' opaque fc 'grey90' vertical top right height 0.5

set xtics out font "times,14" 
set ytics out font "times,14" 

set xlabel font "times,14" 'index observation point'
set ylabel font "times,14" 'B_z [{/Symbol m}T]'

##############################
set output 'B2difference_3D_mag.png'

set autoscale xy
set dgrid3d 20,20
set hidden3d offset 0
set style data lines

set ticslevel 0.2

#set format z "%.0e"
#set zrange[-5e-9:3e-9]

set xtics font "times,14" offset -0.2,-0.2
set ytics font "times,14"
set ztics font "times,14" 
set xlabel font "times,14" 'x-coordinate [m]' offset -0.5,-0.5
set ylabel font "times,14" 'y-coordinate [m]'
set zlabel font "times,14" '|B| [{/Symbol m}T]' offset -2.8,1.2

splot '< exec bash -c "paste <(cat ./d0/measurements_plane.ascii) <(head -n 200 ./d0_1/measurements_plane.ascii)"' u 1:2:((sqrt($16**2+$17**2+$18**2)-sqrt($7**2+$8**2+$9**2))*1e6) w lp ls 3 t "setup 1 - base",\
      '< exec bash -c "paste <(cat ./d0/measurements_plane.ascii) <(head -n 200 ./d0_1_2_10_50/measurements_plane.ascii)"' u 1:2:((sqrt($16**2+$17**2+$18**2)-sqrt($7**2+$8**2+$9**2))*1e6) w lp ls 4 t "setup 2 - base"

##############################
set terminal pngcairo size 1500,500
set output 'B2difference_3D_mp.png'
set multiplot layout 1,3
set autoscale xy
set format z "%.0e"

set zlabel font "times,14" 'B_x [{/Symbol m}T]' offset 4,6.5
set size 0.33,1
unset key
splot '< exec bash -c "paste <(cat ./d0/measurements_plane.ascii) <(head -n 200 ./d0_1/measurements_plane.ascii)"' u 1:2:(($16-$7)*1e6) w lp ls 3 t "setup 1 - base",\
      '< exec bash -c "paste <(cat ./d0/measurements_plane.ascii) <(head -n 200 ./d0_1_2_10_50/measurements_plane.ascii)"' u 1:2:(($16-$7)*1e6) w lp ls 4 t "setup 2 - base"

set autoscale y
set key default font "times,14" box lc 'grey60' opaque fc 'grey90' vertical top right height 0.5
set size 0.33,1
set zlabel font "times,14" 'B_y [{/Symbol m}T]' offset 4,6.5
splot '< exec bash -c "paste <(cat ./d0/measurements_plane.ascii) <(head -n 200 ./d0_1/measurements_plane.ascii)"' u 1:2:(($17-$8)*1e6) w lp ls 3 t "setup 1 - base",\
      '< exec bash -c "paste <(cat ./d0/measurements_plane.ascii) <(head -n 200 ./d0_1_2_10_50/measurements_plane.ascii)"' u 1:2:(($17-$8)*1e6) w lp ls 4 t "setup 2 - base" 

unset key
set size 0.33,1
set zlabel font "times,14" 'B_z [{/Symbol m}T]' offset 4,6.5
splot '< exec bash -c "paste <(cat ./d0/measurements_plane.ascii) <(head -n 200 ./d0_1/measurements_plane.ascii)"' u 1:2:(($18-$9)*1e6) w lp ls 3 t "setup 1 - base",\
      '< exec bash -c "paste <(cat ./d0/measurements_plane.ascii) <(head -n 200 ./d0_1_2_10_50/measurements_plane.ascii)"' u 1:2:(($18-$9)*1e6) w lp ls 4 t "setup 2 - base" 

unset multiplot

