import numpy as np
import csv

def compute_statistics(file_path):
    # Load the data, skipping the first two header lines
    data = np.loadtxt(file_path, skiprows=2)

    # Extracting the columns of interest for siB0 and field data
    intensity_siB0 = data[:, 5] * 1e6  # In_siB0, multiplied by 1e6
    inclination_siB0 = data[:, 6]  # Ic_siB0
    declination_siB0 = data[:, 7]  # Dc_siB0

    intensity_field = data[:, 9]  # In_m, multiplied by 1e6
    inclination_field = data[:, 10]  # Ic_m
    declination_field = data[:, 11]  # Dc_m

    # IGRF values
    igrf_intensity = data[:, 0] * 1e6  # IGRF_In, multiplied by 1e6
    igrf_inclination = data[:, 1]  # IGRF_Ic
    igrf_declination = data[:, 2]  # IGRF_Dc

    # Calculating statistics
    stats = {
        'Intensity': {
            'Model': f"{round(np.nanmedian(intensity_siB0),2)} ± {round(np.nanstd(intensity_siB0, ddof=1),2)}",
            'Field': f"{round(np.nanmedian(intensity_field),2)} ± {round(np.nanstd(intensity_field, ddof=1),2)}",
            'IGRF': round(np.mean(igrf_intensity),2),
            'Median_dif_m': round(np.nanmedian(intensity_siB0) - np.median(igrf_intensity),2),
            'Median_dif_f': round(np.nanmedian(intensity_field) - np.median(igrf_intensity),2),
            'Min_m': round(min(intensity_siB0),2),
            'Max_m': round(max(intensity_siB0),2),
            'Min_f': round(min(intensity_field),2),
            'Max_f': round(max(intensity_field),2)

        },
        'Inclination': {
            'Model': f"{round(np.nanmedian(inclination_siB0),2)} ± {round(np.nanstd(inclination_siB0, ddof=1),2)}",
            'Field': f"{round(np.nanmedian(inclination_field),2)} ± {round(np.nanstd(inclination_field, ddof=1),2)}",
            'IGRF': round(np.mean(igrf_inclination),2),
            'Median_dif_m': round(np.nanmedian(inclination_siB0) - np.median(igrf_inclination),2),
            'Median_dif_f': round(np.nanmedian(inclination_field) - np.median(igrf_inclination),2),
            'Min_m': round(min(inclination_siB0),2),
            'Max_m': round(max(inclination_siB0),2),
            'Min_f': round(min(inclination_field),2),
            'Max_f': round(max(inclination_field),2)
        },
        'Declination': {
            'Model': f"{round(np.nanmedian(declination_siB0),2)} ± {round(np.nanstd(declination_siB0, ddof=1),2)}",
            'Field': f"{round(np.nanmedian(declination_field),2)} ± {round(np.nanstd(declination_field, ddof=1),2)}",
            'IGRF': round(np.mean(igrf_declination),2),
            'Median_dif_m': round(np.nanmedian(declination_siB0) - np.median(igrf_declination),2),
            'Median_dif_f': round(np.nanmedian(declination_field) - np.median(igrf_declination),2),
            'Min_m': round(min(declination_siB0),2),
            'Max_m': round(max(declination_siB0),2),
            'Min_f': round(min(declination_field),2),
            'Max_f': round(max(declination_field),2)

        }
    }
    return stats
#

def main(output_csv_path, file_paths):
    # Header for the CSV file
    header = ['Site', 'Path', 'Int model', 'Int field', 'Int IGRF', 'Int median dif IGRF model',\
              'Int median dif IGRF field', 'Int min model', 'Int max model',\
              'Int min field', 'Int max field',\
              'Inc model', 'Inc field', 'Inc IGRF', 'Inc median dif IGRF model',\
              'Inc median dif IGRF field', 'Inc min model', 'Inc max model',\
              'Inc min field', 'Inc max field',\
              'Dec model', 'Dec field', 'Dec IGRF', 'Dec median dif IGRF model',\
              'Dec median dif IGRF field', 'Dec min model', 'Dec max model',
              'Dec min field', 'Dec max field'
                ]

    # List to hold all rows of the CSV
    rows = []

    # Process each file
    for file_info in file_paths:
        site, path, file_path = file_info
        stats = compute_statistics(file_path)
        row = [
            site, path,
            stats['Intensity']['Model'], stats['Intensity']['Field'], stats['Intensity']['IGRF'],\
            stats['Intensity']['Median_dif_m'], stats['Intensity']['Median_dif_f'],\
            stats['Intensity']['Min_m'], stats['Intensity']['Max_m'], stats['Intensity']['Min_f'],\
            stats['Intensity']['Max_f'],
            stats['Inclination']['Model'], stats['Inclination']['Field'], stats['Inclination']['IGRF'],\
            stats['Inclination']['Median_dif_m'], stats['Inclination']['Median_dif_f'],\
            stats['Inclination']['Min_m'], stats['Inclination']['Max_m'],\
            stats['Inclination']['Min_f'], stats['Inclination']['Max_f'],
            stats['Declination']['Model'], stats['Declination']['Field'], stats['Declination']['IGRF'],\
            stats['Declination']['Median_dif_m'], stats['Declination']['Median_dif_f'],\
            stats['Declination']['Min_m'], stats['Declination']['Max_m'], stats['Declination']['Min_f'],\
            stats['Declination']['Max_f']
        ]
        rows.append(row)

    # Writing to CSV
    with open(output_csv_path, 'w', newline='') as csvfile:
        writer = csv.writer(csvfile)
        writer.writerow(header)
        writer.writerows(rows)

# Usage

file_paths_100 = [  # 100 cm
    ('FLUX1', 'path 1', './path_results/results_5m_site1_path1_sdem2_ho1_fb_zt/measurements_path_plotfile.ascii'),
    ('', 'path 2', './path_results/results_5m_site1_path2_sdem2_ho1_fb_zt/measurements_path_plotfile.ascii'),
    ('', 'path 3', './path_results/results_5m_site1_path3_sdem2_ho1_fb_zt/measurements_path_plotfile.ascii'),
    ('FLUX2', 'path 1', './path_results/results_5m_site2_path1_sdem2_ho1_fb_zt/measurements_path_plotfile.ascii'),
    ('', 'path 2', './path_results/results_5m_site2_path2_sdem2_ho1_fb_zt/measurements_path_plotfile.ascii'),
    ('', 'path 3', './path_results/results_5m_site2_path3_sdem2_ho1_fb_zt/measurements_path_plotfile.ascii'),
    ('FLUX3', 'path 1', './path_results/results_2m_site3_path1_sdem2_ho1_fb_zt/measurements_path_plotfile.ascii'),
    ('', 'path 2', './path_results/results_2m_site3_path2_sdem2_ho1_fb_zt/measurements_path_plotfile.ascii'),
    ('', 'path 3', './path_results/results_2m_site3_path3_sdem2_ho1_fb_zt/measurements_path_plotfile.ascii'),
    ('FLUX4', 'path 1', './path_results/results_5m_site4_path3_sdem2_ho1_fb_zt/measurements_path_plotfile.ascii'),
    ('FLUX5', 'path 1', './path_results/results_5m_site5_path1_sdem2_ho2_fb_zt/measurements_path_plotfile.ascii'),
    ('', 'path 2', './path_results/results_5m_site5_path2_sdem2_ho2_fb_zt/measurements_path_plotfile.ascii'),
    ('', 'path 3', './path_results/results_5m_site5_path3_sdem2_ho2_fb_zt/measurements_path_plotfile.ascii'),
    ('FLUX6', 'path 1', './path_results/results_5m_site6_path1_sdem4_ho1_fb_zt/measurements_path_plotfile.ascii'),
]
output_csv_path_100 = 'stats_100.csv'
main(output_csv_path_100, file_paths_100)

file_paths_180 = [  # 180 cm
    ('FLUX1', 'path 1', './path_results/results_5m_site1_path1_sdem2_ho2_fb_zt/measurements_path_plotfile.ascii'),
    ('', 'path 2', './path_results/results_5m_site1_path2_sdem2_ho2_fb_zt/measurements_path_plotfile.ascii'),
    ('', 'path 3', './path_results/results_5m_site1_path3_sdem2_ho2_fb_zt/measurements_path_plotfile.ascii'),
    ('FLUX2', 'path 1', './path_results/results_5m_site2_path1_sdem2_ho2_fb_zt/measurements_path_plotfile.ascii'),
    ('', 'path 2', './path_results/results_5m_site2_path2_sdem2_ho2_fb_zt/measurements_path_plotfile.ascii'),
    ('', 'path 3', './path_results/results_5m_site2_path3_sdem2_ho2_fb_zt/measurements_path_plotfile.ascii'),
    ('FLUX3', 'path 1', './path_results/results_2m_site3_path1_sdem2_ho2_fb_zt/measurements_path_plotfile.ascii'),
    ('', 'path 2', './path_results/results_2m_site3_path2_sdem2_ho2_fb_zt/measurements_path_plotfile.ascii'),
    ('', 'path 3', './path_results/results_2m_site3_path3_sdem2_ho2_fb_zt/measurements_path_plotfile.ascii'),
    ('FLUX4', 'path 1', './path_results/results_5m_site4_path3_sdem2_ho2_fb_zt/measurements_path_plotfile.ascii'),
    ('FLUX5', 'path 1', './path_results/results_5m_site5_path1_sdem2_ho4_fb_zt/measurements_path_plotfile.ascii'),
    ('', 'path 2', './path_results/results_5m_site5_path2_sdem2_ho4_fb_zt/measurements_path_plotfile.ascii'),
    ('', 'path 3', './path_results/results_5m_site5_path3_sdem2_ho4_fb_zt/measurements_path_plotfile.ascii'),
]
output_csv_path_180 = 'stats_180.csv'
main(output_csv_path_180, file_paths_180)

file_paths_s5 = [  # s5 only
    ('FLUX5', 'path 1: 0.25m', './path_results/results_5m_site5_path1_sdem2_ho1_fb_zt/measurements_path_plotfile.ascii'),
    ('', 'path 1: 0.75m', './path_results/results_5m_site5_path1_sdem2_ho2_fb_zt/measurements_path_plotfile.ascii'),
    ('', 'path 1: 1.25m', './path_results/results_5m_site5_path1_sdem2_ho3_fb_zt/measurements_path_plotfile.ascii'),
    ('', 'path 1: 1.75m', './path_results/results_5m_site5_path1_sdem2_ho4_fb_zt/measurements_path_plotfile.ascii'),
    ('', 'path 2: 0.25m', './path_results/results_5m_site5_path2_sdem2_ho1_fb_zt/measurements_path_plotfile.ascii'),
    ('', 'path 2: 0.75m', './path_results/results_5m_site5_path2_sdem2_ho2_fb_zt/measurements_path_plotfile.ascii'),
    ('', 'path 2: 1.25m', './path_results/results_5m_site5_path2_sdem2_ho3_fb_zt/measurements_path_plotfile.ascii'),
    ('', 'path 2: 1.75m', './path_results/results_5m_site5_path2_sdem2_ho4_fb_zt/measurements_path_plotfile.ascii'),
    ('', 'path 3: 0.25m', './path_results/results_5m_site5_path3_sdem2_ho1_fb_zt/measurements_path_plotfile.ascii'),
    ('', 'path 3: 0.75m', './path_results/results_5m_site5_path3_sdem2_ho2_fb_zt/measurements_path_plotfile.ascii'),
    ('', 'path 3: 1.25m', './path_results/results_5m_site5_path3_sdem2_ho3_fb_zt/measurements_path_plotfile.ascii'),
    ('', 'path 3: 1.75m', './path_results/results_5m_site5_path3_sdem2_ho4_fb_zt/measurements_path_plotfile.ascii'),
]
output_csv_path_s5 = 'stats_s5.csv'
main(output_csv_path_s5, file_paths_s5)
