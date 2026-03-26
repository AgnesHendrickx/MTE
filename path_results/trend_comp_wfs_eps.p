
loc10 = "./FLUX6/results_5m_site6_path1_sdem4_ho1_fb_zt/measurements_path_plotfile2.ascii"
loc5 = "./FLUX5/results_5m_site5_path3_sdem2_ho1_fb_zt/measurements_path_plotfile.ascii"

loc7 = "../flanksim_parameters/east/250_250_20_fb/measurements_line_plotfile.ascii"
loc13 = "../flanksim_parameters/south/250_250_20_25cm/measurements_line_plotfile.ascii"

set terminal epscairo enhanced font "Times New Roman,13" size 16cm,22cm

set style line 1 pt 2 lw 2 ps 0.5 lc "grey20" dt 2
set style line 1 pt 2 lw 1.5 ps 0.5 lc "grey20" dt 2

set style fill transparent solid 0.15 noborder
set style line 2 lw 1.5 lc "steelblue"
set style line 3 lw 1.5 lc rgb "#CD5C5C"
set style line 4 pt 7 ps 1.5 lw 2 lc "red"
set style line 24 pt 9 dt 2 ps 1.5 lw 3 lc "coral"


set style line 5 pt 5 ps 1.5 lw 2 lc "royalblue"
set style line 25 pt 3 dt 2 ps 1.5 lw 3 lc "dark-cyan"

set style line 12 lc "grey80" dt 2 lw 0.5
set style line 6 pt 11 lw 2 ps 1.5 lc "web-green"

set key default font "Times New Roman,13" box lc "grey60" opaque vertical top right height 0.5 width 1.5

set xtics out font "Times New Roman,13" offset 0,0.5
set ytics out font "Times New Roman,13" offset 0.5
set y2tics out font "Times New Roman,13" offset -1
set grid back ytics ls 12

set autoscale xy
set ytics nomirror


set xlabel font "Times New Roman,13" 'distance [m]' offset 0,1.2
set ylabel font "Times New Roman,13" 'B_z [{/Symbol m}T]'
set y2label font "Times New Roman,13" 'height surface [m]' rotate by 90+180 offset -2.4
set format y "%.0f"


set datafile missing '0.00000000000000000'
set rmargin 6.8
set lmargin 5
set tmargin 0.5
set bmargin 2.3


set terminal epscairo enhanced font "Times New Roman,13" size 16cm,22cm


set key default font "Times New Roman,13" box lc "grey60" opaque vertical top right height 0.5 width 1.5

set xtics out font "Times New Roman,13"
set ytics out font "Times New Roman,13"
set y2tics out font "Times New Roman,13"
set grid back ytics ls 12

set autoscale xy
set ytics nomirror

set xlabel font "Times New Roman,13" 'distance [m]' offset 0,1
set ylabel font "Times New Roman,13" 'B_z [μT]'
set y2label font "Times New Roman,13" 'height surface [m]'

set format y "%.0f"

set y2tics 1600,2

set label 1 'W' front at graph -0.02,-0.15 font "Times New Roman,20"
set label 2 'E' front at graph 0.98,-0.15 font "Times New Roman,20"

set datafile missing '0.00000000000000000'
#################################################################################################

#################################################################################################
set terminal pdfcairo enhanced size 16cm,12cm

set label 1 'S' front at graph -0.02,-0.1 font "Times New Roman,16"
set label 2 'N' front at graph 0.98,-0.1 font "Times New Roman,16"
sh=5
set y2tics 1528,4
set y2range[1534:1548]
set xrange [sh:291]
set output 'trend_comp_wfs.pdf'
set yrange[*:*]
set xrange [225:255]
set multiplot layout 2,3
set border front
#set style fill transparent solid 0.15 noborder
unset key
set xtics 0,10
set ytics 39,2
set yrange [39:49]
unset grid
set bmargin 2.6
set rmargin 7.2
set lmargin 5.5

#set label 3 'F6' front at graph 1,1 font "Times New Roman,13"
set label 4 'a)' front at graph 0.03,0.96 font "Times New Roman,16"


set key bottom left at graph 0,0 font "Times New Roman,10" width -0.4
set ylabel font "Times New Roman,13" 'intensity [μT]' offset 0.8
plot loc10 u ($4+sh):($5-1) w filledc x1 ls 2 t "DEM"  axis x1y2,\
     loc10 u ($4):($9) w filledc x1 ls 3 t "fld topo" axis x1y2,\
     loc10 u ($4+sh):($1*1e6) w l ls 1 t "IGRF" axis x1y1,\
     loc10 u ($4+sh):($6*1e6) w l ls 5 t "model" axis x1y1,\
     loc10 u ($4):10 w l ls 4 t "field" axis x1y1

set label 4 'b)' front at graph 0.03,0.96 font "Times New Roman,16"

set autoscale y
set ytics auto
unset key
#set key bottom right at graph 1,0 font "Times New Roman,10" width -0.4
set ylabel font "Times New Roman,13" 'inclination [{/Symbol \260}]' offset 1
plot loc10 u ($4+sh):($5-1) w filledc x1 ls 2 t "DEM"  axis x1y2,\
     loc10 u ($4):($9) w filledc x1 ls 3 t "fld topo" axis x1y2,\
     loc10 u ($4+sh):2 w l ls 1 t "IGRF" axis x1y1,\
     loc10 u ($4+sh):7 w l ls 5 t "model" axis x1y1,\
     loc10 u ($4):11 w l ls 4 t "field" axis x1y1

#set label 3 'F1' front at graph 1,1 font "Times New Roman,13"
set label 4 'c)' front at graph 0.03,0.96 font "Times New Roman,16"


set label 1 'W' front at graph -0.02,-0.1 font "Times New Roman,16"
set label 2 'E' front at graph 0.98,-0.1 font "Times New Roman,16"

sh=2
set y2tics 1528,2
set y2range[1812:1820]
set xrange [5+sh:26.5-sh]
#set key bottom right font "Times New Roman,10"
set yrange[-12:12]
set ylabel font "Times New Roman,13" 'declination [{/Symbol \260}]' offset 3
plot loc5 u 4:3 w l ls 1 t "IGRF" axis x1y1,\
     loc5 u ($4+sh):($5-1) w  filledc x1 ls 2 t "DEM" axis x1y2,\
     loc5 u 4:9 w  filledc x1 ls 3 t "fld topo" axis x1y2,\
     loc5 u ($4+sh):8 w l ls 5 t "model" axis x1y1,\
     loc5 u 4:12 w l ls 4 t "field" axis x1y1

set label 1 'S' front at graph -0.02,-0.1 font "Times New Roman,16"
set label 2 'N' front at graph 0.98,-0.1 font "Times New Roman,16"

#set label 3 'FS' front at graph 1,1 font "Times New Roman,13"
set label 4 'd)' front at graph 0.03,0.96 font "Times New Roman,16"


set xrange[116:145]
set xtics 100,10
set y2range[-6:6]
set y2tics -6,2
set yrange [42:48]
set ytics 42,2
set y2label font "Times New Roman,13" 'height surface [m]' rotate by 90+180 offset -1.8

set key bottom left at graph 0,0 font "Times New Roman,10" width 0.7
set ylabel font "Times New Roman,13" 'intensity [μT]' offset 0.8
plot loc7 u 2:($4*1e6) w l ls 1 t "IGRF" axis x1y1,\
     loc7 u 2:($3-1) w filledc x1 ls 1 t "topo" axis x1y2,\
     loc7 u 2:($7*1e6) w l ls 6 t "flksm" axis x1y1
set label 4 'e)' front at graph 0.03,0.96 font "Times New Roman,16"

unset key
set yrange [49:57]
set ytics 49,2
set ylabel font "Times New Roman,13" 'inclination [{/Symbol \260}]' offset 1
plot loc7 u 2:5 w l ls 1 t "IGRF" axis x1y1,\
     loc7 u 2:($3-1) w filledc x1 ls 1 t "topo" axis x1y2,\
     loc7 u 2:8 w l ls 6 t "flksm" axis x1y1



set label 1 'W' front at graph -0.02,-0.11 font "Times New Roman,16"
set label 2 'E' front at graph 0.98,-0.11 font "Times New Roman,16"
set xrange[108:130]
set label 4 'f)' front at graph 0.03,0.96 font "Times New Roman,16"

#set key bottom right at graph 1,0 font "Times New Roman,10" width 0.7
set yrange [-3:10]
set ytics -4,2
set ylabel font "Times New Roman,13" 'declination [{/Symbol \260}]' offset 2
plot loc13 u 1:6 w l ls 1 t "IGRF" axis x1y1,\
     loc13 u 1:($3-1) w filledc x1 ls 1 t "topo" axis x1y2,\
     loc13 u 1:9 w l ls 6 t "flksm" axis x1y1




