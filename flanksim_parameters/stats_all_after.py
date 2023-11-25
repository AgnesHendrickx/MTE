import numpy as np
import csv

def compute_statistics(file_path):
    # Load the data, skipping the first two header lines
    data = np.loadtxt(file_path, skiprows=2)

    # Extracting the columns of interest for siB0 and field data
    intensity_siB0 = data[:, 6] * 1e6  # In_siB0, multiplied by 1e6
    inclination_siB0 = data[:, 7]  # Ic_siB0
    declination_siB0 = data[:, 8]  # Dc_siB0

    # IGRF values
    igrf_intensity = data[:, 3] * 1e6  # IGRF_In, multiplied by 1e6
    igrf_inclination = data[:, 4]  # IGRF_Ic
    igrf_declination = data[:, 5]  # IGRF_Dc

    # Calculating statistics
    stats = {
        'Int': {
            'Model': f"{round(np.nanmedian(intensity_siB0),2)} ± {round(np.nanstd(intensity_siB0, ddof=1),2)}",
            'IGRF': round(np.mean(igrf_intensity),2),
            'Med_dif': round(np.nanmedian(intensity_siB0) - np.median(igrf_intensity),2),
            'Min': round(min(intensity_siB0),2),
            'Max': round(max(intensity_siB0),2)


        },
        'Inc': {
            'Model': f"{round(np.nanmedian(inclination_siB0),2)} ± {round(np.nanstd(inclination_siB0, ddof=1),2)}",
            'IGRF': round(np.mean(igrf_inclination),2),
            'Med_dif': round(np.nanmedian(inclination_siB0) - np.median(igrf_inclination),2),
            'Min': round(min(inclination_siB0),2),
            'Max': round(max(inclination_siB0),2)

        },
        'Dec': {
            'Model': f"{round(np.nanmedian(declination_siB0),2)} ± {round(np.nanstd(declination_siB0, ddof=1),2)}",
            'IGRF': round(np.mean(igrf_declination),2),
            'Med_dif': round(np.nanmedian(declination_siB0) - np.median(igrf_declination),3),
            'Min': round(min(declination_siB0),2),
            'Max': round(max(declination_siB0),2)

        }
    }
    return stats
#

def main(output_csv_path, file_paths):
    # Header for the CSV file
    header = ['Site', 'Path', 'Int model', 'Int IGRF', 'Int median dif IGRF model',\
              'Int min model', 'Int max model',\
              'Inc model', 'Inc IGRF', 'Inc median dif IGRF model',\
              'Inc min model', 'Inc max model',\
              'Dec model', 'Dec IGRF', 'Dec median dif IGRF model',\
              'Dec min model', 'Dec max model'
                ]

    # List to hold all rows of the CSV
    rows = []

    # Process each file
    for file_info in file_paths:
        site, path, file_path = file_info
        stats = compute_statistics(file_path)
        row = [
            site, path, stats['Int']['Model'], stats['Int']['IGRF'], stats['Int']['Med_dif'],\
            stats['Int']['Min'], stats['Int']['Max'], stats['Inc']['Model'], stats['Inc']['IGRF'],\
            stats['Inc']['Med_dif'], stats['Inc']['Min'], stats['Inc']['Max'],\
            stats['Dec']['Model'], stats['Dec']['IGRF'], stats['Dec']['Med_dif'],\
            stats['Dec']['Min'], stats['Dec']['Max']
        ]
        rows.append(row)

    # Writing to CSV
    with open(output_csv_path, 'w', newline='') as csvfile:
        writer = csv.writer(csvfile)
        writer.writerow(header)
        writer.writerows(rows)

# Usage

file_fs = [
    ('FS', '1', './south/250_250_20_fb/measurements_line_plotfile.ascii'),
    ('', '1.8', './south/250_250_20_fb_180/measurements_line_plotfile.ascii'),
    ('FE', '1', './east/250_250_20_fb/measurements_line_plotfile.ascii'),
    ('', '1.8', './east/250_250_20_fb_180/measurements_line_plotfile.ascii'),
    ('FN', '1', './north/250_250_20_fb/measurements_line_plotfile.ascii'),
    ('', '1.8', './north/250_250_20_fb_180/measurements_line_plotfile.ascii'),
    ('FW', '1', './west/250_250_20_fb/measurements_line_plotfile.ascii'),
    ('', '1.8', './west/250_250_20_fb_180/measurements_line_plotfile.ascii'),
]
output_csv_fs = 'stats_fs.csv'
main(output_csv_fs, file_fs)

file_fsp = [
    ('FS', '1', './south/250_250_20_fb_ztr_paraguay/measurements_line_plotfile.ascii'),
    ('FE', '1', './east/250_250_20_fb_ztr_paraguay/measurements_line_plotfile.ascii'),
    ('FN', '1', './north/250_250_20_fb_ztr_paraguay/measurements_line_plotfile.ascii'),
    ('FW', '1', './west/250_250_20_fb_ztr_paraguay/measurements_line_plotfile.ascii'),
]
output_csv_fsp = 'stats_fsp.csv'
main(output_csv_fsp, file_fsp)

