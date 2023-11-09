import matplotlib.pyplot as plt
import numpy as np

# Data loading function
def load_data(file_path, columns):
    return np.loadtxt(file_path, usecols=columns, unpack=True)

# Plotting function
def plot_data(axis, x, y, style, label=None, secondary_y=False):
    if secondary_y:
        # Create a secondary y-axis if needed
        axis = axis.twinx()
        axis.set_ylim(-6, 6)
    axis.plot(x, y, **style, label=label)

# Define plot styles
plot_styles = {
    'IGRF': {'color': 'black', 'linewidth': 1.0},
    'surface': {'color': 'grey', 'linestyle': '--', 'linewidth': 0.5},
    'flank': {'linewidth': 1.5},
    '180_flank': {'linewidth': 0.5}
}

# Define markers
markers = ['o', 's', 'D', '^']

# Define the figure and axis
fig, ax1 = plt.subplots(figsize=(20, 10))

# Plot all data
for i, direction in enumerate(['north', 'east', 'south', 'west']):
    # Data for normal flank
    path = f'./{direction}/250_250_20_fb/measurements_line_plotfile.ascii'
    x, y = load_data(path, (0, 7))
    plot_data(ax1, x, y*1e6, style={**plot_styles['flank'], 'marker': markers[i]}, label=f'{direction.capitalize()} flank')

    # Data for 180 flank
    path_180 = f'./{direction}/250_250_20_fb_180/measurements_line_plotfile.ascii'
    x_180, y_180 = load_data(path_180, (0, 7))
    plot_data(ax1, x_180, y_180*1e6, style={**plot_styles['180_flank'], 'marker': markers[i]}, label=f'180 {direction.capitalize()} flank')

# Plot IGRF and surface data (assuming north path is representative for these)
path_north = './north/250_250_20_fb/measurements_line_plotfile.ascii'
x, y_IGRF = load_data(path_north, (0, 4))
plot_data(ax1, x, y_IGRF*1e6, style=plot_styles['IGRF'], label='IGRF int')

x, y_surface = load_data(path_north, (0, 3))
plot_data(ax1, x, y_surface, style=plot_styles['surface'], label='Surface')

# Configure the primary y-axis (left)
ax1.set_xlabel('Distance [m]')
ax1.set_ylabel('Intensity [μT]')
ax1.set_xlim(100, 149.5)
ax1.grid(True, which='both', linestyle='--', linewidth=0.5, color='grey')

# Configure the secondary y-axis (right)
ax2 = ax1.twinx()
ax2.set_ylabel('Intensity [nT]')
ax2.set_ylim(-6, 6)

# Add legend
ax1.legend(loc='upper right')

# Save the figure
plt.savefig('flanksimIn_zt.png')

# Show the plot
plt.show()


import matplotlib.pyplot as plt
import numpy as np

# Data loading function
def load_data(file_path, columns):
    return np.loadtxt(file_path, usecols=columns, unpack=True)

# Plotting function
def plot_data(axis, x, y, style, label=None, secondary_y=False):
    if secondary_y:
        # Create a secondary y-axis if needed
        axis = axis.twinx()
    axis.plot(x, y, **style, label=label)

# Define plot styles
plot_styles = {
    'IGRF': {'color': 'black', 'linestyle': '-', 'linewidth': 1.0},
    'surface': {'color': 'grey', 'linestyle': '-', 'linewidth': 1.0},
    'flank': {'linestyle': '-', 'linewidth': 1.5, 'marker': 'o'}
}

# Define linestyle for each flank
flank_linestyles = {
    'north': {'linestyle': 3},
    'east': {'linestyle': 6},
    'south': {'linestyle': 5},
    'west': {'linestyle': 4}
}

# Define the figure and axis
fig, ax1 = plt.subplots(figsize=(20, 10))

# Path for the locations
loc1 = './north/250_250_20_fb/measurements_line_plotfile.ascii'
loc2 = './east/250_250_20_fb/measurements_line_plotfile.ascii'
loc3 = './south/250_250_20_fb/measurements_line_plotfile.ascii'
loc4 = './west/250_250_20_fb/measurements_line_plotfile.ascii'

# Plot IGRF data
x, y_IGRF = load_data(loc1, (0, 4))
plot_data(ax1, x, y_IGRF, plot_styles['IGRF'], label='IGRF inc')

# Plot surface data
x, y_surface = load_data(loc1, (0, 2))
plot_data(ax1, x, y_surface-1, plot_styles['surface'], label='surface', secondary_y=True)

# Plot flank data
for direction, loc in zip(['north', 'east', 'south', 'west'], [loc1, loc2, loc3, loc4]):
    x, y_flank = load_data(loc, (0 if direction in ['north', 'south'] else 1, 7))
    plot_data(ax1, x, y_flank, {**plot_styles['flank'], **flank_linestyles[direction]}, label=f'{direction.capitalize()} flank')

# Configure the primary y-axis (left)
ax1.set_xlabel('Distance [m]')
ax1.set_ylabel('Inclination [degrees]', fontname='Times New Roman', fontsize=12)
ax1.grid(True, which='both', linestyle='--', linewidth=0.5, color='grey')
ax1.legend(loc='upper right')

# Configure the secondary y-axis (right)
ax2 = ax1.twinx()
ax2.set_ylabel('Intensity [nT]', fontname='Times New Roman', fontsize=12)

# Save the figure
plt.savefig('flanksimIc_zt.png')

# Show the plot
plt.show()


