import numpy as np
from numba import jit

epsilon = 1e-20

###############################################################################


@jit(nopython=True)
def cross(a, b):
    """
    | Produces vector (cross) product of two vectors. :math:`\\vec{a} \\times \\vec{b} = \\vec{c}`

    :param a: 1D array(3) containing 3 components (0=x;1=y;2=z) of vector **a**.
    :type a: array_like(float)
    :param b: 1D array(3) containing 3 components (0=x;1=y;2=z) of vector **b**.
    :type b: array_like(float)

    :return:
      - **c** *(array_like(float))* - 1D array(3) containing 3 components (0=x;1=y;2=z) of vector **c**..

    """
    cx = a[1] * b[2] - a[2] * b[1]
    cy = a[2] * b[0] - a[0] * b[2]
    cz = a[0] * b[1] - a[1] * b[0]
    return np.array([cx, cy, cz], dtype=np.float64)


###############################################################################


@jit(nopython=True)
def qcoords_1D(nqpts):
    """
    Determines the coordinates of the quadrature points depending on the amount chosen.

    :param nqpts: the number of quadrature points per dimension.
    :type nqpts: scalar(int)

    :return:
      - **coordsq** *(array_like(float))* - 1D array(nqpts) containing coordinates of quadrature points.

    """

    if nqpts == 1:
       return np.array([0], dtype=np.float64)

    if nqpts == 2:
       return np.array([-1.0 / np.sqrt(3.0), 1.0 / np.sqrt(3.0)], dtype=np.float64)

    if nqpts == 3:
       return np.array([-np.sqrt(3 / 5), 0.0, np.sqrt(3 / 5)], dtype=np.float64)

    if nqpts == 4:
       qc4a = np.sqrt(3.0 / 7.0 + 2.0 / 7.0 * np.sqrt(6.0 / 5.0))
       qc4b = np.sqrt(3.0 / 7.0 - 2.0 / 7.0 * np.sqrt(6.0 / 5.0))
       return np.array([-qc4a, -qc4b, qc4b, qc4a], dtype=np.float64)

    if nqpts == 5:
       qc5a = np.sqrt(5.0 + 2.0 * np.sqrt(10.0 / 7.0)) / 3.0
       qc5b = np.sqrt(5.0 - 2.0 * np.sqrt(10.0 / 7.0)) / 3.0
       qc5c = 0.0
       return np.array([-qc5a, -qc5b, qc5c, qc5b, qc5a], dtype=np.float64)

    if nqpts == 6:
       return np.array(
           [
               -0.932469514203152,
               -0.661209386466265,
               -0.238619186083197,
               +0.238619186083197,
               +0.661209386466265,
               +0.932469514203152,
           ],
           dtype=np.float64,
       )

    if nqpts == 7:
       return np.array(
           [
               -0.9491079123427585,
               -0.7415311855993945,
               -0.4058451513773972,
               0.0000000000000000,
               0.4058451513773972,
               0.7415311855993945,
               0.9491079123427585,
           ],
           dtype=np.float64,
       )

    if nqpts == 8:
       return np.array(
           [
               -0.9602898564975363,
               -0.7966664774136267,
               -0.5255324099163290,
               -0.1834346424956498,
               0.1834346424956498,
               0.5255324099163290,
               0.7966664774136267,
               0.9602898564975363,
           ],
           dtype=np.float64,
       )

    if nqpts == 9:
       return np.array(
           [
               -0.9681602395076261,
               -0.8360311073266358,
               -0.6133714327005904,
               -0.3242534234038089,
               0.0000000000000000,
               0.3242534234038089,
               0.6133714327005904,
               0.8360311073266358,
               0.9681602395076261,
           ],
           dtype=np.float64,
       )

    if nqpts == 10:
       return np.array(
           [
               -0.973906528517172,
               -0.865063366688985,
               -0.679409568299024,
               -0.433395394129247,
               -0.148874338981631,
               0.148874338981631,
               0.433395394129247,
               0.679409568299024,
               0.865063366688985,
               0.973906528517172,
           ],
           dtype=np.float64,
       )


###############################################################################


@jit(nopython=True)
def qweights_1D(nqpts):
    """
    Determines the weights of the quadrature points depending on the amount chosen.

    :param nqpts: the number of quadrature points per dimension.
    :type nqpts: scalar(int)

    :return:
      - **weightsq** *(array_like(float))* - 1D array(nqpts) containing weights of quadrature points.

    """

    if nqpts == 1:
       return np.array([2], dtype=np.float64)

    if nqpts == 2:
       return np.array([1.0, 1.0], dtype=np.float64)

    if nqpts == 3:
       return np.array([5 / 9, 8 / 9, 5 / 9], dtype=np.float64)

    if nqpts == 4:
       qw4a = (18 - np.sqrt(30.0)) / 36.0
       qw4b = (18 + np.sqrt(30.0)) / 36
       return np.array([qw4a, qw4b, qw4b, qw4a], dtype=np.float64)

    if nqpts == 5:
       qw5a = (322.0 - 13.0 * np.sqrt(70.0)) / 900.0
       qw5b = (322.0 + 13.0 * np.sqrt(70.0)) / 900.0
       qw5c = 128.0 / 225.0
       return np.array([qw5a, qw5b, qw5c, qw5b, qw5a], dtype=np.float64)

    if nqpts == 6:
       return np.array(
           [
               0.171324492379170,
               0.360761573048139,
               0.467913934572691,
               0.467913934572691,
               0.360761573048139,
               0.171324492379170,
           ],
           dtype=np.float64,
       )

    if nqpts == 7:
       return np.array(
           [
               0.1294849661688697,
               0.2797053914892766,
               0.3818300505051189,
               0.4179591836734694,
               0.3818300505051189,
               0.2797053914892766,
               0.1294849661688697,
           ],
           dtype=np.float64,
       )

    if nqpts == 8:
       return np.array(
           [
               0.1012285362903763,
               0.2223810344533745,
               0.3137066458778873,
               0.3626837833783620,
               0.3626837833783620,
               0.3137066458778873,
               0.2223810344533745,
               0.1012285362903763,
           ],
           dtype=np.float64,
       )

    if nqpts == 9:
       return np.array(
           [
               0.0812743883615744,
               0.1806481606948574,
               0.2606106964029354,
               0.3123470770400029,
               0.3302393550012598,
               0.3123470770400029,
               0.2606106964029354,
               0.1806481606948574,
               0.0812743883615744,
           ],
           dtype=np.float64,
       )

    if nqpts == 10:
       return np.array(
           [
               0.066671344308688,
               0.149451349150581,
               0.219086362515982,
               0.269266719309996,
               0.295524224714753,
               0.295524224714753,
               0.269266719309996,
               0.219086362515982,
               0.149451349150581,
               0.066671344308688,
           ],
           dtype=np.float64,
       )


###############################################################################


@jit(nopython=True)  # TODO fill docstrings #CT
def NNN(r, s, t):
    """
    {DESCRIPTION FUNCTION} Q1 basis functions inside the [-1:1]x[-1:1]x[-1:1] reference element

    :param r: ** - 1D array(nqpts) containing {DESCRIPTION PARAMETER}
    :type r: (array_like(float))
    :param s: 1D array(nqpts) containing {DESCRIPTION PARAMETER}
    :type s: (array_like(float))
    :param t: 1D array(nqpts) containing {DESCRIPTION PARAMETER}
    :type t: (array_like(float))

    :return:
      - **N** *(array_like(float))* - 1D array(8) containing {DESCRIPTION RETURN PARAMETER}

    """

    N0 = 0.125 * (1.0 - r) * (1.0 - s) * (1.0 - t)
    N1 = 0.125 * (1.0 + r) * (1.0 - s) * (1.0 - t)
    N2 = 0.125 * (1.0 + r) * (1.0 + s) * (1.0 - t)
    N3 = 0.125 * (1.0 - r) * (1.0 + s) * (1.0 - t)
    N4 = 0.125 * (1.0 - r) * (1.0 - s) * (1.0 + t)
    N5 = 0.125 * (1.0 + r) * (1.0 - s) * (1.0 + t)
    N6 = 0.125 * (1.0 + r) * (1.0 + s) * (1.0 + t)
    N7 = 0.125 * (1.0 - r) * (1.0 + s) * (1.0 + t)
    return np.array([N0, N1, N2, N3, N4, N5, N6, N7], dtype=np.float64)


@jit(nopython=True)
def dNNNdr(r, s, t):  # TODO fill docstrings #CT
    """
    {DESCRIPTION FUNCTION}

    :param r: ** - 1D array(nqpts) containing {DESCRIPTION PARAMETER}
    :type r: (array_like(float))
    :param s: 1D array(nqpts) containing {DESCRIPTION PARAMETER}
    :type s: (array_like(float))
    :param t: 1D array(nqpts) containing {DESCRIPTION PARAMETER}
    :type t: (array_like(float))

    :return:
      - **dNdr** *(array_like(float))* - 1D array(8) containing {DESCRIPTION RETURN PARAMETER}

    """
    dNdr0 = -0.125 * (1.0 - s) * (1.0 - t)
    dNdr1 = +0.125 * (1.0 - s) * (1.0 - t)
    dNdr2 = +0.125 * (1.0 + s) * (1.0 - t)
    dNdr3 = -0.125 * (1.0 + s) * (1.0 - t)
    dNdr4 = -0.125 * (1.0 - s) * (1.0 + t)
    dNdr5 = +0.125 * (1.0 - s) * (1.0 + t)
    dNdr6 = +0.125 * (1.0 + s) * (1.0 + t)
    dNdr7 = -0.125 * (1.0 + s) * (1.0 + t)
    return np.array(
        [dNdr0, dNdr1, dNdr2, dNdr3, dNdr4, dNdr5, dNdr6, dNdr7], dtype=np.float64
    )


@jit(nopython=True)
def dNNNds(r, s, t):  # TODO fill docstrings #CT
    """
    {DESCRIPTION FUNCTION}

    :param r: ** - 1D array(nqpts) containing {DESCRIPTION PARAMETER}
    :type r: (array_like(float))
    :param s: 1D array(nqpts) containing {DESCRIPTION PARAMETER}
    :type s: (array_like(float))
    :param t: 1D array(nqpts) containing {DESCRIPTION PARAMETER}
    :type t: (array_like(float))

    :return:
      - **dNds** *(array_like(float))* - 1D array(8) containing {DESCRIPTION RETURN PARAMETER}

    """
    dNds0 = -0.125 * (1.0 - r) * (1.0 - t)
    dNds1 = -0.125 * (1.0 + r) * (1.0 - t)
    dNds2 = +0.125 * (1.0 + r) * (1.0 - t)
    dNds3 = +0.125 * (1.0 - r) * (1.0 - t)
    dNds4 = -0.125 * (1.0 - r) * (1.0 + t)
    dNds5 = -0.125 * (1.0 + r) * (1.0 + t)
    dNds6 = +0.125 * (1.0 + r) * (1.0 + t)
    dNds7 = +0.125 * (1.0 - r) * (1.0 + t)
    return np.array(
        [dNds0, dNds1, dNds2, dNds3, dNds4, dNds5, dNds6, dNds7], dtype=np.float64
    )


@jit(nopython=True)
def dNNNdt(r, s, t):  # TODO fill docstrings #CT
    """
    {DESCRIPTION FUNCTION}

    :param r: ** - 1D array(nqpts) containing {DESCRIPTION PARAMETER}
    :type r: (array_like(float))
    :param s: 1D array(nqpts) containing {DESCRIPTION PARAMETER}
    :type s: (array_like(float))
    :param t: 1D array(nqpts) containing {DESCRIPTION PARAMETER}
    :type t: (array_like(float))

    :return:
      - **dNdt** *(array_like(float))* - 1D array(8) containing {DESCRIPTION RETURN PARAMETER}

    """
    dNdt0 = -0.125 * (1.0 - r) * (1.0 - s)
    dNdt1 = -0.125 * (1.0 + r) * (1.0 - s)
    dNdt2 = -0.125 * (1.0 + r) * (1.0 + s)
    dNdt3 = -0.125 * (1.0 - r) * (1.0 + s)
    dNdt4 = +0.125 * (1.0 - r) * (1.0 - s)
    dNdt5 = +0.125 * (1.0 + r) * (1.0 - s)
    dNdt6 = +0.125 * (1.0 + r) * (1.0 + s)
    dNdt7 = +0.125 * (1.0 - r) * (1.0 + s)
    return np.array(
        [dNdt0, dNdt1, dNdt2, dNdt3, dNdt4, dNdt5, dNdt6, dNdt7], dtype=np.float64
    )


###############################################################################


@jit(nopython=True)
def compute_B_quadrature(xmeas, ymeas, zmeas, x, y, z, icon, Mx, My, Mz, nqdim):  # TODO check docstrings #CT
    """
    | Solves volume integral, numerical solution, as the volume integral is parameterized by the number of quadrature points per dimension (nqdim). Computes magnetic field components based on 2^3 quadrature point integration produced by a single hexahedron (cuboid) carrying a magnetization vector (Mx,My,Mz) assumed to be constant inside the element. # TODO: allow for higher quadrature

    :param xmeas: x coordinate of observation point.
    :type xmeas: scalar(float)
    :param ymeas:  y coordinate of observation point.
    :type ymeas: scalar(float)
    :param zmeas: z coordinate of observation point.
    :type zmeas: scalar(float)
    :param x: 1D array(NV) containing x coordinate of each observation point.
    :type x: array_like(float)
    :param y: 1D array(NV) containing y coordinate of each observation point.
    :type y: array_like(float)
    :param z: 1D array(NV) containing z coordinate of each observation point.
    :type z: array_like(float)
    :param icon: 1D array(8), containing connectivity, marking nodes that define an element, see code.
    :type icon: array_like(int)
    :param Mx: x component magnetization [A/m] of the element.
    :type Mx: scalar(float)
    :param My: y component magnetization [A/m]  of the element.
    :type My: scalar(float)
    :param Mz: z component magnetization [A/m] of the element.
    :type Mz: scalar(float)
    :param nqpts: the number of quadrature points per dimension.
    :type nqpts: scalar(int)

    :return:
      - **B_vi** *(array_like(float))* - 1D array(3) containing 3 components (0=x;1=y;2=z) of the magnetic field strength [T] at a point computed by volume integral method.

    """

    hx = x[icon[6]] - x[icon[0]]
    hy = y[icon[6]] - y[icon[0]]
    hz = z[icon[6]] - z[icon[0]]

    Bx = 0
    By = 0
    Bz = 0

    coordsq = qcoords_1D(nqdim)
    weightsq = qweights_1D(nqdim)

    for iq in range(0, nqdim):
        for jq in range(0, nqdim):
            for kq in range(0, nqdim):
                rq = coordsq[iq]
                sq = coordsq[jq]
                tq = coordsq[kq]
                weightq = weightsq[iq] * weightsq[jq] * weightsq[kq]

                dNdr = dNNNdr(rq, sq, tq)
                dNds = dNNNds(rq, sq, tq)
                dNdt = dNNNdt(rq, sq, tq)
                jcb = np.zeros((3, 3), dtype=np.float64)
                jcb[0, 0] = dNdr.dot(x[icon[0:8]])
                jcb[0, 1] = dNdr.dot(y[icon[0:8]])
                jcb[0, 2] = dNdr.dot(z[icon[0:8]])
                jcb[1, 0] = dNds.dot(x[icon[0:8]])
                jcb[1, 1] = dNds.dot(y[icon[0:8]])
                jcb[1, 2] = dNds.dot(z[icon[0:8]])
                jcb[2, 0] = dNdt.dot(x[icon[0:8]])
                jcb[2, 1] = dNdt.dot(y[icon[0:8]])
                jcb[2, 2] = dNdt.dot(z[icon[0:8]])
                jcob = np.linalg.det(jcb)
                JxW = weightq * jcob

                # JxW=weightq*hx*hy*hz/8

                N = NNN(rq, sq, tq)

                xq = N.dot(x[icon[:]])
                yq = N.dot(y[icon[:]])
                zq = N.dot(z[icon[:]])

                dist2 = (xmeas - xq) ** 2 + (ymeas - yq) ** 2 + (zmeas - zq) ** 2
                dist = np.sqrt(dist2)
                dist3 = dist**3
                dist5 = dist**5

                Mrr = Mx * (xmeas - xq) + My * (ymeas - yq) + Mz * (zmeas - zq)

                Bx += (3.0 * Mrr / dist2 * (xmeas - xq) - Mx) / dist3 * JxW
                By += (3.0 * Mrr / dist2 * (ymeas - yq) - My) / dist3 * JxW
                Bz += (3.0 * Mrr / dist2 * (zmeas - zq) - Mz) / dist3 * JxW

                # Ax=Ax+(My*(z-zq)-Mz*(y-yq))/dist3*JxW
                # Ay=Ay+(Mz*(x-xq)-Mx*(z-zq))/dist3*JxW
                # Az=Az+(Mx*(y-yq)-My*(x-xq))/dist3*JxW
                # psi=psi+(Mx*(x-xq)+ My*(y-yq)+ Mz*(z-zq))/dist3*JxW
                # Thetax_x=(dist2-3.*(x-xq)*(x-xq))/dist5
                # Thetax_y=(     -3.*(x-xq)*(y-yq))/dist5
                # Thetax_z=(     -3.*(x-xq)*(z-zq))/dist5
                # Thetay_x=(     -3.*(y-yq)*(x-xq))/dist5
                # Thetay_y=(dist2-3.*(y-yq)*(y-yq))/dist5
                # Thetay_z=(     -3.*(y-yq)*(z-zq))/dist5
                # Thetaz_x=(     -3.*(z-zq)*(x-xq))/dist5
                # Thetaz_y=(     -3.*(z-zq)*(y-yq))/dist5
                # Thetaz_z=(dist2-3.*(z-zq)*(z-zq))/dist5
                # Hx=Hx-(Mx*Thetax_x+My*Thetay_x+Mz*Thetaz_x)*JxW
                # Hy=Hy-(Mx*Thetax_y+My*Thetay_y+Mz*Thetaz_y)*JxW
                # Hz=Hz-(Mx*Thetax_z+My*Thetay_z+Mz*Thetaz_z)*JxW

    Bx = Bx * 1e-7  # (left from cm, output now [T])
    By = By * 1e-7
    Bz = Bz * 1e-7

    return np.array([Bx, By, Bz], dtype=np.float64)


###############################################################################


@jit(nopython=True)
def plane(x0, y0, z0, x1, y1, z1, x2, y2, z2, x3, y3, z3):
    """
    | Function plane computes the intersection (x,y,z) of a plane and a perpendicular line.
    | The plane is defined by three points (x1,y1,z1), (x2,y2,z2), and (x3,y3,z3), in facmag the (first 3) polygon corners are passed. The line passes through (x0,y0,z0), in facmag the observation point is passed.
    | Computation is done by a transformation and inverse transformation of coordinates systems. It defines three vectors N0, N2 and N3 in the process. N0 = vector from point 1 (x1,y1,z1) to point 0 (x0,y0,z0). N2 = vector from point 1 (x1,y1,z1) to point 2 (x2,y2,z2). N3 = vector from point 1 (x1,y1,z1) to point 3 (x3,y3,z3).
    | Directly translated from ANSI-standard FORTRAN 77 subroutines from :cite:`BLAKELY`.

    :param x0: x coordinate of point 0.
    :type x0: scalar(float)
    :param y0: y coordinate of point 0.
    :type y0: scalar(float)
    :param z0: z coordinate of point 0.
    :type z0: scalar(float)
    :param x1: x coordinate of point 1.
    :type x1: scalar(float)
    :param y1: y coordinate of point 1.
    :type y1: scalar(float)
    :param z1: z coordinate of point 1.
    :type z1: scalar(float)
    :param x2: x coordinate of point 2.
    :type x2: scalar(float)
    :param y2: y coordinate of point 2.
    :type y2: scalar(float)
    :param z2: z coordinate of point 2.
    :type z2: scalar(float)
    :param x3: x coordinate of point 3.
    :type x3: scalar(float)
    :param y3: y coordinate of point 3.
    :type y3: scalar(float)
    :param z3: z coordinate of point 3.
    :type z3: scalar(float)

    :return:
      - **x** *(scalar(float))* - x coordinate of the intersection point (plane and line)
      - **y** *(scalar(float))* - y coordinate of the intersection point (plane and line)
      - **z** *(scalar(float))* - z coordinate of the intersection point (plane and line)
      - **r** *(scalar(float))* - distance between intersection point and point 0 (x0,y0,z0)

    """
    x2n = x2 - x1  # vector N2 from point 1 to point 2.
    y2n = y2 - y1
    z2n = z2 - z1
    x0n = x0 - x1  # vector N0 from point 1 to point 0.
    y0n = y0 - y1
    z0n = z0 - z1
    x3n = x3 - x1  # vector N3 from point 1 to point 3.
    y3n = y3 - y1
    z3n = z3 - z1

    # call cross(x3n,y3n,z3n,x2n,y2n,z2n,cx,cy,cz,c)
    V3 = np.array([x3n, y3n, z3n], dtype=np.float64)
    V2 = np.array([x2n, y2n, z2n], dtype=np.float64)
    C = cross(V3, V2)
    cx = C[0]
    cy = C[1]
    cz = C[2]
    c = np.sqrt(cx**2 + cy**2 + cz**2)

    # call cross(x2n,y2n,z2n,cx,cy,cz,dx,dy,dz,d)
    D = cross(V2, C)
    dx = D[0]
    dy = D[1]
    dz = D[2]
    d = np.sqrt(dx**2 + dy**2 + dz**2)

    a = np.sqrt(x2n**2 + y2n**2 + z2n**2)
    t11 = x2n / a
    t12 = y2n / a
    t13 = z2n / a
    t21 = cx / c
    t22 = cy / c
    t23 = cz / c
    t31 = dx / d
    t32 = dy / d
    t33 = dz / d
    tx0 = t11 * x0n + t12 * y0n + t13 * z0n
    tz0 = t31 * x0n + t32 * y0n + t33 * z0n
    r = t21 * x0n + t22 * y0n + t23 * z0n
    x = t11 * tx0 + t31 * tz0
    y = t12 * tx0 + t32 * tz0
    z = t13 * tx0 + t33 * tz0
    x = x + x1
    y = y + y1
    z = z + z1
    return x, y, z, r


###############################################################################


@jit(nopython=True)
def line(x0, y0, z0, x1, y1, z1, x2, y2, z2):
    """
    | Function LINE determines the intersection (x,y,z) of two lines.  First line is defined by points (x1,y1,z1) and (x2,y2,z2).
    | Second line is perpendicular to the first and passes through point (x0,y0,z0).Distance between (x,y,z) and (x0,y0,z0) is returned as r. Computation is done by a transformation of coordinate systems, and defining two vectors T0 and T2 in the process. T0 = vector from point 1 (x1,y1,z1) to point 0 (x0,y0,z0). T2 = vector from point 1 (x1,y1,z1) to point 2 (x2,y2,z2).
    | Directly translated from ANSI-standard FORTRAN 77 subroutines from :cite:`BLAKELY`.


    :param x0: x coordinate of point 0.
    :type x0: scalar(float)
    :param y0: y coordinate of point 0.
    :type y0: scalar(float)
    :param z0: z coordinate of point 0.
    :type z0: scalar(float)
    :param x1: x coordinate of point 1.
    :type x1: array_like(float)
    :param y1: y coordinate of point 1.
    :type y1: array_like(float)
    :param z1: z coordinate of point 1.
    :type z1: array_like(float)
    :param x2: x coordinate of point 2.
    :type x2: array_like(float)
    :param y2: y coordinate of point 2.
    :type y2: array_like(float)
    :param z2: z coordinate of point 2.
    :type z2: array_like(float)

    :return:
      - **x** *(scalar(float))* - x coordinate of intersection point between the lines
      - **y** *(scalar(float))* - y coordinate of intersection point between the lines
      - **z** *(scalar(float))* - z coordinate of intersection point between the lines
      - **v1** *(scalar(float))* - the negative of the projection of vector T0 on T2 (dot product of normalized T2 and T0).
      - **v2** *(scalar(float))* - the length of vector T2 minus the projection of vector T0 on T2.
      - **r** *(scalar(float))* - distance between intersection point and point 0 (x0,y0,z0)
    """
    tx0 = x0 - x1  # T0= vector from point 1 to point 0.
    ty0 = y0 - y1
    tz0 = z0 - z1
    tx2 = x2 - x1  # T2= vector from point 1 to point 2.
    ty2 = y2 - y1
    tz2 = z2 - z1
    a = np.sqrt(tx2**2 + ty2**2 + tz2**2)  # length of T2 vector.
    T2 = np.array([tx2, ty2, tz2], dtype=np.float64)
    T0 = np.array([tx0, ty0, tz0], dtype=np.float64)
    C = cross(T2, T0)
    cx = C[0]
    cy = C[1]
    cz = C[2]
    c = np.sqrt(cx**2 + cy**2 + cz**2)
    D = cross(C, T2)
    dx = D[0]
    dy = D[1]
    dz = D[2]
    d = np.sqrt(dx**2 + dy**2 + dz**2)
    tt11 = tx2 / a  # normalized vector T2
    tt12 = ty2 / a
    tt13 = tz2 / a
    tt21 = dx / d
    tt22 = dy / d
    tt23 = dz / d
    tt31 = cx / c
    tt32 = cy / c
    tt33 = cz / c
    u0 = (
        tt11 * tx0 + tt12 * ty0 + tt13 * tz0
    )  # dot product of normalized T2 vector and T0 vector (i.e. projection)
    r = tt21 * tx0 + tt22 * ty0 + tt23 * tz0
    x = tt11 * u0 + x1
    y = tt12 * u0 + y1
    z = tt13 * u0 + z1
    v1 = -u0
    v2 = a - u0
    return x, y, z, v1, v2, r


###############################################################################


@jit(nopython=True)
def rot(ax, ay, az, bx, by, bz, nx, ny, nz, px, py, pz):
    """
    | Function ROT finds the sense of rotation of the vector from (ax,ay,az) to (bx,by,bz) with respect to a second vector through point (px,py,pz). The second vector has components given by (nx,ny,nz).
    | Returned parameter s is 1 if anticlockwise, -1 if clockwise, or 0 if colinear.
    | Directly translated from ANSI-standard FORTRAN 77 subroutines from :cite:`BLAKELY`.

    :param ax: x coordinate of point a, defines start of the first vector.
    :type ax: scalar(float)
    :param ay: y coordinate of point a, defines start of the first vector.
    :type ay: scalar(float)
    :param az: y coordinate of point a, defines start of the first vector.
    :type az: scalar(float)
    :param bx: y coordinate of point b, defines end of the first vector.
    :type bx: scalar(float)
    :param by: y coordinate of point b, defines end of the first vector.
    :type by: scalar(float)
    :param bz: z coordinate of point b, defines end of the first vector.
    :type bz: scalar(float)
    :param nx: x component of second vector.
    :type nx: scalar(float)
    :param ny: y component of second vector.
    :type ny: scalar(float)
    :param nz: z component of second vector.
    :type nz: scalar(float)
    :param px: x coordinate of point p, second vector passes through.
    :type px: scalar(float)
    :param py: y coordinate of point p, second vector passes through.
    :type py: scalar(float)
    :param pz: z coordinate of point p, second vector passes through.
    :type pz: scalar(float)

    :return:
      - **s** *(scalar(int))* - parameter that defines sense of rotation of a vector w.r.t. a second vector
    """

    x = bx - ax
    y = by - ay
    z = bz - az

    N = np.array([nx, ny, nz], dtype=np.float64)
    V = np.array([x, y, z], dtype=np.float64)
    C = cross(N, V)
    cx = C[0]
    cy = C[1]
    cz = C[2]
    np.sqrt(cx**2 + cy**2 + cz**2)

    u = px - ax
    v = py - ay
    w = pz - az
    d = u * cx + v * cy + w * cz

    if d < 0:
       s = 1
    elif d > 0:
       s = -1
    else:
       s = 0

    return s


###############################################################################


@jit(nopython=True)
def facmag(Mx, My, Mz, x0, y0, z0, x, y, z, n):
    """
    | Function FACMAG computes the magnetic field strength **B** due to surface charge on a polygonal face. Repeated calls on each face of a polyhedron builds the field of said arbitrary polyhedron, algorithm from :cite:`Bott63`.
    | The polygon is limited to 10 corners (n). Requires functions :func:`rot`, :func:`line`, :func:`plane` as define above. Distance units are irrelevant but must be consistent.
    | A spatial problem, see :doc:`computational_approach`, is mitigated due to the introduction of a small (1e-20) artificial distance for ``p``, in case ``p`` lies on a plane aligning with an edge of an element.
    | Directly translated from ANSI-standard FORTRAN 77 subroutines from :cite:`BLAKELY`.



    :param Mx: x component magnetization [A/m] of the element.
    :type Mx: scalar(float)
    :param My: y component magnetization [A/m] of the element.
    :type My: scalar(float)
    :param Mz: z component magnetization [A/m] of the element.
    :type Mz: scalar(float)
    :param x0: x coordinate of observation point (xmeas).
    :type x0: scalar(float)
    :param y0:  y coordinate of observation point (ymeas).
    :type y0: scalar(float)
    :param z0: z coordinate of observation point (zmeas).
    :type z0: scalar(float)
    :param x: 1D array(n+1) containing x coordinate for each polygon corner (and wrapping around).
    :type x: array_like(float)
    :param y: 1D array(n+1) containing y coordinate for each polygon corner (and wrapping around).
    :type y: array_like(float)
    :param z: 1D array(n+1) containing z coordinate for each polygon corner (and wrapping around).
    :type z: array_like(float)
    :param n: amount of corners defining the polygon surface, max 10.
    :type n: scalar(int)

    :return:
       - **B** *(array_like(float))* - 1D array(3) containing 3 components (0=x;1=y;2=z) of the magnetic field strength [T] at a point due to the surface charges of a polygon surface.
    """
    # x,y,z of size n+1!
    Bx = 0.0
    By = 0.0
    Bz = 0.0
    xl = np.zeros(n, dtype=np.float64)
    yl = np.zeros(n, dtype=np.float64)
    zl = np.zeros(n, dtype=np.float64)
    # ------------------------
    for i in range(0, n):
        xl[i] = x[i + 1] - x[i]
        yl[i] = y[i + 1] - y[i]
        zl[i] = z[i + 1] - z[i]
        rl = np.sqrt(xl[i] ** 2 + yl[i] ** 2 + zl[i] ** 2)
        xl[i] = xl[i] / rl
        yl[i] = yl[i] / rl
        zl[i] = zl[i] / rl
    # end for
    L1 = np.array([xl[1], yl[1], zl[1]], dtype=np.float64)
    L0 = np.array([xl[0], yl[0], zl[0]], dtype=np.float64)
    N = cross(L1, L0)
    nx = N[0]
    ny = N[1]
    nz = N[2]
    rn = np.sqrt(nx**2 + ny**2 + nz**2)
    nx = nx / rn
    ny = ny / rn
    nz = nz / rn
    dot = Mx * nx + My * ny + Mz * nz
    if abs(dot) < epsilon:
       return np.array([0.0, 0.0, 0.0])
    px, py, pz, w = plane(
        x0, y0, z0, x[0], y[0], z[0], x[1], y[1], z[1], x[2], y[2], z[2]
    )
    # ------------------------
    s = np.zeros(n, dtype=np.int32)
    u = np.zeros(n, dtype=np.float64)
    xk = np.zeros(n, dtype=np.float64)
    yk = np.zeros(n, dtype=np.float64)
    zk = np.zeros(n, dtype=np.float64)
    v1 = np.zeros(n, dtype=np.float64)
    v2 = np.zeros(n, dtype=np.float64)
    for i in range(0, n):
        s[i] = rot(
            x[i], y[i], z[i], x[i + 1], y[i + 1], z[i + 1], nx, ny, nz, px, py, pz
        )
        if s[i] == 0:
            continue
        u1, v, w1, v1[i], v2[i], u[i] = line(
            px, py, pz, x[i], y[i], z[i], x[i + 1], y[i + 1], z[i + 1]
        )

        rk = np.sqrt((u1 - px) ** 2 + (v - py) ** 2 + (w1 - pz) ** 2)
        xk[i] = (u1 - px) / rk
        yk[i] = (v - py) / rk
        zk[i] = (w1 - pz) / rk
    # end for
    # ------------------------
    for j in range(0, n):
        if s[j] == 0:
           continue

        us = u[j] ** 2
        v2s = v2[j] ** 2
        v1s = v1[j] ** 2
        a2 = v2[j] / u[j]
        a1 = v1[j] / u[j]

        f2 = np.sqrt(1.0 + a2 * a2)
        f1 = np.sqrt(1.0 + a1 * a1)
        rho2 = np.sqrt(us + v2s)
        rho1 = np.sqrt(us + v1s)
        r2 = np.sqrt(us + v2s + w**2)
        r1 = np.sqrt(us + v1s + w**2)
        if abs(w) > epsilon:
           fu2 = (a2 / f2) * np.log((r2 + rho2) / abs(w)) - 0.5 * np.log(
               (r2 + v2[j]) / (r2 - v2[j])
           )
           fu1 = (a1 / f1) * np.log((r1 + rho1) / abs(w)) - 0.5 * np.log(
               (r1 + v1[j]) / (r1 - v1[j])
           )
           fv2 = (1.0 / f2) * np.log((r2 + rho2) / abs(w))
           fv1 = (1.0 / f1) * np.log((r1 + rho1) / abs(w))
           fw2 = np.arctan2((a2 * (r2 - abs(w))), (r2 + a2 * a2 * abs(w)))
           fw1 = np.arctan2((a1 * (r1 - abs(w))), (r1 + a1 * a1 * abs(w)))
           fu = dot * (fu2 - fu1)
           fv = -dot * (fv2 - fv1)
           fw = (-w * dot / abs(w)) * (fw2 - fw1)
        else:
           fu2 = (a2 / f2) * (1.0 + np.log((r2 + rho2) / epsilon)) - 0.5 * np.log(
               (r2 + v2[j]) / (r2 - v2[j])
           )
           fu1 = (a1 / f1) * (1.0 + np.log((r1 + rho1) / epsilon)) - 0.5 * np.log(
               (r1 + v1[j]) / (r1 - v1[j])
           )
           fv2 = (1.0 / f2) * (1.0 + np.log((r2 + rho2) / epsilon))
           fv1 = (1.0 / f1) * (1.0 + np.log((r1 + rho1) / epsilon))
           fu = dot * (fu2 - fu1)
           fv = -dot * (fv2 - fv1)
           fw = 0.0
        # end if
        Bx -= s[j] * (fu * xk[j] + fv * xl[j] + fw * nx)
        By -= s[j] * (fu * yk[j] + fv * yl[j] + fw * ny)
        Bz -= s[j] * (fu * zk[j] + fv * zl[j] + fw * nz)
    # end for
    return np.array([Bx, By, Bz], dtype=np.float64)


##############################################################################
# internal node numbering:
#     z
#     |
#     4---7---y
#    /   /
#   5---6
#     |
#     0---3---y
#    /   /
#   1---2
#  /
# x
###########

@jit(nopython=True)
def compute_B_surface_integral_cuboid(xmeas, ymeas, zmeas, x, y, z, icon, Mx, My, Mz):
    """
    | This function computes the magnetic field at a point (defined my x,y,z-coordinate) produced by a cuboid element employing :func:`facmag` function on each face. Here again the magnetization vector (Mx,My,Mz) is assumed to be constant inside the element. It uses the ``icon`` array to identify the x-,y-,z-coordinates associated with each node, before calling :func:`facmag`, to compute the total magnetic field strength for each face.
    | Magnetic field strength :math:`\mathbf{B}` is computed in Tesla [T]. Note that the negative of the computed values is passed, as the numbering of our nodes was counterclockwise, not clockwise as in :cite:`BLAKELY`.
    | Distance units are irrelevant but must be consistent.  For numbering of the nodes, see :doc:`app2`.

    :param xmeas: x coordinate of observation point.
    :type xmeas: scalar(float)
    :param ymeas:  y coordinate of observation point.
    :type ymeas: scalar(float)
    :param zmeas: z coordinate of observation point.
    :type zmeas: scalar(float)
    :param x: 1D array(NV) containing x coordinate of each node.
    :type x: array_like(float)
    :param y: 1D array(NV) containing y coordinate of each node.
    :type y: array_like(float)
    :param z: 1D array(NV) containing z coordinate of each node.
    :type z: array_like(float)
    :param icon: 1D array(8), containing connectivity, marking nodes that define an element, see code.
    :type icon: array_like(int)
    :param Mx: x component magnetization [A/m] of the element.
    :type Mx: scalar(float)
    :param My: y component magnetization [A/m] of the element.
    :type My: scalar(float)
    :param Mz: z component magnetization [A/m] of the element.
    :type Mz: scalar(float)

    :return:
       - **B_si** *(array_like(float))* - 1D array(3) containing 3 components (0=x;1=y;2=z) of the magnetic field strength in [T] at each point computed by surface integral method for a cuboid element.

    """

    Bx = 0
    By = 0
    Bz = 0

    nface = 4  # square face duh :)
    xface = np.empty(nface + 1, dtype=np.float64)
    yface = np.empty(nface + 1, dtype=np.float64)
    zface = np.empty(nface + 1, dtype=np.float64)

    # face x=0
    xface[0] = x[icon[7]]
    yface[0] = y[icon[7]]
    zface[0] = z[icon[7]]
    xface[1] = x[icon[3]]
    yface[1] = y[icon[3]]
    zface[1] = z[icon[3]]
    xface[2] = x[icon[0]]
    yface[2] = y[icon[0]]
    zface[2] = z[icon[0]]
    xface[3] = x[icon[4]]
    yface[3] = y[icon[4]]
    zface[3] = z[icon[4]]
    xface[4] = xface[0]
    yface[4] = yface[0]
    zface[4] = zface[0]
    field = facmag(Mx, My, Mz, xmeas, ymeas, zmeas, xface, yface, zface, nface)
    Bx += field[0]
    By += field[1]
    Bz += field[2]

    # face x=1
    xface[0] = x[icon[1]]
    yface[0] = y[icon[1]]
    zface[0] = z[icon[1]]
    xface[1] = x[icon[2]]
    yface[1] = y[icon[2]]
    zface[1] = z[icon[2]]
    xface[2] = x[icon[6]]
    yface[2] = y[icon[6]]
    zface[2] = z[icon[6]]
    xface[3] = x[icon[5]]
    yface[3] = y[icon[5]]
    zface[3] = z[icon[5]]
    xface[4] = xface[0]
    yface[4] = yface[0]
    zface[4] = zface[0]
    field = facmag(Mx, My, Mz, xmeas, ymeas, zmeas, xface, yface, zface, nface)
    Bx += field[0]
    By += field[1]
    Bz += field[2]

    # face y=0
    xface[0] = x[icon[0]]
    yface[0] = y[icon[0]]
    zface[0] = z[icon[0]]
    xface[1] = x[icon[1]]
    yface[1] = y[icon[1]]
    zface[1] = z[icon[1]]
    xface[2] = x[icon[5]]
    yface[2] = y[icon[5]]
    zface[2] = z[icon[5]]
    xface[3] = x[icon[4]]
    yface[3] = y[icon[4]]
    zface[3] = z[icon[4]]
    xface[4] = xface[0]
    yface[4] = yface[0]
    zface[4] = zface[0]
    field = facmag(Mx, My, Mz, xmeas, ymeas, zmeas, xface, yface, zface, nface)
    Bx += field[0]
    By += field[1]
    Bz += field[2]

    # face y=1
    xface[0] = x[icon[2]]
    yface[0] = y[icon[2]]
    zface[0] = z[icon[2]]
    xface[1] = x[icon[3]]
    yface[1] = y[icon[3]]
    zface[1] = z[icon[3]]
    xface[2] = x[icon[7]]
    yface[2] = y[icon[7]]
    zface[2] = z[icon[7]]
    xface[3] = x[icon[6]]
    yface[3] = y[icon[6]]
    zface[3] = z[icon[6]]
    xface[4] = xface[0]
    yface[4] = yface[0]
    zface[4] = zface[0]
    field = facmag(Mx, My, Mz, xmeas, ymeas, zmeas, xface, yface, zface, nface)
    Bx += field[0]
    By += field[1]
    Bz += field[2]

    # face z=0
    xface[0] = x[icon[3]]
    yface[0] = y[icon[3]]
    zface[0] = z[icon[3]]
    xface[1] = x[icon[2]]
    yface[1] = y[icon[2]]
    zface[1] = z[icon[2]]
    xface[2] = x[icon[1]]
    yface[2] = y[icon[1]]
    zface[2] = z[icon[1]]
    xface[3] = x[icon[0]]
    yface[3] = y[icon[0]]
    zface[3] = z[icon[0]]
    xface[4] = xface[0]
    yface[4] = yface[0]
    zface[4] = zface[0]
    field = facmag(Mx, My, Mz, xmeas, ymeas, zmeas, xface, yface, zface, nface)
    Bx += field[0]
    By += field[1]
    Bz += field[2]

    # face z=1
    xface[0] = x[icon[4]]
    yface[0] = y[icon[4]]
    zface[0] = z[icon[4]]
    xface[1] = x[icon[5]]
    yface[1] = y[icon[5]]
    zface[1] = z[icon[5]]
    xface[2] = x[icon[6]]
    yface[2] = y[icon[6]]
    zface[2] = z[icon[6]]
    xface[3] = x[icon[7]]
    yface[3] = y[icon[7]]
    zface[3] = z[icon[7]]
    xface[4] = xface[0]
    yface[4] = yface[0]
    zface[4] = zface[0]
    field = facmag(Mx, My, Mz, xmeas, ymeas, zmeas, xface, yface, zface, nface)
    Bx += field[0]
    By += field[1]
    Bz += field[2]

    Bx = Bx * 1e-7  # B in Tesla [T], left from cm in facmag.
    By = By * 1e-7
    Bz = Bz * 1e-7
    return np.array([-Bx, -By, -Bz], dtype=np.float64)


###############################################################################
# internal node numbering:
#     z
#     |
#     4---7---y
#    / 9 /
#   5---6
#     |
#     0---3---y
#    / 8 /
#   1---2
#  /
# x
###########


@jit(nopython=True)
def compute_B_surface_integral_wtopo(xmeas, ymeas, zmeas, x, y, z, icon, Mx, My, Mz):
    """

    | This function computes the magnetic field at a point (defined my x,y,z-coordinate) produced by a hexahedron element which vertical sides are planar. Only the top and bottom faces can contain 4 nodes which are not co-planar.
    | In light thereof we subdivide the top and bottom faces into four triangles. This feature is needed in the case topography is prescribed at the top (or bottom) of the domain and the vertical position of the nodes are modified.
    | It uses the ``icon`` array to identify the x-,y-,z-coordinates associated with each node, before calling :func:`facmag`, to compute the total magnetic field strength for each face and triangle.
    | Magnetic field strength :math:`\mathbf{B}` is computed in Tesla [T]. Note that the negative of the computed values is passed, as the numbering of our nodes was counterclockwise, not clockwise as in :cite:`BLAKELY`.
    | Distance units are irrelevant but must be consistent. For numbering of the nodes, see :doc:`app2`.

    :param xmeas: x coordinate of observation point.
    :type xmeas: scalar(float)
    :param ymeas:  y coordinate of observation point.
    :type ymeas: scalar(float)
    :param zmeas: z coordinate of observation point.
    :type zmeas: scalar(float)
    :param x: 1D array(NV) containing x coordinate of each node.
    :type x: array_like(float)
    :param y: 1D array(NV) containing y coordinate of each node.
    :type y: array_like(float)
    :param z: 1D array(NV) containing z coordinate of each node.
    :type z: array_like(float)
    :param icon: 1D array(8), containing connectivity, marking nodes that define an element, see code.
    :type icon: array_like(int)
    :param Mx: x component magnetization [A/m] of the element.
    :type Mx: scalar(float)
    :param My: y component magnetization [A/m] of the element.
    :type My: scalar(float)
    :param Mz: z component magnetization [A/m] of the element.
    :type Mz: scalar(float)

    :return:
       - **B_si** *(array_like(float))* - 1D array(3) containing 3 components (0=x;1=y;2=z) of the magnetic field strength in tesla [T] at a point computed by surface integral method for a cuboid element with topography on top and/or bottom surface.

    """
    Bx = 0
    By = 0
    Bz = 0

    nface = 4
    xface = np.empty(nface + 1, dtype=np.float64)
    yface = np.empty(nface + 1, dtype=np.float64)
    zface = np.empty(nface + 1, dtype=np.float64)

    # face 'x=0'
    xface[0] = x[icon[7]]
    yface[0] = y[icon[7]]
    zface[0] = z[icon[7]]
    xface[1] = x[icon[3]]
    yface[1] = y[icon[3]]
    zface[1] = z[icon[3]]
    xface[2] = x[icon[0]]
    yface[2] = y[icon[0]]
    zface[2] = z[icon[0]]
    xface[3] = x[icon[4]]
    yface[3] = y[icon[4]]
    zface[3] = z[icon[4]]
    xface[4] = xface[0]
    yface[4] = yface[0]
    zface[4] = zface[0]
    field = facmag(Mx, My, Mz, xmeas, ymeas, zmeas, xface, yface, zface, nface)
    Bx += field[0]
    By += field[1]
    Bz += field[2]

    # face 'x=1'
    xface[0] = x[icon[1]]
    yface[0] = y[icon[1]]
    zface[0] = z[icon[1]]
    xface[1] = x[icon[2]]
    yface[1] = y[icon[2]]
    zface[1] = z[icon[2]]
    xface[2] = x[icon[6]]
    yface[2] = y[icon[6]]
    zface[2] = z[icon[6]]
    xface[3] = x[icon[5]]
    yface[3] = y[icon[5]]
    zface[3] = z[icon[5]]
    xface[4] = xface[0]
    yface[4] = yface[0]
    zface[4] = zface[0]
    field = facmag(Mx, My, Mz, xmeas, ymeas, zmeas, xface, yface, zface, nface)
    Bx += field[0]
    By += field[1]
    Bz += field[2]

    # face 'y=0'
    xface[0] = x[icon[0]]
    yface[0] = y[icon[0]]
    zface[0] = z[icon[0]]
    xface[1] = x[icon[1]]
    yface[1] = y[icon[1]]
    zface[1] = z[icon[1]]
    xface[2] = x[icon[5]]
    yface[2] = y[icon[5]]
    zface[2] = z[icon[5]]
    xface[3] = x[icon[4]]
    yface[3] = y[icon[4]]
    zface[3] = z[icon[4]]
    xface[4] = xface[0]
    yface[4] = yface[0]
    zface[4] = zface[0]
    field = facmag(Mx, My, Mz, xmeas, ymeas, zmeas, xface, yface, zface, nface)
    Bx += field[0]
    By += field[1]
    Bz += field[2]

    # face 'y=1'
    xface[0] = x[icon[2]]
    yface[0] = y[icon[2]]
    zface[0] = z[icon[2]]
    xface[1] = x[icon[3]]
    yface[1] = y[icon[3]]
    zface[1] = z[icon[3]]
    xface[2] = x[icon[7]]
    yface[2] = y[icon[7]]
    zface[2] = z[icon[7]]
    xface[3] = x[icon[6]]
    yface[3] = y[icon[6]]
    zface[3] = z[icon[6]]
    xface[4] = xface[0]
    yface[4] = yface[0]
    zface[4] = zface[0]
    field = facmag(Mx, My, Mz, xmeas, ymeas, zmeas, xface, yface, zface, nface)
    Bx += field[0]
    By += field[1]
    Bz += field[2]

    nface = 3
    xface = np.empty(nface + 1, dtype=np.float64)
    yface = np.empty(nface + 1, dtype=np.float64)
    zface = np.empty(nface + 1, dtype=np.float64)

    # bottom face
    x8 = (x[icon[0]] + x[icon[1]] + x[icon[2]] + x[icon[3]]) * 0.25
    y8 = (y[icon[0]] + y[icon[1]] + y[icon[2]] + y[icon[3]]) * 0.25
    z8 = (z[icon[0]] + z[icon[1]] + z[icon[2]] + z[icon[3]]) * 0.25

    # 328
    xface[0] = x[icon[3]]
    yface[0] = y[icon[3]]
    zface[0] = z[icon[3]]
    xface[1] = x[icon[2]]
    yface[1] = y[icon[2]]
    zface[1] = z[icon[2]]
    xface[2] = x8
    yface[2] = y8
    zface[2] = z8
    xface[3] = xface[0]
    yface[3] = yface[0]
    zface[3] = zface[0]
    field = facmag(Mx, My, Mz, xmeas, ymeas, zmeas, xface, yface, zface, nface)
    Bx += field[0]
    By += field[1]
    Bz += field[2]

    # 821
    xface[0] = x8
    yface[0] = y8
    zface[0] = z8
    xface[1] = x[icon[2]]
    yface[1] = y[icon[2]]
    zface[1] = z[icon[2]]
    xface[2] = x[icon[1]]
    yface[2] = y[icon[1]]
    zface[2] = z[icon[1]]
    xface[3] = xface[0]
    yface[3] = yface[0]
    zface[3] = zface[0]
    field = facmag(Mx, My, Mz, xmeas, ymeas, zmeas, xface, yface, zface, nface)
    Bx += field[0]
    By += field[1]
    Bz += field[2]

    # 108
    xface[0] = x[icon[1]]
    yface[0] = y[icon[1]]
    zface[0] = z[icon[1]]
    xface[1] = x[icon[0]]
    yface[1] = y[icon[0]]
    zface[1] = z[icon[0]]
    xface[2] = x8
    yface[2] = y8
    zface[2] = z8
    xface[3] = xface[0]
    yface[3] = yface[0]
    zface[3] = zface[0]
    field = facmag(Mx, My, Mz, xmeas, ymeas, zmeas, xface, yface, zface, nface)
    Bx += field[0]
    By += field[1]
    Bz += field[2]

    # 803
    xface[0] = x8
    yface[0] = y8
    zface[0] = z8
    xface[1] = x[icon[0]]
    yface[1] = y[icon[0]]
    zface[1] = z[icon[0]]
    xface[2] = x[icon[3]]
    yface[2] = y[icon[3]]
    zface[2] = z[icon[3]]
    xface[3] = xface[0]
    yface[3] = yface[0]
    zface[3] = zface[0]
    field = facmag(Mx, My, Mz, xmeas, ymeas, zmeas, xface, yface, zface, nface)
    Bx += field[0]
    By += field[1]
    Bz += field[2]

    # top face
    x9 = (x[icon[4]] + x[icon[5]] + x[icon[6]] + x[icon[7]]) * 0.25
    y9 = (y[icon[4]] + y[icon[5]] + y[icon[6]] + y[icon[7]]) * 0.25
    z9 = (z[icon[4]] + z[icon[5]] + z[icon[6]] + z[icon[7]]) * 0.25

    # 679
    xface[0] = x[icon[6]]
    yface[0] = y[icon[6]]
    zface[0] = z[icon[6]]
    xface[1] = x[icon[7]]
    yface[1] = y[icon[7]]
    zface[1] = z[icon[7]]
    xface[2] = x9
    yface[2] = y9
    zface[2] = z9
    xface[3] = xface[0]
    yface[3] = yface[0]
    zface[3] = zface[0]
    field = facmag(Mx, My, Mz, xmeas, ymeas, zmeas, xface, yface, zface, nface)
    Bx += field[0]
    By += field[1]
    Bz += field[2]

    # 974
    xface[0] = x9
    yface[0] = y9
    zface[0] = z9
    xface[1] = x[icon[7]]
    yface[1] = y[icon[7]]
    zface[1] = z[icon[7]]
    xface[2] = x[icon[4]]
    yface[2] = y[icon[4]]
    zface[2] = z[icon[4]]
    xface[3] = xface[0]
    yface[3] = yface[0]
    zface[3] = zface[0]
    field = facmag(Mx, My, Mz, xmeas, ymeas, zmeas, xface, yface, zface, nface)
    Bx += field[0]
    By += field[1]
    Bz += field[2]

    # 459
    xface[0] = x[icon[4]]
    yface[0] = y[icon[4]]
    zface[0] = z[icon[4]]
    xface[1] = x[icon[5]]
    yface[1] = y[icon[5]]
    zface[1] = z[icon[5]]
    xface[2] = x9
    yface[2] = y9
    zface[2] = z9
    xface[3] = xface[0]
    yface[3] = yface[0]
    zface[3] = zface[0]
    field = facmag(Mx, My, Mz, xmeas, ymeas, zmeas, xface, yface, zface, nface)
    Bx += field[0]
    By += field[1]
    Bz += field[2]

    # 956
    xface[0] = x9
    yface[0] = y9
    zface[0] = z9
    xface[1] = x[icon[5]]
    yface[1] = y[icon[5]]
    zface[1] = z[icon[5]]
    xface[2] = x[icon[6]]
    yface[2] = y[icon[6]]
    zface[2] = z[icon[6]]
    xface[3] = xface[0]
    yface[3] = yface[0]
    zface[3] = zface[0]
    field = facmag(Mx, My, Mz, xmeas, ymeas, zmeas, xface, yface, zface, nface)
    Bx += field[0]
    By += field[1]
    Bz += field[2]
    Bx = Bx * 1e-7  # output, left from cm = [T]
    By = By * 1e-7
    Bz = Bz * 1e-7
    return np.array([-Bx, -By, -Bz], dtype=np.float64)


# minus as always reversed, see previous function last lines , minus Bz,Bx,By.
# Likely due to counterclockwise fashion numbering of corners
# while the original blakely subroutines are structured for clockwise numbering
# benchmark 1/3 validify orientation


@jit(nopython=True)
def compute_B_surface_integral_wtopo_noise(xmeas, ymeas, zmeas, x, y, z, icon, Mx, My, Mz, noise):
    """
    | This function computes the magnetic field produced by a hexahedron element which vertical sides are planar. Only the top and bottom faces can contain 4 nodes which are not co-planar, and are therefor subdivided into four triangles.
    | Numbering of nodes is same as previous function. The noise is added to the extra node on the top/bottom surface.
    | Note that when computation are caried out and noise is added to this middle point, it could be that the observation point is then location within the domain, but we do not correct for it nor test it. So, this situation must be avoided during setup of any testing employing this function.
    | Distance units are irrelevant but must be consistent.

    :param xmeas: x coordinate of observation point.
    :type xmeas: scalar(float)
    :param ymeas:  y coordinate of observation point.
    :type ymeas: scalar(float)
    :param zmeas: z coordinate of observation point.
    :type zmeas: scalar(float)
    :param x: 1D array(NV) containing x coordinate of each node.
    :type x: array_like(float)
    :param y: 1D array(NV) containing y coordinate of each node.
    :type y: array_like(float)
    :param z: 1D array(NV) containing z coordinate of each node.
    :type z: array_like(float)
    :param icon: 1D array(8), containing connectivity, marking nodes that define an element, see code.
    :type icon: array_like(int)
    :param Mx: x component magnetization [A/m] of the element.
    :type Mx: scalar(float)
    :param My: y component magnetization [A/m] of the element.
    :type My: scalar(float)
    :param Mz: z component magnetization [A/m] of the element.
    :type Mz: scalar(float)
    :param noise: the height substracted or added to the middle node on the top and/or bottom surface of each element representing noise potentially smoothed by the DEM.
    :type noise: scalar(float)

    :return:
       - **B_si** *(array_like(float))* - 1D array(3) containing 3 components (0=x;1=y;2=z) of the magnetic field strength in [T] at a point computed by surface integral method for a cuboid element with topography on top and/or bottom surface and noise.

    """
    Bx = 0
    By = 0
    Bz = 0

    nface = 4
    xface = np.empty(nface + 1, dtype=np.float64)
    yface = np.empty(nface + 1, dtype=np.float64)
    zface = np.empty(nface + 1, dtype=np.float64)

    # face 'x=0'
    xface[0] = x[icon[7]]
    yface[0] = y[icon[7]]
    zface[0] = z[icon[7]]
    xface[1] = x[icon[3]]
    yface[1] = y[icon[3]]
    zface[1] = z[icon[3]]
    xface[2] = x[icon[0]]
    yface[2] = y[icon[0]]
    zface[2] = z[icon[0]]
    xface[3] = x[icon[4]]
    yface[3] = y[icon[4]]
    zface[3] = z[icon[4]]
    xface[4] = xface[0]
    yface[4] = yface[0]
    zface[4] = zface[0]
    field = facmag(Mx, My, Mz, xmeas, ymeas, zmeas, xface, yface, zface, nface)
    Bx += field[0]
    By += field[1]
    Bz += field[2]

    # face 'x=1'
    xface[0] = x[icon[1]]
    yface[0] = y[icon[1]]
    zface[0] = z[icon[1]]
    xface[1] = x[icon[2]]
    yface[1] = y[icon[2]]
    zface[1] = z[icon[2]]
    xface[2] = x[icon[6]]
    yface[2] = y[icon[6]]
    zface[2] = z[icon[6]]
    xface[3] = x[icon[5]]
    yface[3] = y[icon[5]]
    zface[3] = z[icon[5]]
    xface[4] = xface[0]
    yface[4] = yface[0]
    zface[4] = zface[0]
    field = facmag(Mx, My, Mz, xmeas, ymeas, zmeas, xface, yface, zface, nface)
    Bx += field[0]
    By += field[1]
    Bz += field[2]

    # face 'y=0'
    xface[0] = x[icon[0]]
    yface[0] = y[icon[0]]
    zface[0] = z[icon[0]]
    xface[1] = x[icon[1]]
    yface[1] = y[icon[1]]
    zface[1] = z[icon[1]]
    xface[2] = x[icon[5]]
    yface[2] = y[icon[5]]
    zface[2] = z[icon[5]]
    xface[3] = x[icon[4]]
    yface[3] = y[icon[4]]
    zface[3] = z[icon[4]]
    xface[4] = xface[0]
    yface[4] = yface[0]
    zface[4] = zface[0]
    field = facmag(Mx, My, Mz, xmeas, ymeas, zmeas, xface, yface, zface, nface)
    Bx += field[0]
    By += field[1]
    Bz += field[2]

    # face 'y=1'
    xface[0] = x[icon[2]]
    yface[0] = y[icon[2]]
    zface[0] = z[icon[2]]
    xface[1] = x[icon[3]]
    yface[1] = y[icon[3]]
    zface[1] = z[icon[3]]
    xface[2] = x[icon[7]]
    yface[2] = y[icon[7]]
    zface[2] = z[icon[7]]
    xface[3] = x[icon[6]]
    yface[3] = y[icon[6]]
    zface[3] = z[icon[6]]
    xface[4] = xface[0]
    yface[4] = yface[0]
    zface[4] = zface[0]
    field = facmag(Mx, My, Mz, xmeas, ymeas, zmeas, xface, yface, zface, nface)
    Bx += field[0]
    By += field[1]
    Bz += field[2]

    nface = 3
    xface = np.empty(nface + 1, dtype=np.float64)
    yface = np.empty(nface + 1, dtype=np.float64)
    zface = np.empty(nface + 1, dtype=np.float64)

    # bottom face
    x8 = (x[icon[0]] + x[icon[1]] + x[icon[2]] + x[icon[3]]) * 0.25
    y8 = (y[icon[0]] + y[icon[1]] + y[icon[2]] + y[icon[3]]) * 0.25
    z8 = ((z[icon[0]] + z[icon[1]] + z[icon[2]] + z[icon[3]]) * 0.25) + noise
    ##### HERE NOISE ####

    # 328
    xface[0] = x[icon[3]]
    yface[0] = y[icon[3]]
    zface[0] = z[icon[3]]
    xface[1] = x[icon[2]]
    yface[1] = y[icon[2]]
    zface[1] = z[icon[2]]
    xface[2] = x8
    yface[2] = y8
    zface[2] = z8
    xface[3] = xface[0]
    yface[3] = yface[0]
    zface[3] = zface[0]
    field = facmag(Mx, My, Mz, xmeas, ymeas, zmeas, xface, yface, zface, nface)
    Bx += field[0]
    By += field[1]
    Bz += field[2]

    # 821
    xface[0] = x8
    yface[0] = y8
    zface[0] = z8
    xface[1] = x[icon[2]]
    yface[1] = y[icon[2]]
    zface[1] = z[icon[2]]
    xface[2] = x[icon[1]]
    yface[2] = y[icon[1]]
    zface[2] = z[icon[1]]
    xface[3] = xface[0]
    yface[3] = yface[0]
    zface[3] = zface[0]
    field = facmag(Mx, My, Mz, xmeas, ymeas, zmeas, xface, yface, zface, nface)
    Bx += field[0]
    By += field[1]
    Bz += field[2]

    # 108
    xface[0] = x[icon[1]]
    yface[0] = y[icon[1]]
    zface[0] = z[icon[1]]
    xface[1] = x[icon[0]]
    yface[1] = y[icon[0]]
    zface[1] = z[icon[0]]
    xface[2] = x8
    yface[2] = y8
    zface[2] = z8
    xface[3] = xface[0]
    yface[3] = yface[0]
    zface[3] = zface[0]
    field = facmag(Mx, My, Mz, xmeas, ymeas, zmeas, xface, yface, zface, nface)
    Bx += field[0]
    By += field[1]
    Bz += field[2]

    # 803
    xface[0] = x8
    yface[0] = y8
    zface[0] = z8
    xface[1] = x[icon[0]]
    yface[1] = y[icon[0]]
    zface[1] = z[icon[0]]
    xface[2] = x[icon[3]]
    yface[2] = y[icon[3]]
    zface[2] = z[icon[3]]
    xface[3] = xface[0]
    yface[3] = yface[0]
    zface[3] = zface[0]
    field = facmag(Mx, My, Mz, xmeas, ymeas, zmeas, xface, yface, zface, nface)
    Bx += field[0]
    By += field[1]
    Bz += field[2]

    # top face
    x9 = (x[icon[4]] + x[icon[5]] + x[icon[6]] + x[icon[7]]) * 0.25
    y9 = (y[icon[4]] + y[icon[5]] + y[icon[6]] + y[icon[7]]) * 0.25
    z9 = ((z[icon[4]] + z[icon[5]] + z[icon[6]] + z[icon[7]]) * 0.25) + noise

    # 679
    xface[0] = x[icon[6]]
    yface[0] = y[icon[6]]
    zface[0] = z[icon[6]]
    xface[1] = x[icon[7]]
    yface[1] = y[icon[7]]
    zface[1] = z[icon[7]]
    xface[2] = x9
    yface[2] = y9
    zface[2] = z9
    xface[3] = xface[0]
    yface[3] = yface[0]
    zface[3] = zface[0]
    field = facmag(Mx, My, Mz, xmeas, ymeas, zmeas, xface, yface, zface, nface)
    Bx += field[0]
    By += field[1]
    Bz += field[2]

    # 974
    xface[0] = x9
    yface[0] = y9
    zface[0] = z9
    xface[1] = x[icon[7]]
    yface[1] = y[icon[7]]
    zface[1] = z[icon[7]]
    xface[2] = x[icon[4]]
    yface[2] = y[icon[4]]
    zface[2] = z[icon[4]]
    xface[3] = xface[0]
    yface[3] = yface[0]
    zface[3] = zface[0]
    field = facmag(Mx, My, Mz, xmeas, ymeas, zmeas, xface, yface, zface, nface)
    Bx += field[0]
    By += field[1]
    Bz += field[2]

    # 459
    xface[0] = x[icon[4]]
    yface[0] = y[icon[4]]
    zface[0] = z[icon[4]]
    xface[1] = x[icon[5]]
    yface[1] = y[icon[5]]
    zface[1] = z[icon[5]]
    xface[2] = x9
    yface[2] = y9
    zface[2] = z9
    xface[3] = xface[0]
    yface[3] = yface[0]
    zface[3] = zface[0]
    field = facmag(Mx, My, Mz, xmeas, ymeas, zmeas, xface, yface, zface, nface)
    Bx += field[0]
    By += field[1]
    Bz += field[2]

    # 956
    xface[0] = x9
    yface[0] = y9
    zface[0] = z9
    xface[1] = x[icon[5]]
    yface[1] = y[icon[5]]
    zface[1] = z[icon[5]]
    xface[2] = x[icon[6]]
    yface[2] = y[icon[6]]
    zface[2] = z[icon[6]]
    xface[3] = xface[0]
    yface[3] = yface[0]
    zface[3] = zface[0]
    field = facmag(Mx, My, Mz, xmeas, ymeas, zmeas, xface, yface, zface, nface)
    Bx += field[0]
    By += field[1]
    Bz += field[2]
    Bx = Bx * 1e-7  # output, left from cm = [T]
    By = By * 1e-7
    Bz = Bz * 1e-7
    return np.array([-Bx, -By, -Bz], dtype=np.float64)


# minus as always reversed, see previous function last lines , minus Bz,Bx,By.
# Likely due to counterclockwise fashion numbering of corners
# while the original blakely subroutines are structured for clockwise numbering
# benchmark 1/3 validify orientation
