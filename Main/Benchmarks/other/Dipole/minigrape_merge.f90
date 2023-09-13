program compute_magfield_at_plane

use mpi

implicit none
real x0,y0,z0,tstart,tend,tstart2,tend2
real fx,fy,fz
real xface(10),yface(10),zface(10)
real dx,dy,dz,hx,hy,hz,xllcorner,yllcorner
real pi,nr,mu,Xv
real A,wl,zbottom,h,sf,sb,b,bdeg,dis
real Magx,Magy,Magz,hf,dhf,slo,sl,sh
real xmin,xmax,ymin,ymax,zmin,zmax
real IGRF_E,IGRF_N,IGRF_D,IGRFint,IGRFdec,IGRFinc
real Lx,Ly,Lz,Bx_pt,By_pt,Bz_pt,xi,dztopo
real N1,N2,N3,N4,r,s,dif_h,poh
real Mean,Variance,StDev,Mean2,Variance2,Stdev2
real xs,ys,zs,rs,dr,theta,dtr,phi,noise
real Brefx,Brefy,Brefz,Brefint,Brefdec,Brefinc
real Bref_int,Bref_dec,Bref_inc,MagInc,MagInt
real IGRFx,IGRFy,IGRFz,xD,yD,xmidP,ymidP
integer ic,icx,icy,iproc,nproc,ierr,option,ho,Dres,Iter
integer npts,i,j,k,ny,nx,nz,obs,iel,site,flank,path,sDEM1
integer nelx,nely,nelz,nel,nnx,nny,nnz,nnp,counter,im
integer i1,i2,i3,i4,i5,i6,i7,i8,nsurf,ktop,counter2,fc
integer, dimension(:,:), allocatable :: icon
integer, dimension(:,:), allocatable :: icon_plane
real, dimension(:), allocatable :: x,y,z,xmeas,ymeas,zmeas,zPmeas,dmeas
real, dimension(:), allocatable :: mx,my,mz,Btx,Bty,Btz,xPmeas,yPmeas
real, dimension(:), allocatable :: intensity,inclination,declination,intm,incm,decm
real, dimension(:), allocatable :: xsurf,ysurf,zsurf,mdec,minc,mint
real, dimension(:), allocatable :: Bmx,Bmy,Bmz,Bx,By,Bz
real, dimension(:), allocatable :: BmIx,BmIy,BmIz,intIm,incIm,decIm
real, dimension(:), allocatable :: xc,yc,zc,X_DEM,Y_DEM,Z_DEM
real, dimension(:), allocatable :: yp3,yp4,yp2,yp1,xp1,xp2,xp3,xp4
real, dimension(:), allocatable :: hp1,hp2,hp3,hp4,hp,hpo,pdo,pmdo

real x01,x02,x03,x04,y01,y02,y03,y04,x0D,y0D 

integer, parameter :: nface_tri=3
integer, parameter :: nface_quad=4

character(len=255) :: arg

integer :: option_ID
integer :: argc,numarg

logical :: err_detected
logical add_random
logical add_sine
logical only_top
logical use_DEM
logical use_DEMPath
logical DEM_random
logical flanksim
logical use_meas
logical sin_random
logical use_path
logical sphere
logical line_vert
logical etna
logical produce_dif_h
logical combine
logical add_noise

pi = 4.d0*atan(1d0)
mu = 4.d0*pi*(1e-7) !vacuum permeability of air
dtr = pi/180.d0 !degrees to radian

!--------------------------------------------------------------
CALL mpi_init(ierr)                             
call mpi_comm_size (mpi_comm_world,nproc,ierr) 
call mpi_comm_rank (mpi_comm_world,iproc,ierr) 
if (iproc==0) print *,'----------------------------------------------'
call mpi_barrier(mpi_comm_world,ierr)
print *,'I am thread ',iproc,' out of ',nproc
call flush(6)
call mpi_barrier(mpi_comm_world,ierr)
if (iproc==0) print *,'----------------------------------------------'

!---------------------------------------------------------------------
!BENCHMARKS
!----------------------
!benchmarks 2D sphere, line vertical dipole, add_random noise to y direction
sphere=.false.    !3D sphere -> numerical solve of function if the M is only in z direction and angles of r 
line_vert=.true.    ! vertical -> numerical solve for dipole -> for far away
add_random=.false.     ! adding random noise in the z direction 

!----------------------------
!options for Mag & B ref
!--------------------------------------
etna=.false.      !The IGRF & Mag, shape of sin of Etna

!--------------------------------
!Topography options
!--------------------------------
!choose either: Use_DEM, add_sine/flanksim or use_DEMPath. Can not be combined.
use_DEM=.false.           !use DEM -> make sure to use the right site 
Dres=5                   ! 2x2  or 5x5 m 
sDEM1=3                  ! to do domain size test, 1 only 2m DEM => site 1: 2000, 2: 1400, 3: 1000 4: 600 5:400  6:100 7:4000 8:6000
                          !if site 6 and DEM 5 then 1:2100 2:1100 3:600 4:300,5:smallest possible. ALL OTHER 5m DEM 
                          !1: 2000m, 2: 300, 3:200
use_DEMPath=.false.      !topography from path walked, an average of the distance between measurement points will be used combined
                         !with the height measurements and a repeated path topography is tested (NOTE: does not work on all sites!!)
 combine=.false.         ! combines all height measurements from all walks on the path (of differents measurement heights)
 Iter=7                  !if use_DEMPath how many times the topography of the path will be iterated, chose amount of iterations 

add_sine=.false.         !sine function used for topography, approximation of a surface
 flanksim=.false.        !flanksimulation of the Etna -> the M + the sine + the IGRF will be 'rotated' to the appropriate flank

only_top=.false.         !only top means only to the surface and rest is deformed to fit 
add_noise=.false.         !adding noise to path, currently DEM, flank sim  and simple sine only   
!--------------------------
!Observation / computation  options
!-------------------------
use_meas=.true.         !use measurement plane/path based above the elements not a function the same as the topography (which is
                         !the default setting if neither is chosen (however not optional on DEM or DEMPath)
use_path=.false.          !load measurements from the field path files
option=2          
!option=1                x(meas), y(meas) & z(meas) from the field path
!option=2                xy (meas) from field path, but z from DEM
!option=3                a square around the measurements, adding 20 m on both sides (x & y of field path)
produce_dif_h=.false.    !produces difference between h from path and h from DEM stops afterwards

!-------------------------------------------
!observation method, 1=plane, 2=vertical line, 3=path
obs=2                    !vertical path is only used for a benchmark 

!add IGRF/Bref, DEM site 1-6. If not chosen: IGRF average (south flank added if flanksim)
site=1
path=1
flank=1                  !Flank simulation Etna, 1=S, 2=E, 3=N, 4=W
ho=1                     !height option path => difference per path, regular is 1=100 cm and 2=180 cm, site 5: h:1 25,h:2 75,h:3
                         !125,h:4 175 

!-------------------------------
!INPUT PARAMETERS 
!------------------------------

!height above surface, req. when using add_sine or add_DEM
h=1

!amplitude and wave length of sine 
A=4
wl=50
dis=-7.5

! size of domain
!Lx=2
!Ly=2
!lz=2
Lx=30
Ly=30
lz=30

!Lz=lx*2.4d0

!number of cells
!nelx=300*4
nelx=10
nely=10
nelz=10
!nelz=90

!Magnetization & ref field
Brefx=0
Brefy=0
Brefz=0
Magx=0
Magy=1.d0
Magz=0



if (line_vert) then
 Lx=2
 Ly=2
 Lz=2
 Brefx=0.d0
 Brefy=0.d0
 Brefz=0.d0
 Magx=0.d0
 Magy=1.d0
 Magz=0.d0
 nelx=100
 nely=100
 nelz=100
end if 

if (sphere) then
 Lx=21
 Ly=21
 Lz=21
 Brefx=0.d0
 Brefy=0.d0
 Brefz=0.d0
 Magx=0.d0
 Magy=0.d0
 Magz=7.5
 nelx=100
 nely=100
 nelz=100
end if 






if (etna) then
!Magx=0
!Magy=4.085d0
!Magz=-6.290d0


MagInc=57.d0
MagInt=7.5d0
Magx=0 
Magy=MagInt*(cos(dtr*MagInc)) 
Magz=-(MagInt*(sin(dtr*MagInc))) 
A=4
wl=25
dis=0
!Magy=7.080d0
!Magz=-10.90d0
end if 

!bdeg is the deviation of the sine with the direction of the sine <-90:90] -> b is in radian, -90 and 90 are the same, use 90.
!The surface(sin) is flipped every time so the sine proceeds to the right side of the domain, being different for every flank, for easy
!comparing. If bdeg=90 then the sine goes up the slope. Does not matter on big scale but is more correct on small to compare.flanksim
!z0=(Lz/2)
sf=0.15
bdeg=0

!----------------------------------------
option_ID=1

numarg = command_argument_count()
if (numarg>0) then

   argc=command_argument_count()

   do while (option_ID <= argc)
   call getarg(option_ID,arg)
   !print *,arg

  if (arg == '-site' ) then 
      option_ID=option_ID+1
      call getarg(option_ID,arg)
      read(arg,*) site
      write(*,'(a,i3)') 'read: site = ',site
      write(*,'(a)') '--------------------------------'
  elseif (arg == '-path' ) then 
      option_ID=option_ID+1
      call getarg(option_ID,arg)
      read(arg,*) path
      write(*,'(a,i3)') 'read: path = ',path
      write(*,'(a)') '--------------------------------'
  elseif (arg == '-height' ) then 
      option_ID=option_ID+1
      call getarg(option_ID,arg)
      read(arg,*) ho
      write(*,'(a,i3)') 'read: height option = ',ho
      write(*,'(a)') '--------------------------------'
  elseif (arg == '-Iter' ) then 
      option_ID=option_ID+1
      call getarg(option_ID,arg)
      read(arg,*) Iter
      write(*,'(a,i3)') 'read: Iteration = ',Iter
      write(*,'(a)') '--------------------------------'
  elseif (arg == '-sDEM1' ) then 
      option_ID=option_ID+1
      call getarg(option_ID,arg)
      read(arg,*) sDEM1
      write(*,'(a,i3)') 'read: size DEM 1 = ',sDEM1
      write(*,'(a)') '--------------------------------'
  elseif (arg == '-flank' ) then 
      option_ID=option_ID+1
      call getarg(option_ID,arg)
      read(arg,*) flank
      write(*,'(a,i3)') 'read: flank = ',flank
      write(*,'(a)') '--------------------------------'
   else
      err_detected=.true.
      stop 'detected error in input parameters'
      exit
   end if

   option_ID=option_ID+1

   end do

end if


!special cases of domain, hard set input parameters  in specific domain cases !
!---------------------------------------- -------------------------------------
!DEM  SPECIFIC INPUT                                     
!---------------------------------------- --------------------------------------
if (use_DEM) then                         
  if (site==1) then                       
   if (Dres==2) then                      
    ! size of domain, Lz is the added dep th under the DEM
    Lx=1038*2 !2x nelx                    
    Ly=1031*2 !2x nely                    
    Lz=5000                               
    !number of cells                      
    nelx=1038 !ncols-1                    
    nely=1031 !nrows-1                    
    nelz=10                               
    xllcorner=500700.44188544d0           
    yllcorner=4170086.9789642d0           
   elseif (Dres==5) then                  
    Lx=415*5                              
    Ly=412*5                              
    Lz=5000                               
    !number of cells                      
    nelx=415                              
    nely=412                              
    nelz=10                               
    xllcorner=500698.81984712d0           
    yllcorner=4170088.3580075d0           
   end if                                 
  elseif (site==2 .or. site==5) then      
   if (Dres==2) then                      
    Lx=1050*2                             
    Ly=1039*2                             
    Lz=5000                               
    nelx=1050                             
    nely=1039                             
    nelz=10                               
    xllcorner=498322.44188544d0           
    yllcorner=4170900.9789642d0           
   elseif (Dres==5) then                  
    Lx=420*5                              
    Ly=415*5                              
    Lz=5000                               
    !number of cells                      
    nelx=420                              
    nely=415                              
    nelz=10                               
    xllcorner=498318.81984712d0           
    yllcorner=4170903.3580075d0           
   end if                                 
  elseif (site==3) then                   
   if (Dres==2) then                      
    Lx=1053*2                             
    Ly=1052*2
    Lz=5000
    nelx=1053
    nely=1052
    nelz=10
    xllcorner=506076.44188544d0
    yllcorner=4187572.9789642d0   
   elseif (Dres==5) then
    stop 'site 3 is not on the 5x5 DEM' 
   end if         
 elseif (site==4 .or. site==6) then 
   if (Dres==2) then
    Lx=1043*2
    Ly=1112*2
    Lz=5000
    nelx=1043
    nely=1112
    nelz=10
    xllcorner=504334.44188544d0
    yllcorner=4182130.9789642d0
   elseif (Dres==5) then
    Lx=417*5
    Ly=444*5
    Lz=5000
    !number of cells
    nelx=417
    nely=444
    nelz=10
    xllcorner=504333.81984712d0
    yllcorner=4182133.3580075d0
   end if         
  end if 
end if

!--------------
!DEM SIZE TESTS
!--------------

!for the DEM size test 4
if (use_DEM .and. site==4 .and. Dres==5 .and. sDEM1>=2) then                       
  if (sDEM1==2) then                      
    Lx=44*5
    Ly=53*5
    Lz=Ly*2.4d0
    !number of cells
    nelx=44 !ncols-1
    nely=53 !nrows-1
    nelz=10
    xllcorner=505233.81984712d0
    yllcorner=4183088.3580075d0
  elseif (sDEM1==3) then
    Lx=24*5
    Ly=33*5
    Lz=Ly*2.4d0
    !number of cells
    nelx=24
    nely=33
    nelz=10
    xllcorner=505283.81984712d0
    yllcorner=4183138.3580075d0
 end if 
end if


!for the DEM size test 2 5
if (use_DEM .and. (site==2 .or. site==5) .and. Dres==5 .and. sDEM1>=2) then                       
  if (sDEM1==2) then                      
    Lx=60*5
    Ly=55*5
    Lz=Ly*2.4d0
    !number of cells
    nelx=60 !ncols-1
    nely=55 !nrows-1
    nelz=10
    xllcorner=499218.81984712d0
    yllcorner=4171803.3580075d0
  elseif (sDEM1==3) then
    Lx=40*5
    Ly=35*5
    Lz=Ly*2.4d0
    !number of cells
    nelx=40
    nely=35
    nelz=10
    xllcorner=499268.81984712d0
    yllcorner=4171853.3580075d0
 end if 
end if



!for the DEM size test 3
if (use_DEM .and. site==3 .and. sDEM1>=2) then                       
  if (sDEM1==2) then                      
    Lx=153*2
    Ly=152*2
    Lz=Ly*2.4d0
    !number of cells
    nelx=153 !ncols-1
    nely=152  !nrows-1
    nelz=10
    xllcorner=506976.44188544d0
    yllcorner=4188472.9789642d0
  elseif (sDEM1==3) then
    Lx=103*2
    Ly=107*2
    Lz=Ly*2.4d0
    !number of cells
    nelx=103
    nely=107
    nelz=10
    xllcorner=507026.44188544d0
    yllcorner=4188522.9789642d0
 end if 
end if



!for the DEM size tests 6
if (use_DEM .and. site==6 .and. Dres==5 .and. sDEM1>=2) then                       
  if (sDEM1==2) then                      
    Lx=217*5
    Ly=244*5
    Lz=Ly*2.4d0
    !number of cells
    nelx=217
    nely=244
    nelz=10
    xllcorner=504833.81984712d0
    yllcorner=4182633.3580075d0
  elseif (sDEM1==3) then
    Lx=97*5
    Ly=124*5
    Lz=Ly*2.4d0
    !number of cells
    nelx=97
    nely=124
    nelz=10
    xllcorner=505133.81984712d0
    yllcorner=4182933.3580075d0
  elseif (sDEM1==4) then
    Lx=57*5
    Ly=84*5
    Lz=Ly*2.4d0
    !number of cells
    nelx=57
    nely=84
    nelz=10
    xllcorner=505233.81984712d0
    yllcorner=4183033.3580075d0
   elseif (sDEM1==5) then
    Lx=35*5
    Ly=60*5
    Lz=Ly*2.4d0
    !number of cells
    nelx=35
    nely=60
    nelz=10
    xllcorner=505313.81984712d0
    yllcorner=4183083.3580075d0
  elseif (sDEM1==6) then
    Lx=23*5
    Ly=48*5
    Lz=Ly*2.4d0
    !number of cells
    nelx=23
    nely=48
    nelz=10
    xllcorner=505343.81984712d0
    yllcorner=4183113.3580075d0
  end if 
 end if 

if (use_DEM .and. site==1  .and. sDEM1>=2) then                       
  
  if (Dres==2) then        
  if (sDEM1==2) then                      
    Lx=738*2 !2x nelx                    
    Ly=731*2 !2x nely                    
    Lz=3555                               
    nelx=738 !ncols-1                    
    nely=731 !nrows-1                    
    nelz=10                               
    xllcorner=501000.44188544d0           
    yllcorner=4170386.9789642d0    
  elseif (sDEM1==3) then                      
    Lx=538*2 !2x nelx                    
    Ly=531*2 !2x nely                    
    Lz=2592                               
    nelx=538 !ncols-1                    
    nely=531 !nrows-1                    
    nelz=10                               
    xllcorner=501200.44188544d0           
    yllcorner=4170586.9789642d0  
  elseif (sDEM1==4) then                      
    Lx=338*2 !2x nelx                    
    Ly=331*2 !2x nely                    
    Lz=3000                               
    nelx=338 !ncols-1                    
    nely=331 !nrows-1                    
    nelz=10                               
    xllcorner=501400.44188544d0           
    yllcorner=4170786.9789642d0
  elseif (sDEM1==5) then                      
    Lx=238*2 !2x nelx                    
    Ly=231*2 !2x nely                    
    Lz=1146                               
    nelx=238 !ncols-1                    
    nely=231 !nrows-1                    
    nelz=10                               
    xllcorner=501500.44188544d0           
    yllcorner=4170886.9789642d0 
  elseif (sDEM1==6) then                      
    Lx=38*2 !2x nelx                    
    Ly=31*2 !2x nely                    
    Lz=183                               
    nelx=38 !ncols-1                    
    nely=31 !nrows-1                    
    nelz=10                               
    xllcorner=501700.44188544d0           
    yllcorner=4171086.9789642d0   
  elseif (sDEM1==7) then                      
    Lx=2038*2 !2x nelx                    
    Ly=2019*2 !2x nely                    
    Lz=9782                               
    nelx=2038 !ncols-1                    
    nely=2019 !nrows-1                    
    nelz=10                               
    xllcorner=499700.44188544d0           
    yllcorner=4169086.9789642d0    
  end if
elseif (Dres==5) then
  if (sDEM1==2) then                      
    Lx=55*5 !2x nelx                    
    Ly=52*5 !2x nely                    
    Lz=Lx*2.4d0                               
    nelx=55 !ncols-1                    
    nely=52 !nrows-1                    
    nelz=10                               
    xllcorner=501598.81984712d0           
    yllcorner=4170988.3580075d0     
  elseif (sDEM1==3) then                      
    Lx=35*5 !2x nelx                    
    Ly=32*5 !2x nely                    
    Lz=Lx*2.4d0                               
    nelx=35 !ncols-1                    
    nely=32 !nrows-1                    
    nelz=10                               
    xllcorner=501648.81984712d0           
    yllcorner=4171038.3580075d0     
   end if
  end if
end if


if (use_path .and. Dres==2) then
 if (site==1 .or. site==2 .or. site==3 .or. site==5) then
  poh=8.5d0     !offset from height of path to height of DEM.
 else
  poh=0.d0
 end if
elseif (use_path .and. Dres==5) then
 if (site==1 .or. site==2 .or. site==4 .or. site==5) then
  poh=3.d0
 else 
  poh=0.d0
 end if 
end if 

!-----------------------
!sphere is a benchmark
!-----------------------
if (sphere) then
 xs=(Lx/2)
 ys=(Ly/2)
 zs=(Lz/2)
 rs=10.d0
 dr=10.4d0
 theta=0        !ver angle between ^r & ^k if B is only directed in j, xaxis= 90,0 yaxis=90,90 zaxis=0,-
 phi=0          !hor angle from ^i increasing anticlockwise
 Xv=0.05d0       !the (effective) magnetic susceptibility of the material 
 x0=xs+sin(theta*dtr)*cos(phi*dtr)*dr 
 y0=ys+sin(theta*dtr)*sin(phi*dtr)*dr
 z0=-zs+cos(theta*dtr)*dr
 Brefx=(mu*(1.d0+Xv)*Magx)/Xv
 Brefy=(mu*(1.d0+Xv)*Magy)/Xv
 Brefz=(mu*(1.d0+Xv)*Magz)/Xv
 CALL  compute_benchmark_sphere(rs,dr,Brefx,Brefy,Brefz,Magx,Magy,Magz,Xv,theta,phi,x0,y0,z0)
end if 

!---------------------
!single dipole is a benchmark
!--------------------
if (line_vert) then
 xs=(Lx/2)
 ys=(Ly/2)
 zs=(Lz/2)
 rs=1.d0
end if 

!add observation style, 1=plane, 2=vertical line, 3=path
if (line_vert) obs=2
if (sphere) obs=3

if (use_path) then
 if (option==2 .or. option==1) obs=3
 if (option==3) obs=1
 if (ho==2) h=1.8d0
 if (ho==1) h=1.d0
 if (site==5) then
  if (ho==1) h=0.25d0
  if (ho==2) h=0.75d0
  if (ho==3) h=1.25d0
  if (ho==4) h=1.75d0
 end if 
end if

!Flank simulation Etna, 1=S, 2=E, 3=N, 4=W
if (flanksim .or. use_DEMPath) then
 if (site==1 .or. site==2 .or. site==5) then  
   flank=1
 elseif (site==3) then
  flank=3
  bdeg=-31
 elseif (site==4 .or. site==6) then 
   flank=2      !note that they geographically lie on the norther flank, but the direction of the paths is s-N) 
 end if 
end if

if (flanksim) then
 if (bdeg/=90 .and. bdeg/=0) then
  if (flank==2 .or. flank==4) then 
   bdeg=-(bdeg)
  end if 
 end if
 b=bdeg*pi/180d0
end if 

if (add_noise .and. add_sine) then 
 use_meas=.true. 
end if 


!---------------------------------------------
!------Computational option input--------------
!---------------------------------------------
if (obs==1) then !plane 
   xmin=988
   xmax=1088
   ymin=981
   ymax=1081
   zmin=1
   zmax=1
   nx=30
   ny=30
   nz=1
end if

if (obs==2) then !vertical line
   xmin= xs
   xmax= xs
   ymin= ys
   ymax= ys
   zmin=0.01d0
   zmax=10000d0
   nx=1
   ny=1
   nz=10000
end if

if (obs==3) then !path
 xmin=lx/2d0-30.2
 xmax=lx/2d0+30.1 
 ymin=ly/2d0
 ymax=ly/2d0
 zmin=1
 zmax=1
 nx=50
 ny=1
 nz=1
 if (flanksim) then
   if (flank==2 .or. flank==4) then
     xmin=lx/2d0
     xmax=lx/2d0
     ymin=Ly/2d0-25
     ymax=ly/2d0+25
     nx=1
     ny=60
   end if 
  end if 
end if 

!-------------------------------------------------
!hard set parameters due from observation options choises 
if (use_path .and. obs==3) then
 if (site==1) then
   if (option==1 .or. option==2 .or. produce_dif_h) then
     if (path==1) npts=39
     if (path==2) npts=27
     if (path==3) npts=36
   elseif (option==3) then
     xmin=501682-xllcorner
     xmax=501764-xllcorner
     ymin=4171093-yllcorner
     ymax=4171169-yllcorner
   end if 
 elseif (site==2) then
   if (option==1 .or. option==2 .or. produce_dif_h) then
     if (path==1) npts=30
     if (path==2) npts=39
     if (path==3) npts=42
    elseif (option==3) then
     xmin=499302-xllcorner
     xmax=499414-xllcorner
     ymin=4171902-yllcorner
     ymax=4172001-yllcorner
    end if 
  elseif (site==3) then
   if (option==1 .or. option==2 .or. produce_dif_h) then
     if (path==1) npts=39
     if (path==2) npts=55
     if (path==3) npts=40
    elseif (option==3) then
     xmin=507102-xllcorner
     xmax=507203-xllcorner
     ymin=4188553-yllcorner
     ymax=4188697-yllcorner
    end if 
  elseif (site==4) then
   if (option==1 .or. option==2 .or. produce_dif_h) then
     if (path==1) npts=38
     if (path==2) npts=56
     if (path==3) npts=54
    elseif (option==3) then
     xmin=505317-xllcorner
     xmax=505441-xllcorner
     ymin=4183171-yllcorner
     ymax=4183276-yllcorner
    end if 
  elseif (site==5) then
   if (option==1 .or. option==2 .or. produce_dif_h) then
     if (path==1) npts=28
     if (path==2) npts=31
     if (path==3) npts=27
    elseif (option==3) then
     xmin=499372-xllcorner
     xmax=499436-xllcorner
     ymin=4171888-yllcorner
     ymax=4171946-yllcorner
    end if 
  elseif (site==6) then
    if (option==1 .or. option==2 .or. produce_dif_h) then
     npts=147
    elseif (option==3) then
     xmin=505340-xllcorner
     xmax=505459-xllcorner
     ymin=4183112-yllcorner
     ymax=4183376-yllcorner
    end if 
  end if 
end if 

if (flanksim .or. use_DEMPath) then
  if (flank==1 .or. flank==3) then 
   hf=sf*Ly
   dhf=hf/nely
  else 
   hf=sf*Lx
  dhf=hf/nelx
  end if 
end if 

if (sphere) then
  nz=1
  ny=1
  nx=1
  npts=1
end if


if (use_DEMPath) then
 nelx=(npts*Iter)-1
 nely=(npts*Iter)-1
 nelz=10
end if 

nnx=nelx+1
nny=nely+1
nnz=nelz+1
nsurf=(nelx+1)*(nely+1)

nel=nelx*nely*nelz
nnp=nnx*nny*nnz
if (.not. use_path) npts=nx*ny*nz




!--------------------------
!printing the input 
!--------------------------
if (iproc==0) then
 if (.not. use_DEMPath) then 

  print *, '----------------- Domain --------------------' 
  print *,'Lx=',Lx
  print *,'Ly=',Ly
  print *,'Lz=',Lz
 end if  
 print *,'nelx=',nelx
 print *,'nely=',nely
 print *,'nelz=',nelz
 print *,'nel =',nel
 print *,'nsurf=',nsurf
 print *,'Mx=',Magx
 print *,'My=',Magy
 print *,'Mz=',Magz

 print *, '--------------- Observations ----------------' 
 if (obs==1) print *,'observation plane'
 if (obs==2) print *,'observation vertical line'
 if (obs==3) print *,'observation path'
 if (.not. sphere .and. .not. use_path) then 
   
  print *,'height above=',h
  print *,'xmin=',xmin
  print *,'xmax=',xmax
  print *,'ymin=',ymin
  print *,'ymax=',ymax
  print *,'zmin=',zmin
  print *,'zmax=',zmax
 
  print *,'nx=',nx
  print *,'ny=',ny
  print *,'nz=',nz
  print *,'npts=',npts
 end if 
 if (use_path) then
   print *, 'Chosen: loading observation path from field path'
   if (option==1) print *,option, '=z is from path'
   if (option==2) print *,option, '=z is from mesh'
   if (option==3) print *,option, '=plane around field path, 20 m on both sides added, square'
  print *,'height above=',h
 end if 


 print *,'------- optional functions information --------'
 if (etna) print *,'site=',site
 if (use_path .or. use_DEMPath) then 
  print *, 'path=', path
  print *, 'height option=', ho 
 end if 
 if (use_DEM) then
  print *, 'Chosen: DEM as topography'
  print *,'height above surface=',h
 elseif (add_sine) then
  print *,'added sine approximation as topography'
  print *,'Amplitude=',A
  print *,'wavelength=',wl
  print *,'displacement=',dis
 end if 
 if (only_top) then
  print *,'only to  top (flat bottom)'
 else
  print *, 'to all layers bottom=top surface' 
 end if  
 if (add_noise) then
   print*, 'noise added'          
   print*, 'noise [-1;1],0.1'          
 end if 
 if (flanksim .or. use_DEMPath) then 
  if (flank==1) then 
   print *,flank,'South Flank'
  elseif (flank==2) then
   print *,flank,'East Flank'
  elseif (flank==3) then
   print *,flank,'North Flank'
  elseif (flank==4) then
   print *,flank,'West Flank'
  else
   stop 'no flank chosen' 
  end if
  print *, 'surface flank angle =', sf
  if (flank==1 .or. flank==3) then 
   if (.not. use_DEMPath) print *, 'angle of sine to the x-axis=',bdeg
  end if 
  if (flank==2 .or. flank==4) then 
   if (.not. use_DEMPath) print *, 'angle of sine to the y-axis=',bdeg
  end if 
 end if
 if (line_vert) print*, 'Benchmark vertical line, goal: dipole'
 if (sphere .or. line_vert) then 
  print*, 'Benchmark spherical inclusion, goal: numerical solve' 
  print *,'distance to point r=',dr
  print *,'radius sphere=',rs
  print *,'xcentre sphere=',xs
  print *,'ycentre sphere=',ys
  print *,'zcentre sphere=',zs
  if (sphere) then
  print *,'theta',theta
  print *,'phi',phi
  print *,'x0=',x0
  print *,'y0=',y0
  print *,'z0=',z0
  end if 
 end if
 if (use_DEMPath) then
  print *,'chosen: Building mesh from path'
  print *,'Iteration of the path=',Iter
  end if
end if 

!----------------------------------------------------
!stops if the input parameters are not in bounds
if (b>90 .or. b<=-90) then 
 stop 'b can not be outside of range <-90:90]'
end if 
if (only_top .and. .not. (add_sine .or. use_DEM) ) then
stop 'can not do only top without adding sine or using DEM'
elseif (flanksim .and. .not. add_sine) then
    stop 'can not do flanksim without adding sine' 
elseif (use_DEM .and. .not. use_meas .and. .not. use_path) then
    stop 'can not use DEM without computing observation points' 
elseif (use_path .and. use_meas) then 
   stop 'either use Path or use measurements calculated'
elseif (use_DEM .and. use_DEMPath) then
   stop 'either use DEM or use DEMPpath (produce a topography based on the path)'
elseif (use_DEM .and. add_sine) then
   stop 'either use DEM or add_sine'
elseif (use_DEMPath .and. add_sine) then
   stop 'either use DEMPath or add_sine'
elseif (Iter <=2 .and. use_DEMPath .and. Iter/=1) then
  stop 'Iteration of the path can not be either >=3 or 1'
!if (Iter==1 .and. combine) stop 'iteration 1 can only be done with a single path)'
elseif (flanksim .and. use_DEMPath) then
   stop 'do not use flanksim for DEMPAth, flanksim is only used for the sine approx, flank will be sloped using just DEMPath'
end if
if (use_path .and. .not. site==5) then
   if (ho>=3) stop 'height option 3 and 4 do not exist outside site 5'
end if
if (flanksim .and. use_DEM) then
        stop 'either flanksim or DEM'
end if 

if (obs==2) then
  if (add_sine .or. use_DEM .or. only_top .or. add_random .or. flanksim .or. use_DEMPath) &
          stop 'observation vertical line only used for benchmark' 
end if 


!----------------------------------------------------------------
!!!!!!!!!!START ACTUAL MODEL!!!!!!!!!!!!
!----------------------------------------------------------------
!----------------------------------------------------------------
!Build mesh, coordinates and connectivity array,  regular spacing 
!----------------------------------------------------------------
if (iproc==0) print *,'----------------------------------------------'
allocate(x(nnp))
allocate(y(nnp))
allocate(z(nnp))
allocate(X_DEM(nsurf))
allocate(Y_DEM(nsurf))
allocate(Z_DEM(nsurf))
allocate(zsurf(nsurf))
allocate(icon(8,nel))

if (.not. use_DEMPath) then
 hx=Lx/nelx
 hy=Ly/nely
 hz=Lz/nelz
! if (iproc==0) then
!  print *,'hx=',hx
!  print *,'hy=',hy
!  print *,'hz=',hz
! end if
end if 

 counter=0    
do i=0,nelx    
   do j=0,nely 
      do k=0,nelz
         counter=counter+1
         x(counter)=dble(i)*Lx/nelx
         y(counter)=dble(j)*Ly/nely
         z(counter)=dble(k)*Lz/nelz - Lz
       end do
  end do
end do
      !     Z
      !     |
      !     5---8---y  
      !    /   /
      !   6---7
      !     |
      !     1---4---y  
      !    /   /
      !   2---3
      !  /  
      ! x   

       !     
      !     
      !     1---2---x  
      !    /   /
      !   4---3
      !     |
      !     5---6---x  
      !    /: /
      !   8---7
      !  /  :
      ! y   Z

counter=0
do i=1,nelx
   do j=1,nely
      do k=1,nelz
      counter=counter+1
      icon(1,counter)=nny*nnz*(i-1)+nnz*(j-1)+k
      icon(2,counter)=nny*nnz*(i  )+nnz*(j-1)+k
      icon(3,counter)=nny*nnz*(i  )+nnz*(j  )+k
      icon(4,counter)=nny*nnz*(i-1)+nnz*(j  )+k
      icon(5,counter)=nny*nnz*(i-1)+nnz*(j-1)+k+1
      icon(6,counter)=nny*nnz*(i  )+nnz*(j-1)+k+1
      icon(7,counter)=nny*nnz*(i  )+nnz*(j  )+k+1
      icon(8,counter)=nny*nnz*(i-1)+nnz*(j  )+k+1
      !  icon(1,counter)=nny*nnz*(i-1)+nnz*(j-1)+k+1
      !  icon(2,counter)=nny*nnz*(i-1)+nnz*(j  )+k+1
      !  icon(3,counter)=nny*nnz*(i  )+nnz*(j  )+k+1
      !  icon(4,counter)=nny*nnz*(i  )+nnz*(j-1)+k+1
      !  icon(5,counter)=nny*nnz*(i-1)+nnz*(j-1)+k
      !  icon(6,counter)=nny*nnz*(i-1)+nnz*(j  )+k
      !  icon(7,counter)=nny*nnz*(i  )+nnz*(j  )+k
      !  icon(8,counter)=nny*nnz*(i  )+nnz*(j-1)+k
      end do
   end do
end do

if (sphere .or. line_vert) then
 allocate(xc(nel))
 allocate(yc(nel))
 allocate(zc(nel))

 counter=0
 do i=0,(nelx-1)
   do j=0,(nely-1)
     do k=0,(nelz-1)
       counter=counter+1
        xc(counter)=(Lx/nelx)/2+((Lx/nelx)*i)
        yc(counter)=(Ly/nely)/2+((Ly/nely)*j)
        zc(counter)=(Lz/nelz)/2+((Lz/nelz)*k)
    end do
   end do
  end do
end if 

!---------------------------------------------------
! offet and deform grid options 
!---------------------------------------------------
!--------------------------------------------------
!Add DEM to surface
!----------- read DEM -----------------------------

call mpi_barrier(mpi_comm_world,ierr)
if (iproc==0) print *,'----------------------------------------------'

if (iproc==0) then
  if (.not. produce_dif_h) then
   if (add_sine .or. flanksim .or. use_DEM .or. use_DEMPath) then 
    open(unit=321,file='topography.dat',status='replace',action='write')     
    write(321,*) '# 1 2 3'
    write(321,*) '# x y z'
   end if 
   if (use_path) then
    open(unit=222,file='topography_small.dat',status='replace',action='write')     
    write(222,*) '# 1 2 3'
    write(222,*) '# x y z'
   end if 
 end if
end if 

if (use_DEM) then
 if (site==1) then
  if (Dres==2 .and. sDEM1==1) open(unit=123,file='DEMS/2m_utm_bili_site1.asc', action='read')
  if (Dres==2 .and. sDEM1==1) print*, 'reading from 2x2 DEM site 1 regular size'
  if (Dres==2 .and. sDEM1==2)  open(unit=123,file='DEMS/dem2m_site1_1400.asc', action='read')
  if (Dres==2 .and. sDEM1==2) print*, 'reading from 2x2 DEM site 1 1400'
  if (Dres==2 .and. sDEM1==3)  open(unit=123,file='DEMS/dem2m_site1_1000.asc', action='read')
  if (Dres==2 .and. sDEM1==3) print*, 'reading from 2x2 DEM site 1 1000'
  if (Dres==2 .and. sDEM1==4)  open(unit=123,file='DEMS/dem2m_site1_600.asc', action='read')
  if (Dres==2 .and. sDEM1==4) print*, 'reading from 2x2 DEM site 1 600'
  if (Dres==2 .and. sDEM1==5)  open(unit=123,file='DEMS/dem2m_site1_400.asc', action='read')
  if (Dres==2 .and. sDEM1==5) print*, 'reading from 2x2 DEM site 1 400'
  if (Dres==2 .and. sDEM1==6)  open(unit=123,file='DEMS/dem2m_site1_0.asc', action='read')
  if (Dres==2 .and. sDEM1==6) print*, 'reading from 2x2 DEM site 1 0-around paths'
  if (Dres==2 .and. sDEM1==7)  open(unit=123,file='DEMS/dem2m_site1_4000.asc', action='read')
  if (Dres==2 .and. sDEM1==7) print*, 'reading from 2x2 DEM site 1 4000 around paths'
  if (Dres==5 .and. sDEM1==1) open(unit=123,file='DEMS/5m_site1.asc', action='read')
  if (Dres==5 .and. sDEM1==1) print*, 'reading from 5x5 DEM site 1 2000'
  if (Dres==5 .and. sDEM1==2) open(unit=123,file='DEMS/dem5m_site1_300.asc', action='read')
  if (Dres==5 .and. sDEM1==2) print*, 'reading from 5x5 DEM site 1 300'
  if (Dres==5 .and. sDEM1==3) open(unit=123,file='DEMS/dem5m_site1_200.asc', action='read')
  if (Dres==5 .and. sDEM1==3) print*, 'reading from 5x5 DEM site 1 200'
  elseif (site==2 .or. site==5) then
  if (Dres==2) open(unit=123,file='DEMS/2m_utm_bili_site2_5.asc', action='read')
  if (Dres==2) print*, 'reading from 2x2 DEM site 2 and 5 '
  if (Dres==5 .and. sDEM1==1) open(unit=123,file='DEMS/5m_site2_5.asc', action='read')
  if (Dres==5 .and. sDEM1==1) print*, 'reading from 5x5 DEM site 2 and 5 2000'
  if (Dres==5 .and. sDEM1==2) open(unit=123,file='DEMS/dem5m_site2_5_300.asc', action='read')
  if (Dres==5 .and. sDEM1==2) print*, 'reading from 5x5 DEM site 2 and 5 300'
  if (Dres==5 .and. sDEM1==3) open(unit=123,file='DEMS/dem5m_site2_5_200.asc', action='read')
  if (Dres==5 .and. sDEM1==3) print*, 'reading from 5x5 DEM site 2 and 5 200'

 elseif (site==4 .or. site==6) then
  if (Dres==2) open(unit=123,file='DEMS/2m_utm_bili_site4_6.asc', action='read')
  if (Dres==2) print*, 'reading from 2x2 DEM site 4 and 6'
  if (Dres==5 .and. site==4 .and. sDEM1==1)  open(unit=123,file='DEMS/5m_site4_6.asc', action='read')
  if (Dres==5 .and. site==4 .and. sDEM1==1)  print*, 'reading from 5x5 DEM site 4 and 6 2000'
  if (Dres==5 .and. site==4 .and. sDEM1==2)  open(unit=123,file='DEMS/dem5m_site4_300.asc', action='read')
  if (Dres==5 .and. site==4 .and. sDEM1==2)  print*, 'reading from 5x5 DEM site 4 specific 300'
  if (Dres==5 .and. site==4 .and. sDEM1==3)  open(unit=123,file='DEMS/dem5m_site4_200.asc', action='read')
  if (Dres==5 .and. site==4 .and. sDEM1==3)  print*, 'reading from 5x5 DEM site 4 specific 200'
 
  if (Dres==5 .and. site==6) then
      if (sDEM1==1) open(unit=123,file='DEMS/5m_site4_6.asc', action='read')
      if (sDEM1==1)  print*, 'reading from 5x5 DEM site 2100'
      if (sDEM1==2) open(unit=123,file='DEMS/dem5m_site4_6_1100.asc', action='read')
      if (sDEM1==2)  print*, 'reading from 5x5 DEM site 6 1100'
      if (sDEM1==3) open(unit=123,file='DEMS/dem5m_site4_6_500.asc', action='read')
      if (sDEM1==3)  print*, 'reading from 5x5 DEM site 6 500'
      if (sDEM1==4) open(unit=123,file='DEMS/dem5m_site4_6_300.asc', action='read')
      if (sDEM1==4)  print*, 'reading from 5x5 DEM site 6 300'
      if (sDEM1==5) open(unit=123,file='DEMS/dem5m_site4_6_50r.asc', action='read')
      if (sDEM1==5)  print*, 'reading from 5x5 DEM site 6 50 m around'
      if (sDEM1==6) open(unit=123,file='DEMS/site6_20r.asc', action='read')
      if (sDEM1==6)  print*, 'reading from 5x5 DEM site 6 20 m around'
  end if   
 elseif (site==3) then
  if (Dres==2 .and. sDEM1==1) open(unit=123,file='DEMS/2m_utm_bili_site3.asc', action='read')
  if (Dres==2 .and. sDEM1==1) print*, 'reading from 2x2 DEM site 1 2000'
  if (Dres==2 .and. sDEM1==2) open(unit=123,file='DEMS/dem2m_site3_300.asc', action='read')
  if (Dres==2 .and. sDEM1==2) print*, 'reading from 2x2 DEM site 1 300'
  if (Dres==2 .and. sDEM1==3) open(unit=123,file='DEMS/dem2m_site3_200.asc', action='read')
  if (Dres==2 .and. sDEM1==3) print*, 'reading from 2x2 DEM site 1 200'
  if (Dres==5) stop 'its impossible to ever get here, if you do something is really wrong. Hello :)' 
 end if 

!---------read the DEM from the file ----------------
 do i=nny,1,-1
   read(123,*) zsurf((i-1)*nnx+1:i*nnx)
 end do
 close(123)
 
 if (iproc==0) print *,'topo (m/M):',minval(zsurf),maxval(zsurf)

 zmin=maxval(zsurf)+h
 zmax=maxval(zsurf)+h
  
!-------- add_DEM ----------
 counter=0
 do j=1,nny
   do i=1,nnx
      counter=counter+1
      ktop=nny*nnz*(i-1)+nnz*(j-1)+nnz
      z(ktop)=zsurf(counter)
      if (add_noise) then
       call RANDOM_number(noise)
       noise=noise*2-1
       z(ktop) =  z(ktop)+noise 
      end if 
   end do
 end do

 !--------PRODUCING TOPOGRAPHY (if used)---------------
 if (iproc==0 .and. use_path) then 
  counter=0
  counter2=0
  do i=0,nelx
    do j=0,nely
     do k=0,nelz
     counter2=counter2+1
     if (k==nelz) then 
       counter=counter+1
       X_DEM(counter)= x(counter2) + xllcorner
       Y_DEM(counter)= y(counter2) + yllcorner
       Z_DEM(counter)= z(counter2) - poh
       !print*, X_DEM(i),Y_DEM(i)
       if (site==1) then 
          if (X_DEM(counter)>=501682.4419 .and. Y_DEM(counter)>=4171093.979 .and. .not. X_DEM(counter)>=501764.4419 &
           .and. .not. Y_DEM(counter)>=4171169.979) then
            write(222,*) x_DEM(counter),y_DEM(counter),z(counter) 
          end if   
       elseif (site==2) then 
         if (X_DEM(counter)>=499302.4419 .and. Y_DEM(counter)>=4171902.979 .and. .not. X_DEM(counter)>=499414.4419 &
         .and. .not. Y_DEM(counter)>=4172001.979) then
           write(222,*) x_DEM(counter),y_DEM(counter),z(counter)        
         end if   
       elseif (site==3) then 
         if (X_DEM(counter)>=507102.4419 .and. Y_DEM(counter)>=4188553.979 .and. .not. X_DEM(counter)>=507203.4419 &
         .and. .not. Y_DEM(counter)>=4188697.979) then
           write(222,*) x_DEM(counter),y_DEM(counter),z(counter) 
         end if   
       elseif (site==4) then 
         if (X_DEM(counter)>=505317.4419 .and. Y_DEM(counter)>=4183171.979 .and. .not. X_DEM(counter)>=505441.4419 &
         .and. .not. Y_DEM(counter)>=4183276.979) then
           write(222,*) x_DEM(counter),y_DEM(counter),z(counter) 
         end if   
       elseif (site==5) then 
         if (X_DEM(counter)>=499372.4419 .and. Y_DEM(counter)>=4171888.979 .and. .not. X_DEM(counter)>=499436.4419 &
         .and. .not. Y_DEM(counter)>=4171946.979) then
            write(222,*) x_DEM(counter),y_DEM(counter),z(counter) 
         end if   
       elseif (site==6) then 
         if (X_DEM(counter)>=505340.4419 .and. Y_DEM(counter)>=4183112.979 .and. .not. X_DEM(counter)>=505459.4419 &
         .and. .not. Y_DEM(counter)>=4183376.979) then
           write(222,*) x_DEM(counter),y_DEM(counter),z(counter) 
         end if   
       end if 
       write(321,*) x(counter2),y(counter2),z(counter2) 
     end if 
     end do 
    end do
  end do
 
 close(321)
 if (use_path) close(222)
 print*,'DEM read ok'
 end if !Topo/iproc

end if !USE_DEM



 
if (use_DEMPath) then 
 if (iproc==0) then
    if (site==1 .and. path==1) then 
      open(unit=123,file='sites/1-1-1.txt', action='read')
      open(unit=456,file='sites/1-1-2.txt', action='read')
      print *,'reading from 1-1'
    elseif (site==1 .and. path==2) then
      open(unit=123,file='sites/1-2-1.txt', action='read')
      open(unit=456,file='sites/1-2-2.txt', action='read')
      print *,'reading from 1-2'
    elseif (site==1 .and. path==3) then
      open(unit=123,file='sites/1-3-1.txt', action='read')
      open(unit=456,file='sites/1-3-2.txt', action='read')
      print *,'reading from 1-3'
    elseif (site==2 .and. path==1) then
      open(unit=123,file='sites/2-1-1.txt', action='read')
      open(unit=456,file='sites/2-1-2.txt', action='read')
      print *,'reading from 2-1'
    elseif (site==2 .and. path==2) then
      open(unit=123,file='sites/2-2-1.txt', action='read')
      open(unit=456,file='sites/2-2-2.txt', action='read')
      print *,'reading from 2-2'
    elseif (site==2 .and. path==3) then
      open(unit=123,file='sites/2-3-1.txt', action='read')
      open(unit=456,file='sites/2-3-2.txt', action='read')
      print *,'reading from 2-3'
    elseif (site==3 .and. path==1) then
      open(unit=123,file='sites/3-1-1.txt', action='read')
      open(unit=456,file='sites/3-1-2.txt', action='read')
      print *,'reading from 3-1'
    elseif (site==3 .and. path==2) then
      open(unit=123,file='sites/3-2-1.txt', action='read')
      open(unit=456,file='sites/3-2-2.txt', action='read')
      print *,'reading from 3-2'
    elseif (site==3 .and. path==3) then
      open(unit=123,file='sites/3-3-1.txt', action='read')
      open(unit=456,file='sites/3-3-2.txt', action='read')
      print *,'reading from 3-3'
    elseif (site==4 .and. path==1) then
      open(unit=123,file='sites/4-1-1.txt', action='read')
      open(unit=456,file='sites/4-1-2.txt', action='read')
      print *,'reading from 4-1'
    elseif (site==4 .and. path==2) then
      open(unit=123,file='sites/4-2-1.txt', action='read')
      open(unit=456,file='sites/4-2-2.txt', action='read')
      print *,'reading from 4-2'
    elseif (site==4 .and. path==3) then
      open(unit=123,file='sites/4-3-1.txt', action='read')
      open(unit=456,file='sites/4-3-2.txt', action='read')
      print *,'reading from 4-3'
    elseif (site==5 .and. path==1) then
      open(unit=123,file='sites/5-1-1.txt', action='read')
      open(unit=456,file='sites/5-1-2.txt', action='read')
      open(unit=567,file='sites/5-1-3.txt', action='read')
      open(unit=765,file='sites/5-1-4.txt', action='read')
      print *,'reading from 5-1'
    elseif (site==1 .and. path==2) then
      open(unit=123,file='sites/5-2-1.txt', action='read')
      open(unit=456,file='sites/5-2-2.txt', action='read')
      open(unit=567,file='sites/5-2-3.txt', action='read')
      open(unit=765,file='sites/5-2-4.txt', action='read')
      print *,'reading from 5-2'
    elseif (site==5 .and. path==3) then
      open(unit=123,file='sites/5-3-1.txt', action='read')
      open(unit=456,file='sites/5-3-2.txt', action='read')
      open(unit=567,file='sites/5-3-3.txt', action='read')
      open(unit=765,file='sites/5-3-4.txt', action='read')
      print *,'reading from 5-3'
    elseif (site==6) then
      open(unit=123,file='sites/1-1-1.txt', action='read')
      print *,'reading from 6'
    end if 
  
    open(unit=886,file='topography_DEMPath.dat',status='replace',action='write')     
    write(886,*) '# 1 2 3'
    write(886,*) '# x y z'
   
 


 end if !iproc

 allocate(xp1(npts))
 allocate(xp2(npts))
 allocate(yp1(npts))
 allocate(yp2(npts))
 allocate(hp1(npts))
 allocate(hp2(npts))
 allocate(hpo(npts))
 allocate(hp(npts*Iter))
 allocate(pdo(npts))
 allocate(pmdo(npts))
 

 if (site==5) then
  allocate(xp3(npts))
  allocate(yp3(npts))
  allocate(xp4(npts))
  allocate(yp4(npts))
  allocate(hp3(npts))
  allocate(hp4(npts))
 end if 

    
 counter=0
 do i=1,npts
  counter=counter+1
  if (i==1) then
   read(123,*) nr,x01,y01,hp1(counter),nr,nr,yp1(counter),xp1(counter)
   read(456,*) nr,x02,y02,hp2(counter),nr,nr,yp2(counter),xp2(counter)
   pdo(counter)=0.d0
   if (site==5) then 
    read(567,*) nr,x03,y03,hp3(counter),nr,nr,yp3(counter),xp3(counter)
    read(765,*) nr,x04,y04,hp4(counter),nr,nr,yp4(counter),xp4(counter)
   end if 
  elseif (i>=1) then 
   read(123,*) nr,nr,nr,hp1(counter),nr,nr,yp1(counter),xp1(counter)
   read(456,*) nr,nr,nr,hp2(counter),nr,nr,yp2(counter),xp2(counter)
   if (site==5) then 
    read(567,*) nr,nr,nr,hp3(counter),nr,nr,yp3(counter),xp3(counter)
    read(765,*) nr,nr,nr,hp4(counter),nr,nr,yp4(counter),xp4(counter)
    if (combine) then 
     pdo(i)=sqrt((((xp1(i)+xp2(i)+xp3(i)+xp4(i))/4.d0)-((xp1(i-1)+xp2(i-1)+xp3(i-1)+xp4(i-1))/4d0))**2 &
             +(((yp1(i)+yp2(i)+yp3(i)+yp4(i))/4.d0)-((yp1(i-1)+yp2(i-1)+yp3(i-1)+yp4(i-1))/4d0))**2)+pdo(i-1)
     pmdo(i)=pdo(i)-pdo(i-1)
    end if  
   elseif (combine .and. .not. site==5) then
     pdo(i)=sqrt((((xp1(i)+xp2(i))/2.d0)-((xp1(i-1)+xp2(i-1))/2d0))**2 &
            +(((yp1(i)+yp2(i))/2.d0)-((yp1(i-1)+yp2(i-1))/2d0))**2)+pdo(i-1)
   else 
     pdo(i)=sqrt((xp1(i)-xp1(i-1))**2+(yp1(i)-yp1(i-1))**2)+pdo(i-1)
   end if
     pmdo(i)=pdo(i)-pdo(i-1)
  end if 
  
  if (site==6 .or. .not. combine) then 
    hpo(counter)=hp1(counter)
  else
   hpo(counter)= (hp1(counter)+hp2(counter))/2.d0
   if (site==5) then
     hpo(counter)= (hp1(counter)+hp2(counter)+hp3(counter)+hp4(counter))/4.d0
   end if 
  end if 
 end do

 print*, 'first path read ok' 
 
 counter=0
 if (Iter>=3) then 
  do j=1,Iter
    do i=1,npts
     counter=counter+1
      hp(counter)=hpo(i)
   end do
  end do
  print*, 'Iteration ok'
 !elseif (Iter==2) then
 ! stop 'never tested'
 
 ! do j=1,Iter 
 !  do i=1,(npts*fc) 
 !   counter=counter+1
 !   if (counter<=(Nint(npts/2.d0))) then
 !    hp(counter)=hpo(counter+(nint(npts/2.d0)))
 !   elseif (counter>(nint(npts/2.d0)) .and. j<2) then
 !    hp(counter)=hpo(counter-(nint(npts/2.d0)))
 !   elseif (counter<=(Nint(npts/2.d0)+npts)) then
 !    hp(counter)=hpo(counter-npts+nint(npts/2.d0))
 !   elseif (counter>(nint(npts/2.d0)+npts) .and. j==Iter) then
 !    hp(counter)=hpo(counter-npts-(nint(npts/2.d0)))
 !   end if 
 !1  end do 
 ! end do
 ! print*, 'Iteration ok'
 elseif (Iter==1) then
  do i=1,(npts)
    hp(i)=hpo(i)
  end do 
  print*, 'Iteration ok'
 end if 

 dx=sum(pmdo)/(npts-1)

 dx=dx
 if (combine) then 
  x0D=(x01+x02)/2
  y0D=(y01+y02)/2
  if (site==5) then
   x0D=(x01+x02+x03+x04)/4
   y0D=(y01+y02+y03+y04)/4
  end if
  xllcorner=x0D
  yllcorner=y0D
 else
  xllcorner=x01
  yllcorner=y01
 end if 
 dx=dx*0.8d0
 dy=dx
 Lx=dx*nelx
 Ly=dy*nely
 Lz=Lx*2.4d0 
 if (flank==1 .or. flank==3) then 
   xmidP=0 
   ymidP=Ly/2d0 
 elseif (flank==2 .or. flank==4) then
   ymidP=0
   xmidP=Lx/2d0
 end if 
 if (Iter>=3) then
   if (flank==1) then
     if (mod(Iter,2)>0) then
      xmidP= (nint(Iter/2d0-0.5d0)*npts-1)*dx
     else 
      xmidP= ((Iter/2)*npts-1)*dx
     end if
   elseif (flank==2) then 
     if (mod(Iter,2)>0) then
      ymidP= (nint(Iter/2d0-0.5d0)*npts-1)*dy
     else 
      ymidP= ((Iter/2)*npts-1)*dy
     end if
   elseif (flank==3) then 
     if (mod(Iter,2)>0) then
      xmidP= (nint(Iter/2d0+0.5d0)*npts-1)*dx
     else 
      xmidP= ((Iter/2)*npts-1)*dx
     end if
   elseif (flank==4) then 
     if (mod(Iter,2)>0) then
      ymidP= (nint(Iter/2d0+0.5d0)*npts-1)*dy
     else 
      ymidP= ((Iter/2)*npts-1)*dy
     end if
   end if
 end if 
 
 xllcorner=xllcorner-xmidP
 yllcorner=yllcorner-ymidP
      
 counter=0    
 if (flank==1 .or. flank==3) then 
   hf=sf*Ly
   dhf=hf/nely
  else 
   hf=sf*Lx
  dhf=hf/nelx
  end if 
 hx=Lx/nelx
 hy=Ly/nely
 hz=Lz/nelz


 if (iproc==0) then
 counter=0
 xD=0.d0
 yD=0.d0
 do i=0,(npts-1)
  counter=counter+1
  xD=i*dx
  yD=i*dx
  write(886,*) xD,yD,hpo(counter),pdo(counter)
 end do

       
 print *,'hx=',hx
 print *,'hy=',hy
 print *,'hz=',hz

 print*, 'xllcorner=',xllcorner
 print*, 'yllcorner=',yllcorner
 print*, 'dx=',dx
 print*, 'Lx=',Lx
 print*, 'Ly=',Ly
  

  close(886)
  close(123)
  close(456)
  if (site==5) close(567)
  if (site==5) close(765)
 end if 

 !building a new regular space domain with sizes based on the average path 
  counter=0
  do i=0,nelx    
   do j=0,nely 
      do k=0,nelz
         counter=counter+1
         x(counter)=dble(i)*Lx/nelx
         y(counter)=dble(j)*Ly/nely
         z(counter)=dble(k)*Lz/nelz - Lz
      end do
   end do
 end do

 print *,'new DOMAIN Built'


 !making the slope of the face
 sb=hf/2
 counter=0    
 do j=1,nny 
     do i=1,nnx 
     counter=counter+1
     if (flank==1) then
       sl=+(dhf*(j-1))-sb
     elseif (flank==2) then
       sl=-(dhf*(i-1))+sb 
     elseif (flank==3) then
       sl=-(dhf*(j-1))+sb 
     elseif (flank==4) then 
       sl=+(dhf*(i-1))-sb 
     end if      
     zsurf(counter)=hp(i)+sl 
   end do
 end do 
 
 counter=0
 do j=1,nny
   do i=1,nnx
      counter=counter+1
      ktop=nny*nnz*(i-1)+nnz*(j-1)+nnz
      z(ktop)=zsurf(counter)
   end do
 end do

 !writing topography 
 counter=0    
 do i=0,nelx    
   do j=0,nely 
     do k=0,nelz
     counter=counter+1
     if (iproc==0) then
       if (flank==1 .or. flank==3) then
         if (k==nelz) then 
           if (obs==3 .and. j==nint(nely*0.5d0)) then
             write(321,*) (x(counter)+xllcorner),x(counter),(y(counter)+yllcorner),y(counter),z(counter)
           elseif (obs/=3) then  
             write(321,*) (x(counter)+xllcorner),x(counter),(y(counter)+yllcorner),y(counter),z(counter)
           end if
         end if 
       else if (flank==2 .or. flank==4) then
         if (k==nelz) then 
           if (obs==3 .and. i==nint(nelx*0.5d0)) then
             write(321,*) (x(counter)+xllcorner),x(counter),(y(counter)+yllcorner),y(counter),z(counter)
           elseif (obs/=3) then  
             write(321,*) (x(counter)+xllcorner),x(counter),(y(counter)+yllcorner),y(counter),z(counter)
           end if
         end if !k=nelx
       end if  !flanks
     end if !iproc   
    end do
  end do 
 end do 
 print *, 'Build topography from path DONE'

end if !use_DEMPath 
!--------------------------------------------
!add_random adds noise only in Z direction  
!------------------------------------------

if (add_random) then 
  counter=0
   do i=0,nelx    
     do j=0,nely 
       do k=0,nelz 
         counter=counter+1
         !if (add_random .and. i>0 .and. i<nelx) then
         !    call random_number(xi)
         !    x(counter)=x(counter)+(xi-0.5)/10*(Lx/nelx)
         !end if
         !
         !if (add_random .and. j>0 .and. j<nely) then
         !   call random_number(xi)
         !   y(counter)=y(counter)+(xi-0.5)/10*(Ly/nely)
         !end if
         
        if (k>0 .and. k<nelz) then 
         call random_number(xi)
         z(counter)=z(counter)+(xi-0.5)/10*(Lz/nelz)
        end if 
     end do
   end do
 end do
 if (iproc==0) print *, 'random noise added'
end if

!-------------------------------------
!add_sine to the top surface of the elements, sin of x taken. 
!---------------add sine to surface------------------- 
if (add_sine .and. .not. flanksim) then
  counter=0    
  do i=0,nelx    
    do j=0,nely 
      do k=0,nelz
     counter=counter+1
      if (only_top .and. k==nelz) then 
        z(counter)= z(counter)+(A*SIN((2*pi/wl)*x(counter)+dis))
        if (add_noise) then
         call RANDOM_number(noise)
         noise=noise*2-1
         z(counter) =  z(counter)+noise 
        end if 
       if (iproc==0) then 
        if (obs==3 .and. j==nint(nely*0.5d0)) then
            write(321,*) x(counter),y(counter),z(counter)
        elseif (obs/=3) then  
          write(321,*) x(counter),y(counter),z(counter)
        end if
       end if 
      elseif (add_sine .and. .not. only_top) then
        z(counter)= z(counter)+(A*SIN((2*pi/wl)*x(counter)+dis))
        if (k==nelz .and. add_noise) then
        call RANDOM_number(noise)
        noise=noise*2-1
        z(counter) =  z(counter)+noise 
        end if 
        if (iproc==0) then
         if (k==nelz .and. obs==3 .and. j==nint(nely*0.5d0)) then
          write(321,*) x(counter),y(counter),z(counter)
         elseif (k==nelz .and. obs/=3)  then 
          write(321,*) x(counter),y(counter),z(counter)
         end if
        end if 
      end if 
      end do
    end do
   end do
 if (iproc==0) close(321)
 if (iproc==0) print *, 'topo from sine eq. done'
end if 

!-------------------------------------
!flank simulations with sloped sine
!sb makes sure the surfaces of the slopes are on the same 'plane', as with raising and lowering the surface it results in an offset
!sh is the shift the sine requires if we are on the oppossite site of the 'regular' side, so North & West. Switching to cosine
!would do the same. Note: if looking up the slope on 0 degrees, the sine of the surface wave goes up first to the right and the
!angle goes up the slope. This is done for easy comparison. If not wanted simply remove sh. 

if (flanksim) then
sb=hf/2
counter=0    
 do i=0,nelx    
   do j=0,nely 
     do k=0,nelz
     counter=counter+1
     if (flank==1) then
      sl=+(dhf*j)-sb
      sh=0.d0
     elseif (flank==2) then
      sl=-(dhf*i)+sb 
      sh=0.d0
     elseif (flank==3) then
      sl=-(dhf*j)+sb 
      !sh=-0.5*wl
      sh=0.d0
     elseif (flank==4) then 
      sl=+(dhf*i)-sb 
     ! sh=-0.5*wl
      sh=0.d0
     end if 
      if (only_top .and. k==nelz) then 
        if (flank==1 .or. flank==3) then
          if (bdeg==90) then 
            if (flank==3) then 
                  z(counter)= z(counter)+(A*SIN((2*pi/wl)*(-0.5*wl+y(counter))))
            elseif (flank==1) then 
                  z(counter)= z(counter)+(A*SIN((2*pi/wl)*(y(counter))))
             end if
            z(counter)= z(counter)+sl
           else
             z(counter)= z(counter)+(A*SIN((2*pi/wl)*(sh+x(counter)/cos(b)+sin(b)*(y(counter)-x(counter)*tan(b)))))
             z(counter)= z(counter)+sl
           end if 
        elseif (flank==2 .or. flank==4) then 
             if (bdeg==90) then 
                if (flank==2) then 
                  z(counter)= z(counter)+(A*SIN((2*pi/wl)*(-0.5*wl+x(counter))))
                elseif (flank==4) then
                  z(counter)= z(counter)+(A*SIN((2*pi/wl)*(x(counter))))
                end if 
              z(counter)= z(counter)+sl
             else 
               z(counter)= z(counter)+(A*SIN((2*pi/wl)*(sh+y(counter)/cos(b)+sin(b)*(x(counter)-y(counter)*tan(b)))))
               z(counter)= z(counter)+sl
             end if 
        end if  
       if (add_noise) then
          call RANDOM_number(noise)
          noise=noise*2-1
          z(counter) =  z(counter)+noise 
       end if 
      elseif (.not. only_top) then  
        if (flank==1 .or. flank==3) then
          if (bdeg==90) then 
            z(counter)= z(counter)+(A*SIN((2*pi/wl)*(y(counter))))
            z(counter)= z(counter)+sl
          else 
            z(counter)= z(counter)+(A*SIN((2*pi/wl)*(sh+x(counter)/cos(b)+sin(b)*(y(counter)-x(counter)*tan(b)))))
            z(counter)= z(counter)+sl
          end if 
        elseif (flank==2 .or. flank==4) then
             if (bdeg==90) then 
               z(counter)= z(counter)+(A*SIN((2*pi/wl)*(-0.5*wl+x(counter))))
               z(counter)= z(counter)+sl
             else 
               z(counter)= z(counter)+(A*SIN((2*pi/wl)*(sh+y(counter)/cos(b)+sin(b)*(x(counter)-y(counter)*tan(b)))))
               z(counter)= z(counter)+sl
              end if 
         end if 
        if (add_noise .and. k==nelz) then
         call RANDOM_number(noise)
         noise=noise*2-1
         z(counter) =  z(counter)+noise 
        end if 
      end if 
       
      if (iproc==0) then
       if (flank==1 .or. flank==3) then
         if (k==nelz) then 
           if (obs==3 .and. j==nint(nely*0.5d0)) then
             write(321,*) x(counter),y(counter),z(counter)
           elseif (obs/=3) then  
             write(321,*) x(counter),y(counter),z(counter)
           end if
         end if 
       else if (flank==2 .or. flank==4) then
         if (k==nelz) then 
           if (obs==3 .and. i==nint(nelx*0.5d0)) then
             write(321,*) x(counter),y(counter),z(counter)
           elseif (obs/=3) then  
             write(321,*) x(counter),y(counter),z(counter)
           end if
         end if 
       end if 
      end if 
      end do
   end do
 end do
 if (iproc==0) close(321)
 if (iproc==0) print *, 'flank simulations done'
end if 
 
!-----------------deform mesh------------------------
if (only_top .or. use_DEM .or. use_DEMPath) then 
  if (flanksim) then
    if (flank==1 .or. flank==3) then
      zbottom=(-A)-Lz-(nny*sf)
    elseif (flank==2 .or. flank==4) then
      zbottom=(-A)-Lz-(nnx*sf)
    end if
  elseif  (use_DEMPath) then 
    if (flank==1 .or. flank==3) then 
     zbottom= minval(hp)-(nny*sf)-Lz
    elseif (flank==2 .or. flank==4) then
     zbottom= minval(hp)-(nnx*sf)-Lz
    end if
  elseif (use_DEM) then
     zbottom=minval(zsurf)-Lz
  elseif (add_sine .and. .not. flanksim) then
     zbottom=(-A)-Lz
  end if 

  counter=0    
  do i=1,nnx    
   do j=1,nny    
     do k=1,nnz
     counter=counter+1
     ktop=nny*nnz*(i-1)+nnz*(j-1)+nnz
     if (use_DEM .and. .not. only_top) then
      dztopo=hz
     else
      dztopo=abs((z(ktop)-zbottom))/nelz
     end if
     if (k<nnz)  then
       z(counter)=z(ktop)-(nnz-k)*dztopo
     end if 
     end do
   end do
  end do
 if (iproc==0) print *, 'mesh deformed'
end if 



!------------------------------------------------------------------
!M vector

allocate(mx(nel))
allocate(my(nel))
allocate(mz(nel))

if (sphere .or. line_vert) then
 counter=0
 do iel=1,nel
     counter=counter+1
       if (((xc(counter)-xs)**2+(yc(counter)-ys)**2+(zc(counter)-zs)**2)<(rs**2)) then
              
        mx(counter)=Magx
        my(counter)=Magy
        mz(counter)=Magz
        else 
        mx(counter)=0
        my(counter)=0
        mz(counter)=0
       end if 
  end do  
else
 mx(:)=Magx
 my(:)=Magy
 mz(:)=Magz
end if 


!-------------------------------------------------------------------
!IGRF on sites and average
!-------------------------------------------------------------------
if (etna) then

 if (site==1) then
  IGRF_E=1560.1e-9
  IGRF_N=26887.4e-9
  IGRF_D=36243.6e-9
  Bref_inc=54.06d0
  Bref_dec=5.34d0
  Bref_int=44.89e-6

 print *,'reference field and IGRF site 1'

 else if (site==2) then
  IGRF_E=1557.8e-9
  IGRF_N=26881e-9
  IGRF_D=36243.1e-9
  Bref_inc=52.46d0
  !Bref_dec=-10.8318d0
  Bref_dec=0.59d0
  Bref_int=44.00e-6
 print *,'reference field and IGRF site 2'
 else if (site==3) then
  IGRF_E=1565.3e-9
  IGRF_N=26804.1e-9
  IGRF_D=36407.4e-9
  Bref_inc=53.03d0
  Bref_dec=-1.65d0
  Bref_int=44.39e-6
 print *,'reference field and IGRF site 3'
 else if (site==4) then   
  IGRF_E=1563e-9
  IGRF_N=26824.3e-9
  IGRF_D=36348.6e-9
  Bref_inc=52.18d0
 ! Bref_dec=-41.42892
 ! Bref_dec=-5.36d0
  Bref_dec=-1.02d0
  Bref_int=43.36e-6
 print *,'reference field and IGRF site 4'
 else if (site==5) then  
  IGRF_E=1557.9e-9
  IGRF_N=26881.1e-9
  IGRF_D=36243.3e-9
  Bref_inc=52.13d0
  Bref_dec=1.03d0
  Bref_int=43.85e-6
 print *,'reference field and IGRF site 5'
 else if (site==6) then       
  IGRF_E=1562.9e-9
  IGRF_N=26824.1e-9
  IGRF_D=36348.3e-9
  Bref_inc=53.69d0
  Bref_dec=0.36d0
  Bref_int=43.85e-6
 print *,'reference field and IGRF site 6'
 else
  IGRF_E=1561.2e-9
  IGRF_N=26850.3e-9
  IGRF_D=36305.7e-9
 print *,'reference field is IGRF average'
 end if 
  !coordinate switch from ref to model
  IGRFx=IGRF_N
  IGRFy=IGRF_E
  IGRFz=IGRF_D
  
  Brefy=Bref_int*cos(Bref_inc*dtr)*sin(Bref_dec*dtr)
  Brefx=Bref_int*cos(Bref_inc*dtr)*cos(Bref_dec*dtr)
  Brefz=(Bref_int)*sin(Bref_inc*dtr)
end if 

Brefint=sqrt(Brefx**2+Brefy**2+Brefz**2)
Brefinc=atan2(Brefz,sqrt(Brefx**2+Brefy**2))/pi*180.d0
Brefdec=atan2(Brefy,Brefx)/pi*180.d0
if (etna) then
 IGRFint=sqrt(IGRFx**2+IGRFy**2+IGRFz**2)        
 IGRFinc=atan2(IGRFz,sqrt(IGRFx**2+IGRFy**2))/pi*180.d0
 IGRFdec=atan2(IGRFy,IGRFx)/pi*180.d0
end if

if (iproc==0) then
 if (etna) then
!  print *, "IGRF x=",IGRFx
!  print *, "IGRF y=",IGRFy
!  print *, "IGRF z=",IGRFz
  print *, "IGRF Int=",IGRFint
  print *, "IGRF Inc=",IGRFinc
  print *, "IGRF Dec=",IGRFdec
 end if 
! print *, "Bref x=",Brefx
! print *, "Bref y=",Brefy
! print *, "Bref z=",Brefz
 print *, "Bref Int=",Brefint
 print *, "Bref Inc=",Brefinc
 print *, "Bref Dec=",Brefdec
end if 

!------------------------------------------------------------------------------
! compute coordinates of observation points 
!------------------------------------------------------------------------------
call mpi_barrier(mpi_comm_world,ierr)
if (.not. use_DEMPath) then
dx=(xmax-xmin)/(nx-1)
dy=(ymax-ymin)/(ny-1)
dz=(zmax-zmin)/(nz-1)

if (nx==1) dx=0 
if (ny==1) dy=0 
if (nz==1) dz=0 
end if
 

allocate(icon_plane(4,(nx-1)*(ny-1)))
allocate(xmeas(npts))
allocate(ymeas(npts))
allocate(zmeas(npts))
allocate(zPmeas(npts))
allocate(xPmeas(npts))
allocate(yPmeas(npts))
allocate(dmeas(npts))
allocate(Btx(npts))
allocate(Bty(npts))
allocate(Btz(npts))
allocate(Bx(npts))
allocate(By(npts))
allocate(Bz(npts))
allocate(intensity(npts))   
allocate(inclination(npts)) 
allocate(declination(npts))
allocate(Bmx(npts))
allocate(Bmy(npts))
allocate(Bmz(npts))
allocate(decm(npts))
allocate(intm(npts))
allocate(incm(npts))
allocate(minc(npts))
allocate(mdec(npts))
allocate(mint(npts))
allocate(BmIx(npts))
allocate(BmIy(npts))
allocate(BmIz(npts))
allocate(decIm(npts))
allocate(intIm(npts))
allocate(incIm(npts))

if (iproc==0) print *,'----------------------------------------------'

if (obs==3 .or. obs==1) then
 counter=0
 do j=1,ny-1
  do i=1,nx-1
   counter=counter+1
   icon_plane(1,counter)=i+(j-1)*(nx)
   icon_plane(2,counter)=i+1+(j-1)*(nx)
   icon_plane(3,counter)=i+1+j*(nx)
   icon_plane(4,counter)=i+j*(nx)
  end do
 end do
end if 


if (use_meas .or. (use_path .and. option==3)) then
 counter=0
  do k=1,nz
   do j=1,ny
    do i=1,nx
        counter=counter+1
        xmeas(counter)=xmin+(i-1)*dx
        ymeas(counter)=ymin+(j-1)*dy
        if (obs==2) then 
         zmeas(counter)=zmin+(k-1)*dz
        else
         zmeas(counter)=h
        end if 
     end do
   end do
  end do
end if 


if (use_path .or. (use_DEMPath .and. .not. option==3)) then
  if (iproc==0) then
    if (site==1 .and. path==1 .and. ho==1) then
      open(unit=123,file='sites/1_1_100.txt', action='read')
      print *,'reading from 1_1_100.txt'
    elseif (site==1 .and. path==1 .and. ho==2) then
      open(unit=123,file='sites/1_1_180.txt', action='read')
      print *,'reading from 1_1_180.txt'
    elseif (site==1 .and. path==2 .and. ho==1) then
      open(unit=123,file='sites/1_2_100.txt', action='read')
      print *,'reading from 1_2_100.txt'
    elseif (site==1 .and. path==2 .and. ho==2) then
      open(unit=123,file='sites/1_2_180.txt', action='read')
      print *,'reading from 1_2_180.txt'
    elseif (site==1 .and. path==3 .and. ho==1) then
      open(unit=123,file='sites/1_3_100.txt', action='read')
      print *,'reading from 1_3_100.txt'
    elseif (site==1 .and. path==3 .and. ho==2) then
      open(unit=123,file='sites/1_3_180.txt', action='read')
      print *,'reading from 1_3_180.txt'
    
    elseif (site==2 .and. path==1 .and. ho==1) then
      open(unit=123,file='sites/2_1_100.txt', action='read')
      print *,'reading from 2_1_100.txt'
    elseif (site==2 .and. path==1 .and. ho==2) then
      open(unit=123,file='sites/2_1_180.txt', action='read')
      print *,'reading from 2_1_180.txt'
    elseif (site==2 .and. path==2 .and. ho==1) then
      open(unit=123,file='sites/2_2_100.txt', action='read')
      print *,'reading from 2_2_100.txt'
    elseif (site==2 .and. path==2 .and. ho==2) then
      open(unit=123,file='sites/2_2_180.txt', action='read')
      print *,'reading from 2_2_180.txt'
    elseif (site==2 .and. path==3 .and. ho==1) then
      open(unit=123,file='sites/2_3_100.txt', action='read')
      print *,'reading from 2_3_100.txt'
    elseif (site==2 .and. path==3 .and. ho==2) then
      open(unit=123,file='sites/2_3_180.txt', action='read')
      print *,'reading from 2_3_180.txt'
    
    elseif (site==3 .and. path==1 .and. ho==1) then
      open(unit=123,file='sites/3_1_100.txt', action='read')
      print *,'reading from 3_1_100.txt'
    elseif (site==3 .and. path==1 .and. ho==2) then
      open(unit=123,file='sites/3_1_180.txt', action='read')
      print *,'reading from 3_1_180.txt'
    elseif (site==3 .and. path==2 .and. ho==1) then
      open(unit=123,file='sites/3_2_100.txt', action='read')
      print *,'reading from 3_2_100.txt'
    elseif (site==3 .and. path==2 .and. ho==2) then
      open(unit=123,file='sites/3_2_180.txt', action='read')
      print *,'reading from 3_2_180.txt'
    elseif (site==3 .and. path==3 .and. ho==1) then
      open(unit=123,file='sites/3_3_100.txt', action='read')
      print *,'reading from 3_3_100.txt'
    elseif (site==3 .and. path==3 .and. ho==2) then
      open(unit=123,file='sites/3_3_180.txt', action='read')
      print *,'reading from 3_3_180.txt'
    
    elseif (site==4 .and. path==1 .and. ho==1) then
      open(unit=123,file='sites/4_1_100.txt', action='read')
      print *,'reading from 4_1_100.txt'
    elseif (site==4 .and. path==1 .and. ho==2) then
      open(unit=123,file='sites/4_1_180.txt', action='read')
      print *,'reading from 4_1_180.txt'
    elseif (site==4 .and. path==2 .and. ho==1) then
      open(unit=123,file='sites/4_2_100.txt', action='read')
      print *,'reading from 4_2_100.txt'
    elseif (site==4 .and. path==2 .and. ho==2) then
      open(unit=123,file='sites/4_2_180.txt', action='read')
      print *,'reading from 4_2_180.txt'
    elseif (site==4 .and. path==3 .and. ho==1) then
      open(unit=123,file='sites/4_3_100.txt', action='read')
      print *,'reading from 4_3_100.txt'
    elseif (site==4 .and. path==3 .and. ho==2) then
      open(unit=123,file='sites/4_3_180.txt', action='read')
      print *,'reading from 4_3_180.txt'

    elseif (site==5 .and. path==1 .and. ho==1) then
      open(unit=123,file='sites/5_1_25.txt', action='read')
      print *,'reading from 5_1_25.txt'
    elseif (site==5 .and. path==1 .and. ho==2) then
      open(unit=123,file='sites/5_1_75.txt', action='read')
      print *,'reading from 5_1_75.txt'
    elseif (site==5 .and. path==1 .and. ho==3) then
      open(unit=123,file='sites/5_1_125.txt', action='read')
      print *,'reading from 5_1_125.txt'
    elseif (site==5 .and. path==1 .and. ho==4) then
      open(unit=123,file='sites/5_1_175.txt', action='read')
      print *,'reading from 5_1_175.txt'
    elseif (site==5 .and. path==2 .and. ho==1) then
      open(unit=123,file='sites/5_2_25.txt', action='read')
      print *,'reading from 5_2_25.txt'
    elseif (site==5 .and. path==2 .and. ho==2) then
      open(unit=123,file='sites/5_2_75.txt', action='read')
      print *,'reading from 5_2_75.txt'
    elseif (site==5 .and. path==2 .and. ho==3) then
      open(unit=123,file='sites/5_2_125.txt', action='read')
      print *,'reading from 5_2_125.txt'
    elseif (site==5 .and. path==2 .and. ho==4) then
      open(unit=123,file='sites/5_2_175.txt', action='read')
      print *,'reading from 5_2_175.txt'
    elseif (site==5 .and. path==3 .and. ho==1) then
      open(unit=123,file='sites/5_3_25.txt', action='read')
      print *,'reading from 5_3_25.txt'
    elseif (site==5 .and. path==3 .and. ho==2) then
      open(unit=123,file='sites/5_3_75.txt', action='read')
      print *,'reading from 5_3_75.txt'
    elseif (site==5 .and. path==3 .and. ho==3) then
      open(unit=123,file='sites/5_3_125.txt', action='read')
      print *,'reading from 5_3_125.txt'
    elseif (site==5 .and. path==3 .and. ho==4) then
      open(unit=123,file='sites/5_3_175.txt', action='read')
      print *,'reading from 5_3_175.txt'

    elseif (site==6) then
      open(unit=123,file='sites/6_100.txt', action='read')
      print *,'reading from 6_100.txt'
    end if
    
    if (produce_dif_h) then
     open(unit=765,file='difference_h.dat',status='replace',action='write')     
     write(765,*) '# 1 2 3 4 5 '
     write(765,*) '# x y zpath zDEM difference '
    end if 
  end if !iproc
end if !if use_path
 
!if (((use_path .and. .not. option==3) .or. use_DEMPath .or. use_meas) .and. .not. obs==2) then
if ((use_path .and. .not. option==3) .or. use_DEMPath) then
 do i=1,npts
  if (use_path .or. use_DEMPath) then
     read(123,*) nr,xPmeas(i),yPmeas(i),zPmeas(i),minc(i),mdec(i),mint(i)
     mint(i)=mint(i)*10e-6
     xmeas(i)=xPmeas(i)-xllcorner
     ymeas(i)=yPmeas(i)-yllcorner
     if (use_DEMPath .and. .not. use_path) then 
      if (Iter==1) then
       if (flank==1 .or. flank==3) then
        xmeas(i)=(i-1)*(dx-0.03d0)+0.1d0
        ymeas(i)=(dy*nely)/2d0
       elseif (flank==2 .or. flank==4) then
        ymeas(i)=(i-1)*(dy-0.03d0)+0.1d0
        xmeas(i)=(dx*nelx)/2d0
       end if 
       !print *, 'mod iter', (mod(Iter,2)) 
      elseif (Iter>=3) then
       if (flank==1 .or. flank==3) then
        xmeas(i)=xmidP+(dx*i)
        ymeas(i)=ymidP 
       elseif (flank==2 .or. flank==4) then
        ymeas(i)=ymidP+(dy*i)
        xmeas(i)=xmidP 
       end if         
      end if          
     end if         
             
     !   if (mod(Iter,2)>0) then
     !      xmeas(i)=xmeas(i)+(dx*(npts-1))*(Iter/2d0+0.5d0)
     !   else
     !    xmeas(i)=xmeas(i)+(dx*(npts-1))*(Iter/2d0)
     !   end if 
     !   ymeas(i)=ymeas(i)+((dy*nely)/2d0) 
     ! end if 
      
     if (i==1) then
       dmeas(i)=0.d0
     else
       dmeas(i)=sqrt((xmeas(i)-xmeas(i-1))**2+(ymeas(i)-ymeas(i-1))**2)+dmeas(i-1)
     end if
     if (.not. produce_dif_h) then
      zPmeas(i)=zPmeas(i)-Poh
     end if 
  end if  
    
    icx=xmeas(i)/Lx*nelx+1      
    icy=ymeas(i)/Ly*nely+1      

    xmin=(icx-1)*hx
    xmax=(icx  )*hx
    
    r=((xmeas(i)-xmin)/(xmax-xmin)-0.5d0)*2.d0
    if (r>+1) stop 'r>+1'
    if (r<-1) stop 'r<-1'

    ymin=(icy-1)*hy
    ymax=(icy  )*hy
 
    s=((ymeas(i)-ymin)/(ymax-ymin)-0.5d0)*2.d0
    if (s>+1) stop 's>+1'
    if (s<-1) stop 's<-1'
  
    ic=nely*nelz*(icx-1)+nelz*(icy-1)+nelz

    N1=0.25d0*(1-r)*(1-s)
    N2=0.25d0*(1+r)*(1-s)
    N3=0.25d0*(1+r)*(1+s)
    N4=0.25d0*(1-r)*(1+s)
    !print *,icx,icy,r,s
 
    zmeas(i)=N1*z(icon(5,ic))+&
             N2*z(icon(6,ic))+&
             N3*z(icon(7,ic))+&
             N4*z(icon(8,ic))+ h
     
     if (use_DEMPath) then
         !if (site==1 .or. site==4) then 
         ! zmeas(i)=zmeas(i)+sb
        ! else
        ! zmeas(i)=zmeas(i)+sb
      ! end if
     end if 
          
     if (produce_dif_h) then
      print *,'zDEM ', zmeas(i)
      print *,'z path ', zPmeas(i)
      dif_h=zPmeas(i)-zmeas(i)
      write(765,*) xmeas(i),ymeas(i),zPmeas(i),zmeas(i),dif_h
     end if 
      
 end do
  
  if (iproc==0) then 
   print *,'measurements points setup ok'
   print *,'site=',site
   print *,'path=',path
   print *,'height above=',h
   close(123)
   close(765) 
  end if 
 if (produce_dif_h) stop 'stopped after produce difference'
end if 


!observation above flank simulation, done by simply the same equation (sine plane/path) as the surface of the domain, but spaced above it by h, since the -90 and 90 degrees deviation from x and y sine will produce a flipped function, these are a seperate case, only 90 is done
if ((flanksim .or. add_sine ) .and. .not. use_meas ) then 
 counter=0
 do k=1,nz
   do j=1,ny
      do i=1,nx
        counter=counter+1
        xmeas(counter)=xmin+(i-1)*dx
        ymeas(counter)=ymin+(j-1)*dy
        
        if (obs==3) then
          if (flanksim) then 
            if (flank==2 .or. flank==4) then
              xmeas(counter)=xmin
            else
              ymeas(counter)=ymin
            end if 
          else 
            ymeas(counter)=ymin
          end if
        end if
        
        if (add_sine .and. .not. flanksim) then
         zmeas(counter)=A*SIN((2*pi/wl)*xmeas(counter))+h
        elseif (flanksim) then
          if (obs==1) then
           if (flank==1) slo=+(sf*dy*(j-1))+(ymin*sf)-sb+h
           if (flank==2) slo=-(sf*dx*(i-1))+(xmin*sf)+sb+h
           if (flank==3) slo=-(sf*dy*(j-1))+(ymin*sf)+sb+h
           if (flank==4) slo=+(sf*dx*(i-1))+(xmin*sf)-sb+h
          elseif (obs==3) then 
           slo=h
          end if 
          if (bdeg==90) then
             if (flank==1) then
                 zmeas(counter)=A*SIN((2*pi/wl)*sin(b)*ymeas(counter))+slo
             elseif (flank==3) then
                 zmeas(counter)=A*SIN((2*pi/wl)*(-0.5*wl+(sin(b)*ymeas(counter))))+slo
             elseif (flank==4) then 
               zmeas(counter)=A*SIN((2*pi/wl)*sin(b)*xmeas(counter))+slo
             elseif (flank==2) then
               zmeas(counter)=A*SIN((2*pi/wl)*(-0.5*wl+(sin(b)*xmeas(counter))))+slo
             end if 
          else 
             if (flank==1 .or. flank==3) then
               zmeas(counter)=A*SIN((2*pi/wl)*(sh+(xmeas(counter)/cos(b))+(sin(b)*(ymeas(counter)-xmeas(counter)*tan(b)))))+slo
             elseif (flank==2 .or. flank==4) then
               zmeas(counter)=A*SIN((2*pi/wl)*(sh+(ymeas(counter)/cos(b))+(sin(b)*(xmeas(counter)-ymeas(counter)*tan(b)))))+slo
             end if 
          end if 
        elseif (obs==2) then 
         zmeas(counter)=zmin+(k-1)*dz
        else
         zmeas(counter)=h
        end if
      end do
   end do
 end do
 
 if (iproc==0) print *,'measurement points setup ok'
end if 




!---------------------------------------
! carry out computations
!-----------------------------------------

call mpi_barrier(mpi_comm_world,ierr)
if (iproc==0) print *,'----------------------------------------------'
if (iproc==0) print *,'starting computation in observation points'
   
if (iproc==0) then
 open(unit=123,file='magfield.dat',status='replace',action='write')
 write(123,*) '# 1 2 3 4 5 6 7 8'
 write(123,*) '# x0 x0+xllcorner y0 y0+yllcorner z0 Bx By Bz'
 
 open(unit=888,file='magfield_conv.dat',status='replace',action='write')
 write(888,*) '# 1 2 3 4 5 6 7 8 9'
 write(888,*) '# x0 y0 z0 Btx Bty Btz Bt_int Bt_dec Bt_inc dis'

 open(unit=567,file='Bref.dat',status='replace',action='write')
 write(567,*) '# 1 2 3 4 5 6 7 8 9'
 write(567,*) '# x0 y0 z0 Brefx Brefy Brefz Brefint Brefdec Brefinc dis '
 
 open(unit=321,file='magfield_Bref.dat',status='replace',action='write')
 write(321,*) '# 1 2 3 4 5 6 7 8 9'
 write(321,*) '# x0 y0 z0 Bx+Brefx By+Brefy Bz+Brefz total_int total_inc total_dec dis'
 
 open(unit=987,file='IGRF.dat',status='replace',action='write')
 write(987,*) '# 1 2 3 4 5 6 7 8 9'
 write(987,*) '# x0 y0 z0 IGRF_N IGRF_E IGRF_D IGRFint IGRFdec IGRFinc dis'
 
 open(unit=345,file='magfield_IGRF.dat',status='replace',action='write')
 write(345,*) '# 1 2 3 4 5 6 7 8 9'
 write(345,*) '# x0 y0 z0 Bx+IGRF_N By+IGRF_E IGRF_D+Bz total_int total_inc total_dec dis'

 open(unit=666,file='statistics_Bref.dat',status='replace',action='write') !pun intended 
 write(666,*) '# 1 2 3 4 5 6 7 8 9 10'
 write(666,*) '# data site path height npts mean variance stDEV minval maxval of Bref'
 open(unit=616,file='statistics_IGRF.dat',status='replace',action='write') 
 write(616,*) '# 1 2 3 4 5 6 7 8 9 10 '
 write(616,*) '# data site path height npts mean variance stDEV minval maxval of IGRF'

 if (obs==1) then
  open(unit=221,file='magfield_middle_plane.dat',status='replace',action='write')
  write(221,*) '# 1 2 3 4 5 6 7 8 9'
  write(221,*) '# x0 y0 z0 Bx By Bz intensity inclination declination'
  open(unit=456,file='magfield_IGRF_middle_plane.dat',status='replace',action='write')
  write(456,*) '# 1 2 3 4 5 6 7 8 9'
  write(456,*) '# x0 y0 z0 Bx+IGRFx By+IGRFy Bz+IGRFz total_int total_inc total_dec IGRF_int'
 end if
end if 

tstart = MPI_WTIME ()

do i=1,npts

   tstart2 = MPI_WTIME ()
  
    x0=xmeas(i)
    y0=ymeas(i)
    
       
    if (use_path .and. option==1) then 
     z0=zPmeas(i)
    else
     z0=zmeas(i)
    end if 
   
    if (sphere) then
     xmeas(i)=x0
     ymeas(i)=y0
     zmeas(i)=z0
    end if 

   Bx_pt=0d0
   By_pt=0d0
   Bz_pt=0d0

   do iel=1+iproc,nel,nproc  
      !     
      !     Z
      !     |
      !     5---8---y  
      !    /   /
      !   6---7
      !     |
      !     1---4---y  
      !    /   /
      !   2---3
      !  /  
      ! x   


      !print *,'I am ',iproc,' taking care of iel=',iel
   
      i1=icon(1,iel)
      i2=icon(2,iel)
      i3=icon(3,iel)
      i4=icon(4,iel)
      i5=icon(5,iel)
      i6=icon(6,iel)
      i7=icon(7,iel)
      i8=icon(8,iel)

      !-----------------------------------------------------------------
      !face x=0 (8 4 1 5)
      xface(1:4)=(/x(i8),x(i4),x(i1),x(i5)/)
      yface(1:4)=(/y(i8),y(i4),y(i1),y(i5)/)
      zface(1:4)=(/z(i8),z(i4),z(i1),z(i5)/)
      call facmag(mx(iel),my(iel),mz(iel),x0,y0,z0,xface,yface,zface,nface_quad,fx,fy,fz)
      Bx_pt=Bx_pt+fx
      By_pt=By_pt+fy
      Bz_pt=Bz_pt+fz
         if (isnan(Bx_pt)) then
           !  print *,'fx,fy,fz',fx,fy,fz
           !  print *,'thread',iproc
           !  print *,'i=',i
           !  print *,'iel=',iel
           !  print *,'x,y,z=',xmeas(i),ymeas(i),zmeas(i)
           !  stop 'Bx_pt is a NaN'
             print *,  'Bx_pt is a NaN'
             print *,'face (8 4 1 5)'
          end if
          if (isnan(By_pt)) then 
          !   print *,'fx,fy,fz',fx,fy,fz
          !   print *,'thread',iproc
          !   print *,'i=',i
          !   print *,'iel=',iel
          !   print *,'x,y,z=',xmeas(i),ymeas(i),zmeas(i)
          !   stop 'By_pt is a NaN'
             print *, 'By_pt is a NaN'
             print *,'face (8 4 1 5)'
          end if
          if (isnan(Bz_pt)) then
          !   print *,'fx,fy,fz',fx,fy,fz
          !   print *,'thread',iproc
          !   print *,'i=',i
          !   print *,'iel=',iel
          !   print *,'x,y,z=',xmeas(i),ymeas(i),zmeas(i)
          !   stop 'Bz_pt is a NaN'
             print *, 'Bz_pt is a NaN'
             print *,'face (8 4 1 5)'
          end if

      !-----------------------------------------------------------------
      !face x=1 (2 3 7 6)
      xface(1:4)=(/x(i2),x(i3),x(i7),x(i6)/)
      yface(1:4)=(/y(i2),y(i3),y(i7),y(i6)/)
      zface(1:4)=(/z(i2),z(i3),z(i7),z(i6)/)
      call facmag(mx(iel),my(iel),mz(iel),x0,y0,z0,xface,yface,zface,nface_quad,fx,fy,fz)
      Bx_pt=Bx_pt+fx
      By_pt=By_pt+fy
      Bz_pt=Bz_pt+fz
         if (isnan(Bx_pt)) then
           !  print *,'fx,fy,fz',fx,fy,fz
           !  print *,'thread',iproc
           !  print *,'i=',i
           !  print *,'iel=',iel
           !  print *,'x,y,z=',xmeas(i),ymeas(i),zmeas(i)
           !  stop 'Bx_pt is a NaN'
             print *,  'Bx_pt is a NaN'
             print *,'face (2 3 7 6)'
          end if
          if (isnan(By_pt)) then 
          !   print *,'fx,fy,fz',fx,fy,fz
          !   print *,'thread',iproc
          !   print *,'i=',i
          !   print *,'iel=',iel
          !   print *,'x,y,z=',xmeas(i),ymeas(i),zmeas(i)
          !   stop 'By_pt is a NaN'
             print *, 'By_pt is a NaN'
             print *,'face (2 3 7 6)'
          end if
          if (isnan(Bz_pt)) then
          !   print *,'fx,fy,fz',fx,fy,fz
          !   print *,'thread',iproc
          !   print *,'i=',i
          !   print *,'iel=',iel
          !   print *,'x,y,z=',xmeas(i),ymeas(i),zmeas(i)
          !   stop 'Bz_pt is a NaN'
             print *, 'Bz_pt is a NaN'
             print *,'face (2 3 7 6)'
          end if

  !----------------------------------------------------------------
      !face y=0 (1 2 6 5)
      xface(1:4)=(/x(i1),x(i2),x(i6),x(i5)/)
      yface(1:4)=(/y(i1),y(i2),y(i6),y(i5)/)
      zface(1:4)=(/z(i1),z(i2),z(i6),z(i5)/)
      call facmag(mx(iel),my(iel),mz(iel),x0,y0,z0,xface,yface,zface,nface_quad,fx,fy,fz)
      Bx_pt=Bx_pt+fx
      By_pt=By_pt+fy
      Bz_pt=Bz_pt+fz

           if (isnan(Bx_pt)) then
            !  print *,'face (1 2 6 5)'
            !  print *,'fx,fy,fz',fx,fy,fz
            !  print *,'thread',iproc
            !  print *,'i=',i
            !  print *,'iel=',iel
            !  print *,'x,y,z=',xmeas(i),ymeas(i),zmeas(i)
            !  stop 'Bx_pt is a NaN'
              print *,  'Bx_pt is a NaN'
              print *,'face (1 2 6 5)'
           end if
           if (isnan(By_pt)) then 
           !   print *,'face (1 2 6 5)'
           !   print *,'fx,fy,fz',fx,fy,fz
           !   print *,'thread',iproc
           !   print *,'i=',i
           !   print *,'iel=',iel
           !   print *,'x,y,z=',xmeas(i),ymeas(i),zmeas(i)
           !   stop 'By_pt is a NaN'
              print *, 'By_pt is a NaN'
              print *,'face (1 2 6 5)'
           end if
           if (isnan(Bz_pt)) then
           !   print *,'face (1 2 6 5)'
           !   print *,'fx,fy,fz',fx,fy,fz
           !   print *,'thread',iproc
           !   print *,'i=',i
           !   print *,'iel=',iel
           !   print *,'x,y,z=',xmeas(i),ymeas(i),zmeas(i)
           !   stop 'Bz_pt is a NaN'
              print *, 'Bz_pt is a NaN'
              print *,'face (1 2 6 5)'
           end if


      !-----------------------------------------------------------------
      !face y=1 (3 4 8 7)
      xface(1:4)=(/x(i3),x(i4),x(i8),x(i7)/)
      yface(1:4)=(/y(i3),y(i4),y(i8),y(i7)/)
      zface(1:4)=(/z(i3),z(i4),z(i8),z(i7)/)
      call facmag(mx(iel),my(iel),mz(iel),x0,y0,z0,xface,yface,zface,nface_quad,fx,fy,fz)
      Bx_pt=Bx_pt+fx
      By_pt=By_pt+fy
      Bz_pt=Bz_pt+fz
   
           if (isnan(Bx_pt)) then
           !  print *,'fx,fy,fz',fx,fy,fz
           !  print *,'thread',iproc
           !  print *,'i=',i
           !  print *,'iel=',iel
           !  print *,'x,y,z=',xmeas(i),ymeas(i),zmeas(i)
           !  stop 'Bx_pt is a NaN'
             print *,  'Bx_pt is a NaN'
             print *,'face (3 4 8 7)'
          end if
          if (isnan(By_pt)) then 
          !   print *,'fx,fy,fz',fx,fy,fz
          !   print *,'thread',iproc
          !   print *,'i=',i
          !   print *,'iel=',iel
          !   print *,'x,y,z=',xmeas(i),ymeas(i),zmeas(i)
          !   stop 'By_pt is a NaN'
             print *, 'By_pt is a NaN'
             print *,'face (3 4 8 7)'
          end if
          if (isnan(Bz_pt)) then
          !   print *,'fx,fy,fz',fx,fy,fz
          !   print *,'thread',iproc
          !   print *,'i=',i
          !   print *,'iel=',iel
          !   print *,'x,y,z=',xmeas(i),ymeas(i),zmeas(i)
          !   stop 'Bz_pt is a NaN'
             print *, 'Bz_pt is a NaN'
             print *,'face (3 4 8 7)'
          end if


 if (add_random) then
      !-----------------------------------------------------------------
      !face bottom (4 3 2 )
      xface=0
      yface=0
      zface=0
      xface(1:3)=(/x(i4),x(i3),x(i2)/)
      yface(1:3)=(/y(i4),y(i3),y(i2)/)
      zface(1:3)=(/z(i4),z(i3),z(i2)/)
      call facmag(mx(iel),my(iel),mz(iel),x0,y0,z0,xface,yface,zface,nface_tri,fx,fy,fz)
      Bx_pt=Bx_pt+fx
      By_pt=By_pt+fy
      Bz_pt=Bz_pt+fz
           if (isnan(Bx_pt)) then
           !  print *,'fx,fy,fz',fx,fy,fz
           !  print *,'thread',iproc
           !  print *,'i=',i
           !  print *,'iel=',iel
           !  print *,'x,y,z=',xmeas(i),ymeas(i),zmeas(i)
           !  stop 'Bx_pt is a NaN'
             print *,  'Bx_pt is a NaN'
             print *,'face (4 3 2)'
          end if
          if (isnan(By_pt)) then 
          !   print *,'fx,fy,fz',fx,fy,fz
          !   print *,'thread',iproc
          !   print *,'i=',i
          !   print *,'iel=',iel
          !   print *,'x,y,z=',xmeas(i),ymeas(i),zmeas(i)
          !   stop 'By_pt is a NaN'
             print *, 'By_pt is a NaN'
             print *,'face (4 3 2)'
          end if
          if (isnan(Bz_pt)) then
          !   print *,'fx,fy,fz',fx,fy,fz
          !   print *,'thread',iproc
          !   print *,'i=',i
          !   print *,'iel=',iel
          !   print *,'x,y,z=',xmeas(i),ymeas(i),zmeas(i)
          !   stop 'Bz_pt is a NaN'
             print *, 'Bz_pt is a NaN'
             print *,'face (4 3 2)'
          end if
         

      !-----------------------------------------------------------------
      !face bottom (2 1 4 )
      xface(1:3)=(/x(i2),x(i1),x(i4)/)
      yface(1:3)=(/y(i2),y(i1),y(i4)/)
      zface(1:3)=(/z(i2),z(i1),z(i4)/)
      call facmag(mx(iel),my(iel),mz(iel),x0,y0,z0,xface,yface,zface,nface_tri,fx,fy,fz)
      Bx_pt=Bx_pt+fx
      By_pt=By_pt+fy
      Bz_pt=Bz_pt+fz
           if (isnan(Bx_pt)) then
           !  print *,'fx,fy,fz',fx,fy,fz
           !  print *,'thread',iproc
           !  print *,'i=',i
           !  print *,'iel=',iel
           !  print *,'x,y,z=',xmeas(i),ymeas(i),zmeas(i)
           !  stop 'Bx_pt is a NaN'
             print *,  'Bx_pt is a NaN'
             print *,'face (2 1 4)'
          end if
          if (isnan(By_pt)) then 
          !   print *,'fx,fy,fz',fx,fy,fz
          !   print *,'thread',iproc
          !   print *,'i=',i
          !   print *,'iel=',iel
          !   print *,'x,y,z=',xmeas(i),ymeas(i),zmeas(i)
          !   stop 'By_pt is a NaN'
             print *, 'By_pt is a NaN'
             print *,'face (2 1 4)'
          end if
          if (isnan(Bz_pt)) then
          !   print *,'fx,fy,fz',fx,fy,fz
          !   print *,'thread',iproc
          !   print *,'i=',i
          !   print *,'iel=',iel
          !   print *,'x,y,z=',xmeas(i),ymeas(i),zmeas(i)
          !   stop 'Bz_pt is a NaN'
             print *, 'Bz_pt is a NaN'
             print *,'face (2 1 4)'
          end if
  
      !-----------------------------------------------------------------
      !face top (6 7 8)
      xface(1:3)=(/x(i6),x(i7),x(i8)/)
      yface(1:3)=(/y(i6),y(i7),y(i8)/)
      zface(1:3)=(/z(i6),z(i7),z(i8)/)
      call facmag(mx(iel),my(iel),mz(iel),x0,y0,z0,xface,yface,zface,nface_tri,fx,fy,fz)
      Bx_pt=Bx_pt+fx
      By_pt=By_pt+fy
      Bz_pt=Bz_pt+fz
           if (isnan(Bx_pt)) then
           !  print *,'fx,fy,fz',fx,fy,fz
           !  print *,'thread',iproc
           !  print *,'i=',i
           !  print *,'iel=',iel
           !  print *,'x,y,z=',xmeas(i),ymeas(i),zmeas(i)
           !  stop 'Bx_pt is a NaN'
             print *,  'Bx_pt is a NaN'
             print *,'face (6 7 8)'
          end if
          if (isnan(By_pt)) then 
          !   print *,'fx,fy,fz',fx,fy,fz
          !   print *,'thread',iproc
          !   print *,'i=',i
          !   print *,'iel=',iel
          !   print *,'x,y,z=',xmeas(i),ymeas(i),zmeas(i)
          !   stop 'By_pt is a NaN'
             print *, 'By_pt is a NaN'
             print *,'face (6 7 8)'
          end if
          if (isnan(Bz_pt)) then
          !   print *,'fx,fy,fz',fx,fy,fz
          !   print *,'thread',iproc
          !   print *,'i=',i
          !   print *,'iel=',iel
          !   print *,'x,y,z=',xmeas(i),ymeas(i),zmeas(i)
          !   stop 'Bz_pt is a NaN'
             print *, 'Bz_pt is a NaN'
             print *,'face (6 7 8)'
          end if
   
      !-----------------------------------------------------------------
      !face top (8 5 6)
      xface(1:3)=(/x(i8),x(i5),x(i6)/)
      yface(1:3)=(/y(i8),y(i5),y(i6)/)
      zface(1:3)=(/z(i8),z(i5),z(i6)/)
      call facmag(mx(iel),my(iel),mz(iel),x0,y0,z0,xface,yface,zface,nface_tri,fx,fy,fz)
      Bx_pt=Bx_pt+fx
      By_pt=By_pt+fy
      Bz_pt=Bz_pt+fz
                    if (isnan(Bx_pt)) then
           !  print *,'fx,fy,fz',fx,fy,fz
           !  print *,'thread',iproc
           !  print *,'i=',i
           !  print *,'iel=',iel
           !  print *,'x,y,z=',xmeas(i),ymeas(i),zmeas(i)
           !  stop 'Bx_pt is a NaN'
             print *,  'Bx_pt is a NaN'
               print *,'face (8 5 6)'
          end if
          if (isnan(By_pt)) then 
          !   print *,'fx,fy,fz',fx,fy,fz
          !   print *,'thread',iproc
          !   print *,'i=',i
          !   print *,'iel=',iel
          !   print *,'x,y,z=',xmeas(i),ymeas(i),zmeas(i)
          !   stop 'By_pt is a NaN'
             print *, 'By_pt is a NaN'
               print *,'face (8 5 6)'
          end if
          if (isnan(Bz_pt)) then
          !   print *,'fx,fy,fz',fx,fy,fz
          !   print *,'thread',iproc
          !   print *,'i=',i
          !   print *,'iel=',iel
          !   print *,'x,y,z=',xmeas(i),ymeas(i),zmeas(i)
          !   stop 'Bz_pt is a NaN'
             print *, 'Bz_pt is a NaN'
               print *,'face (8 5 6)'
          end if
else 
 !-----------------------------------------------------------------
     !face bottom (4 3 2 1)
     xface(1:4)=(/x(i4),x(i3),x(i2),x(i1)/)
     yface(1:4)=(/y(i4),y(i3),y(i2),y(i1)/)
     zface(1:4)=(/z(i4),z(i3),z(i2),z(i1)/)
     call facmag(mx(iel),my(iel),mz(iel),x0,y0,z0,xface,yface,zface,nface_quad,fx,fy,fz)
     Bx_pt=Bx_pt+fx
     By_pt=By_pt+fy
     Bz_pt=Bz_pt+fz
            if (isnan(Bx_pt)) then
            !  print *,'fx,fy,fz',fx,fy,fz
            !  print *,'thread',iproc
            !  print *,'i=',i
            !  print *,'iel=',iel
            !  print *,'x,y,z=',xmeas(i),ymeas(i),zmeas(i)
            !  stop 'Bx_pt is a NaN'
              print *,  'Bx_pt is a NaN'
                print *,'face (4 3 2 1)'
           end if
           if (isnan(By_pt)) then 
           !   print *,'fx,fy,fz',fx,fy,fz
           !   print *,'thread',iproc
           !   print *,'i=',i
           !   print *,'iel=',iel
           !   print *,'x,y,z=',xmeas(i),ymeas(i),zmeas(i)
           !   stop 'By_pt is a NaN'
              print *, 'By_pt is a NaN'
                print *,'face (4 3 2 1)'
           end if
           if (isnan(Bz_pt)) then
           !   print *,'fx,fy,fz',fx,fy,fz
           !   print *,'thread',iproc
           !   print *,'i=',i
           !   print *,'iel=',iel
           !   print *,'x,y,z=',xmeas(i),ymeas(i),zmeas(i)
           !   stop 'Bz_pt is a NaN'
              print *, 'Bz_pt is a NaN'
                print *,'face (4 3 2 1)'
           end if
    
    !-----------------------------------------------------------------
    !face top (5 6 7 8)
    xface(1:4)=(/x(i5),x(i6),x(i7),x(i8)/)
    yface(1:4)=(/y(i5),y(i6),y(i7),y(i8)/)
    zface(1:4)=(/z(i5),z(i6),z(i7),z(i8)/)
    call facmag(mx(iel),my(iel),mz(iel),x0,y0,z0,xface,yface,zface,nface_quad,fx,fy,fz)
    Bx_pt=Bx_pt+fx
    By_pt=By_pt+fy
    Bz_pt=Bz_pt+fz
    
         if (isnan(Bx_pt)) then
         !  print *,'fx,fy,fz',fx,fy,fz
         !  print *,'thread',iproc
         !  print *,'i=',i
         !  print *,'iel=',iel
         !  print *,'x,y,z=',xmeas(i),ymeas(i),zmeas(i)
         !  stop 'Bx_pt is a NaN'
            print *,  'Bx_pt is a NaN'
            print *,'face (5 6 7 8)'
         end if
         if (isnan(By_pt)) then 
         !   print *,'fx,fy,fz',fx,fy,fz
         !   print *,'thread',iproc
         !   print *,'i=',i
         !   print *,'iel=',iel
         !   print *,'x,y,z=',xmeas(i),ymeas(i),zmeas(i)
         !   stop 'By_pt is a NaN'
            print *, 'By_pt is a NaN'
            print *,'face (5 6 7 8)'
         end if
         if (isnan(Bz_pt)) then
         !   print *,'fx,fy,fz',fx,fy,fz
         !   print *,'thread',iproc
         !   print *,'i=',i
         !   print *,'iel=',iel
         !   print *,'x,y,z=',xmeas(i),ymeas(i),zmeas(i)
         !   stop 'Bz_pt is a NaN'
            print *, 'Bz_pt is a NaN'
            print *,'face (5 6 7 8)'
         end if 

   end if
  end do


   !print *,iproc,Bx_pt,By_pt,Bz_pt

   call MPI_REDUCE (Bx_pt,Bx(i),1,MPI_DOUBLE_PRECISION,MPI_SUM,0,MPI_COMM_WORLD,ierr)
   call MPI_REDUCE (By_pt,By(i),1,MPI_DOUBLE_PRECISION,MPI_SUM,0,MPI_COMM_WORLD,ierr)
   call MPI_REDUCE (Bz_pt,Bz(i),1,MPI_DOUBLE_PRECISION,MPI_SUM,0,MPI_COMM_WORLD,ierr)

      
            ! if (etna) then
      !  Bmx(i)=Bx(i)+IGRF_E
      !  Bmy(i)=By(i)+IGRF_N
      !  Bmz(i)=IGRF_D-Bz(i)
      ! else
        !facmag is built in different system  
        Bx(i)=-Bx(i)
        By(i)=-By(i)
        Bz(i)=-Bz(i)
        !to geomagnetic system (N,E,D),(x,y,z) 
        if (etna) then
         Btx(i)=By(i)
         Bty(i)=Bx(i)
         Btz(i)=-Bz(i)
        end if 
        
        intensity(i)=sqrt(Btx(i)**2+Bty(i)**2+Btz(i)**2)
        inclination(i)=atan2(Btz(i),sqrt(Btx(i)**2+Bty(i)**2))/pi*180.d0
        declination(i)=atan2(Bty(i),Btx(i))/pi*180.d0        
       
        if (etna) then 
         Bmx(i)=Btx(i)+Brefx
         Bmy(i)=Bty(i)+Brefy
         Bmz(i)=Btz(i)+Brefz
         BmIx(i)=Btx(i)+IGRFx
         BmIy(i)=Bty(i)+IGRFy
         BmIz(i)=Btz(i)+IGRFz
        else 
         Bmx(i)=Bx(i)+Brefx
         Bmy(i)=By(i)+Brefy
         Bmz(i)=Bz(i)+Brefz
         BmIx(i)=0
         BmIy(i)=0
         BmIz(i)=0
        end if 

        intm(i)=sqrt(Bmx(i)**2+Bmy(i)**2+Bmz(i)**2)
        incm(i)=atan2(Bmz(i),sqrt(Bmx(i)**2+Bmy(i)**2))/pi*180.d0
        decm(i)=atan2(Bmy(i),Bmx(i))/pi*180.d0      
        intIm(i)=sqrt(BmIx(i)**2+BmIy(i)**2+BmIz(i)**2)
        incIm(i)=atan2(BmIz(i),sqrt(BmIx(i)**2+BmIy(i)**2))/pi*180.d0
        decIm(i)=atan2(BmIy(i),BmIx(i))/pi*180.d0             
   tend2 = MPI_WTIME ()
          
    if (iproc==0) then
    print *,'obs point',i,' out of ',npts,'| done in ',tend2-tstart2,'s'
    write(123,*) x0,(x0+xllcorner),y0,(y0+yllcorner),z0,Bx(i),By(i),Bz(i)
    write(888,*) x0,y0,z0,Btx(i),Bty(i),Btz(i),intensity(i),inclination(i),declination(i),dmeas(i)
    write(321,*) x0,y0,z0,Bmx(i),Bmy(i),Bmz(i),intm(i),incm(i),decm(i),dmeas(i)
    write(345,*) x0,y0,z0,BmIx(i),BmIy(i),BmIz(i),intIm(i),incIm(i),decIm(i),dmeas(i)
    write(567,*) x0,y0,z0,Brefx,Brefy,Brefz,Brefint,Brefdec,Brefinc,dmeas(i)
    write(987,*) x0,y0,z0,IGRFx,IGRFy,IGRFz,IGRFint,IGRFdec,IGRFinc,dmeas(i)
    call flush(123)
   end if 

   end do

 tend = MPI_WTIME ()

if (iproc==0) then
 print *,'time computations=',tend-tstart
 print *,'time per observation pt =',(tend-tstart)/npts
 close(123)
 close(321)
 close(567)
 close(987)
 close(345)
 close(888)
 
 print *,'computations done'
end if 

!STATISTICS !!! 

!int
Mean=0.d0
Mean2=0.d0
do i=1,npts
 intm(i)=intm(i)*1e6
 intIm(i)=intIm(i)*1e6
 Mean = Mean + intm(i)
 Mean2 = Mean2 + intIm(i)
end do
Mean = Mean / npts
Mean2 = Mean2 / npts

Variance=0.d0
Variance2=0.d0
do i=1,npts
 Variance = Variance+(intm(i)-Mean)**2
 Variance2 = Variance2+(intIm(i)-Mean2)**2
end do
Variance = Variance/(npts-1)
Variance2 = Variance2/(npts-1)
Stdev = sqrt(Variance) 
Stdev2 = sqrt(Variance2) 
 
if (iproc==0) then
write(666,*) 'int', site,path,ho,npts,Mean,Variance,stDEV,minval(intm),maxval(intm)
write(616,*) 'int', site,path,ho,npts,Mean2,Variance2,stDEV2,minval(intIm),maxval(intIm)
print *,'Mean Bref added=',Mean
print *,'Variance Bref added=',Variance
print *,'stDEV Bref added=',stDEV
print *,'Mean IGRF added=',Mean2
print *,'Variance IGRF added=',Variance2
print *,'stDEV IGRF added=',stDEV2
end if 

!INC
Mean=0.d0
Mean2=0.d0
do i=1,npts
 Mean = Mean + incm(i)
 Mean = Mean + incIm(i)
end do
Mean = Mean / npts
Mean2 = Mean2 / npts

Variance2=0.d0
Variance=0.d0
do i=1,npts
 Variance = Variance+(incm(i)-Mean)**2
 Variance2 = Variance2+(incIm(i)-Mean2)**2
end do
Variance = Variance/(npts-1)
Variance2 = Variance2/(npts-1)
Stdev = sqrt(Variance) 
Stdev2 = sqrt(Variance2) 
 
if (iproc==0) then
write(666,*) 'inc',site,path,ho,npts,Mean,Variance,stDEV,minval(incm),maxval(incm)
write(616,*) 'inc',site,path,ho,npts,Mean2,Variance2,stDEV2,minval(incIm),maxval(incIm)
print *,'Mean Bref added=',Mean
print *,'Variance Bref added=',Variance
print *,'stDEV Bref added=',stDEV
print *,'Mean IGRF added=',Mean2
print *,'Variance IGRF added=',Variance2
print *,'stDEV IGRF added=',stDEV2
end if 

!DEC
Mean=0.d0
Mean2=0.d0
do i=1,npts
 Mean = Mean + decm(i)
 Mean2 = Mean2 + decIm(i)
end do
Mean = Mean / npts
Mean2 = Mean2 / npts

Variance=0.d0
Variance2=0.d0
do i=1,npts
 Variance = Variance+(decm(i)-Mean)**2
 Variance2 = Variance2+(decIm(i)-Mean2)**2
end do
Variance = Variance/(npts-1)
Variance2 = Variance2/(npts-1)
Stdev = sqrt(Variance) 
Stdev2 = sqrt(Variance2) 
 
if (iproc==0) then
write(666,*) 'dec',site,path,ho,npts,Mean,Variance,stDEV,minval(decm),maxval(decm)
write(616,*) 'dec',site,path,ho,npts,Mean2,Variance2,stDEV2,minval(decIm),maxval(decIm)
print *,'Mean Bref added=',Mean
print *,'Variance Bref added=',Variance
print *,'stDEV Bref added=',stDEV
print *,'Mean IGRF added=',Mean2
print *,'Variance IGRF added=',Variance2
print *,'stDEV IGRF added=',stDEV2
end if 

!if a plane is chosen this produces the topo of a path in middle, or it did once. 
 
if (iproc==0) then
 counter=0
 do k=1,nz
   do j=1,ny
      do i=1,nx
        counter=counter+1
        if (obs==1 .and. j==(nint(ny*0.5d0)) .and. .not. flanksim) then
          write(456,*) x0,y0,z0,Bx(counter),By(counter),Bz(counter),intensity(counter),inclination(counter),declination(counter)
          write(221,*) x0,y0,z0,Bmx(counter),Bmy(counter),Bmz(counter),intm(counter),incm(counter),decm(counter) 
        elseif (flanksim .and. obs==1) then
          if (flank==1 .or. flank==3) then 
            if (j==(nint(ny*0.5d0))) then
             write(456,*) x0,y0,z0,Bx(counter),By(counter),Bz(counter),intensity(counter),inclination(counter),declination(counter)
             write(221,*) x0,y0,z0,Bmx(counter),Bmy(counter),Bmz(counter),intm(counter),incm(counter),decm(counter) 
            end if 
          elseif (flank==2 .or. flank==4) then
            if (k==(nint(nx*0.5d0))) then
             write(456,*) x0,y0,z0,Bx(counter),By(counter),Bz(counter),intensity(counter),inclination(counter),declination(counter)
             write(221,*) x0,y0,z0,Bmx(counter),Bmy(counter),Bmz(counter),intm(counter),incm(counter),decm(counter)
            end if
          end if
        end if 
      end do
   end do 
 end do
 if (obs==1) close(221)
 if (obs==1) close(456)
 close(666)
 close(616)
end if

!--------------------------------------------------------------------
!!----------export vtu--------------
!
!
if (iproc==0) then
 if (ho==1) then
open(unit=123,file='mesh.vtu',status='replace',form='formatted')
write(123,*) '<VTKFile type="UnstructuredGrid" version="0.1" byte_order="BigEndian">'
write(123,*) '<UnstructuredGrid>'
write(123,*) '<Piece NumberOfPoints="',nnp,'" NumberOfCells="',nel,'">'
!.............................
write(123,*) '<Points>'
write(123,*) '<DataArray type="Float32" NumberOfComponents="3" Format="ascii">'
do i=1,nnp
write(123,'(3es14.5)') x(i),y(i),z(i)
end do
write(123,*) '</DataArray>'
write(123,*) '</Points>'
!.............................
write(123,*) '<CellData Scalars="scalars">'
write(123,*) '<DataArray type="Float32" Name="pb" Format="ascii">'
do iel=1,nel
   if (iel==735423) then
   write(123,*) 1.
   else
   write(123,*) 0.
   end if
end do
write(123,*) '</DataArray>'

write(123,*) '<DataArray type="Float32"  Name="magnetisation M" NumberOfComponents="3" Format="ascii">'
do iel=1,nel
write(123,'(3es11.3)') mx(iel),my(iel),mz(iel)
end do

write(123,*) '</DataArray>'
write(123,*) '</CellData>'
!-----------------------------------
write(123,*) '<PointData Scalars="scalars">'
write(123,*) '<DataArray type="Float32" Name="z" Format="ascii">'
do i=1,nnp
write(123,*) z(i)
end do
write(123,*) '</DataArray>'
write(123,*) '</PointData>'
!-----------------------------------
write(123,*) '<Cells>'
write(123,*) '<DataArray type="Int32" Name="connectivity" Format="ascii">'
do iel=1,nel
write(123,*) icon(1:8,iel)-1
end do
write(123,*) '</DataArray>'

write(123,*) '<DataArray type="Int32" Name="offsets" Format="ascii">'
write(123,*) (iel*8,iel=1,nel)
write(123,*) '</DataArray>'

write(123,*) '<DataArray type="Int32" Name="types" Format="ascii">'
write(123,'(i3)') (12,iel=1,nel)
write(123,*) '</DataArray>'

write(123,*) '</Cells>'
write(123,*) '</Piece>'
write(123,*) '</UnstructuredGrid>'
write(123,*) '</VTKFile>'
close(123)
end if !if ho=1 etc 
!-------------------------------------------------------------------------------
if (obs==2 .or. obs==3) then 
        
open(unit=123,file='meas.vtu',status='replace',form='formatted')
write(123,*) '<VTKFile type="UnstructuredGrid" version="0.1" byte_order="BigEndian">'
write(123,*) '<UnstructuredGrid>'
write(123,*) '<Piece NumberOfPoints="',npts,'" NumberOfCells="',npts,'">'
!=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
write(123,*) '<Points>'
!-----
write(123,*) '<DataArray type="Float32" NumberOfComponents="3" Format="ascii">'
do im=1,npts
write(123,'(3es12.4)') xmeas(im),ymeas(im),zmeas(im)
end do
write(123,*) '</DataArray>'
!-----
write(123,*) '</Points>'
!=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
write(123,*) '<PointData Scalars="scalars">'
!---
write(123,*) '<DataArray type="Float32" NumberOfComponents="3" Name="B vector" Format="ascii">'
do im=1,npts
write(123,*) Bx(im),By(im),Bz(im)
end do
write(123,*) '</DataArray>'
!---
write(123,*) '<DataArray type="Float32" NumberOfComponents="3" Name="B int,inc,dec" Format="ascii">'
do im=1,npts
write(123,*) intensity(im),inclination(im),declination(im)
end do
write(123,*) '</DataArray>'
!---
write(123,*) '<DataArray type="Float32" NumberOfComponents="3" Name="B+IGRF" Format="ascii">'
do im=1,npts
write(123,*) Bmx(im),Bmy(im),Bmz(im)
end do
write(123,*) '</DataArray>'
!----
write(123,*) '<DataArray type="Float32" NumberOfComponents="3" Name="B+IGRF int,inc,dec" Format="ascii">'
do im=1,npts
write(123,*) intm(im),incm(im),decm(im)
end do
write(123,*) '</DataArray>'
!----
write(123,*) '</PointData>'

!=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
write(123,*) '<Cells>'
!-----
write(123,*) '<DataArray type="Int32" Name="connectivity" Format="ascii">'
do im=1,npts
write(123,'(i8)') im-1
end do
write(123,*) '</DataArray>'
!-----
write(123,*) '<DataArray type="Int32" Name="offsets" Format="ascii">'
do im=1,npts
write(123,'(i8)') im
end do
write(123,*) '</DataArray>'
!-----
write(123,*) '<DataArray type="Int32" Name="types" Format="ascii">'
do im=1,npts
write(123,'(i1)') 1
end do
write(123,*) '</DataArray>'
!-----
write(123,*) '</Cells>'
!=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
write(123,*) '</Piece>'
write(123,*) '</UnstructuredGrid>'
write(123,*) '</VTKFile>'
close(123)
end if

!===================================================================================

if (obs==1) then 
open(unit=123,file='plane.vtu',status='replace',form='formatted')
write(123,*) '<VTKFile type="UnstructuredGrid" version="0.1" byte_order="BigEndian">'
write(123,*) '<UnstructuredGrid>'
write(123,*) '<Piece NumberOfPoints="',npts,'" NumberOfCells="',(nx-1)*(ny-1),'">'
!.............................
write(123,*) '<PointData Scalars="scalars">'
write(123,*) '<DataArray type="Float32" NumberOfComponents="3" Name="B vector" Format="ascii">'
do im=1,npts
write(123,*) Bx(im),By(im),Bz(im)
end do
write(123,*) '</DataArray>'
!---
write(123,*) '<DataArray type="Float32" NumberOfComponents="1" Name="B int" Format="ascii">'
do im=1,npts
write(123,*) intensity(im)
end do
write(123,*) '</DataArray>'
!---
write(123,*) '<DataArray type="Float32" NumberOfComponents="1" Name="B inc" Format="ascii">'
do im=1,npts
write(123,*) inclination(im)
end do
write(123,*) '</DataArray>'
!---
write(123,*) '<DataArray type="Float32" NumberOfComponents="1" Name="B dec" Format="ascii">'
do im=1,npts
write(123,*) declination(im)
end do
write(123,*) '</DataArray>'
!---
write(123,*) '<DataArray type="Float32" NumberOfComponents="3" Name="B+IGRF" Format="ascii">'
do im=1,npts
write(123,*) Bmx(im),Bmy(im),Bmz(im)
end do
write(123,*) '</DataArray>'
!----
write(123,*) '<DataArray type="Float32" NumberOfComponents="1" Name="B+IGRF int" Format="ascii">'
do im=1,npts
write(123,*) intm(im)
end do
write(123,*) '</DataArray>'
!----
write(123,*) '<DataArray type="Float32" NumberOfComponents="1" Name="B+IGRF inc" Format="ascii">'
do im=1,npts
write(123,*) incm(im)
end do
write(123,*) '</DataArray>'
!----
write(123,*) '<DataArray type="Float32" NumberOfComponents="1" Name="B+IGRF dec" Format="ascii">'
do im=1,npts
write(123,*) decm(im)
end do
write(123,*) '</DataArray>'

!----
write(123,*) '</PointData>'

!.............................
write(123,*) '<Points>'
write(123,*) '<DataArray type="Float32" NumberOfComponents="3" Format="ascii">'
do im=1,npts
write(123,'(3es12.4)') xmeas(im),ymeas(im),zmeas(im)
end do
write(123,*) '</DataArray>'
write(123,*) '</Points>'
!.............................
write(123,*) '<Cells>'
write(123,*) '<DataArray type="Int32" Name="connectivity" Format="ascii">'
do iel=1,(nx-1)*(ny-1)
write(123,'(4i8)') icon_plane(1,iel)-1,icon_plane(2,iel)-1,icon_plane(3,iel)-1,icon_plane(4,iel)-1
end do
write(123,*) '</DataArray>'
write(123,*) '<DataArray type="Int32" Name="offsets" Format="ascii">'
write(123,*) (iel*4,iel=1,(nx-1)*(ny-1))
write(123,*) '</DataArray>'
write(123,*) '<DataArray type="Int32" Name="types" Format="ascii">'
write(123,*) (9,iel=1,(nx-1)*(ny-1))
write(123,*) '</DataArray>'
write(123,*) '</Cells>'
write(123,*) '</Piece>'
write(123,*) '</UnstructuredGrid>'
write(123,*) '</VTKFile>'
close(123)
end if
!
end if !iproc

call MPI_FINALIZE (ierr)

end program

