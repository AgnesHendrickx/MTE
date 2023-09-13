#subroutine compute_benchmark_sphere(rs,dr,Brefx,Brefy,Brefz,Magx,Magy,Magz,Xv,theta,phi,x0,y0,z0)
import numpy as np
from math import pi as pi 

from math import cos as cos 
from math import sin as sin 
from math import tan as tan 
from math import acos as acos

mu=4.*pi*1e-7
dtr=pi/180.
rtd=180./pi

#def compute_benchmark_sphere(rs,dr,Mz,theta,phi):
    
Q=(1./3.)*((rs/dr)**3))*mu
    
rux=sin(theta*dtr)*cos(phi*dtr)
ruy=sin(theta*dtr)*sin(phi*dtr)
ruz=cos(theta*dtr)
ru=rux+ruy+ruz
    
thux=cos(theta*dtr)*cos(phi*dtr)
thuy=cos(theta*dtr)*sin(phi*dtr)
thuz=-sin(theta*dtr)
thu=thux+thuy+thuz
    
Bcax=Q*Mz*(2*(rux*cos(theta*dtr))+thux*sin(theta*dtr))
Bcay=Q*Mz*(2*(ruy*cos(theta*dtr))+thuy*sin(theta*dtr))
Bcaz=Q*Mz*(2*(ruz*cos(theta*dtr))+thuz*sin(theta*dtr))


Lx=21
Ly=21
Lz=21
Brefx=0.
Brefy=0.
Brefz=0.
Mx=0.
My=0.
Mz=7.5
nelx=100
nely=100
nelz=100

xs=Lx/2
ys=Ly/2
zs=Lz/2
rs=10.
dr=10.40
theta=0
phi=0
!Xv=0.05

x0=xs+sin(theta*dtr)*cos(phi*dtr)*dr
y0=ys+sin(theta*dtr)*sin(phi*dtr)*dr
z0=-zs+cos(theta*dtr)*dr
nx=1
ny=1
nz=1
npts=1

print bcax
print bx

print bcay
print by

print bcaz 
print bz


#real, INTENT(IN) :: rs,dr,Brefx,Brefy,Brefz,Xv,theta,phi,x0,y0,z0,Magx,Magy,Magz
#real(8) :: Bcax,Bcay,Bcaz,D,BcaInt,Xvd
#real(8) :: rux,ruy,ruz,thux,thuy,thuz,ru,thu
#real(8) :: Btcax,Btcay,Btcaz
#real(8) :: Q,BrefInt,pi,mu,dtr,rtd,P


#pi = 4.d0*atan(1d0)
#mu = 4d0*pi*(1e-7) !vacuum permeability of air
#dtr = pi/180.d0 !degrees to radian
#rtd = 180.d0/pi

#Q=(1.d0/3.d0)*((rs/dr)**3)*mu
#BrefInt=sqrt(Brefx**2+Brefy**2+Brefz**2)

#open(unit=321,file='sphere_benchmark_calculations.dat',status='replace',action='write')     
#write(321,*) '# 1 2 3 4 5 6 '
#write(321,*) '# x0 y0 z0 Bcalcx Bcalcy Bcalcz BcalcInt D Q'
#write(321,*) x0,y0,z0,Bcax,Bcay,Bcaz,BcaInt,D
#close(321)

#end subroutine 



