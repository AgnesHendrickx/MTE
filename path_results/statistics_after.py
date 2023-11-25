import numpy as np
import csv

def compute_statistics(file_path, output_csv_path): # Designed for plotfile.ascii
    # Load the data, skipping the first two header lines
    data = np.loadtxt(file_path, skiprows=2)

    # Extracting the columns of interest for siB0 and field data
    intensity_siB0 = data[:,5] * 1e6  # In_siB0
    inclination_siB0 = data[:,6]  # Ic_siB0
    declination_siB0 = data[:,7]  # Dc_siB0

    intensity_field = data[:,9]  # In_m
    inclination_field = data[:,10]  # Ic_m
    declination_field = data[:,11]  #  Dc_m

    # IGRF values for comparison and output
    igrf_intensity = data[:,0] * 1e6  # IGRF_In
    igrf_inclination = data[:,1]  # IGRF_Ic
    igrf_declination = data[:,2]  # IGRF_Dc


    # Dictionary to hold statistics
    stats = []

    # Calculating statistics for each column
    for col, col_field, igrf_col, name in [(intensity_siB0, intensity_field, igrf_intensity, 'Intensity'),
                                           (inclination_siB0, inclination_field, igrf_inclination, 'Inclination'),
                                           (declination_siB0, declination_field, igrf_declination, 'Declination')]:
        stats.append([name + ' Median',
                      '',
                      np.nanmedian(col),
                      np.nanmedian(col_field),
                      np.nanmedian(col) - np.median(igrf_col),
                      np.nanmedian(col_field) - np.median(igrf_col)])

        stats.append([name + ' Mean',
                      '',
                      np.nanmean(col),
                      np.nanmean(col_field),
                      np.nanmean(col) - np.mean(igrf_col),
                      np.nanmean(col_field) - np.mean(igrf_col)])

        stats.append([name + ' Standard Deviation',
                      '',
                      np.nanstd(col, ddof=1),
                      np.nanstd(col_field, ddof=1),
                      '',
                      ''])

        stats.append([name + ' Min',
                      '',
                      np.min(col),
                      np.min(col_field),
                      '',
                      ''])

        stats.append([name + ' Max',
                      '',
                      np.max(col),
                      np.max(col_field),
                      '',
                      ''])

    # Adding IGRF values
    stats.extend([
        ['IGRF Mean Intensity', np.mean(igrf_intensity), '', '', '', ''],
        ['IGRF Mean Inclination', np.mean(igrf_inclination), '', '', '', ''],
        ['IGRF Mean Declination', np.mean(igrf_declination), '', '', '', '']
    ])

    # Writing statistics to CSV
    with open(output_csv_path, 'w', newline='') as csvfile:
        writer = csv.writer(csvfile)
        writer.writerow(['Statistic', 'IGRF', 'siB0', 'Field Data', 'siB0 Difference from IGRF', 'Field Data Difference from IGRF'])
        writer.writerows(stats)

# state file locations, output and input
file_path = './results_5m_site6_path1_sdem4_ho1_fb_zt/measurements_path_plotfile.ascii'  # Replace with your file path
output_csv_path = 'output_statistics_s6_p1.csv'  # Replace with your desired output path
#file_path = './results_5m_site1_path1_sdem2_ho1_fb_zt/measurements_path_plotfile.ascii'  # Replace with your file path
#output_csv_path = 'output_statistics_s1_p1.csv'  # Replace with your desired output path
file_path = './results_5m_site6_path1_sdem4_ho1_fb_zt_mag_13_noise_1_5/measurements_path_plotfile.ascii'  # Replace with your file path
output_csv_path = 'output_statistics_s6_p1_noise_mag.csv'  # Replace with your desired output path

results = compute_statistics(file_path, output_csv_path)
#print(results)

