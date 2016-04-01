#!/bin/python3

import vtk as v
import sys
import os
import glob
import traceback
import argparse


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--power", help="power level to convert")
    parser.add_argument("--step",
                        help="step to use for power (default: take highest)")
    parser.add_argument("--prefix", default="tosoratti-probe-sensitivity",
                        help="directory to use for VTU profiles "
                        "(default: tosoratti-probe-sensitivity)")
    args = parser.parse_args()
    prefix = args.prefix
    power = int(args.power)

    if args.step:
        vtu = "%s-%d/Q_over_sigma%s.vtu" % (prefix, power, args.step)
    else:
        # Change (not creation) time - cf. mtime
        vtus = glob.glob('%s-%d/Q_over_sigma*.vtu' % (prefix, power))
        vtus.sort(key=os.path.getctime)

        try:
            vtu = vtus[-1]
        except KeyError:
            raise RuntimeError("No VTUs found for power")

    reader = v.vtkXMLUnstructuredGridReader()
    reader.SetFileName(vtu)
    reader.Update()

    unstructured_grid = reader.GetOutput()

    cell_data_to_point_data = v.vtkCellDataToPointData()
    cell_data_to_point_data.SetInputData(unstructured_grid)
    cell_data_to_point_data.Update()

    point_grid = cell_data_to_point_data.GetOutput()
    points = point_grid.GetPoints()
    data = point_grid.GetPointData().GetScalars()

    for i in range(points.GetNumberOfPoints()):
        point = points.GetPoint(i)
        datum = data.GetComponent(i, 0)
        print("%lf %lf %g" % (point[0], point[1], datum))


if __name__ == "__main__":
    try:
        main()
    except Exception as e:
        traceback.print_exc()
        sys.exit(1)
