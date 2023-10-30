import numpy as np
import matplotlib.pyplot as plt


loc = './'

# Load data
data = np.loadtxt(loc+'measurements_line.ascii', usecols=(6,7,8,9,10,11))
x = np.linspace(0,20,21)
Bx_computed = data[:, 0] * 1e-3
By_computed = data[:, 1] * 1e-3
Bz_computed = data[:, 2] * 1e-3
Bx_analytical = data[:, 3] * 1e-3
By_analytical = data[:, 4] * 1e-3
Bz_analytical = data[:, 5] * 1e-3

# Set style
styles = {
    1: {'marker': 'o', 'linestyle': '-', 'linewidth': 4, 'markersize': 8, 'color': 'royalblue'},
    2: {'marker': 's', 'linestyle': '-', 'linewidth': 2, 'markersize': 2, 'color': 'green'},
    3: {'marker': '^', 'linestyle': '-', 'linewidth': 2, 'markersize': 4, 'color': 'coral'},
    4: {'marker': '^', 'linestyle': '-', 'linewidth': 2, 'markersize': 4, 'color': 'olive'},
    5: {'marker': '^', 'linestyle': '-', 'linewidth': 2, 'markersize': 4, 'color': 'gold'},
}

# Plot B4.png
fig, axs = plt.subplots(1, 3, figsize=(20, 6))

# Plot Bx_a
axs[0].plot(x, Bx_computed, **styles[1], label='computed')
axs[0].plot(x, Bx_analytical, **styles[2], label='analytical')
axs[0].set_ylabel('Bx_a (µT)', fontname="courier", fontsize=14)
axs[0].grid(True, linestyle='--', linewidth=0.5, which='both')

# Plot By_a
axs[1].plot(x, By_computed, **styles[1], label='computed')
axs[1].plot(x, By_analytical, **styles[2], label='analytical')
axs[1].set_ylabel('By_a (µT)', fontname="courier", fontsize=14)
axs[1].grid(True, linestyle='--', linewidth=0.5, which='both')
axs[1].legend(loc="upper right")

# Plot Bz_a
axs[2].plot(x, Bz_computed, **styles[1], label='computed')
axs[2].plot(x, Bz_analytical, **styles[2], label='analytical')
axs[2].set_ylabel('Bz_a (µT)', fontname="courier", fontsize=14)
axs[2].grid(True, linestyle='--', linewidth=0.5, which='both')

plt.tight_layout()
plt.savefig('B4_py.png')

# Plot B4_dif.png
fig, ax = plt.subplots(figsize=(10, 6))

ax.plot(x, Bx_analytical - Bx_computed, **styles[3], label='(Bx_{analytical} - Bx_{computed})')
ax.plot(x, By_analytical - By_computed, **styles[4], label='(By_{analytical} - By_{computed})')
ax.plot(x, Bz_analytical - Bz_computed, **styles[5], label='(Bz_{analytical} - Bz_{computed})')

ax.set_ylabel('ΔBi_a (µT)', fontname="courier", fontsize=14)
ax.grid(True, linestyle='--', linewidth=0.5, which='both')
ax.legend(loc="upper right")

plt.tight_layout()
plt.savefig('B4_dif_py.png')
plt.show()

