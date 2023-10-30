import numpy as np
import matplotlib.pyplot as plt

# Define the files and their paths
loc = './'  # Modify this if needed
files = {
    '0_25_3': loc + '0_25_above/measurements_spiral.ascii',
    '0_25_6': loc + '0_25_2_above/measurements_spiral.ascii',
    '0_5_3': loc + '0_5_above/measurements_spiral.ascii',
    '0_5_6': loc + '0_5_2_above/measurements_spiral.ascii'
}

# Load data from files
data = {key: np.loadtxt(fname) for key, fname in files.items()}

# Compute the magnetic field differences
def compute_differences(file_data):
    diff_x = file_data[:, 9] - file_data[:, 6]
    diff_y = file_data[:, 10] - file_data[:, 7]
    diff_z = file_data[:, 11] - file_data[:, 8]
    return np.sqrt(diff_x**2 + diff_y**2 + diff_z**2) * 1e6

differences = {key: compute_differences(value) for key, value in data.items()}

# Plotting
fig, ax = plt.subplots(figsize=(10, 6))
ax.set_ylim([-5, 4])
ax.grid(True, which='both', linestyle='--', linewidth=0.5)
ax.set_xlabel('point ID', fontname="courier", fontsize=14)
ax.set_ylabel('|ΔB| (μT)', fontname="courier", fontsize=14)

plot_data = [
    (differences['0_25_3'], '25 cm & 3 el/m'),
    (differences['0_25_6'], '25 cm & 6 el/m'),
    (differences['0_5_3'], '50 cm & 3 el/m'),
    (differences['0_5_6'], '50 cm & 6 el/m')
]

for diff_data, label in plot_data:
    ax.scatter(range(len(diff_data)), diff_data, label=label)

ax.legend()
plt.tight_layout()
plt.savefig('B3sphere_dif_mag_all_py.png')

##############################

# Define the files and their paths
loc = './'  # Modify this if needed
files = {
    '0_25_3': loc + '0_25_above/measurements_spiral.ascii',
    '0_25_6': loc + '0_25_2_above/measurements_spiral.ascii',
}

# Load data from files
data = {key: np.loadtxt(fname) for key, fname in files.items()}

# Plot structure
fig, axes = plt.subplots(1, 3, figsize=(15, 5))

# Common settings
for ax in axes:
    ax.set_xlabel('point ID', fontname="courier", fontsize=14)
    ax.grid(True, which='both', linestyle='--', linewidth=0.5)

# Plot for B_x
axes[0].set_ylabel('B_x (μT)', fontname="courier", fontsize=14)
points = [
    (data['0_25_3'][:, 6] * 1e6, '25 cm & 3 el/m'),
    (data['0_25_6'][:, 6] * 1e6, '25 cm & 6 el/m'),
    (data['0_25_3'][:, 9] * 1e6, 'analytical 0.25 above')
]
for point_data, label in points:
    axes[0].scatter(range(len(point_data)), point_data, label=label)

# Plot for B_y
axes[1].set_ylabel('B_y (μT)', fontname="courier", fontsize=14)
points = [
    (data['0_25_3'][:, 7] * 1e6, '25 cm & 3 el/m'),
    (data['0_25_6'][:, 7] * 1e6, '25 cm & 6 el/m'),
    (data['0_25_3'][:, 10] * 1e6, 'analytical 0.25 above')
]
for point_data, label in points:
    axes[1].scatter(range(len(point_data)), point_data, label=label)

# Plot for B_z
axes[2].set_ylabel('B_z (μT)', fontname="courier", fontsize=14)
points = [
    (data['0_25_3'][:, 8] * 1e6, '25 cm & 3 el/m'),
    (data['0_25_6'][:, 8] * 1e6, '25 cm & 6 el/m'),
    (data['0_25_3'][:, 11] * 1e6, 'analytical 0.25 above')
]
for point_data, label in points:
    axes[2].scatter(range(len(point_data)), point_data, label=label)

for ax in axes:
    ax.legend()

plt.tight_layout()
plt.savefig('B3sphere_mp_025_py.png')

##############################

# Define the files and their paths
loc = './'  # Modify this if needed
files = {
    '0_5_3': loc + '0_5_above/measurements_spiral.ascii',
    '0_5_6': loc + '0_5_2_above/measurements_spiral.ascii',
    '0_25_3': loc + '0_25_above/measurements_spiral.ascii',
}

# Load data from files
data = {key: np.loadtxt(fname) for key, fname in files.items()}

# Plot structure
fig, axes = plt.subplots(1, 3, figsize=(15, 5))

# Common settings
for ax in axes:
    ax.set_xlabel('point ID', fontname="courier", fontsize=14)
    ax.grid(True, which='both', linestyle='--', linewidth=0.5)

# Plot for B_x
axes[0].set_ylabel('B_x (μT)', fontname="courier", fontsize=14)
points = [
    (data['0_5_3'][:, 6] * 1e6, '50 cm & 3 el/m'),
    (data['0_5_6'][:, 6] * 1e6, '50 cm & 6 el/m'),
    (data['0_5_6'][:, 9] * 1e6, 'analytical 0.5 above')
]
for point_data, label in points:
    axes[0].scatter(range(len(point_data)), point_data, label=label)

# Plot for B_y
axes[1].set_ylabel('B_y (μT)', fontname="courier", fontsize=14)
points = [
    (data['0_5_3'][:, 7] * 1e6, '50 cm & 3 el/m'),
    (data['0_5_6'][:, 7] * 1e6, '50 cm & 6 el/m'),
    (data['0_25_3'][:, 10] * 1e6, 'analytical 0.25 above')
]
for point_data, label in points:
    axes[1].scatter(range(len(point_data)), point_data, label=label)

# Plot for B_z
axes[2].set_ylabel('B_z (μT)', fontname="courier", fontsize=14)
points = [
    (data['0_5_3'][:, 8] * 1e6, '50 cm & 3 el/m'),
    (data['0_5_6'][:, 8] * 1e6, '50 cm & 6 el/m'),
    (data['0_5_6'][:, 11] * 1e6, 'analytical 0.5 above')
]
for point_data, label in points:
    axes[2].scatter(range(len(point_data)), point_data, label=label)

for ax in axes:
    ax.legend()

plt.tight_layout()
plt.savefig('B3sphere_mp_05_py.png')
##############################

# Define the files and their paths
loc = './'  # Modify this if needed
files = {
    '0_25_3': loc + '0_25_above/measurements_spiral.ascii',
    '0_25_6': loc + '0_25_2_above/measurements_spiral.ascii',
    '0_5_3': loc + '0_5_above/measurements_spiral.ascii',
    '0_5_6': loc + '0_5_2_above/measurements_spiral.ascii',
}

# Load data from files
data = {key: np.loadtxt(fname) for key, fname in files.items()}

# Plot structure
fig, axes = plt.subplots(1, 3, figsize=(15, 5))

# Common settings
for ax in axes:
    ax.set_xlabel('point ID', fontname="courier", fontsize=14)
    ax.set_ylim(-5, 6)
    ax.set_yticks(np.arange(-5, 6, 1))
    ax.grid(True, which='both', linestyle='--', linewidth=0.5)

# Plot for B_x
axes[0].set_ylabel('B_x (μT)', fontname="courier", fontsize=14)
points = [
    (data['0_25_3'][:, 6] * 1e6, '25 cm & 3 el/m'),
    (data['0_25_6'][:, 6] * 1e6, '25 cm & 6 el/m'),
    (data['0_5_3'][:, 6] * 1e6, '50 cm & 3 el/m'),
    (data['0_5_6'][:, 6] * 1e6, '50 cm & 6 el/m'),
    (data['0_5_6'][:, 9] * 1e6, 'analytical 0.5 above'),
    (data['0_25_3'][:, 9] * 1e6, 'analytical 0.25 above'),
]
for point_data, label in points:
    axes[0].scatter(range(len(point_data)), point_data, label=label)

# Plot for B_y
axes[1].set_ylabel('B_y (μT)', fontname="courier", fontsize=14)
points = [
    (data['0_25_3'][:, 7] * 1e6, '25 cm & 3 el/m'),
    (data['0_25_6'][:, 7] * 1e6, '25 cm & 6 el/m'),
    (data['0_5_3'][:, 7] * 1e6, '50 cm & 3 el/m'),
    (data['0_5_6'][:, 7] * 1e6, '50 cm & 6 el/m'),
    (data['0_5_6'][:, 10] * 1e6, 'analytical 0.5 above'),
    (data['0_25_3'][:, 10] * 1e6, 'analytical 0.25 above'),
]
for point_data, label in points:
    axes[1].scatter(range(len(point_data)), point_data, label=label)

# Plot for B_z
axes[2].set_ylabel('B_z (μT)', fontname="courier", fontsize=14)
points = [
    (data['0_25_3'][:, 8] * 1e6, '25 cm & 3 el/m'),
    (data['0_25_6'][:, 8] * 1e6, '25 cm & 6 el/m'),
    (data['0_5_3'][:, 8] * 1e6, '50 cm & 3 el/m'),
    (data['0_5_6'][:, 8] * 1e6, '50 cm & 6 el/m'),
    (data['0_5_6'][:, 11] * 1e6, 'analytical 0.5 above'),
    (data['0_25_3'][:, 11] * 1e6, 'analytical 0.25 above'),
]
for point_data, label in points:
    axes[2].scatter(range(len(point_data)), point_data, label=label)

for ax in axes:
    ax.legend()

plt.tight_layout()
plt.savefig('B3sphere_mp_all_py.png')
##############################
# Define the files and their paths
loc = './'  # Modify this if needed
files = {
    '0_25_3': loc + '0_25_above/measurements_spiral.ascii',
    '0_25_6': loc + '0_25_2_above/measurements_spiral.ascii',
    '0_5_3': loc + '0_5_above/measurements_spiral.ascii',
    '0_5_6': loc + '0_5_2_above/measurements_spiral.ascii'
}

# Load data from files
data = {key: np.loadtxt(fname) for key, fname in files.items()}

# Compute the magnetic field differences
def compute_differences(file_data):
    diff_x = file_data[:, 9] - file_data[:, 6]
    diff_y = file_data[:, 10] - file_data[:, 7]
    diff_z = file_data[:, 11] - file_data[:, 8]
    return np.sqrt(diff_x**2 + diff_y**2 + diff_z**2) * 1e6

differences = {key: compute_differences(value) for key, value in data.items()}

# Plotting
fig, ax = plt.subplots(figsize=(10, 6))
ax.set_ylim([-5, 4])
ax.grid(True, which='both', linestyle='--', linewidth=0.5)
ax.set_xlabel('point ID', fontname="courier", fontsize=14)
ax.set_ylabel('|ΔB| (μT)', fontname="courier", fontsize=14)

plot_data = [
    (differences['0_25_3'], '25 cm & 3 el/m'),
    (differences['0_25_6'], '25 cm & 6 el/m'),
    (differences['0_5_3'], '50 cm & 3 el/m'),
    (differences['0_5_6'], '50 cm & 6 el/m')
]

for diff_data, label in plot_data:
    ax.scatter(range(len(diff_data)), diff_data, label=label)

ax.legend()
plt.tight_layout()
plt.savefig('B3sphere_dif_mag_all_py.png')
##############################
def plot_data(ax, file_path):
    data = np.loadtxt(file_path)
    x = np.linspace(0,100,101)
    y1 = (data[:, 9] - data[:, 6]) * 1e6
    y2 = (data[:, 10] - data[:, 7]) * 1e6
    y3 = (data[:, 11] - data[:, 8]) * 1e6
    
    ax.plot(x, y1, 'o', label='Bx_a-Bx_c', linestyle='', color='blue')
    ax.plot(x, y2, 'o', label='By_a-By_c', linestyle='', color='green')
    ax.plot(x, y3, 'o', label='Bz_a-Bz_c', linestyle='', color='red')

titles = ['25 cm & 3 el/m', '25 cm & 6 el/m', '50 cm & 3 el/m', '50 cm & 6 el/m']
file_paths = [
    '0_25_above/measurements_spiral.ascii',
    '0_25_2_above/measurements_spiral.ascii',
    '0_5_above/measurements_spiral.ascii',
    '0_5_2_above/measurements_spiral.ascii'
]

fig, axs = plt.subplots(1, 4, figsize=(20, 6), sharey=True)

for ax, title, path in zip(axs, titles, file_paths):
    ax.set_title(title, fontname="courier", fontsize=14)
    ax.set_xlabel('point ID', fontname="courier", fontsize=14)
    ax.grid(True, which='both', linestyle='--', linewidth=0.5)
    ax.set_ylim(-5, 4)
    ax.set_xlim(0,100)
    plot_data(ax, path)
    ax.legend(loc='upper right')

axs[0].set_ylabel(r'$\Delta B_i (\mu T)$', fontname="courier", fontsize=14)

plt.tight_layout()
plt.savefig('B3sphere_dif_mp_splitcase_all_py.png')
##############################
