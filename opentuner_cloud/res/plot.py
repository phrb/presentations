#!/usr/bin/env python
# a stacked bar plot with errorbars
import numpy as np
import matplotlib as mpl

mpl.use('ps')

import matplotlib.pyplot as plt

plt.rc('text', usetex=True)
plt.rc('font', family='serif')

N = 3
loc = (540, 453, 104)
ind = np.array([0, 0.25, 0.5])    # the x locations for the groups

width = 0.2

fig = plt.figure(1, figsize=(9, 6))

ax = fig.add_subplot(111)

ax.yaxis.grid(True, linestyle='-', which='major', color='darkgrey',
              alpha=1, zorder=0)

p1 = ax.bar(ind, loc, width, color='w', zorder=3)

plt.ylabel(r'Lines of Code')
plt.title(r'Lines of Code for Each Module')
plt.xticks(ind + width/2., (r'Server', r'GCEInterface', 'MeasurementClient'))
plt.yticks(np.arange(0, 600, 50))
plt.xlim([min(ind) - 0.3*width, max(ind) + 1.3*width])
#plt.legend((p1[0], p2[0]), (r'Non-Test', r'Unit Test'))

plt.savefig('loc_comparison.eps', format='eps', dpi=1000)
