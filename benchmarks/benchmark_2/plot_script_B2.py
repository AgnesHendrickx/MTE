import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

# Load data
def load_data(file1, file2):
    d1 = np.loadtxt(file1)
    d2 = np.loadtxt(file2, max_rows=200)
    return np.column_stack((d1, d2))

data1 = load_data('./d0/measurements_plane.ascii', './d0_1/measurements_plane.ascii')
data2 = load_data('./d0/measurements_plane.ascii', './d0_1_2_10_50/measurements_plane.ascii')

# Plot 1
fig = plt.figure(figsize=(18, 9))
ax = fig.add_subplot(111, projection='3d')
ax.set_xlabel('x-coordinate (m)')
ax.set_ylabel('y-coordinate (m)')
ax.set_zlabel('|B| (µT)')
#ax.set_zlim(-1e8, 0)

z1 = ((np.sqrt(data1[:, 15]**2 + data1[:, 16]**2 + data1[:, 17]**2) - 
      np.sqrt(data1[:, 6]**2 + data1[:, 7]**2 + data1[:, 8]**2)) * 1e6)
z2 = ((np.sqrt(data2[:, 15]**2 + data2[:, 16]**2 + data2[:, 17]**2) - 
      np.sqrt(data2[:, 6]**2 + data2[:, 7]**2 + data2[:, 8]**2)) * 1e6)

ax.scatter(data1[:, 0], data1[:, 1], z1, c='royalblue', marker='o', label='setup 1 - base')
ax.scatter(data2[:, 0], data2[:, 1], z2, c='coral', marker='s', label='setup 2 - base')
ax.legend()
plt.savefig('B2difference_3D_mag_py.png')

# Plot 2
fig = plt.figure(figsize=(18, 9))
components = ['B_x', 'B_y', 'B_z']
delta_indices = [(15, 6), (16, 7), (17, 8)]

for idx, (d_idx, comp) in enumerate(zip(delta_indices, components)):
    ax = fig.add_subplot(1, 3, idx+1, projection='3d')
    ax.set_xlabel('x-coordinate (m)')
    ax.set_ylabel('y-coordinate (m)')
    ax.set_zlabel(f'{comp} (µT)')
    
    z1 = (data1[:, d_idx[0]] - data1[:, d_idx[1]]) * 1e6
    z2 = (data2[:, d_idx[0]] - data2[:, d_idx[1]]) * 1e6

    ax.scatter(data1[:, 0], data1[:, 1], z1, c='royalblue', marker='o', label='setup 1 - base')
    ax.scatter(data2[:, 0], data2[:, 1], z2, c='coral', marker='s', label='setup 2 - base')

plt.tight_layout()
plt.savefig('B2difference_3D_mp_py.png')
plt.show()
