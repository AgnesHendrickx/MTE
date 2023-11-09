loc1 = './252_r12_r2_afx5_afy12_s2/measurements_path_plotfile.ascii'
loc2 = './252_r12_r2_afx5_afy12_s2_180/measurements_path_plotfile.ascii'
loc3 = './252_r12_r2_afx5_afy12_s2_noise_nf1/measurements_path_plotfile.ascii'
loc4 = './252_r12_r2_afx5_afy12_s2_noise_nf1_180/measurements_path_plotfile.ascii'

set terminal pngcairo size 1800,1200

set style line 1 pt 1 lw 2 ps 0.5 lc "black"
set style line 2 pt 2 lw 1 ps 0.5 lc 'grey20' dt 2
set style line 20 pt 2 lw 1 ps 0.5 lc 'sienna4' dt 2
set style line 3 pt 7 lw 3 ps 1.5 lc "royalblue"
set style line 4 pt 5 lw 3 ps 1 lc "web-green" 
set style line 5 pt 9 lw 3 ps 1.5 lc "orange-red"
set style line 6 pt 11 lw 3 ps 1.5 lc "gold"

set style line 30 pt 6 lw 2 ps 1.2 lc "skyblue"
set style line 40 pt 4 lw 2 ps 0.5 lc "light-green" 
set style line 50 pt 8 lw 2 ps 1 lc "salmon"
set style line 60 pt 10 lw 2 ps 1 lc "sienna4"

set style line 14 pt 7 ps 2 lw 2 lc 'light-green'
set style line 144 pt 6 ps 2 lw 2 lc 'web-green' 
set style line 1444 pt 7 ps 0.5 lw 2 lc 'dark-green'
set style line 14444 pt 6 ps 0.5 lw 2 lc 'olive'
set style line 144444 pt 7 ps 1 lw 2 dt 1 lc 'sienna4'

set style line 17 pt 13 ps 2 lw 2 lc 'slategray'
set style line 177 pt 12 ps 2 lw 2 lc 'steelblue'
set style line 1777 pt 11 ps 1.5 lw 2 lc 'skyblue'
set style line 17777 pt 10 ps 1.5 lw 2 lc 'web-blue'
set style line 177777 pt 9 ps 1.5 lw 2 lc 'royalblue'
set style line 1777777 pt 8 ps 1.5 lw 2 lc 'medium-blue'
set style line 17777777 pt 11 ps 2.5 lw 2 lc 'midnight-blue'
set style line 177777777 pt 10 ps 2.5 lw 2 lc 'cyan'
set style line 1777777777 pt 9 ps 2 lw 2 lc 'aquamarine'
set style line 17777777777 pt 6 lw 2 lc 'dark-turquoise'

set style line 15 pt 5 ps 0.5 lw 8 lc 'salmon'
set style line 155 pt 5 ps 0.5 lw 8 lc 'orange'
set style line 1555 pt 5 ps 2 lw 2 lc 'red'
set style line 15555 pt 4 ps 2 lw 2 lc 'magenta'
set style line 155555 pt 2 ps 2 lw 2 lc 'purple'
set style line 1555555 pt 3 ps 2 lw 2 lc 'orchid4'

set style line 12 lc 'grey80' dt 2 lw 0.5

set key default font "times,14" box lc 'grey60' opaque fc 'grey90' vertical top right height 0.5 width 0.5

set xtics out font "times,14"
set ytics out font "times,14"
set y2tics out font "times,14"
set grid back ytics ls 12

set autoscale xy
set ytics nomirror

set xlabel font "times,14" 'distance (m)'
set ylabel font "times,14" 'intensity [{/Symbol m}T]'
set y2label font "times,14" 'height surface [m]'

set format y "%.0f"

set xrange[0:30.5]
set y2range[182:198]
set y2tics 162,4

set label 1 'NW' front at graph -0.02,-0.12 font "times,20"
set label 2 'SE' front at graph 0.98,-0.12 font "times,20"

#################################################################################################
set format y "%.1f"
set output 'art_DEM_int_noise.png'
set ylabel font "times,14" 'intensity [{/Symbol m}T]'
plot loc1 u 4:($1*1e6) w l ls 1 t "IGRF int" axis x1y1,\
     loc1 u ($4):($5-1) w l ls 2 t "surface 2m art DEM" axis x1y2,\
     loc1 u ($4):($6*1e6) w l ls 3 t "2m 250 DEM + IGRF -h:100" axis x1y1,\
     loc3 u ($4):($6*1e6) w l ls 4 t "Noise nf1, 2m 250 DEM + IGRF -h:100" axis x1y1,\
     loc2 u ($4):($6*1e6) w l ls 30 t "2m 250 DEM + IGRF -h:180" axis x1y1,\
     loc4 u ($4):($6*1e6) w l ls 40 t "Noise nf1, 2m 250 DEM + IGRF -h:180" axis x1y1

set format y "%.0f"
set output 'art_DEM_ic_noise.png'
set ylabel font "times,14" 'inclination [{/Symbol \260}]'
plot loc1 u 4:2 w l ls 1 t "IGRF inc" axis x1y1,\
     loc1 u ($4):($5-1) w l ls 2 t "surface 2m art DEM" axis x1y2,\
     loc1 u ($4):($7) w l ls 3 t "2m 250 DEM + IGRF -h:100" axis x1y1,\
     loc2 u ($4):($7) w l ls 30 t "2m 250 DEM + IGRF -h:180" axis x1y1

set output 'art_DEM_dc_noise.png'
set ylabel font "times,14" 'declination [{/Symbol \260}]'
plot loc1 u 4:3 w l ls 1 t "IGRF dec" axis x1y1,\
     loc1 u ($4):($5-1) w l ls 2 t "surface 2m art DEM" axis x1y2,\
     loc1 u ($4):($8) w l ls 3 t "2m 250 DEM + IGRF -h:100" axis x1y1,\
     loc2 u ($4):($8) w l ls 30 t "2m 250 DEM + IGRF -h:180" axis x1y1

################################################
set terminal pngcairo enhanced size 2000,1000
set output 'art_DEM_mp_noise.png'
set multiplot layout 2,2
#unset title

unset key
set format y "%.1f"
set ylabel font "times,14" 'intensity [{/Symbol m}T]'
plot loc1 u 4:($1*1e6) w l ls 1 t "IGRF" axis x1y1,\
     loc1 u ($4):($5-1) w l ls 2 t "surface 2m art DEM" axis x1y2,\
     loc1 u ($4):($6*1e6) w l ls 3 t "2m 250 DEM + IGRF -h:100" axis x1y1,\
     loc3 u ($4):($6*1e6) w l ls 4 t "Noise nf1, 2m 250 DEM + IGRF -h:100" axis x1y1,\
     loc2 u ($4):($6*1e6) w l ls 30 t "2m 250 DEM + IGRF -h:180" axis x1y1,\
     loc4 u ($4):($6*1e6) w l ls 40 t "Noise nf1, 2m 250 DEM + IGRF -h:180" axis x1y1

set format y "%.0f"
set ylabel font "times,14" 'inclination [{/Symbol \260}]'
plot loc1 u 4:2 w l ls 1 t "IGRF" axis x1y1,\
     loc1 u ($4):($5-1) w l ls 2 t "surface 2m art DEM" axis x1y2,\
     loc1 u ($4):($7) w l ls 3 t "2m 250 DEM + IGRF -h:100" axis x1y1,\
     loc3 u ($4):($7) w l ls 4 t "Noise nf1, 2m 250 DEM + IGRF -h:100" axis x1y1,\
     loc2 u ($4):($7) w l ls 30 t "2m 250 DEM + IGRF -h:180" axis x1y1,\
     loc4 u ($4):($7) w l ls 40 t "Noise nf1, 2m 250 DEM + IGRF -h:180" axis x1y1

set format y "%.0f"
set key default font "times,14" box lc 'grey60' opaque fc 'grey90' at screen 0.75,screen 0.25 center center height 0.5 width 0.5
#set yrange[-4:6]
set ylabel font "times,14" 'declination [{/Symbol \260}]'
plot loc1 u 4:3 w l ls 1 t "IGRF" axis x1y1,\
     loc1 u ($4):($5-1) w l ls 2 t "surface 2m art DEM" axis x1y2,\
     loc1 u ($4):($8) w l ls 3 t "2m 250 DEM + IGRF -h:100" axis x1y1,\
     loc3 u ($4):($8) w l ls 4 t "Noise nf1, 2m 250 DEM + IGRF -h:100" axis x1y1,\
     loc2 u ($4):($8) w l ls 30 t "2m 250 DEM + IGRF -h:180" axis x1y1,\
     loc4 u ($4):($8) w l ls 40 t "Noise nf1, 2m 250 DEM + IGRF -h:180" axis x1y1

unset multiplot
#################################################################################################


