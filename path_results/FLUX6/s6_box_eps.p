loc1 = './results_5m_site6_path1_sdem4_ho1_fb_zt/measurements_path_plotfile2.ascii'

loc2 = './results_5m_site6_path1_sdem4_ho1_fb_zt_noise_1/measurements_path_plotfile.ascii'
loc3 = './results_5m_site6_path1_sdem4_ho1_fb_zt_noise_2/measurements_path_plotfile.ascii'

loc4 = './results_5m_site6_path1_sdem4_ho1_fb_zt_mag_1/measurements_path_plotfile.ascii'
loc5 = './results_5m_site6_path1_sdem4_ho1_fb_zt_mag_20/measurements_path_plotfile.ascii'

loc6 = './results_5m_site6_path1_sdem4_ho1_fb_zt_mag_20_noise_2/measurements_path_plotfile.ascii'


set terminal epscairo enhanced size 16cm,22cm

set style line 1 pt 2 lw 3 ps 0.5 lc 'grey20' dt 2
set style fill transparent solid 0.15 noborder
set style line 2 lw 1.5 lc "steelblue"
set style line 3 lw 1.5 lc rgb '#CD5C5C'
set style line 4 pt 7 ps 1.5 lw 4 lc "red"
set style line 5 pt 5 ps 1.5 lw 4 lc "royalblue"
set style line 12 lc 'grey80' dt 2 lw 0.5
set style line 6 pt 11 lw 4 ps 1.5 lc "web-green"

set key default font "times,14" box lc 'grey60' opaque vertical top right height 0.5 width 1.5

set xtics out font "times,12" offset 0,0.5
set ytics out font "times,12" offset 0.5
set y2tics out font "times,12" offset -1
set grid back ytics ls 12

set autoscale xy
set ytics nomirror


set xlabel font "times,12" 'distance [m]' offset 0,1.2
set ylabel font "times,12" 'B_z [{/Symbol m}T]'
set y2label font "times,12" 'height surface [m]' rotate by 90+180 offset -2.8
set format y "%.0f"

set y2tics 1528,4
set y2range[1534:1558]

set label 1 'S' front at graph -0.02,-0.05 font "times,16"
set label 2 'N' front at graph 0.98,-0.05 font "times,16"
set datafile missing '0.00000000000000000'
set rmargin 6.8
set lmargin 5.5
set tmargin 0.5
set bmargin 2.3

#################################################################################################
sh=0
set xrange [sh:291-sh]

set output 's6_mp_ztr.eps'
set yrange[*:*]
set multiplot layout 3,1
unset key

set ylabel font "times,12" 'intensity [{/Symbol m}T]' offset 1
plot loc1 u ($4+sh):($5-1) w filledc x1 ls 2 t "DEM"  axis x1y2,\
     loc1 u ($4):($9) w filledc x1 ls 3 t "field topo" axis x1y2,\
     loc1 u ($4+sh):($1*1e6) w l ls 1 t "IGRF" axis x1y1,\
     loc1 u ($4+sh):($6*1e6) w l ls 5 t "DEM + IGRF" axis x1y1,\
     loc1 u ($4):10 w l ls 4 t "field data" axis x1y1
unset key
set ylabel font "times,12" 'inclination [{/Symbol \260}]' offset 1
plot loc1 u ($4+sh):($5-1) w filledc x1 ls 2 t "DEM"  axis x1y2,\
     loc1 u ($4):($9) w filledc x1 ls 3 t "field topo" axis x1y2,\
     loc1 u ($4+sh):2 w l ls 1 t "IGRF" axis x1y1,\
     loc1 u ($4+sh):7 w l ls 5 t "DEM + IGRF" axis x1y1,\
     loc1 u ($4):11 w l ls 4 t "field data" axis x1y1

set key at graph 0,0 bottom left font "times,12" height 0 width 1.5

set yrange[-15:10]
set ylabel font "times,12" 'declination [{/Symbol \260}]' offset 2
plot loc1 u ($4+sh):($5-1) w filledc x1 ls 2 t "DEM"  axis x1y2,\
     loc1 u ($4):($9) w filledc x1 ls 3 t "field topo" axis x1y2,\
     loc1 u ($4+sh):3 w l ls 1 t "IGRF" axis x1y1,\
     loc1 u ($4+sh):8 w l ls 5 t "DEM + IGRF" axis x1y1,\
     loc1 u ($4):12 w l ls 4 t "field data" axis x1y1
unset multiplot

#################################################################################################
sh=5
set xrange [sh:291]

set output 's6_mp_ztr_sh.eps'
set yrange[*:*]
set multiplot layout 3,1
unset key


set ylabel font "times,12" 'intensity [{/Symbol m}T]' offset 1
plot loc1 u ($4+sh):($5-1) w filledc x1 ls 2 t "DEM"  axis x1y2,\
     loc1 u ($4):($9) w filledc x1 ls 3 t "field topo" axis x1y2,\
     loc1 u ($4+sh):($1*1e6) w l ls 1 t "IGRF" axis x1y1,\
     loc1 u ($4+sh):($6*1e6) w l ls 5 t "DEM + IGRF" axis x1y1,\
     loc1 u ($4):10 w l ls 4 t "field data" axis x1y1

set autoscale y
set ytics auto
unset key
set ylabel font "times,12" 'inclination [{/Symbol \260}]' offset 1
plot loc1 u ($4+sh):($5-1) w filledc x1 ls 2 t "DEM"  axis x1y2,\
     loc1 u ($4):($9) w filledc x1 ls 3 t "field topo" axis x1y2,\
     loc1 u ($4+sh):2 w l ls 1 t "IGRF" axis x1y1,\
     loc1 u ($4+sh):7 w l ls 5 t "DEM + IGRF" axis x1y1,\
     loc1 u ($4):11 w l ls 4 t "field data" axis x1y1

set key at graph 0,0 bottom left font "times,12" height 0 width 1.5
set yrange[-15:10]
set ylabel font "times,12" 'declination [{/Symbol \260}]' offset 2
plot loc1 u ($4+sh):($5-1) w filledc x1 ls 2 t "DEM"  axis x1y2,\
     loc1 u ($4):($9) w filledc x1 ls 3 t "field topo" axis x1y2,\
     loc1 u ($4+sh):3 w l ls 1 t "IGRF" axis x1y1,\
     loc1 u ($4+sh):8 w l ls 5 t "DEM + IGRF" axis x1y1,\
     loc1 u ($4):12 w l ls 4 t "field data" axis x1y1


unset multiplot

#################################################################################################
