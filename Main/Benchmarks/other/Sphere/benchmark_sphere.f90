subroutine compute_benchmark_sphere(rs,dr,Brefx,Brefy,Brefz,Magx,Magy,Magz,Xv,theta,phi,x0,y0,z0)


implicit none
real, INTENT(IN) :: rs,dr,Brefx,Brefy,Brefz,Xv,theta,phi,x0,y0,z0,Magx,Magy,Magz
real(8) :: Bcax,Bcay,Bcaz,D,BcaInt,Xvd
real(8) :: rux,ruy,ruz,thux,thuy,thuz,ru,thu
real(8) :: Btcax,Btcay,Btcaz
real(8) :: Q,BrefInt,pi,mu,dtr,rtd,P
integer :: opt


pi = 4.d0*atan(1d0)
mu = 4d0*pi*(1e-7) !vacuum permeability of air
dtr = pi/180.d0 !degrees to radian
rtd = 180.d0/pi

!It has been noticed that doing it via option 2 will introduce a fault at bigger angles (probably due to conversion of B to M ->
!etc. only use option 1) 
opt = 1

Q=(1.d0/3.d0)*((rs/dr)**3)*mu
P=xv/(xv+3.d0)*((rs/dr)**3)
BrefInt=sqrt(Brefx**2+Brefy**2+Brefz**2)
open(unit=321,file='sphere_benchmark_calculations.dat',status='replace',action='write')     
write(321,*) '# 1 2 3 4 5 6 '
write(321,*) '# x0 y0 z0 Bcalcx Bcalcy Bcalcz BcalcInt D Q'
rux=sin(theta*dtr)*cos(phi*dtr)
ruy=sin(theta*dtr)*sin(phi*dtr)
ruz=cos(theta*dtr)
ru=rux+ruy+ruz
thux=cos(theta*dtr)*cos(phi*dtr)
thuy=cos(theta*dtr)*sin(phi*dtr)
thuz=-sin(theta*dtr)
thu=thux+thuy+thuz
if (opt==1) then
Bcax=Q*Magz*(2*(rux*cos(theta*dtr))+thux*sin(theta*dtr))
Bcay=Q*Magz*(2*(ruy*cos(theta*dtr))+thuy*sin(theta*dtr))
Bcaz=Q*Magz*(2*(ruz*cos(theta*dtr))+thuz*sin(theta*dtr))
else
Bcax=P*Brefz*(2*(rux*cos(theta*dtr))+thux*sin(theta*dtr))
Bcay=P*Brefz*(2*(ruy*cos(theta*dtr))+thuy*sin(theta*dtr))
Bcaz=P*Brefz*(2*(ruz*cos(theta*dtr))+thuz*sin(theta*dtr))
end if 

!Btcax=Bcax+Brefx
Btcax=Bcax
!Btcay=Bcay+Brefy
Btcay=Bcay
!Btcaz=Bcaz+Brefz
Btcaz=Bcaz
!Bcay=Q*Magz*(2*sin(theta*dtr)*sin(phi*dtr)*cos(theta*dtr)+cos(theta*dtr)*sin(phi*dtr)*sin(theta*dtr))
!Bcaz=Q*Magz*(2*(cos(theta*dtr))**2-(sin(theta*dtr))**2)

BcaInt= sqrt(Btcax**2+Btcay**2+Btcaz**2)
D=ACOS((Btcax*Brefx+Btcay*Brefy+Btcaz*Brefz)/(BcaInt*BrefInt))
D=D*rtd


write(321,*) x0,y0,z0,Bcax,Bcay,Bcaz,BcaInt,D

close(321)

end subroutine 



