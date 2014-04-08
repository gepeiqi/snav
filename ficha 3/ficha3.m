clear
clc

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

fprintf('Argument of latitude:\n%f rad\n%f º\n',phi,phi*180/pi);
