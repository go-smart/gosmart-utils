from __future__ import print_function

import sys
import numpy as N
from matplotlib import pyplot
import math

plot = zip(*N.genfromtxt(sys.argv[1], delimiter=' '))
pyplot.scatter(plot[0], plot[1], c=N.log10(plot[2]), marker='+')
pyplot.show()
