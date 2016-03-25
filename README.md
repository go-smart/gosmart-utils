# Go-Smart Utilities

The scripts in this directory may be useful in conjuction with other
Go-Smart tools, particularly in preparing output and validation.

## Simulation tools

### make_needles.sh

Run in the directory of a *goosefoot* simulation diagnostic output
(as returned by, for instance ``glot diagnostic XXXXX``) to
generate needle STL files. Requires *go-smart-needle-library*
(part of Goosefoot) to be installed
locally (and, in particular, the PythonOCC dependency). If working
with containerized Glossia, this means installing Goosefoot on the
host (or another machine) *outside* the container, as a normal
Python package.

It works by extracting the needle positions from GSSF-XML and
creating an XML input for *go-smart-needle-library*. Not
guaranteed to work in all situations, it makes a couple of
assumptions, but we haven't had incorrect output thus far. In
general, it should be pretty clear if there is an issue
as the needles will not line up with the rest of the output.
