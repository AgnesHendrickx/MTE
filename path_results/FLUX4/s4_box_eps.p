loc5 = './results_5m_site4_path1_sdem2_ho1_fb_zt/measurements_path_plotfile.ascii'
loc6 = './results_5m_site4_path1_sdem2_ho2_fb_zt/measurements_path_plotfile.ascii'
loc3 = './results_5m_site4_path2_sdem2_ho1_fb_zt/measurements_path_plotfile.ascii'
loc4 = './results_5m_site4_path2_sdem2_ho2_fb_zt/measurements_path_plotfile.ascii'
loc1 = './results_5m_site4_path3_sdem2_ho1_fb_zt/measurements_path_plotfile.ascii'
loc2 = './results_5m_site4_path3_sdem2_ho2_fb_zt/measurements_path_plotfile.ascii'

set style line 1 pt 2 lw 3 ps 0.5 lc 'grey20' dt 2

set style fill transparent solid 0.15 noborder
set style line 2 lw 1.5 lc "black"
set style line 3 lw 1.5 lc "grey50"
set style line 2 lw 1.5 lc "steelblue"
set style line 3 lw 1.5 lc rgb '#CD5C5C'

set style line 4 pt 7 ps 1.5 lw 4 lc "red"
set style line 14 pt 6 ps 1.5 lw 3 lc "coral" dt 4
set style line 5 pt 5 ps 1.5 lw 4 lc "royalblue"
set style line 15 pt 4 ps 1.5 lw 3 lc "steelblue" dt 4
set style line 15 pt 4 ps 1.5 lw 3 lc rgb '#20B2AA' dt 4

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

set y2tics 1530,2


set label 1 'S' front at graph -0.02,-0.15 font "times,20"
set label 2 'N' front at graph 0.98,-0.15 font "times,20"

set datafile missing '0.00000000000000000'

#################################################################################################
set terminal epscairo enhanced size 16cm,22cm
set yrange[*:*]
sh=5
set y2range[1540:1556]
set xrange [sh:72.5]

set output 's4p3_mp_ztr_sh.eps'
set yrange[*:*]
set multiplot layout 3,1
#unset title
unset key
set ylabel font "times,12" 'intensity [{/Symbol m}T]'
plot loc1 u ($4+sh):($5-1) w filledc x1 ls 2 t "DEM"  axis x1y2,\
     loc1 u ($4):($9) w filledc x1 ls 3 t "1m, field topo" axis x1y2,\
     loc1 u ($4+sh):($1*1e6) w l ls 1 t "IGRF" axis x1y1,\
     loc1 u ($4+sh):($6*1e6) w l ls 5 t "1m, DEM + IGRF" axis x1y1,\
     loc2 u ($4+sh):($6*1e6) w l ls 15 t "1.8m, DEM + IGRF" axis x1y1,\
     loc1 u ($4):10 w l ls 4 t "1m, field data" axis x1y1,\
     loc2 u ($4):10 w l ls 14 t "1.8m, field data" axis x1y1

set key top left font "times,11"
set ylabel font "times,12" 'inclination [{/Symbol \260}]'
plot loc1 u ($4+sh):($5-1) w filledc x1 ls 2 t "DEM"  axis x1y2,\
     loc1 u ($4):($9) w filledc x1 ls 3 t "1m, field topo" axis x1y2,\
     loc1 u ($4+sh):2 w l ls 1 t "IGRF" axis x1y1,\
     loc1 u ($4+sh):7 w l ls 5 t "1m, DEM + IGRF" axis x1y1,\
     loc2 u ($4+sh):7 w l ls 15 t "1.8m, DEM + IGRF" axis x1y1,\
     loc1 u ($4):11 w l ls 4 t "1m, field data" axis x1y1,\
     loc2 u ($4):11 w l ls 14 t "1.8m, field data" axis x1y1
unset key
set yrange[-7:6]
set ylabel font "times,12" 'declination [{/Symbol \260}]'
plot loc1 u ($4+sh):($5-1) w filledc x1 ls 2 t "DEM"  axis x1y2,\
     loc1 u ($4):($9) w filledc x1 ls 3 t "1m, field topo" axis x1y2,\
     loc1 u ($4+sh):3 w l ls 1 t "IGRF" axis x1y1,\
     loc1 u ($4+sh):8 w l ls 5 t "1m, DEM + IGRF" axis x1y1,\
     loc2 u ($4+sh):8 w l ls 15 t "1.8m, DEM + IGRF" axis x1y1,\
     loc1 u ($4):12 w l ls 4 t "1m, field data" axis x1y1,\
     loc2 u ($4):12 w l ls 14 t "1.8m, field data" axis x1y1
unset multiplot
#################################################################################################
set terminal epscairo enhanced size 16cm,22cm
set yrange[*:*]
sh=0
set y2range[1540:1556]
set xrange [sh:72.5]


set output 's4p3_mp_ztr.eps'
set yrange[*:*]
set multiplot layout 3,1
#unset title

unset key
set ylabel font "times,12" 'intensity [{/Symbol m}T]'
plot loc1 u ($4+sh):($5-1) w filledc x1 ls 2 t "DEM"  axis x1y2,\
     loc1 u ($4):($9) w filledc x1 ls 3 t "1m, field topo" axis x1y2,\
     loc1 u ($4+sh):($1*1e6) w l ls 1 t "IGRF" axis x1y1,\
     loc1 u ($4+sh):($6*1e6) w l ls 5 t "1m, DEM + IGRF" axis x1y1,\
     loc2 u ($4+sh):($6*1e6) w l ls 15 t "1.8m, DEM + IGRF" axis x1y1,\
     loc1 u ($4):10 w l ls 4 t "1m, field data" axis x1y1,\
     loc2 u ($4):10 w l ls 14 t "1.8m, field data" axis x1y1

set ylabel font "times,12" 'inclination [{/Symbol \260}]'
plot loc1 u ($4+sh):($5-1) w filledc x1 ls 2 t "DEM"  axis x1y2,\
     loc1 u ($4):($9) w filledc x1 ls 3 t "1m, field topo" axis x1y2,\
     loc1 u ($4+sh):2 w l ls 1 t "IGRF" axis x1y1,\
     loc1 u ($4+sh):7 w l ls 5 t "1m, DEM + IGRF" axis x1y1,\
     loc2 u ($4+sh):7 w l ls 15 t "1.8m, DEM + IGRF" axis x1y1,\
     loc1 u ($4):11 w l ls 4 t "1m, field data" axis x1y1,\
     loc2 u ($4):11 w l ls 14 t "1.8m, field data" axis x1y1

set key top center horizontal font "times,11" width 0
set yrange[-7:6]
set ylabel font "times,12" 'declination [{/Symbol \260}]'
plot loc1 u ($4+sh):($5-1) w filledc x1 ls 2 t "DEM"  axis x1y2,\
     loc1 u ($4):($9) w filledc x1 ls 3 t "1m, field topo" axis x1y2,\
     loc1 u ($4+sh):3 w l ls 1 t "IGRF" axis x1y1,\
     loc1 u ($4+sh):8 w l ls 5 t "1m, DEM + IGRF" axis x1y1,\
     loc2 u ($4+sh):8 w l ls 15 t "1.8m, DEM + IGRF" axis x1y1,\
     loc1 u ($4):12 w l ls 4 t "1m, field data" axis x1y1,\
     loc2 u ($4):12 w l ls 14 t "1.8m, field data" axis x1y1
unset multiplot