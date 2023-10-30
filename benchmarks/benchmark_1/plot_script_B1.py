import numpy as np
import matplotlib.pyplot as plt

loc = './'

# Common styles and settings
style_computed = dict(marker='o', linestyle='-', color='royalblue', label='computed')
style_analytical = dict(marker='s', linestyle='-', color='green', label='analytical')
style_diff = dict(marker='D', linestyle='-', color='coral', label='(Bz_{analytical} - Bz_{computed})')
grid_style = dict(which='both', color='#aaaaaa', linestyle='--', linewidth=0.5)

# Load data
data = np.loadtxt(loc+'measurements_line.ascii', usecols=(2, 8, 11))
x_data = data[:, 0]
y_computed = data[:, 1] * 1e6
y_analytical = data[:, 2] * 1e6
y_diff = y_analytical - y_computed

# Load zoomed data
data_zoom = np.loadtxt(loc+'results_zoom/measurements_line.ascii', usecols=(2, 8, 11))
x_data_zoom = data_zoom[:, 0]
y_computed_zoom = data_zoom[:, 1] * 1e6
y_analytical_zoom = data_zoom[:, 2] * 1e6
y_diff_zoom = y_analytical_zoom - y_computed_zoom

# 1. B1dipole.png
plt.figure(figsize=(18, 9))
plt.loglog(x_data, y_computed, **style_computed)
plt.loglog(x_data, y_analytical, **style_analytical)
plt.xlabel('distance to sphere (m)')
plt.ylabel('B_z (µT)')
plt.legend()
plt.grid(**grid_style)
plt.savefig('B1dipole_py.png')

# 2. B1dipole_zoom.png
plt.figure(figsize=(18, 9))
plt.xlim(0, 2)
plt.plot(x_data_zoom, y_computed_zoom, **style_computed)
plt.plot(x_data_zoom, y_analytical_zoom, **style_analytical)
plt.xlabel('distance to sphere (m)')
plt.ylabel('B_z (µT)')
plt.legend()
plt.grid(**grid_style)
plt.savefig('B1dipole_zoom_py.png')

# 3. B1dipole_dif.png
plt.figure(figsize=(18, 9))
plt.xlim(0, 100)
plt.plot(x_data, y_diff, **style_diff)
plt.xlabel('distance to sphere (m)')
plt.ylabel('ΔBz (µT)')
plt.legend()
plt.grid(**grid_style)
plt.tight_layout()
plt.savefig('B1dipole_dif_py.png')

# 4. B1dipole_dif_zoom.png
plt.figure(figsize=(18, 9))
plt.xlim(0, 2)
plt.plot(x_data_zoom, y_diff_zoom, **style_diff)
plt.xlabel('distance to sphere (m)')
plt.ylabel('ΔBz (µT)')
plt.legend()
plt.grid(**grid_style)
plt.xlim(0, 2)
plt.ylim(-0.05, 0.2)
plt.axhline(0, color='black', linestyle='--')
plt.savefig('B1dipole_dif_zoom_py.png')

# 5. B1dipole_dif_zoom_withlines.png
plt.figure(figsize=(18, 9))
plt.plot(x_data_zoom, y_diff_zoom, **style_diff)
plt.xlabel('distance to sphere (m)')
plt.ylabel('ΔBz (µT)')
plt.legend()
plt.grid(**grid_style)
plt.xlim(0, 2)
plt.ylim(-0.05, 0.2)
plt.axhline(0, color='black', linestyle='--')
plt.arrow(0.25, -0.0093181, -0.008, 0, head_width=0.005, head_length=0.05, color='grey')
plt.arrow(0.25, -0.0093181, 0, -0.042, head_width=0.05, head_length=0.005, color='grey')
plt.text(0, -0.009, "-0.0093", ha='right', fontsize=12)
plt.text(0.25, -0.052, "0.25", ha='center', va='bottom', fontsize=12)
plt.savefig('B1dipole_dif_zoom_withlines_py.png')

# Show plots
plt.show()
