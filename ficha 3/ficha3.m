clear
clc

c=3e8;
A=26559755;
e=0.017545;
w=1.626021;

t=39929;

miu=3.986005*10^14;

T=2*pi*sqrt((A^3)/miu);

fprintf('Orbital period:\n%f s\n%f m\n%f h\n\n',T,T/60,T/3600);

eta=2*pi/T;

fprintf('Mean angular motion:\n%f rad/s\n%f º/s\n%f º/h\n\n',eta,eta*180/pi,eta*180/pi*3600);

M=eta*t;

fprintf('Mean anomaly:\n%f rad/s\n%f º\n\n',M,M*180/pi);

E=solveEA(M,e);

fprintf('Eccentric anomaly:\n%f rad/s\n%f º\n\n',E,E*180/pi);

[phi0,r]=trueanomr(A,e,E);

fprintf('True anomaly:\n%f rad\n%f º\n',phi0,phi0*180/pi);
fprintf('Radius:\n%f m\n\n',r);

phi=phi0+w;

fprintf('Argument of latitude:\n%f rad\n%f º\n\n',phi,phi*180/pi);

X1=4918526.668;
Y1=-791212.115;
Z1=3969767.14;

t=213984;
WN=1693;

data=load('ephemerides.eph');

SATECEF=zeros(size(data,1),4);

for i=1:size(data,1)
   SATECEF(i,1)=data(i,1);
   [SATECEF(i,2),SATECEF(i,3),SATECEF(i,4)]=satpos(data(i,1:end),t,WN);
   fprintf('%d\t %f \t %f \t %f\n',SATECEF(i,1),SATECEF(i,2),SATECEF(i,3),SATECEF(i,4))
end

fprintf('\n');
dists=zeros(size(SATECEF,1),1);

for i=1:size(dists,1)
    dists(i,1)=distance(X1,Y1,Z1,SATECEF(i,2),SATECEF(i,3),SATECEF(i,4));
end
fprintf('\n');

ENU=zeros(size(SATECEF,1),3);
DCOS=zeros(size(SATECEF,1),3);
[lat1,lon1,~]=xyz2llh(X1,Y1,Z1);
for i=1:size(SATECEF,1)
    [ENU(i,1),ENU(i,2),ENU(i,3)]=ecef2enu(X1,Y1,Z1,lat1,lon1,SATECEF(i,2),SATECEF(i,3),SATECEF(i,4));
    for j=1:3
        DCOS(i,j)=ENU(i,j)/dists(i);
    end
    fprintf('%d\t %f \t %f \t %f\n',SATECEF(i,1),DCOS(i,1),DCOS(i,2),DCOS(i,3))
end

fprintf('\n');

azelev=zeros(size(SATECEF,1),3);

for i=1:size(SATECEF,1)
    azelev(i,1)=SATECEF(i,1);
    azelev(i,2)=atan2(DCOS(i,1),DCOS(i,2))*180/pi;
    azelev(i,3)=atan2(DCOS(i,3),sqrt(DCOS(i,1)^2+DCOS(i,2)^2))*180/pi;
    fprintf('%d\t %f \t %f\n',azelev(i,1),azelev(i,2),azelev(i,3))
end