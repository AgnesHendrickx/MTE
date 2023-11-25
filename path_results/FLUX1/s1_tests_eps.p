
loc1 = './results_5m_site1_path1_sdem2_ho1_fb_zt/measurements_path_plotfile.ascii'
loc7 = './results_5m_site1_path1_sdem1_ho1_fb_zt/measurements_path_plotfile.ascii'
loc8 = './results_5m_site1_path1_sdem3_ho1_fb_zt/measurements_path_plotfile.ascii'

loc2 = './results_5m_site1_path1_sdem2_ho2_fb_zt/measurements_path_plotfile.ascii'
loc3 = './results_5m_site1_path1_sdem2_ho1_fb_zt_mag_1/measurements_path_plotfile.ascii'
loc4 = './results_5m_site1_path1_sdem2_ho1_fb_zt_mag_20/measurements_path_plotfile.ascii'
loc5 = './results_5m_site1_path1_sdem2_ho1_fb_zt_noise_1/measurements_path_plotfile.ascii'
loc6 = './results_5m_site1_path1_sdem2_ho1_fb_zt_noise_2/measurements_path_plotfile.ascii'

loc7 = './results_5m_site1_path1_sdem1_ho1_fb_zt/measurements_path_plotfile.ascii'
loc8 = './results_5m_site1_path1_sdem3_ho1_fb_zt/measurements_path_plotfile.ascii'

loc9 = './results_2m_site1_path1_sdem5_ho1_fb_zt/measurements_path_plotfile.ascii'
loc10 = './results_2m_site1_path1_sdem5_ho2_fb_zt/measurements_path_plotfile.ascii'

set terminal pngcairo size 1200,900

set style line 1 pt 2 lw 3 ps 0.5 lc 'grey20' dt 2

set style fill transparent solid 0.15 noborder
set style line 2 lw 1.5 lc "black"
set style line 3 lw 1.5 lc "grey50"
set style line 2 lw 1.5 lc "steelblue"
set style line 20 lc "cyan" dt (2,2,2,2)
set style line 3 lw 1.5 lc rgb '#CD5C5C'
set style line 30 lw 1.5 lc "magenta" dt (2,2,2,2)

set style line 4 pt 7 ps 1.5 lw 4 lc "red"
set style line 12 pt 6 ps 1.5 lw 3 lc "coral" dt 4
set style line 5 pt 5 ps 1.5 lw 4 lc "royalblue"
set style line 15 pt 4 ps 1.5 lw 3 lc "steelblue" dt 4
set style line 15 pt 4 ps 1.5 lw 3 lc rgb '#20B2AA' dt 4
set style line 4 pt 7 lw 4 ps 1.5 lc "red" dt (2,2,2,2)
set style line 5 pt 7 lw 4 ps 4 lc "royalblue"  dt (2,2,2,2)
set style line 6 pt 5 lw 5 ps 4 lc "web-green"
set style line 7 pt 9 lw 5 ps 4 lc "magenta"
set style line 8 pt 11 lw 5 ps 4 lc "gold"
set style line 9 pt 11 lw 5 ps 4 lc "cyan"




set style line 12 lc 'grey80' dt 2 lw 0.5

set key default font "times,16" box lc 'grey60' opaque vertical top right height 0.5 width 1.5

set xtics out font "times,12" offset 0,0.5
set ytics out font "times,12" offset 0.5
set y2tics out font "times,12" offset -1
set grid back ytics ls 12

set autoscale xy
set ytics nomirror

set xlabel font "times,12" 'distance [m]' offset 0,1.2
set ylabel font "times,12" 'B_z [{/Symbol m}T]' offset 1
set y2label font "times,12" 'height surface [m]' rotate by 90+180 offset -2.8

set format y "%.0f"

set y2tics 1600,2
set y2range[1611:1619]
#set y2range[1612:1620]
#set y2range[1609:1612]

set label 1 'SW' front at graph -0.02,-0.05 font "times,16"
set label 2 'NE' front at graph 0.98,-0.05 font "times,16"

set datafile missing '0.00000000000000000'
sh=3

set rmargin 6.8
set lmargin 5.5
set tmargin 0.5
set bmargin 2.3
#################################################################################################
################################################
set terminal epscairo enhanced size 16cm,22cm
set xrange [sh:65.8]

set output 's1p1_mp_ztr_sh_tests_mag.eps'
set yrange[*:*]
set multiplot layout 3,1
#unset title
unset key
set ylabel font "times,12" 'intensity [{/Symbol m}T]' offset 1
plot loc1 u ($4+sh):($5-1) w filledc x1 ls 2 t "DEM"  axis x1y2,\
     loc1 u ($4):($9) w filledc x1 ls 3 t "1m, field topo" axis x1y2,\
     loc1 u ($4+sh):($1*1e6) w l ls 1 t "IGRF" axis x1y1,\
     loc1 u ($4+sh):($6*1e6) w l ls 5 t "1m, DEM + IGRF" axis x1y1,\
     loc3 u ($4+sh):($6*1e6) w l ls 6 t "mag 1, 1m, DEM + IGRF" axis x1y1,\
     loc4 u ($4+sh):($6*1e6) w l ls 7 t "mag 20, 1m, DEM + IGRF" axis x1y1,\
     loc1 u ($4):10 w l ls 4 t "1m, field data" axis x1y1


set ylabel font "times,12" 'inclination [{/Symbol \260}]' offset 1
plot loc1 u ($4+sh):($5-1) w filledc x1 ls 2 t "DEM"  axis x1y2,\
     loc1 u ($4):($9) w filledc x1 ls 3 t "1m, field topo" axis x1y2,\
     loc1 u ($4+sh):2 w l ls 1 t "IGRF" axis x1y1,\
     loc1 u ($4+sh):7 w l ls 5 t "1m, DEM + IGRF" axis x1y1,\
     loc3 u ($4+sh):7 w l ls 6 t "mag 1, 1m, DEM + IGRF" axis x1y1,\
     loc4 u ($4+sh):7 w l ls 7 t "mag 20, 1m, DEM + IGRF" axis x1y1,\
     loc1 u ($4):11 w l ls 4 t "1m, field data" axis x1y1

set key at graph 1,0 bottom right font "times,12" height 0 width 0.5

set ylabel font "times,12" 'declination [{/Symbol \260}]' offset 1
plot loc1 u ($4+sh):($5-1) w filledc x1 ls 2 t "DEM"  axis x1y2,\
     loc1 u ($4):($9) w filledc x1 ls 3 t "field topo" axis x1y2,\
     loc1 u ($4+sh):3 w l ls 1 t "IGRF" axis x1y1,\
     loc1 u ($4+sh):8 w l ls 5 t "DEM + IGRF" axis x1y1,\
     loc3 u ($4+sh):8 w l ls 6 t "mag 1, DEM + IGRF" axis x1y1,\
     loc4 u ($4+sh):8 w l ls 7 t "mag 20, DEM + IGRF" axis x1y1,\
     loc1 u ($4):12 w l ls 4 t "1m, field data" axis x1y1

unset multiplot
#################################################################################################

set terminal epscairo enhanced size 16cm,22cm
set xrange [sh:65.8]

set output 's1p1_mp_ztr_sh_tests_noise.eps'
set yrange[*:*]
set multiplot layout 3,1
#unset title
unset key
set ylabel font "times,12" 'intensity [{/Symbol m}T]' offset 1
plot loc1 u ($4+sh):($5-1) w filledc x1 ls 2 t "DEM"  axis x1y2,\
     loc1 u ($4):($9) w filledc x1 ls 3 t "1m, field topo" axis x1y2,\
     loc1 u ($4+sh):($1*1e6) w l ls 1 t "IGRF" axis x1y1,\
     loc1 u ($4+sh):($6*1e6) w l ls 5 t "1m, DEM + IGRF" axis x1y1,\
     loc5 u ($4+sh):($6*1e6) w l ls 8 t "noise 1, 1m, DEM + IGRF" axis x1y1,\
     loc6 u ($4+sh):($6*1e6) w l ls 9 t "noise 2, 1m, DEM + IGRF" axis x1y1,\
     loc1 u ($4):10 w l ls 4 t "1m, field data" axis x1y1


set ylabel font "times,12" 'inclination [{/Symbol \260}]' offset 1
plot loc1 u ($4+sh):($5-1) w filledc x1 ls 2 t "DEM"  axis x1y2,\
     loc1 u ($4):($9) w filledc x1 ls 3 t "1m, field topo" axis x1y2,\
     loc1 u ($4+sh):2 w l ls 1 t "IGRF" axis x1y1,\
     loc1 u ($4+sh):7 w l ls 5 t "1m, DEM + IGRF" axis x1y1,\
     loc5 u ($4+sh):7 w l ls 8 t "noise 1, 1m, DEM + IGRF" axis x1y1,\
     loc6 u ($4+sh):7 w l ls 9 t "noise 2, 1m, DEM + IGRF" axis x1y1,\
     loc1 u ($4):11 w l ls 4 t "1m, field data" axis x1y1

set key at graph 0,1 top left font "times,12" height 0 width 0.5
set ylabel font "times,12" 'declination [{/Symbol \260}]' offset 1
plot loc1 u ($4+sh):($5-1) w filledc x1 ls 2 t "DEM"  axis x1y2,\
     loc1 u ($4):($9) w filledc x1 ls 3 t "1m, field topo" axis x1y2,\
     loc1 u ($4+sh):3 w l ls 1 t "IGRF" axis x1y1,\
     loc1 u ($4+sh):8 w l ls 5 t "1m, DEM + IGRF" axis x1y1,\
     loc5 u ($4+sh):8 w l ls 8 t "noise 1, 1m, DEM + IGRF" axis x1y1,\
     loc6 u ($4+sh):8 w l ls 9 t "noise 2, 1m, DEM + IGRF" axis x1y1,\
     loc1 u ($4):12 w l ls 4 t "1m, field data" axis x1y1

unset multiplot
################################################

set terminal epscairo enhanced size 16cm,22cm
set xrange [sh:65.8]

set output 's1p1_mp_ztr_sh_extest.eps'
set yrange[*:*]
set multiplot layout 3,1
#unset title

set key font "times,12" at graph 0,1 top left width 0.5 height 0.3
set ylabel font "times,12" 'intensity [{/Symbol m}T]'
plot loc1 u ($4+sh):($5-1) w filledc x1 ls 2 t "DEM"  axis x1y2,\
     loc1 u ($4):($9) w filledc x1 ls 3 t "1m, field topo" axis x1y2,\
     loc1 u ($4+sh):($1*1e6) w l ls 1 t "IGRF" axis x1y1,\
     loc7 u ($4+sh):($6*1e6) w l ls 7 t "1m, DEM 2000 + IGRF" axis x1y1,\
     loc1 u ($4+sh):($6*1e6) w l ls 5 t "1m, DEM 300 + IGRF" axis x1y1,\
     loc8 u ($4+sh):($6*1e6) w l ls 6 t "1m, DEM 200 + IGRF" axis x1y1,\
     loc1 u ($4):10 w l ls 4 t "1m, field data" axis x1y1
unset key
set ylabel font "times,12" 'inclination [{/Symbol \260}]'
plot loc1 u ($4+sh):($5-1) w filledc x1 ls 2 t "DEM"  axis x1y2,\
     loc1 u ($4):($9) w filledc x1 ls 3 t "1m, field topo" axis x1y2,\
     loc1 u ($4+sh):2 w l ls 1 t "IGRF" axis x1y1,\
     loc7 u ($4+sh):7 w l ls 7 t "1m, DEM 2000 + IGRF" axis x1y1,\
     loc1 u ($4+sh):7 w l ls 5 t "1m, DEM 300 + IGRF" axis x1y1,\
     loc8 u ($4+sh):7 w l ls 6 t "1m, DEM 200 + IGRF" axis x1y1,\
     loc1 u ($4):11 w l ls 4 t "1m, field data" axis x1y1


set yrange[-4:7]
set ylabel font "times,12" 'declination [{/Symbol \260}]'
plot loc1 u ($4+sh):($5-1) w filledc x1 ls 2 t "DEM"  axis x1y2,\
     loc1 u ($4):($9) w filledc x1 ls 3 t "1m, field topo" axis x1y2,\
     loc1 u ($4+sh):3 w l ls 1 t "IGRF" axis x1y1,\
     loc7 u ($4+sh):8 w l ls 7 t "1m, DEM 2000 + IGRF" axis x1y1,\
     loc1 u ($4+sh):8 w l ls 5 t "1m, DEM 300 + IGRF" axis x1y1,\
     loc8 u ($4+sh):8 w l ls 6 t "1m, DEM 200 + IGRF" axis x1y1,\
     loc1 u ($4):12 w l ls 4 t "1m, field data" axis x1y1
unset multiplot

set terminal epscairo enhanced size 16cm,22cm

set rmargin 6.8
set lmargin 5.5
set tmargin 0.5
set bmargin 2.3

set xrange [sh:65.8]
set format y "%.2f"

set output 's1p1_mp_ztr_sh_extest_dif.eps'
set yrange[*:*]
set multiplot layout 3,1
#unset title

set key font "times,12" at graph 0,1 top left width 0.5 height 0.3
set ylabel font "times,12" 'intensity [{/Symbol m}T]'
plot loc1 u ($4+sh):($5-1) w filledc x1 ls 2 t "DEM"  axis x1y2,\
     '< exec bash -c "paste <(cat ./results_5m_site1_path1_sdem2_ho1_fb_zt/measurements_path_plotfile.ascii) <(head -n 200 ./results_5m_site1_path1_sdem1_ho1_fb_zt/measurements_path_plotfile.ascii) <(head -n 200 ./results_5m_site1_path1_sdem3_ho1_fb_zt/measurements_path_plotfile.ascii)"' u ($4+sh):(($20*1e6)-((($20*1e6)+($6*1e6)+($34*1e6))/3)) w l ls 7 t "1m, DEM 2000 + IGRF" axis x1y1,\
     '< exec bash -c "paste <(cat ./results_5m_site1_path1_sdem2_ho1_fb_zt/measurements_path_plotfile.ascii) <(head -n 200 ./results_5m_site1_path1_sdem1_ho1_fb_zt/measurements_path_plotfile.ascii) <(head -n 200 ./results_5m_site1_path1_sdem3_ho1_fb_zt/measurements_path_plotfile.ascii)"' u ($4+sh):(($6*1e6)-((($20*1e6)+($6*1e6)+($34*1e6))/3)) w l ls 5 t "1m, DEM 300 + IGRF" axis x1y1,\
     '< exec bash -c "paste <(cat ./results_5m_site1_path1_sdem2_ho1_fb_zt/measurements_path_plotfile.ascii) <(head -n 200 ./results_5m_site1_path1_sdem1_ho1_fb_zt/measurements_path_plotfile.ascii) <(head -n 200 ./results_5m_site1_path1_sdem3_ho1_fb_zt/measurements_path_plotfile.ascii)"' u ($4+sh):(($34*1e6)-((($20*1e6)+($6*1e6)+($34*1e6))/3)) w l ls 6 t "1m, DEM 200 + IGRF" axis x1y1

unset key
set ylabel font "times,12" 'inclination [{/Symbol \260}]'
plot loc1 u ($4+sh):($5-1) w filledc x1 ls 2 t "DEM"  axis x1y2,\
     '< exec bash -c "paste <(cat ./results_5m_site1_path1_sdem2_ho1_fb_zt/measurements_path_plotfile.ascii) <(head -n 200 ./results_5m_site1_path1_sdem1_ho1_fb_zt/measurements_path_plotfile.ascii) <(head -n 200 ./results_5m_site1_path1_sdem3_ho1_fb_zt/measurements_path_plotfile.ascii)"' u ($4+sh):($21-(($21+$7+$35)/3)) w l ls 7 t "1m, DEM 2000 + IGRF" axis x1y1,\
     '< exec bash -c "paste <(cat ./results_5m_site1_path1_sdem2_ho1_fb_zt/measurements_path_plotfile.ascii) <(head -n 200 ./results_5m_site1_path1_sdem1_ho1_fb_zt/measurements_path_plotfile.ascii) <(head -n 200 ./results_5m_site1_path1_sdem3_ho1_fb_zt/measurements_path_plotfile.ascii)"' u ($4+sh):($7-(($21+$7+$35)/3)) w l ls 5 t "1m, DEM 300 + IGRF" axis x1y1,\
     '< exec bash -c "paste <(cat ./results_5m_site1_path1_sdem2_ho1_fb_zt/measurements_path_plotfile.ascii) <(head -n 200 ./results_5m_site1_path1_sdem1_ho1_fb_zt/measurements_path_plotfile.ascii) <(head -n 200 ./results_5m_site1_path1_sdem3_ho1_fb_zt/measurements_path_plotfile.ascii)"' u ($4+sh):($35-(($21+$7+$35)/3)) w l ls 6 t "1m, DEM 200 + IGRF" axis x1y1

set ylabel font "times,12" 'declination [{/Symbol \260}]'
plot loc1 u ($4+sh):($5-1) w filledc x1 ls 2 t "DEM"  axis x1y2,\
     '< exec bash -c "paste <(cat ./results_5m_site1_path1_sdem2_ho1_fb_zt/measurements_path_plotfile.ascii) <(head -n 200 ./results_5m_site1_path1_sdem1_ho1_fb_zt/measurements_path_plotfile.ascii) <(head -n 200 ./results_5m_site1_path1_sdem3_ho1_fb_zt/measurements_path_plotfile.ascii)"' u ($4+sh):($22-(($22+$8+$36)/3)) w l ls 7 t "1m, DEM 2000 + IGRF" axis x1y1,\
     '< exec bash -c "paste <(cat ./results_5m_site1_path1_sdem2_ho1_fb_zt/measurements_path_plotfile.ascii) <(head -n 200 ./results_5m_site1_path1_sdem1_ho1_fb_zt/measurements_path_plotfile.ascii) <(head -n 200 ./results_5m_site1_path1_sdem3_ho1_fb_zt/measurements_path_plotfile.ascii)"' u ($4+sh):($8-(($22+$8+$36)/3)) w l ls 5 t "1m, DEM 300 + IGRF" axis x1y1,\
     '< exec bash -c "paste <(cat ./results_5m_site1_path1_sdem2_ho1_fb_zt/measurements_path_plotfile.ascii) <(head -n 200 ./results_5m_site1_path1_sdem1_ho1_fb_zt/measurements_path_plotfile.ascii) <(head -n 200 ./results_5m_site1_path1_sdem3_ho1_fb_zt/measurements_path_plotfile.ascii)"' u ($4+sh):($36-(($22+$8+$36)/3)) w l ls 6 t "1m, DEM 200 + IGRF" axis x1y1
unset multiplot


#################################################################################################
set format y "%.0f"

set terminal epscairo enhanced size 16cm,10cm
set xrange [sh:65.8]

set xtics out font "times,11" offset 0,0.5
set ytics out font "times,11" offset 0.5
set y2tics out font "times,11" offset -1
set grid back ytics ls 12


set ytics nomirror

set xlabel font "times,11" 'distance [m]' offset 0,1.2
set y2label font "times,11" 'height surface [m]' rotate by 90+180 offset -3.3


set label 1 'SW' front at graph -0.02,-0.10 font "times,12"
set label 2 'NE' front at graph 0.98,-0.10 font "times,12"

unset key

set output 's1p1_mp_ztr_sh_extest_block.eps'
set yrange[*:*]
set multiplot layout 2,2
set rmargin 5.8
set lmargin 5.5
set tmargin 0.5
set bmargin 2.3

#unset title

set ylabel font "times,12" 'intensity [{/Symbol m}T]' offset 1.2
plot loc1 u ($4+sh):($5-1) w filledc x1 ls 2 t "DEM"  axis x1y2,\
     loc1 u ($4):($9) w filledc x1 ls 3 t "1m, field topo" axis x1y2,\
     loc1 u ($4+sh):($1*1e6) w l ls 1 t "IGRF" axis x1y1,\
     loc7 u ($4+sh):($6*1e6) w l ls 7 t "1m, DEM 2000 + IGRF" axis x1y1,\
     loc1 u ($4+sh):($6*1e6) w l ls 5 t "1m, DEM 300 + IGRF" axis x1y1,\
     loc8 u ($4+sh):($6*1e6) w l ls 6 t "1m, DEM 200 + IGRF" axis x1y1,\
     loc1 u ($4):10 w l ls 4 t "1m, field data" axis x1y1
unset key
set ylabel font "times,12" 'inclination [{/Symbol \260}]' offset 1.2
plot loc1 u ($4+sh):($5-1) w filledc x1 ls 2 t "DEM"  axis x1y2,\
     loc1 u ($4):($9) w filledc x1 ls 3 t "1m, field topo" axis x1y2,\
     loc1 u ($4+sh):2 w l ls 1 t "IGRF" axis x1y1,\
     loc7 u ($4+sh):7 w l ls 7 t "1m, DEM 2000 + IGRF" axis x1y1,\
     loc1 u ($4+sh):7 w l ls 5 t "1m, DEM 300 + IGRF" axis x1y1,\
     loc8 u ($4+sh):7 w l ls 6 t "1m, DEM 200 + IGRF" axis x1y1,\
     loc1 u ($4):11 w l ls 4 t "1m, field data" axis x1y1

set key font "times,12" box lc 'grey60' opaque at screen 0.75,screen 0.25 center center height 0.5 width 0.5

set yrange[-4:7]
set ylabel font "times,12" 'declination [{/Symbol \260}]' offset 1.8
plot loc1 u ($4+sh):($5-1) w filledc x1 ls 2 t "DEM"  axis x1y2,\
     loc1 u ($4):($9) w filledc x1 ls 3 t "1m, field topo" axis x1y2,\
     loc1 u ($4+sh):3 w l ls 1 t "IGRF" axis x1y1,\
     loc7 u ($4+sh):8 w l ls 7 t "1m, DEM 2000 + IGRF" axis x1y1,\
     loc1 u ($4+sh):8 w l ls 5 t "1m, DEM 300 + IGRF" axis x1y1,\
     loc8 u ($4+sh):8 w l ls 6 t "1m, DEM 200 + IGRF" axis x1y1,\
     loc1 u ($4):12 w l ls 4 t "1m, field data" axis x1y1
unset multiplot
#################################################################################################

set style line 12 lc 'grey80' dt 2 lw 0.5

set key default font "times,16" box lc 'grey60' opaque vertical top right height 0.5 width 1.5

set xtics out font "times,12"
set ytics out font "times,12"
set y2tics out font "times,12"
set grid back ytics ls 12

set autoscale xy
set ytics nomirror

set xlabel font "times,12" 'distance [m]'
set ylabel font "times,12" 'B_z [{/Symbol m}T]'
set y2label font "times,12" 'height surface [m]'

set format y "%.0f"

set y2tics 1600,2
set y2range[1611:1619]

set label 1 'SW' front at graph -0.02,-0.1 font "times,20"
set label 2 'NE' front at graph 0.98,-0.1 font "times,20"

set datafile missing '0.00000000000000000'
sh=3

set style fill transparent pattern 11 noborder

set output 's1p1_mp_ztr_sh_DEMtest.eps'
set yrange[*:*]
set multiplot layout 3,1
#unset title

set key top left font "times,12"
set ylabel font "times,12" 'intensity [{/Symbol m}T]'
plot loc1 u ($4+sh):($5-1) w filledc x1 ls 2 t "5m DEM"  axis x1y2,\
     loc9 u ($4+sh):($5-1) w filledc x1 ls 30 t "2m DEM"  axis x1y2,\
     loc1 u ($4):($9) w filledc x1 ls 3 t "1m, field topo" axis x1y2,\
     loc1 u ($4+sh):($1*1e6) w l ls 1 t "IGRF" axis x1y1,\
     loc1 u ($4+sh):($6*1e6) w l ls 5 t "1m, DEM 5m + IGRF" axis x1y1,\
     loc9 u ($4+sh):($6*1e6) w l ls 6 t "1m, DEM 2m + IGRF" axis x1y1,\
     loc1 u ($4):10 w l ls 4 t "1m, field data" axis x1y1

unset key
set ylabel font "times,12" 'inclination [{/Symbol \260}]'
plot loc1 u ($4+sh):($5-1) w filledc x1 ls 2 t "DEM"  axis x1y2,\
     loc9 u ($4+sh):($5-1) w filledc x1 ls 30 t "2m DEM"  axis x1y2,\
     loc1 u ($4):($9) w filledc x1 ls 3 t "1m, field topo" axis x1y2,\
     loc1 u ($4+sh):2 w l ls 1 t "IGRF" axis x1y1,\
     loc1 u ($4+sh):7 w l ls 5 t "1m, DEM 5m + IGRF" axis x1y1,\
     loc9 u ($4+sh):7 w l ls 6 t "1m, DEM 2m + IGRF" axis x1y1,\
     loc1 u ($4):11 w l ls 4 t "1m, field data" axis x1y1


set yrange[-4:7]
set ylabel font "times,12" 'declination [{/Symbol \260}]'
plot loc1 u ($4+sh):($5-1) w filledc x1 ls 2 t "DEM"  axis x1y2,\
     loc9 u ($4+sh):($5-1) w filledc x1 ls 30 t "2m DEM"  axis x1y2,\
     loc1 u ($4):($9) w filledc x1 ls 3 t "1m, field topo" axis x1y2,\
     loc1 u ($4+sh):3 w l ls 1 t "IGRF" axis x1y1,\
     loc1 u ($4+sh):8 w l ls 5 t "1m, DEM 5m + IGRF" axis x1y1,\
     loc9 u ($4+sh):8 w l ls 6 t "1m, DEM 2m + IGRF" axis x1y1,\
     loc1 u ($4):12 w l ls 4 t "1m, field data" axis x1y1
unset multiplot
#################################################################################################

set label 1 'SW' front at graph -0.05,-0.2 font "times,20"
set label 2 'NE' front at graph 0.95,-0.2 font "times,20"

set terminal epscairo enhanced size 8cm,6cm
set output 's1p1_topos.eps'
set yrange[*:*]
set y2range[*:*]
set autoscale xy
set ylabel font "times,12" 'height surface [m]'

unset y2label
unset y2tics

#unset title
set xrange[sh:63]
set yrange[1611:1620]
set ytics 1600,2
set key top left font "times,12" width -2.5 height 0.4
plot loc1 u ($4+sh):($5-1) w l ls 2 lw 3 t "5m DEM",\
     loc9 u ($4+sh):($5-1) w l ls 20 lw 3 t "2m DEM",\
     loc1 u ($4):($9) w l ls 3 lw 3 t "1m, field topo",\
     loc2 u ($4):($9) w l ls 30 lw 3 t "1.8m, field topo"

#################################################################################################
