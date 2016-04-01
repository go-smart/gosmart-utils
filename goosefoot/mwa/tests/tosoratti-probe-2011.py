# Define domain-specific problemname parameters
# Tosoratti 2003
# This is the probe taken from the paper:
#     A Coaxial Antenna With Miniaturized Choke for Minimally Invasive Interstitial Heating
#
# Copyright (C) 2014  Sheldon Hall (sheldon.hall@eng.ox.ac.uk)

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

from axisymm_mwa import *
import time as tm

start_time = tm.strftime('%H:%M:%S')
problemname = "tosoratti-probe-2011"
set_log_level(ERROR) # remove warnings for tests

EM_parameters.freq = 2.45e9 # Probe frequency
EM_parameters.om = 2 * pi * EM_parameters.freq # Probe angular frequency

# define Power in, inner and outer radius of coaxial dielectric for WPBC
#av = 1 # applied voltage
EM_parameters.Pin = 30. # applied power

# radius for WPBC
EM_parameters.r_1 = 0.0001016
EM_parameters.r_2 = 0.000305

# (eps_r, sig, mu_r)
tissue = [[0.0 for x in range(3)] for y in range(5)]
# values from tosoratti paper
tissue[1] = [2.2, 0.0, 1] # dielectric
tissue[2] = [10, 0.0, 1] # alumina
tissue[0] = [43.03, 1.69, 1] # liver
tissue[3] = [53.57, 1.81, 1] # muscle
tissue[4] = [69, 1.97, 1] # egg white

m=2

EM_parameters.eps_r_by_subdomain = [-1, tissue[0][0], tissue[1][0], tissue[m][0]]
EM_parameters.sigma_by_subdomain = [-1, tissue[0][1], tissue[1][1], tissue[m][1]]
EM_parameters.mu_r_by_subdomain = [-1, tissue[0][2], tissue[1][2], tissue[m][2]]

thermal_parameters.restrict_th_mesh = 1 # region to compute thermal solution in

EM_parameters.es1=tissue[0][0]*2.
EM_parameters.es2=0.
EM_parameters.es3=0.
EM_parameters.es4=0.
EM_parameters.ss1=tissue[0][1]*2.
EM_parameters.ss2=0.
EM_parameters.ss3=0.
EM_parameters.ss4=0.

# WPBC incident field expression from Gas paper
EM_parameters.Z_dielectric = sqrt(mu_0 * tissue[1][2] / (eps_0 * tissue[1][0]))
#C_dielectric = av/ln(r_2 / r_1)
EM_parameters.C_dielectric = sqrt((EM_parameters.Z_dielectric * EM_parameters.Pin) / (pi * ln(r_2 / r_1)))
EM_parameters.H_phi_0_re = Expression("(C / (Z * x[0]))",
                        Z=EM_parameters.Z_dielectric, C=EM_parameters.C_dielectric)
EM_parameters.H_phi_0_im = Constant("0.0")


# Load geometry
mesh = Mesh("mesh/%s.xml" % problemname)
boundaries = MeshFunction("size_t", mesh, "mesh/%s_facet_region.xml" % problemname)
interior = MeshFunction("size_t", mesh, "mesh/%s_physical_region.xml" % problemname)

# compute SAR
U, Q, E_r, E_z = compute_SAR_nl(problemname, mesh, interior, boundaries, EM_parameters, thermal_parameters.T0, thermal_parameters)

file_SAR=File("%s/SAR.pvd" % problemname)
file_SAR << Q

print 'start time: ', start_time
print 'end time:   ', tm.strftime('%H:%M:%S')
