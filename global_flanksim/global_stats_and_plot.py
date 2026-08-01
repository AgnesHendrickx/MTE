import numpy as np
import os
import csv
import matplotlib.pyplot as plt


# Set global font to Times New Roman for all plots
plt.rcParams.update({
"font.family": "serif",
"font.serif": ["DejaVu Serif"] 
#"font.serif": ["Nimbus Roman"]
})

def compute_statistics(file_path, median=True):
    try:
        # Check if file exists before loading
        if not os.path.exists(file_path):
            raise FileNotFoundError(f"File {file_path} not found.")

        #print(file_path)
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

        if median:
            int_average = np.nanmedian(intensity_siB0)
            inc_average = np.nanmedian(inclination_siB0)
            dec_average = np.nanmedian(declination_siB0)
            IGRF_int_average = np.median(igrf_intensity)
            IGRF_inc_average = np.median(igrf_inclination)
            IGRF_dec_average = np.median(igrf_declination)
            #print(f"IGRF_int_average: {IGRF_int_average}")
            #print(f"IGRF_inc_average: {IGRF_inc_average}")
            #print(f"IGRF_dec_average: {IGRF_dec_average}")
        else:
            int_average = np.nanmean(intensity_siB0)
            inc_average = np.nanmean(inclination_siB0)
            dec_average = np.nanmean(declination_siB0)
            IGRF_int_average = np.mean(igrf_intensity)
            IGRF_inc_average = np.mean(igrf_inclination)
            IGRF_dec_average = np.mean(igrf_declination)

        # Calculating statistics
        stats = {
            'Int': {
                'Model': f"{round(int_average, 2)} ± {round(np.nanstd(intensity_siB0, ddof=1), 2)}",
                'IGRF': round(IGRF_int_average, 2),
                'Med_dif': round(int_average - IGRF_int_average, 2),
                'Min': round(min(intensity_siB0), 2),
                'Max': round(max(intensity_siB0), 2)
            },
            'Inc': {
                'Model': f"{round(inc_average, 2)} ± {round(np.nanstd(inclination_siB0, ddof=1), 2)}",
                'IGRF': round(IGRF_inc_average, 2),
                'Med_dif': round(inc_average - IGRF_inc_average, 2),
                'Min': round(min(inclination_siB0), 2),
                'Max': round(max(inclination_siB0), 2)
            },
            'Dec': {
                'Model': f"{round(dec_average, 2)} ± {round(np.nanstd(declination_siB0, ddof=1), 2)}",
                'IGRF': round(IGRF_dec_average, 2),
                'Med_dif': round(dec_average - IGRF_dec_average, 3),
                'Min': round(min(declination_siB0), 2),
                'Max': round(max(declination_siB0), 2)
            }
        }

        return stats
    except Exception as e:
        print(f"Error processing file {file_path}: {e}")
        return None


def compute_statistics_noB0(file_path, median=True):
    try:
        # Check if file exists before loading
        if not os.path.exists(file_path):
            raise FileNotFoundError(f"File {file_path} not found.")
        #print(file_path)

        # Load the data, skipping the first two header lines
        data = np.loadtxt(file_path, skiprows=2)

        # Extracting the columns of interest for siB0 and field data
        intensity_si = data[:, 6] * 1e6  # In_siB0, multiplied by 1e6
        inclination_si = data[:, 7]      # Ic_siB0
        declination_si = data[:, 8]      # Dc_siB0

        # IGRF values
        #igrf_intensity = data[:, 3] * 1e6  # IGRF_In, multiplied by 1e6
        #igrf_inclination = data[:, 4]      # IGRF_Ic
        #igrf_declination = data[:, 5]      # IGRF_Dc

        # Calculating statistics
        if median:
            int_average = np.nanmedian(intensity_si)
            inc_average = np.nanmedian(inclination_si)
            dec_average = np.nanmedian(declination_si)
            #print(f"int_median: {int_average}" )
            #print(f"inc_median: {inc_average}" )
            #print(f"dec_median: {dec_average}" )

            #print("median taken")
        else:
            int_average = np.nanmean(intensity_si)
            inc_average = np.nanmean(inclination_si)
            dec_average = np.nanmean(declination_si)
            #print(f"int_mean: {int_average}" )
            #print(f"inc_mean: {inc_average}" )
            #print(f"dec_mean: {dec_average}" )
            #print("mean taken")

        stats = {
            'Int': {
                'Model': f"{int_average} ± {round(np.nanstd(intensity_si, ddof=1),2)}",
                #'IGRF': round(np.mean(igrf_intensity),2),
                'Med_dif': round(int_average,2),
                'Min': round(min(intensity_si),2),
                'Max': round(max(intensity_si),2)
            },
            'Inc': {
                'Model': f"{inc_average} ± {round(np.nanstd(inclination_si, ddof=1),2)}",
                #'IGRF': round(np.mean(igrf_inclination),2),
                'Med_dif': round(inc_average,2),
                'Min': round(min(inclination_si),2),
                'Max': round(max(inclination_si),2)
            },
            'Dec': {
                'Model': f"{dec_average} ± {round(np.nanstd(declination_si, ddof=1),2)}",
                #'IGRF': round(np.mean(igrf_declination),2),
                'Med_dif': round(dec_average,3),
                'Min': round(min(declination_si),2),
                'Max': round(max(declination_si),2)
            }
        }
        #print(stats)
        return stats

    except Exception as e:
        print(f"Error processing file {file_path}: {e}")
        return None

def compute_median_differences(file_paths, output_csv_path, median=True):
    header = ['Latitude', 'Flank', 'Intensity_Median_Dif', 'Inclination_Median_Dif', 'Declination_Median_Dif']
    rows = []

    for file_info in file_paths:
        lat, flank, file_path = file_info
        stats = compute_statistics(file_path, median)
        row = [
            lat,
            flank,
            stats['Int']['Med_dif'],
            stats['Inc']['Med_dif'],
            stats['Dec']['Med_dif']
        ]
        rows.append(row)

    # Write results to CSV
    with open(output_csv_path, 'w', newline='') as csvfile:
        writer = csv.writer(csvfile)
        writer.writerow(header)
        writer.writerows(rows)


def compute_median_differences2(file_paths, output_csv_path, median=True):
    header = ['Latitude', 'Flank', 'Intensity_Median_Dif', 'Inclination_Median_Dif', 'Declination_Median_Dif']
    rows = []

    for file_info in file_paths:
        lat, flank, file_path = file_info
        stats = compute_statistics_noB0(file_path, median)

        # Only add the row if stats were successfully computed
        if stats is not None:
            row = [
                lat,
                flank,
                stats['Int']['Med_dif'],
                stats['Inc']['Med_dif'],
                stats['Dec']['Med_dif']
            ]
            rows.append(row)
    #print(rows)
    # Write results to CSV
    with open(output_csv_path, 'w', newline='') as csvfile:
        writer = csv.writer(csvfile)
        writer.writerow(header)
        writer.writerows(rows)


def plot_median_differences(csv_file, name_image=None, ref_field=True, median=True):
    # Read CSV file
    data = np.genfromtxt(csv_file, delimiter=',', names=True, dtype=None, encoding='utf-8')

    # Extract unique latitudes
    latitudes = np.unique([float(row['Latitude']) for row in data])

    # Prepare dictionary to hold median differences for each flank
    median_differences = {
        'north': {'Int': [], 'Inc': [], 'Dec': []},
        'east': {'Int': [], 'Inc': [], 'Dec': []},
        'south': {'Int': [], 'Inc': [], 'Dec': []},
        'west': {'Int': [], 'Inc': [], 'Dec': []}
    }

    # Organize data by flank
    for row in data:
        lat = float(row['Latitude'])
        flank = row['Flank'].strip().lower()
        if flank in median_differences:
            median_differences[flank]['Int'].append((lat, row['Intensity_Median_Dif']))
            median_differences[flank]['Inc'].append((lat, row['Inclination_Median_Dif']))
            median_differences[flank]['Dec'].append((lat, row['Declination_Median_Dif']))

    # Sort data by latitude for each flank
    for flank in median_differences:
        for key in median_differences[flank]:
            median_differences[flank][key] = sorted(median_differences[flank][key])

    ## Plot for Intensity, Inclination, and Declination
    #for component, label in [('Int', 'Intensity'), ('Inc', 'Inclination'), ('Dec', 'Declination')]:
    #    plt.figure(figsize=(8, 6))
    #    plt.title(f'Median {label} Difference vs Latitude')
    #    plt.xlabel('Latitude')
    #    plt.ylabel(f'Median {label} Difference')
#
    #    # Plot for each flank
    #    for flank, color in zip(median_differences.keys(), ['r', 'g', 'b', 'c']):
    #        flank_data = np.array(median_differences[flank][component])
    #        lat_values = flank_data[:, 0]
    #        median_dif_values = flank_data[:, 1]
#
    #        plt.plot(lat_values, median_dif_values, label=flank.capitalize(), marker='o')
#
    #    plt.legend()
    #    plt.grid(True)
    #    plt.show()
    # Create multiplot (3 rows, 1 column)
    fig, axes = plt.subplots(1, 3, figsize=(10.2, 3.4))


    flank_colors = {
        'north': '#1965B0',
        'east':  '#F6C141',
        'south': '#DC050C', 
        'west':  '#4EB265'
    }
    
    flank_markers = {
        'south': 'o',   # circle
        'east':  's',   # square
        'north': 'D',   # triangle up
        'west':  '^'    # diamond
    }    
    # Plot for Intensity, Inclination, and Declination
    for i, (component, label) in enumerate([('Int', 'intensity [μT]'), ('Inc', 'inclination [$^\\circ$]'), ('Dec', 'declination [$^\\circ$]')]):
        ax = axes[i]
        #ax.set_title(f'Median {label} Difference vs Latitude')
        if ref_field and median:
            ax.set_xlabel(f'$\\tilde{{\\Delta}}$ {label} w.r.t. IGRF', fontsize=12)
        elif ref_field and not median:
            ax.set_xlabel(f'$\\overline{{\\Delta}}$ {label} w.r.t. IGRF', fontsize=12)
        elif not ref_field and not median:
            ax.set_xlabel(f'mean {label} anomaly')
        else:
            ax.set_xlabel(f'median {label} anomaly')

        # Plot for each flank
        for flank in median_differences.keys():
            flank_data = np.array(median_differences[flank][component])
            if flank_data.size > 0:
                lat_values = flank_data[:, 0]
                median_dif_values = flank_data[:, 1]

                # Check if the range of values includes both negative and positive values
                if np.min(median_dif_values) < 0 and np.max(median_dif_values) > 0:
                    # Make the gridline at y=0 darker
                    ax.axvline(x=0, color='black', linewidth=0.8, linestyle='-', zorder=1)  # Darker, thicker line at y=0

                cf=flank_colors[flank]
                mf=flank_markers[flank]
                ax.plot(median_dif_values, lat_values, color=cf, label=flank, marker=mf, markersize=4)

        #ax.axhline(y=0, color='black', linewidth=1.5, linestyle='--')  # Darker, thicker line at y=0

        #ax.grid(True, axis='y')  # Only show grid lines on the y-axis
        for y0, y1 in [(-90, -60), (-30, 30), (60, 90)]:
            ax.axhspan(y0, y1, color='0.95', zorder=0)
        if i == 0:
            ax.legend(loc='lower right')
            ax.set_ylabel('latitude', fontsize=12)

        ax.set_yticks(np.arange(-90, 91, 30))
        ax.tick_params(axis='both', which='major', labelsize=10)
        
        ax.relim()
        ax.autoscale(axis='x')
        ax.margins(x=0.1)
        if median and ref_field:
            if i == 0:
                ax.set_xticks(np.arange(-3, 2, 1))
            elif i == 1:
                ax.set_xticks(np.arange(-4, 5 , 2))
                ax.set_xlim(-3, 4.5)
            elif i == 2:
                ax.set_xticks(np.arange(-15, 20, 5))
            
    # Add common x-label at the bottom of the figure
    #axes[-1].set_xlabel('Latitude')
    axes[1].tick_params(labelleft=False)
    axes[2].tick_params(labelleft=False)
    # Adjust layout to make room for titles and labels
    plt.tight_layout()
    filename_img = f"./flanksim_lat_{name_image}.pdf" if name_image else f"./flanksim_lat.pdf"
    plt.savefig(filename_img, format='pdf', dpi=300)

    plt.show()
# Usage example

file_paths = [
    # South
    (-90, 'south', './lats/-90/south/250_250_20_fb_ztr_vInt/measurements_line_plotfile.ascii'),
    (-75, 'south', './lats/-75/south/250_250_20_fb_ztr_vInt/measurements_line_plotfile.ascii'),
    (-60, 'south', './lats/-60/south/250_250_20_fb_ztr_vInt/measurements_line_plotfile.ascii'),
    (-45, 'south', './lats/-45/south/250_250_20_fb_ztr_vInt/measurements_line_plotfile.ascii'),
    (-30, 'south', './lats/-30/south/250_250_20_fb_ztr_vInt/measurements_line_plotfile.ascii'),
    (-15, 'south', './lats/-15/south/250_250_20_fb_ztr_vInt/measurements_line_plotfile.ascii'),
    (0, 'south', './lats/0/south/250_250_20_fb_ztr_vInt/measurements_line_plotfile.ascii'),
    (15, 'south', './lats/15/south/250_250_20_fb_ztr_vInt/measurements_line_plotfile.ascii'),
    (30, 'south', './lats/30/south/250_250_20_fb_ztr_vInt/measurements_line_plotfile.ascii'),
    (45, 'south', './lats/45/south/250_250_20_fb_ztr_vInt/measurements_line_plotfile.ascii'),
    (60, 'south', './lats/60/south/250_250_20_fb_ztr_vInt/measurements_line_plotfile.ascii'),
    (75, 'south', './lats/75/south/250_250_20_fb_ztr_vInt/measurements_line_plotfile.ascii'),
    (90, 'south', './lats/90/south/250_250_20_fb_ztr_vInt/measurements_line_plotfile.ascii'),

    # East
    (-90, 'east', './lats/-90/east/250_250_20_fb_ztr_vInt/measurements_line_plotfile.ascii'),
    (-75, 'east', './lats/-75/east/250_250_20_fb_ztr_vInt/measurements_line_plotfile.ascii'),
    (-60, 'east', './lats/-60/east/250_250_20_fb_ztr_vInt/measurements_line_plotfile.ascii'),
    (-45, 'east', './lats/-45/east/250_250_20_fb_ztr_vInt/measurements_line_plotfile.ascii'),
    (-30, 'east', './lats/-30/east/250_250_20_fb_ztr_vInt/measurements_line_plotfile.ascii'),
    (-15, 'east', './lats/-15/east/250_250_20_fb_ztr_vInt/measurements_line_plotfile.ascii'),
    (0, 'east', './lats/0/east/250_250_20_fb_ztr_vInt/measurements_line_plotfile.ascii'),
    (15, 'east', './lats/15/east/250_250_20_fb_ztr_vInt/measurements_line_plotfile.ascii'),
    (30, 'east', './lats/30/east/250_250_20_fb_ztr_vInt/measurements_line_plotfile.ascii'),
    (45, 'east', './lats/45/east/250_250_20_fb_ztr_vInt/measurements_line_plotfile.ascii'),
    (60, 'east', './lats/60/east/250_250_20_fb_ztr_vInt/measurements_line_plotfile.ascii'),
    (75, 'east', './lats/75/east/250_250_20_fb_ztr_vInt/measurements_line_plotfile.ascii'),
    (90, 'east', './lats/90/east/250_250_20_fb_ztr_vInt/measurements_line_plotfile.ascii'),

    # North
    (-90, 'north', './lats/-90/north/250_250_20_fb_ztr_vInt/measurements_line_plotfile.ascii'),
    (-75, 'north', './lats/-75/north/250_250_20_fb_ztr_vInt/measurements_line_plotfile.ascii'),
    (-60, 'north', './lats/-60/north/250_250_20_fb_ztr_vInt/measurements_line_plotfile.ascii'),
    (-45, 'north', './lats/-45/north/250_250_20_fb_ztr_vInt/measurements_line_plotfile.ascii'),
    (-30, 'north', './lats/-30/north/250_250_20_fb_ztr_vInt/measurements_line_plotfile.ascii'),
    (-15, 'north', './lats/-15/north/250_250_20_fb_ztr_vInt/measurements_line_plotfile.ascii'),
    (0, 'north', './lats/0/north/250_250_20_fb_ztr_vInt/measurements_line_plotfile.ascii'),
    (15, 'north', './lats/15/north/250_250_20_fb_ztr_vInt/measurements_line_plotfile.ascii'),
    (30, 'north', './lats/30/north/250_250_20_fb_ztr_vInt/measurements_line_plotfile.ascii'),
    (45, 'north', './lats/45/north/250_250_20_fb_ztr_vInt/measurements_line_plotfile.ascii'),
    (60, 'north', './lats/60/north/250_250_20_fb_ztr_vInt/measurements_line_plotfile.ascii'),
    (75, 'north', './lats/75/north/250_250_20_fb_ztr_vInt/measurements_line_plotfile.ascii'),
    (90, 'north', './lats/90/north/250_250_20_fb_ztr_vInt/measurements_line_plotfile.ascii'),

    # West
    (-90, 'west', './lats/-90/west/250_250_20_fb_ztr_vInt/measurements_line_plotfile.ascii'),
    (-75, 'west', './lats/-75/west/250_250_20_fb_ztr_vInt/measurements_line_plotfile.ascii'),
    (-60, 'west', './lats/-60/west/250_250_20_fb_ztr_vInt/measurements_line_plotfile.ascii'),
    (-45, 'west', './lats/-45/west/250_250_20_fb_ztr_vInt/measurements_line_plotfile.ascii'),
    (-30, 'west', './lats/-30/west/250_250_20_fb_ztr_vInt/measurements_line_plotfile.ascii'),
    (-15, 'west', './lats/-15/west/250_250_20_fb_ztr_vInt/measurements_line_plotfile.ascii'),
    (0, 'west', './lats/0/west/250_250_20_fb_ztr_vInt/measurements_line_plotfile.ascii'),
    (15, 'west', './lats/15/west/250_250_20_fb_ztr_vInt/measurements_line_plotfile.ascii'),
    (30, 'west', './lats/30/west/250_250_20_fb_ztr_vInt/measurements_line_plotfile.ascii'),
    (45, 'west', './lats/45/west/250_250_20_fb_ztr_vInt/measurements_line_plotfile.ascii'),
    (60, 'west', './lats/60/west/250_250_20_fb_ztr_vInt/measurements_line_plotfile.ascii'),
    (75, 'west', './lats/75/west/250_250_20_fb_ztr_vInt/measurements_line_plotfile.ascii'),
    (90, 'west', './lats/90/west/250_250_20_fb_ztr_vInt/measurements_line_plotfile.ascii'),
]


output_csv = './median_differences_vInt.csv'
compute_median_differences(file_paths, output_csv, median=True)
plot_median_differences(output_csv,name_image='median_vInt', ref_field=True, median=True)

output_csv = './mean_differences_vInt.csv'
compute_median_differences(file_paths, output_csv, median=False)
plot_median_differences(output_csv, name_image='mean_vInt', ref_field=True, median=False)


file_paths2 = [
    # South
    (-90, 'south', './lats/-90/south/250_250_20_fb_ztr_vInt/measurements_line.ascii'),
    (-75, 'south', './lats/-75/south/250_250_20_fb_ztr_vInt/measurements_line.ascii'),
    (-60, 'south', './lats/-60/south/250_250_20_fb_ztr_vInt/measurements_line.ascii'),
    (-45, 'south', './lats/-45/south/250_250_20_fb_ztr_vInt/measurements_line.ascii'),
    (-30, 'south', './lats/-30/south/250_250_20_fb_ztr_vInt/measurements_line.ascii'),
    (-15, 'south', './lats/-15/south/250_250_20_fb_ztr_vInt/measurements_line.ascii'),
    (0, 'south', './lats/0/south/250_250_20_fb_ztr_vInt/measurements_line.ascii'),
    (15, 'south', './lats/15/south/250_250_20_fb_ztr_vInt/measurements_line.ascii'),
    (30, 'south', './lats/30/south/250_250_20_fb_ztr_vInt/measurements_line.ascii'),
    (45, 'south', './lats/45/south/250_250_20_fb_ztr_vInt/measurements_line.ascii'),
    (60, 'south', './lats/60/south/250_250_20_fb_ztr_vInt/measurements_line.ascii'),
    (75, 'south', './lats/75/south/250_250_20_fb_ztr_vInt/measurements_line.ascii'),
    (90, 'south', './lats/90/south/250_250_20_fb_ztr_vInt/measurements_line.ascii'),

    # East
    (-90, 'east', './lats/-90/east/250_250_20_fb_ztr_vInt/measurements_line.ascii'),
    (-75, 'east', './lats/-75/east/250_250_20_fb_ztr_vInt/measurements_line.ascii'),
    (-60, 'east', './lats/-60/east/250_250_20_fb_ztr_vInt/measurements_line.ascii'),
    (-45, 'east', './lats/-45/east/250_250_20_fb_ztr_vInt/measurements_line.ascii'),
    (-30, 'east', './lats/-30/east/250_250_20_fb_ztr_vInt/measurements_line.ascii'),
    (-15, 'east', './lats/-15/east/250_250_20_fb_ztr_vInt/measurements_line.ascii'),
    (0, 'east', './lats/0/east/250_250_20_fb_ztr_vInt/measurements_line.ascii'),
    (15, 'east', './lats/15/east/250_250_20_fb_ztr_vInt/measurements_line.ascii'),
    (30, 'east', './lats/30/east/250_250_20_fb_ztr_vInt/measurements_line.ascii'),
    (45, 'east', './lats/45/east/250_250_20_fb_ztr_vInt/measurements_line.ascii'),
    (60, 'east', './lats/60/east/250_250_20_fb_ztr_vInt/measurements_line.ascii'),
    (75, 'east', './lats/75/east/250_250_20_fb_ztr_vInt/measurements_line.ascii'),
    (90, 'east', './lats/90/east/250_250_20_fb_ztr_vInt/measurements_line.ascii'),

    # North
    (-90, 'north', './lats/-90/north/250_250_20_fb_ztr_vInt/measurements_line.ascii'),
    (-75, 'north', './lats/-75/north/250_250_20_fb_ztr_vInt/measurements_line.ascii'),
    (-60, 'north', './lats/-60/north/250_250_20_fb_ztr_vInt/measurements_line.ascii'),
    (-45, 'north', './lats/-45/north/250_250_20_fb_ztr_vInt/measurements_line.ascii'),
    (-30, 'north', './lats/-30/north/250_250_20_fb_ztr_vInt/measurements_line.ascii'),
    (-15, 'north', './lats/-15/north/250_250_20_fb_ztr_vInt/measurements_line.ascii'),
    (0, 'north', './lats/0/north/250_250_20_fb_ztr_vInt/measurements_line.ascii'),
    (15, 'north', './lats/15/north/250_250_20_fb_ztr_vInt/measurements_line.ascii'),
    (30, 'north', './lats/30/north/250_250_20_fb_ztr_vInt/measurements_line.ascii'),
    (45, 'north', './lats/45/north/250_250_20_fb_ztr_vInt/measurements_line.ascii'),
    (60, 'north', './lats/60/north/250_250_20_fb_ztr_vInt/measurements_line.ascii'),
    (75, 'north', './lats/75/north/250_250_20_fb_ztr_vInt/measurements_line.ascii'),
    (90, 'north', './lats/90/north/250_250_20_fb_ztr_vInt/measurements_line.ascii'),

    # West
    (-90, 'west', './lats/-90/west/250_250_20_fb_ztr_vInt/measurements_line.ascii'),
    (-75, 'west', './lats/-75/west/250_250_20_fb_ztr_vInt/measurements_line.ascii'),
    (-60, 'west', './lats/-60/west/250_250_20_fb_ztr_vInt/measurements_line.ascii'),
    (-45, 'west', './lats/-45/west/250_250_20_fb_ztr_vInt/measurements_line.ascii'),
    (-30, 'west', './lats/-30/west/250_250_20_fb_ztr_vInt/measurements_line.ascii'),
    (-15, 'west', './lats/-15/west/250_250_20_fb_ztr_vInt/measurements_line.ascii'),
    (0, 'west', './lats/0/west/250_250_20_fb_ztr_vInt/measurements_line.ascii'),
    (15, 'west', './lats/15/west/250_250_20_fb_ztr_vInt/measurements_line.ascii'),
    (30, 'west', './lats/30/west/250_250_20_fb_ztr_vInt/measurements_line.ascii'),
    (45, 'west', './lats/45/west/250_250_20_fb_ztr_vInt/measurements_line.ascii'),
    (60, 'west', './lats/60/west/250_250_20_fb_ztr_vInt/measurements_line.ascii'),
    (75, 'west', './lats/75/west/250_250_20_fb_ztr_vInt/measurements_line.ascii'),
    (90, 'west', './lats/90/west/250_250_20_fb_ztr_vInt/measurements_line.ascii'),
]

output_csv2 = './median_differences_noref_mean_vInt.csv'
compute_median_differences2(file_paths2, output_csv2, median=False)

name_image = "only_anomalies_mean_vInt"
plot_median_differences(output_csv2, name_image, ref_field=False, median=False)


output_csv2 = './median_differences_noref_median_vInt.csv'
compute_median_differences2(file_paths2, output_csv2, median=True)

name_image = "only_anomalies_median_vInt"
plot_median_differences(output_csv2, name_image, ref_field=False, median=True)

