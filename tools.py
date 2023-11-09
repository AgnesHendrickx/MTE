import numpy as np

###################################################################################################


def export_mesh_3D(NV, nel, x, y, z, icon, filename, Mx, My, Mz, nnx, nny, nnz):
    """
    This function creates a VTU file that represents a 3D mesh with height data exported as point data and magnetization vectors exported as cell data.
    The VTU file can be visualized using Paraview software.


    :param NV: number of nodes.
    :type NV: scalar(int)
    :param nel:  number of elements.
    :type nel: scalar(int)
    :param x: 1D array(NV) containing x coordinate of each node.
    :type x: array_like(float)
    :param y: 1D array(NV) containing y coordinate of each node.
    :type y: array_like(float)
    :param z: 1D array(NV) containing z coordinate of each node.
    :type z: array_like(float)
    :param icon: 2D array(8,nel), containing connectivity, marking nodes that define an element, see code.
    :type icon: array_like(int)
    :param filename: the name of the output file (default: `mesh.vtu`)
    :type filename: str
    :param Mx: 1D array(nel) x component magnetization of each cell.
    :type Mx: array_like(float)
    :param My: 1D array(nel) y component magnetization of each cell.
    :type My: array_like(float)
    :param Mz: 1D array(nel) z component magnetization of each cell.
    :type Mz: array_like(float)
    :param nnx: number of nodes, x direction.
    :type nnx: scalar(int)
    :param nny: number of nodes, y direction.
    :type nny: scalar(int)
    :param nnz: number of nodes, z direction.
    :type nnz: scalar(int)

    :return:

    """
    vtufile = open(filename, "w")
    vtufile.write("<VTKFile type='UnstructuredGrid' version='0.1' byte_order='BigEndian'> \n")
    vtufile.write("<UnstructuredGrid> \n")
    vtufile.write("<Piece NumberOfPoints=' %5d ' NumberOfCells=' %5d '> \n" % (NV, nel))
    #####
    vtufile.write("<Points> \n")
    vtufile.write("<DataArray type='Float32' NumberOfComponents='3' Format='ascii'> \n")
    for i in range(0, NV):
        vtufile.write("%10f %10f %10f \n" % (x[i], y[i], z[i]))
    vtufile.write("</DataArray>\n")
    vtufile.write("</Points> \n")
    #####
    vtufile.write("<PointData Scalars='scalars'>\n")
    counter = 0
    zmin = 1e50
    for i in range(0, nnx):
        for j in range(0, nny):
            for k in range(0, nnz):
                if k == nnz - 1:
                   zmin = min(zmin, z[counter])
                counter += 1
    #print(zmin)
    vtufile.write("<DataArray type='Float32' Name='z' Format='ascii'> \n")
    for i in range (0, NV):
        vtufile.write("%10e\n" % max(z[i], zmin))
    vtufile.write("</DataArray>\n")
    vtufile.write("</PointData>\n")
    #####
    vtufile.write("<CellData Scalars='scalars'>\n")
    vtufile.write("<DataArray type='Float32' NumberOfComponents='3'\
                   Name='M vector' Format='ascii'> \n")
    for iel in range (0, nel):
        vtufile.write("%f %f %f \n" % (Mx[iel], My[iel], Mz[iel]))
    vtufile.write("</DataArray>\n")
    vtufile.write("<DataArray type='Float32' Name='Mx' Format='ascii'> \n")
    for iel in range (0, nel):
        vtufile.write("%f \n" % (Mx[iel]))
    vtufile.write("</DataArray>\n")
    vtufile.write("<DataArray type='Float32' Name='My' Format='ascii'> \n")
    for iel in range (0, nel):
        vtufile.write("%f \n" % (My[iel]))
    vtufile.write("</DataArray>\n")
    vtufile.write("<DataArray type='Float32' Name='Mz' Format='ascii'> \n")
    for iel in range (0, nel):
        vtufile.write("%f \n" % (Mz[iel]))
    vtufile.write("</DataArray>\n")
    vtufile.write("<DataArray type='Float32' Name='M' Format='ascii'> \n")
    for iel in range (0, nel):
        vtufile.write("%f \n" % (np.sqrt(Mx[iel]**2 + My[iel]**2 + Mz[iel]**2)))
    vtufile.write("</DataArray>\n")
    vtufile.write("</CellData>\n")
    #####
    vtufile.write("<Cells>\n")
    vtufile.write("<DataArray type='Int32' Name='connectivity' Format='ascii'> \n")
    for iel in range (0, nel):
        vtufile.write("%d %d %d %d %d %d %d %d\n" \
                       % (icon[0,iel], icon[1,iel], icon[2,iel], icon[3,iel],\
                          icon[4,iel], icon[5,iel], icon[6,iel], icon[7,iel]))
    vtufile.write("</DataArray>\n")
    vtufile.write("<DataArray type='Int32' Name='offsets' Format='ascii'> \n")
    for iel in range (0, nel):
        vtufile.write("%d \n" % ((iel + 1) * 8))
    vtufile.write("</DataArray>\n")
    vtufile.write("<DataArray type='Int32' Name='types' Format='ascii'>\n")
    for iel in range (0, nel):
        vtufile.write("%d \n" % 12)
    vtufile.write("</DataArray>\n")
    vtufile.write("</Cells>\n")
    #####
    vtufile.write("</Piece>\n")
    vtufile.write("</UnstructuredGrid>\n")
    vtufile.write("</VTKFile>\n")
    vtufile.close()

###################################################################################################


def export_mesh_2D(NV, nel, x, y, z, icon, filename):
    """
    This function creates a VTU file that represents a 2D mesh surface, which can be utilized for visualization in Paraview.

    :param NV: number of points.
    :type NV: scalar(int)
    :param nel:  number of elements.
    :type nel: scalar(int)
    :param x: 1D array(NV) containing x coordinate of each point.
    :type x: array_like(float)
    :param y: 1D array(NV) containing y coordinate of each point.
    :type y: array_like(float)
    :param z: 1D array(NV) containing z coordinate of each point.
    :type z: array_like(float)
    :param icon: 2D array(4,nel), containing connectivity, marking points that define an element, see code.
    :type icon: array_like(int)
    :param filename: the name of the output file (default: `mesh_plane_measurements.vtu`)
    :type filename: str

    :return:

    """
    vtufile = open(filename, "w")
    vtufile.write("<VTKFile type='UnstructuredGrid' version='0.1' byte_order='BigEndian'> \n")
    vtufile.write("<UnstructuredGrid> \n")
    vtufile.write("<Piece NumberOfPoints=' %5d ' NumberOfCells=' %5d '> \n" % (NV, nel))
    #####
    vtufile.write("<Points> \n")
    vtufile.write("<DataArray type='Float32' NumberOfComponents='3' Format='ascii'> \n")
    for i in range(0, NV):
        vtufile.write("%10e %10e %10e \n" % (x[i], y[i], z[i]))
    vtufile.write("</DataArray>\n")
    vtufile.write("</Points> \n")
    #####
    vtufile.write("<Cells>\n")
    vtufile.write("<DataArray type='Int32' Name='connectivity' Format='ascii'> \n")
    for iel in range (0, nel):
        vtufile.write("%d %d %d %d \n" % (icon[0,iel], icon[1,iel], icon[2,iel], icon[3,iel]))
    vtufile.write("</DataArray>\n")
    vtufile.write("<DataArray type='Int32' Name='offsets' Format='ascii'> \n")
    for iel in range (0, nel):
        vtufile.write("%d \n" % ((iel + 1) * 4))
    vtufile.write("</DataArray>\n")
    vtufile.write("<DataArray type='Int32' Name='types' Format='ascii'>\n")
    for iel in range (0, nel):
        vtufile.write("%d \n" % 9)
    vtufile.write("</DataArray>\n")
    vtufile.write("</Cells>\n")
    #####
    vtufile.write("</Piece>\n")
    vtufile.write("</UnstructuredGrid>\n")
    vtufile.write("</VTKFile>\n")
    vtufile.close()

###################################################################################################


def export_mesh_1D(npath, xpath, ypath, zpath, filename):
    """
    Export 1D path to vtu file (plot with paraview), can be used in main visualize measurement path.

    :param npath: number of measurement points of the line.
    :type npath: scalar(int)
    :param xpath: 1D array(npath) containing x coordinate of each measurement point.
    :type xpath: array_like(float)
    :param ypath: 1D array(npath) containing y coordinate of each measurement point.
    :type ypath: array_like(float)
    :param zpath: 1D array(npath) containing z coordinate of each measurement point.
    :type zpath: array_like(float)
    :param filename: the name of the output file (default: `path.vtu`)
    :type filename: str

    :return:

    """
    vtufile = open(filename, "w")
    vtufile.write("<VTKFile type='UnstructuredGrid' version='0.1' byte_order='BigEndian'> \n")
    vtufile.write("<UnstructuredGrid> \n")
    vtufile.write("<Piece NumberOfPoints=' %5d ' NumberOfCells=' %5d '> \n" % (npath, npath))
    #####
    vtufile.write("<Points> \n")
    vtufile.write("<DataArray type='Float32' NumberOfComponents='3' Format='ascii'>\n")
    for i in range(0, npath):
        vtufile.write("%10e %10e %10e \n" % (xpath[i], ypath[i], zpath[i]))
    vtufile.write("</DataArray>\n")
    vtufile.write("</Points> \n")
    #####
    vtufile.write("<Cells>\n")
    vtufile.write("<DataArray type='Int32' Name='connectivity' Format='ascii'> \n")
    for i in range(0, npath):
        vtufile.write("%d " % i)
    vtufile.write("</DataArray>\n")
    vtufile.write("<DataArray type='Int32' Name='offsets' Format='ascii'> \n")
    for i in range(0, npath):
        vtufile.write("%d " % (i + 1))
    vtufile.write("</DataArray>\n")
    vtufile.write("<DataArray type='Int32' Name='types' Format='ascii'>\n")
    for i in range(0, npath):
        vtufile.write("%d " % 1)
    vtufile.write("</DataArray>\n")
    vtufile.write("</Cells>\n")
    #####
    vtufile.write("</Piece>\n")
    vtufile.write("</UnstructuredGrid>\n")
    vtufile.write("</VTKFile>\n")
    vtufile.close()

    print('produced path.vtu')

###################################################################################################


def export_plane_measurements(NV, nel, x, y, z, icon, filename, B_vi, B_si, B_th):
    """
    Export 2D plane measurements to vtu file (plot with paraview), used for exporting plane measurements with magnetic field strength (**B**) computed by analytical solution, surface integral or volume integral as vectors. If this function is used, but the volume integral is not used (default = not used, see :doc:`computational_approach`), or a setup does not have an analytical solution (:ref:`flank simulations <flanksim>` and :doc:`etna`), the values from surface integral computation are duplicated.

    :param NV: number of measurement points of the plane.
    :type NV: scalar(int)
    :param nel:  number of elements of the measurement plane.
    :type nel: scalar(int)
    :param x: 1D array(NV) containing x coordinate of each measurement point.
    :type x: array_like(float)
    :param y: 1D array(NV) containing y coordinate of each measurement point.
    :type y: array_like(float)
    :param z: 1D array(NV) containing z coordinate of each measurement point.
    :type z: array_like(float)
    :param icon: 2D array(4,nel), containing connectivity, marking point that define an element, see code.
    :type icon: array_like(int)
    :param filename: the name of the output file (default: `plane_measurements.vtu`)
    :type filename: str
    :param B_vi: 2D array(3,NV), containing components (0=x;1=y;2=z,NV) of the computed magnetic field due to the underlying magnetized matter (anomalous field) at each measurement point computed by volume integral.
    :type B_vi: array_like(float)
    :param B_si: 2D array(3,NV), containing components (0=x;1=y;2=z,NV) of the computed magnetic field due to the underlying magnetized matter (anomalous field) at each measurement point computed by surface integral.
    :type B_si: array_like(float)
    :param B_th: 2D array(3,NV), containing components (0=x;1=y;2=z,NV) of the computed magnetic field due to the underlying magnetized matter (anomalous field) at each measurement point computed by analytical solution.
    :type B_th: array_like(float)

    :return:

    """
    vtufile = open(filename, "w")
    vtufile.write("<VTKFile type='UnstructuredGrid' version='0.1' byte_order='BigEndian'> \n")
    vtufile.write("<UnstructuredGrid> \n")
    vtufile.write("<Piece NumberOfPoints=' %5d ' NumberOfCells=' %5d '> \n" % (NV, nel))
    #####
    vtufile.write("<Points> \n")
    vtufile.write("<DataArray type='Float32' NumberOfComponents='3' Format='ascii'> \n")
    for i in range(0, NV):
        vtufile.write("%10e %10e %10e \n" % (x[i], y[i], z[i]))
    vtufile.write("</DataArray>\n")
    vtufile.write("</Points> \n")
    #####
    vtufile.write("<PointData Scalars='scalars'>\n")
    vtufile.write("<DataArray type='Float32' NumberOfComponents='3' Name='B (vol int)'\
                   Format='ascii'> \n")
    for i in range(0, NV):
        vtufile.write("%10e %10e %10e \n" % (B_vi[0,i], B_vi[1,i], B_vi[2,i]))
    vtufile.write("</DataArray>\n")
    vtufile.write("<DataArray type='Float32' NumberOfComponents='3' Name='B (surf int)'\
                   Format='ascii'> \n")
    for i in range(0, NV):
        vtufile.write("%10e %10e %10e \n" % (B_si[0,i], B_si[1,i], B_si[2,i]))
    vtufile.write("</DataArray>\n")
    if abs(np.max(B_th) - np.min(B_th)) > 1e-12:
       vtufile.write("<DataArray type='Float32' NumberOfComponents='3' Name='B (analytical)'\
                      Format='ascii'> \n")
       for i in range(0, NV):
           vtufile.write("%e %e %e \n" % (B_th[0,i], B_th[1,i], B_th[2,i]))
       vtufile.write("</DataArray>\n")
    vtufile.write("</PointData>\n")
    #####
    vtufile.write("<Cells>\n")
    vtufile.write("<DataArray type='Int32' Name='connectivity' Format='ascii'> \n")
    for iel in range (0, nel):
        vtufile.write("%d %d %d %d \n" % (icon[0,iel], icon[1,iel], icon[2,iel], icon[3,iel]))
    vtufile.write("</DataArray>\n")
    vtufile.write("<DataArray type='Int32' Name='offsets' Format='ascii'> \n")
    for iel in range (0, nel):
        vtufile.write("%d \n" % ((iel + 1) * 4))
    vtufile.write("</DataArray>\n")
    vtufile.write("<DataArray type='Int32' Name='types' Format='ascii'>\n")
    for iel in range (0, nel):
        vtufile.write("%d \n" % 9)
    vtufile.write("</DataArray>\n")
    vtufile.write("</Cells>\n")
    #####
    vtufile.write("</Piece>\n")
    vtufile.write("</UnstructuredGrid>\n")
    vtufile.write("</VTKFile>\n")
    vtufile.close()

###################################################################################################


def export_line_measurements(N, x, y, z, filename, B_vi, B_si, B_th):
    """
    Export 1D line measurements to vtu file (plot with paraview), used for exporting line measurements with magnetic field strength (**B**) computed by analytical solution, surface integral or volume integral as vectors. If this function is used, but the volume integral is not used (default = not used, see :doc:`computational_approach`), or a setup does not have an analytical solution (:ref:`flank simulations <flanksim>` and :doc:`etna`), the values from surface integral computation are duplicated.

    :param N: number of measurement points of the line or path.
    :type N: scalar(int)
    :param x: 1D array(N) containing x coordinate of each measurement point.
    :type x: array_like(float)
    :param y: 1D array(N) containing y coordinate of each measurement point.
    :type y: array_like(float)
    :param z: 1D array(N) containing z coordinate of each measurement point.
    :type z: array_like(float)
    :param filename: the name of the output file (default: `line_measurements.vtu`)
    :type filename: str
    :param B_vi: 2D array(3,NV), containing components (0=x;1=y;2=z,N) of the computed magnetic field due to the underlying magnetized matter (anomalous field) at each measurement point computed by volume integral.
    :type B_vi: array_like(float)
    :param B_si: 2D array(3,N), containing components (0=x;1=y;2=z,N) of the computed magnetic field due to the underlying magnetized matter (anomalous field) at each measurement point computed by surface integral.
    :type B_si: array_like(float)
    :param B_th: 2D array(3,N), containing components (0=x;1=y;2=z,N) of the computed magnetic field due to the underlying magnetized matter (anomalous field) at each measurement point computed by analytical solution.
    :type B_th: array_like(float)

    :return:

    """

    vtufile = open(filename, "w")
    vtufile.write("<VTKFile type='UnstructuredGrid' version='0.1' byte_order='BigEndian'> \n")
    vtufile.write("<UnstructuredGrid> \n")
    vtufile.write("<Piece NumberOfPoints=' %5d ' NumberOfCells=' %5d '> \n" % (N, N - 1))
    #####
    vtufile.write("<Points> \n")
    vtufile.write("<DataArray type='Float32' NumberOfComponents='3' Format='ascii'> \n")
    for i in range(0, N):
        vtufile.write("%10e %10e %10e \n" % (x[i], y[i], z[i]))
    vtufile.write("</DataArray>\n")
    vtufile.write("</Points> \n")
    #####
    vtufile.write("<PointData Scalars='scalars'>\n")
    vtufile.write("<DataArray type='Float32' NumberOfComponents='3' Name='B (vol int)'\
                   Format='ascii'> \n")
    for i in range(0, N):
        vtufile.write("%e %e %e \n" % (B_vi[0,i], B_vi[1,i], B_vi[2,i]))
    vtufile.write("</DataArray>\n")
    vtufile.write("<DataArray type='Float32' NumberOfComponents='3' Name='B (surf int)'\
                   Format='ascii'> \n")
    for i in range(0, N):
        vtufile.write("%e %e %e \n" % (B_si[0,i], B_si[1,i], B_si[2,i]))
    vtufile.write("</DataArray>\n")
    if abs(np.max(B_th) - np.min(B_th)) > 1e-12:
       vtufile.write("<DataArray type='Float32' NumberOfComponents='3' Name='B (analytical)'\
                      Format='ascii'> \n")
       for i in range(0, N):
           vtufile.write("%e %e %e \n" % (B_th[0,i], B_th[1,i], B_th[2,i]))
       vtufile.write("</DataArray>\n")
    vtufile.write("</PointData>\n")
    #####
    vtufile.write("<Cells>\n")
    vtufile.write("<DataArray type='Int32' Name='connectivity' Format='ascii'> \n")
    for i in range (0, N - 1):
        vtufile.write("%d %d \n" % (i, i + 1))
    vtufile.write("</DataArray>\n")
    vtufile.write("<DataArray type='Int32' Name='offsets' Format='ascii'> \n")
    for i in range (0, N - 1):
        vtufile.write("%d \n" % ((i + 1) * 2))
    vtufile.write("</DataArray>\n")
    vtufile.write("<DataArray type='Int32' Name='types' Format='ascii'>\n")
    for iel in range (0, N - 1):
        vtufile.write("%d \n" % 3)
    vtufile.write("</DataArray>\n")
    vtufile.write("</Cells>\n")
    #####
    vtufile.write("</Piece>\n")
    vtufile.write("</UnstructuredGrid>\n")
    vtufile.write("</VTKFile>\n")
    vtufile.close()

###################################################################################################


def export_spiral_measurements(N, x, y, z, filename, B_vi, B_si, B_th):
    """
    Export 1D spiral measurements to vtu file (plot with paraview), used for exporting spiral measurements with magnetic field strength (**B**) computed by analytical solution, surface integral or volume integral as vectors. If this function is used, but the volume integral is not used (default = not used, see :doc:`computational_approach`), or a setup does not have an analytical solution (:ref:`flank simulations <flanksim>` and :doc:`etna`), the values from surface integral computation are duplicated.

    :param N: number of measurement points of the spiral.
    :type N: scalar(int)
    :param x: 1D array(N) containing x coordinate of each measurement point.
    :type x: array_like(float)
    :param y: 1D array(N) containing y coordinate of each measurement point.
    :type y: array_like(float)
    :param z: 1D array(N) containing z coordinate of each measurement point.
    :type z: array_like(float)
    :param filename: the name of the output file (default: `line_measurements.vtu`)
    :type filename: str
    :param B_vi: 2D array(3,N), containing components (0=x;1=y;2=z,N) of the computed magnetic field due to the underlying magnetized matter (anomalous field) at each measurement point computed by volume integral.
    :type B_vi: array_like(float)
    :param B_si: 2D array(3,N), containing components (0=x;1=y;2=z,N) of the computed magnetic field due to the underlying magnetized matter (anomalous field) at each measurement point computed by surface integral.
    :type B_si: array_like(float)
    :param B_th: 2D array(3,N), containing components (0=x;1=y;2=z,N) of the computed magnetic field due to the underlying magnetized matter (anomalous field) at each measurement point computed by analytical solution.
    :type B_th: array_like(float)

    :return:

    """
    vtufile = open(filename, "w")
    vtufile.write("<VTKFile type='UnstructuredGrid' version='0.1' byte_order='BigEndian'> \n")
    vtufile.write("<UnstructuredGrid> \n")
    vtufile.write("<Piece NumberOfPoints=' %5d ' NumberOfCells=' %5d '> \n" % (N, N))
    #####
    vtufile.write("<Points> \n")
    vtufile.write("<DataArray type='Float32' NumberOfComponents='3' Format='ascii'> \n")
    for i in range(0, N):
        vtufile.write("%10f %10f %10f \n" % (x[i], y[i], z[i]))
    vtufile.write("</DataArray>\n")
    vtufile.write("</Points> \n")
    #####
    vtufile.write("<PointData Scalars='scalars'>\n")
    vtufile.write("<DataArray type='Float32' NumberOfComponents='3' Name='B (vol int)'\
                   Format='ascii'> \n")
    for i in range(0, N):
        vtufile.write("%e %e %e \n" % (B_vi[0,i], B_vi[1,i], B_vi[2,i]))
    vtufile.write("</DataArray>\n")
    vtufile.write("<DataArray type='Float32' NumberOfComponents='3' Name='B (surf int)'\
                   Format='ascii'> \n")
    for i in range(0, N):
        vtufile.write("%e %e %e \n" % (B_si[0,i], B_si[1,i], B_si[2,i]))
    vtufile.write("</DataArray>\n")
    if abs(np.max(B_th) - np.min(B_th)) > 1e-12:
       vtufile.write("<DataArray type='Float32' NumberOfComponents='3' Name='B (analytical)'\
                      Format='ascii'> \n")
       for i in range(0, N):
           vtufile.write("%e %e %e \n" % (B_th[0,i], B_th[1,i], B_th[2,i]))
       vtufile.write("</DataArray>\n")
    vtufile.write("</PointData>\n")
    #####
    vtufile.write("<Cells>\n")
    vtufile.write("<DataArray type='Int32' Name='connectivity' Format='ascii'> \n")
    for i in range (0, N):
        vtufile.write("%d \n" % i)
    vtufile.write("</DataArray>\n")
    vtufile.write("<DataArray type='Int32' Name='offsets' Format='ascii'> \n")
    for i in range (0, N):
        vtufile.write("%d \n" % (i + 1))
    vtufile.write("</DataArray>\n")
    vtufile.write("<DataArray type='Int32' Name='types' Format='ascii'>\n")
    for iel in range (0, N):
        vtufile.write("%d \n" % 1)
    vtufile.write("</DataArray>\n")
    vtufile.write("</Cells>\n")
    #####
    vtufile.write("</Piece>\n")
    vtufile.write("</UnstructuredGrid>\n")
    vtufile.write("</VTKFile>\n")
    vtufile.close()

    ###################################################################################################