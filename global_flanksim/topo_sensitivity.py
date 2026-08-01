import numpy as np
import os
import csv
import matplotlib.pyplot as plt

plt.rcParams.update({
    "font.family": "serif",
    "font.serif": ["DejaVu Serif"]
})

LATITUDES = [-90, -75, -60, -45, -30, -15, 0, 15, 30, 45, 60, 75, 90]
FLANKS = ['south', 'east', 'north', 'west']

FLANK_COLORS = {
    'north': '#1965B0',
    'east':  '#F6C141',
    'south': '#DC050C',
    'west':  '#4EB265'
}
FLANK_MARKERS = {
    'south': 'o',
    'east':  's',
    'north': 'D',
    'west':  '^'
}

# Scenario folder suffixes -- matches your existing
# './lats/{lat}/{flank}/250_250_20_fb_ztr_{suffix}/measurements_line_plotfile.ascii'
# convention. Add/remove/rename entries here as needed.
#SCENARIOS = [
#    ('Gentle\n(slope=3$^\\circ$, $\\lambda$=50 m, $A$=2 m)',       'gentle'),
#    ('Reference (Etna)\n(slope=6$^\\circ$, $\\lambda$=25 m, $A$=4 m)', 'vInt'),
#    ('Steep\n(slope=20$^\\circ$, $\\lambda$=15 m, $A$=6 m)',       'steep'),
#]
SCENARIOS = [
    ('Gentle',       'gentle'),
    ('Reference (Etna)', 'vInt'),
    ('Steep',       'steep'),
]

def compute_valid_max_x(x_data, wavelength, tol=1e-6):
    """Given the ACTUAL x-coordinates from a line-measurement file, returns
    (xstart, xend, valid_max_x, n_full_periods): xstart/xend are the real
    observed extent of the track (not assumed from a formula), and
    valid_max_x = xstart + n_full_periods * wavelength, where n_full_periods
    is the number of WHOLE periods that fit in the real observed track
    length -- i.e. the x-coordinate beyond which the track continues into a
    partial, incomplete period.

    `tol` guards against floating-point roundoff making a track that's
    "really" e.g. exactly 2.000000001 periods floor down to 1 -- track
    lengths within `tol` of a whole number of periods are rounded up first.

    Only meaningful (and only worth using as a cutoff) when the track
    completes MORE than one full period and then overshoots into a partial
    extra one. If the track doesn't even complete one full period (e.g.
    wavelength=50 on a ~48.96 m track), n_full_periods is 0 and valid_max_x
    collapses to xstart itself -- applying it as a truncation in that case
    would discard nearly all the data. Check n_full_periods >= 1 (and
    ideally that the track overshoots a whole number of periods rather than
    falling just short of one) before using this as a cutoff.
    """
    xstart = float(np.min(x_data))
    xend = float(np.max(x_data))
    track_length = xend - xstart
    n_periods_raw = track_length / wavelength
    n_full_periods = int(np.floor(n_periods_raw + tol))
    valid_max_x = xstart + n_full_periods * wavelength
    return xstart, xend, valid_max_x, n_full_periods


def position_column_for_flank(flank):
    """Which ascii column varies along the measurement line for a given
    flank -- NOT always x! Per your setup code: south/north keep the
    default line (xstart/xend vary, y fixed), with topography direction
    dir=0 (varies along x) -- so position is column 0 (x). East/west swap
    to a line where ystart/yend vary and x is fixed, with dir=90 deg
    (topography varies along y) -- so position is column 1 (y). The line's
    orientation and the topography's own periodic direction are always
    matched by design, which is why no cosine-projection correction is
    needed -- just picking the right column."""
    if flank in ('east', 'west'):
        return 1  # y varies, x is fixed
    else:  # 'south', 'north'
        return 0  # x varies, y is fixed


def compute_statistics(file_path, median=True, truncate_wavelength=None, flank=None):
    """Unchanged from your existing script, except for the optional
    truncate_wavelength: if given, the cutoff is computed directly from
    this file's own along-line coordinates via compute_valid_max_x, and any
    row beyond it is dropped before computing statistics -- use this to
    exclude a trailing partial period without re-running the simulation.
    Ties the cutoff to what's actually in the file rather than an assumed
    domain size.

    `flank` determines WHICH column varies along the line (x for
    south/north, y for east/west -- see position_column_for_flank) and is
    required whenever truncate_wavelength is given."""
    try:
        if not os.path.exists(file_path):
            raise FileNotFoundError(f"File {file_path} not found.")
        data = np.loadtxt(file_path, skiprows=2)

        if truncate_wavelength is not None:
            if flank is None:
                raise ValueError("flank must be given when truncate_wavelength is set "
                                  "(east/west vary in y, not x -- see position_column_for_flank)")
            col = position_column_for_flank(flank)
            pos = data[:, col]
            xstart, xend, valid_max_x, n_full_periods = compute_valid_max_x(pos, truncate_wavelength)
            n_before = len(data)
            data = data[pos <= valid_max_x + 1e-9]
            n_after = len(data)
            axis_name = 'y' if col == 1 else 'x'
            print(f"  {file_path} [{flank}, axis={axis_name}]: track [{xstart:.3f},{xend:.3f}] "
                  f"({(xend-xstart)/truncate_wavelength:.3f} periods of {truncate_wavelength} m) "
                  f"-> keeping {n_full_periods} whole period(s), {axis_name}<={valid_max_x:.3f}, "
                  f"kept {n_after}/{n_before} points")

        intensity_siB0 = data[:, 6] * 1e6
        inclination_siB0 = data[:, 7]
        declination_siB0 = data[:, 8]

        igrf_intensity = data[:, 3] * 1e6
        igrf_inclination = data[:, 4]
        igrf_declination = data[:, 5]

        if median:
            int_average = np.nanmedian(intensity_siB0)
            inc_average = np.nanmedian(inclination_siB0)
            dec_average = np.nanmedian(declination_siB0)
            IGRF_int_average = np.median(igrf_intensity)
            IGRF_inc_average = np.median(igrf_inclination)
            IGRF_dec_average = np.median(igrf_declination)
        else:
            int_average = np.nanmean(intensity_siB0)
            inc_average = np.nanmean(inclination_siB0)
            dec_average = np.nanmean(declination_siB0)
            IGRF_int_average = np.mean(igrf_intensity)
            IGRF_inc_average = np.mean(igrf_inclination)
            IGRF_dec_average = np.mean(igrf_declination)

        return {
            'Int': {'Med_dif': round(int_average - IGRF_int_average, 2)},
            'Inc': {'Med_dif': round(inc_average - IGRF_inc_average, 2)},
            'Dec': {'Med_dif': round(dec_average - IGRF_dec_average, 3)}
        }
    except Exception as e:
        print(f"Error processing file {file_path}: {e}")
        return None


def build_file_paths(suffix, latitudes=LATITUDES, flanks=FLANKS):
    """Builds the (lat, flank, filepath) list for one scenario suffix,
    matching your existing './lats/{lat}/{flank}/250_250_20_fb_ztr_{suffix}/
    measurements_line_plotfile.ascii' convention."""
    file_paths = []
    for flank in flanks:
        for lat in latitudes:
            fp = f'./lats/{lat}/{flank}/250_250_20_fb_ztr_{suffix}/measurements_line_plotfile.ascii'
            file_paths.append((lat, flank, fp))
    return file_paths


def compute_median_differences(file_paths, output_csv_path, median=True, truncate_wavelength=None):
    """Unchanged from your existing script, except silently skips files
    that don't exist or fail to load (useful if a scenario was only run
    for a subset of latitudes/flanks), and accepts an optional
    truncate_wavelength -- passed through to compute_statistics along with
    the flank (needed there to pick the correct varying column: x for
    south/north, y for east/west -- see position_column_for_flank)."""
    header = ['Latitude', 'Flank', 'Intensity_Median_Dif', 'Inclination_Median_Dif', 'Declination_Median_Dif']
    rows = []
    for lat, flank, file_path in file_paths:
        stats = compute_statistics(file_path, median, truncate_wavelength=truncate_wavelength, flank=flank)
        if stats is None:
            continue
        rows.append([lat, flank, stats['Int']['Med_dif'], stats['Inc']['Med_dif'], stats['Dec']['Med_dif']])

    with open(output_csv_path, 'w', newline='') as csvfile:
        writer = csv.writer(csvfile)
        writer.writerow(header)
        writer.writerows(rows)

    if not rows:
        print(f"WARNING: no data found for {output_csv_path} -- check folder paths/suffix.")
    return rows


def load_by_flank(csv_file):
    """Returns {flank: {'Int': [(lat, val), ...], 'Inc': [...], 'Dec': [...]}}"""
    data = np.genfromtxt(csv_file, delimiter=',', names=True, dtype=None, encoding='utf-8')
    data = np.atleast_1d(data)
    out = {f: {'Int': [], 'Inc': [], 'Dec': []} for f in FLANKS}
    for row in data:
        flank = row['Flank'].strip().lower()
        if flank in out:
            out[flank]['Int'].append((float(row['Latitude']), float(row['Intensity_Median_Dif'])))
            out[flank]['Inc'].append((float(row['Latitude']), float(row['Inclination_Median_Dif'])))
            out[flank]['Dec'].append((float(row['Latitude']), float(row['Declination_Median_Dif'])))
    for flank in out:
        for key in out[flank]:
            out[flank][key] = sorted(out[flank][key])
    return out


def compute_shared_xlims(scenario_csvs, margin_frac=0.1):
    """Scans all scenario CSVs (typically gentle/reference/steep) and
    returns {component: (xmin, xmax)}, using the overall min/max across every
    scenario/flank for each component -- i.e. sized to fit whichever scenario
    turns out widest (usually 'steep'), with a fractional margin added on
    each side so points at the ends of the range aren't flush against the
    axis border."""
    components = ['Int', 'Inc', 'Dec']
    overall = {c: [np.inf, -np.inf] for c in components}

    for _, csv_path in scenario_csvs:
        by_flank = load_by_flank(csv_path)
        for flank in FLANKS:
            for component in components:
                data = by_flank[flank][component]
                if not data:
                    continue
                vals = [v for _, v in data]
                overall[component][0] = min(overall[component][0], min(vals))
                overall[component][1] = max(overall[component][1], max(vals))

    x_limits = {}
    for component in components:
        lo, hi = overall[component]
        if not np.isfinite(lo) or not np.isfinite(hi):
            continue
        span = hi - lo
        margin = span * margin_frac if span > 0 else max(abs(hi), 1.0) * margin_frac
        x_limits[component] = (lo - margin, hi + margin)
    return x_limits


def plot_scenario_comparison(scenario_csvs, name_image, x_limits=None):
    """scenario_csvs: list of (row_label, csv_path), e.g.
    [('Reference (Etna)', 'ref.csv'), ('Gentle', 'gentle.csv'), ('Steep', 'steep.csv')]

    x_limits: optional dict {'Int': (xmin, xmax), 'Inc': (...), 'Dec': (...)}
    to force matching x-axis ranges down each column so rows are directly
    comparable. If not given, each row auto-scales independently (still
    useful, just harder to compare magnitudes by eye across rows).
    """
    n_rows = len(scenario_csvs)
    components = [('Int', 'intensity [\u03bcT]'), ('Inc', 'inclination [$^\\circ$]'), ('Dec', 'declination [$^\\circ$]')]

    fig, axes = plt.subplots(n_rows, 3, figsize=(10.2, 3.0 * n_rows), squeeze=False)

    for row_i, (row_label, csv_path) in enumerate(scenario_csvs):
        by_flank = load_by_flank(csv_path)

        for col_i, (component, label) in enumerate(components):
            ax = axes[row_i][col_i]

            if row_i == 0:
                ax.set_title(f'$\\tilde{{\\Delta}}$ {label} w.r.t. IGRF', fontsize=12)

            for flank in FLANKS:
                flank_data = np.array(by_flank[flank][component])
                if flank_data.size == 0:
                    continue
                lat_values = flank_data[:, 0]
                vals = flank_data[:, 1]
                if np.min(vals) < 0 and np.max(vals) > 0:
                    ax.axvline(x=0, color='black', linewidth=0.8, linestyle='-', zorder=1)
                ax.plot(vals, lat_values, color=FLANK_COLORS[flank], label=flank,
                        marker=FLANK_MARKERS[flank], markersize=4)

            for y0, y1 in [(-90, -60), (-30, 30), (60, 90)]:
                ax.axhspan(y0, y1, color='0.95', zorder=0)

            ax.set_yticks(np.arange(-90, 91, 30))
            ax.tick_params(axis='both', which='major', labelsize=10)

            if col_i == 0:
                ax.set_ylabel(f'$\\bf{{{row_label}}}$\nlatitude', fontsize=12)
                if row_i == 0:
                    ax.legend(loc='lower right', fontsize=8)
            else:
                ax.tick_params(labelleft=False)

            if x_limits and component in x_limits:
                ax.set_xlim(*x_limits[component])
            else:
                ax.relim()
                ax.autoscale(axis='x')
                ax.margins(x=0.1)

            ax.relim()
            ax.autoscale(axis='x')
            ax.margins(x=0.1)
    plt.tight_layout()
    filename_img = f"./flanksim_lat_{name_image}.pdf"
    plt.savefig(filename_img, format='pdf', dpi=300)
    plt.show()


# --- Usage ---------------------------------------------------------------
# NOTE: if 'gentle'/'steep' were only run for a subset of latitudes or a
# single representative flank, pass that subset to build_file_paths, e.g.
#   build_file_paths('gentle', latitudes=[0, 45, 90], flanks=['east'])
# rather than the full LATITUDES/FLANKS default. Missing files are skipped
# automatically either way (see compute_median_differences).

# Wavelengths per scenario suffix -- only used to decide whether/how to
# truncate below (see compute_valid_max_x's docstring for why this must
# NOT also be applied to gentle/reference -- gentle doesn't even complete
# one full period, so the same logic would discard nearly all its data).
SCENARIO_WAVELENGTHS_M = {'gentle': 50, 'vInt': 25, 'steep': 15}

scenario_csvs = []
for row_label, suffix in SCENARIOS:
    fp_list = build_file_paths(suffix)
    out_csv = f'./median_differences_{suffix}.csv'

    if suffix == 'steep':
        # cutoff is computed per-file from each file's own x-coordinates,
        # not from an assumed domain size -- see compute_valid_max_x
        compute_median_differences(fp_list, out_csv, median=True,
                                    truncate_wavelength=SCENARIO_WAVELENGTHS_M['steep'])
    else:
        compute_median_differences(fp_list, out_csv, median=True)

    scenario_csvs.append((row_label, out_csv))

# x_limits are computed from the actual data, sized to fit whichever
# scenario has the widest spread (typically 'steep'), so all three rows
# share the same scale per column and are directly comparable by eye.
x_limits = compute_shared_xlims(scenario_csvs)

plot_scenario_comparison(scenario_csvs, name_image='topo_sensitivity', x_limits=x_limits)