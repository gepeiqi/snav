function [X,Y,Z] = satpos(data,t,WN)
%SATPOS Calculate the WGS-84 coordinates of a given satellite
%   Detailed explanation goes here

miu=3.986005*10^14;
OmegaDot_e=7.2921151467*10^-5;

WNa=data(4);
toe=data(7);
sqrtA=data(34);
deltaN=data(37);
M0=data(40);
e=data(43);
w=data(46);
i0=data(49);
IDOT=data(52);
Omega0=data(55);
OmegaDot=data(58);
cuc=data(61);
cus=data(64);
crc=data(67);
crs=data(70);
cic=data(73);
cis=data(76);

A=sqrtA^2;

N=sqrt(miu/(A^3))+deltaN;

while WN>1023
    WN=WN-1024;
end
    
deltat=t-toe;

if deltat>302400
    deltat=deltat-604800;
elseif deltat<-302400
    deltat=deltat+604800;
end


M=M0+N*deltat;

E=solveEA(M,e);

[phi0, r0] = trueanomr(A,e,E);

phi=phi0+w;

delta_u=cuc*cos(2*phi)+cus*sin(2*phi);
u=phi+delta_u;

delta_r=crc*cos(2*phi)+crs*sin(2*phi);
r=r0+delta_r;

delta_i=cic*cos(2*phi)+cis*sin(2*phi);
i=i0+delta_i+IDOT*deltat;

Omega=Omega0+(OmegaDot-OmegaDot_e)*deltat-OmegaDot_e*toe;

[X,Y,Z]=rotx(r*cos(u),r*sin(u),0,-i*180/pi);

[X,Y,Z]=rotz(X,Y,Z,-Omega*180/pi);
end

