import numpy as np

###################################################################################################
# this function adds reference field to measurements and computes Pmag Int,Inc,Dec

def add_referencefield(B0_name,npath,dmeas,B0,B_si,benchmark):
    """
    Returns total computed magnetic field, intensity, inclination and declination
    at all points on a path by 
  
    1. rotating vector from model to Paleomagnetism coordinate system.
    2. adding a (global) reference field B0.
    3. computing standard PMAG equations :cite:`TAUXE`.
  
    Next, it writes individual(x,y,z) components of total magnetic field and intensity,
    inclination and declination into file named: ``measurements_path_refField{BO_name}.ascii``.
   
    :param B0_name: name of reference field (used in writing file).
    :type B0_name: string 
    :param npath: amount of points on path.
    :type npath: scalar(int)
    :param dmeas: 1D array(npath) containing distance between two points of the path (from meyer), used for plotting.
    :type dmeas: array_like(float)
    :param B0: 1D array(3) containing 3 components (0=x;1=y;2=z), components of reference field to be added.
    :type B0: array_like(float)
    :param B_si: 2D array(3,npath), containing components (0=x;1=y;2=z,npath) of the computed magnetic field due to the underlying magnetized matter (anomalous field) at each point of the path.
    :type B_si: array_like(float)
    :param benchmark: number associated with benchmark, see :doc:`benchmarks`.
    :type benchmark: string 
    :return: 
        - **B_siB0** *(array_like(float))* - 2D array(3,npath), containing components (0=x;1=y;2=z,npath) of the total magnetic field (anomalous + reference field) at each point of the path.
        - **In_siB0** *(array_like(float))* - 1D array(npath), containing intensity of the total magnetic field (anomalous + reference field) at each point of the path.
        - **Ic_siB0** *(array_like(float))* - 1D array(npath), containing inclination of the total magnetic field (anomalous + reference field) at each point of the path.
        - **Dc_siB0** *(array_like(float))* - 1D array(npath), containing declination of total magnetic field (anomalous + reference field) at each point of the path.

    """

    linefile1=open(f"measurements_path_refField{B0_name}.ascii","w")
    linefile1.write("# 1    , 2      , 3      , 4      , 5      , 6      , 7       \n")
    linefile1.write("# dmeas, Bx_siB0, By_siB0, Bz_siB0, In_siB0, Ic_siB0, Dc_siB0 \n")

    B_siB0=np.zeros((3,npath),dtype=np.float64)
    In_siB0=np.zeros((npath),dtype=np.float64)
    Ic_siB0=np.zeros((npath),dtype=np.float64)
    Dc_siB0=np.zeros((npath),dtype=np.float64)
    for i in range(0,npath):      
        B_siB0[0,i]=B_si[1,i]+B0[0] #adding B0 in pmag coor + B_si in model coor
        B_siB0[1,i]=B_si[0,i]+B0[1]
        B_siB0[2,i]=-B_si[2,i]+B0[2]
        
        In_siB0[i]=np.sqrt(B_siB0[0,i]**2+B_siB0[1,i]**2+B_siB0[2,i]**2)
        Ic_siB0[i]=np.arctan2(B_siB0[2,i],np.sqrt(B_siB0[0,i]**2+B_siB0[1,i]**2))/np.pi*180
        Dc_siB0[i]=np.arctan2(B_siB0[1,i],B_siB0[0,i])/np.pi*180
   
        if benchmark=='4':
           linefile1.write("%e %e %e %e %e %e \n" %(B_siB0[0,i], B_siB0[1,i], B_siB0[2,i],\
                                                    In_siB0[i], Ic_siB0[i], Dc_siB0[i]))    
        else:         
           linefile1.write("%e %e %e %e %e %e %e \n" %(dmeas[i],\
                                                       B_siB0[0,i], B_siB0[1,i], B_siB0[2,i],\
                                                      In_siB0[i], Ic_siB0[i], Dc_siB0[i]))            
    return B_siB0,In_siB0,Ic_siB0,Dc_siB0

###################################################################################################
# this function returns a topography value at each point x,y passed as argument

def topography(x,y,A,llambda,cos_dir,sin_dir,slopex,slopey):
    """
    Returns topography (height) value at each point defined by x,y coordinates passed.   
    
    :param x: x coordinate of computation point.
    :type x: scalar(float) 
    :param y: y coordinate of computation point.
    :type y: scalar(float) 
    :param A: amplitude of sine function used to approximate wavy topography of ridges and gullies.
    :type A: scalar(float)
    :param llambda: wavelength of sine function used to approximate wavy topography of ridges and gullies.
    :type llambda: scalar(float)
    :param cos_dir: cosine of ``direction``, that defines the direction of the wave function along the surface (default = perpendicular to slope). 
    :type cos_dir: scalar(float)
    :param sin_dir: sine of ``direction``, that defines the direction of the wave function along the surface (default = perpendicular to slope).
    :type sin_dir: scalar(float)
    :param slopex: the tangent of the angle (in rad) of the surface that defines the slope in x direction for each respective side.
    :type slopex: scalar(float)
    :param slopey: the tangent of the angle (in rad) of the surface that defines the slope in y direction for each respective side. 
    :type slopey: scalar(float)

    :return: 
        - **h_fs** *(scalar(float))* - the height value for the point passed to function for the respective position on the flank (chosen by ``subbench``).

    """
    if llambda==0:
        pert1=0
    else:
        pert1=A*np.sin(2*np.pi/llambda*(x*cos_dir+y*sin_dir))
    pert2=slopex*x+slopey*y 
    return pert1+pert2

###################################################################################################
# returns analytical solution (vector B) 

def compute_analytical_solution(x,y,z,R,Mx,My,Mz,xcenter,ycenter,zcenter,benchmark):
   """
   Returns analytical solution, see :doc:`benchmarks`, of the components of the magnetic field for each benchmark.

   :param x: 1D array(npath) containing x coordinate of each computation point.
   :type x: array_like(float)    
   :param y: 1D array(npath) containing y coordinate of each computation point.
   :type y: array_like(float)    
   :param z: 1D array(npath) containing z coordinate of each computation point.
   :type z: array_like(float)
   :param R: radius of the sphere (if applicable)
   :type R: scalar(float)
   :param Mx: x component magnetization of magnetized body (constant).
   :type Mx: scalar(float)
   :param My: y component magnetization of magnetized body (constant).
   :type My: scalar(float)
   :param Mz: z component magnetization of magnetized body (constant).
   :type Mz: scalar(float) 
   :param xcenter: x coordinate of center of the sphere.
   :type xcenter: scalar(float) 
   :param ycenter: y coordinate of center of the sphere.
   :type ycenter: scalar(float) 
   :param zcenter: z coordinate of center of the sphere.
   :type zcenter: scalar(float) 
   :param benchmark: number associated with benchmark, see :doc:`benchmarks`.
   :type benchmark: string 

   :return: 
        - **h_fs** *(array_like(float))* - 2D array(3,npath) containing components (0=x;1=y;2=z) produced by the analytical solution for the magnetic field for chosen benchmark (and model setup) and each point.

   """
   
   #-----------------------------------------------------------------
   if benchmark=='1': 
      mu0=4*np.pi #*1e-7
      V=4/3*np.pi*R**3
      r=np.sqrt((x-xcenter)**2+(y-ycenter)**2+(z-zcenter)**2)
      Bx=0
      By=0
      Bz=2*mu0*V/4/np.pi/r**3*Mz

   #-----------------------------------------------------------------
   if benchmark=='2a' or benchmark=='2b' or benchmark=='4':
      Bx=0
      By=0
      Bz=0

   #-----------------------------------------------------------------
   if benchmark=='3': 
      r=np.sqrt((x-xcenter)**2+(y-ycenter)**2+(z-zcenter)**2)
      theta=np.arccos((z-zcenter)/r)
      phi=np.arctan2((y-ycenter),(x-xcenter))
      mu0=4*np.pi #*1e-7
      Q=(R/r)**3*mu0/3
      rux=np.sin(theta)*np.cos(phi)
      ruy=np.sin(theta)*np.sin(phi)
      ruz=np.cos(theta)
      thux=np.cos(theta)*np.cos(phi)
      thuy=np.cos(theta)*np.sin(phi)
      thuz=-np.sin(theta)
      Bx=Q*Mz*(2*(rux*np.cos(theta))+thux*np.sin(theta))
      By=Q*Mz*(2*(ruy*np.cos(theta))+thuy*np.sin(theta))
      Bz=Q*Mz*(2*(ruz*np.cos(theta))+thuz*np.sin(theta))


   return np.array([Bx,By,Bz],dtype=np.float64)

