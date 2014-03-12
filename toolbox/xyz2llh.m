function [lat,lon,h] = xyz2llh(X,Y,Z)
%XYZ2LLH Geodetic coordinates based on Cartesian input
%   Retrieves latitude and longitude (in degrees, with decimal places) and
%   altitude (in meters) of a point of coordinates X,Y,Z (in meters), given
%   as input. Datum used is WGS-84.

a=6378136;          % Semimajor axis of the ellipsoid
f=1/298.257839303;  % Ellipsoidal flattening
b=a*(1-f);          % Semiminor axis of the ellipsoid

r=sqrt(X^2+Y^2);
es=1-(b^2)/(a^2);
eps=(a^2)/(b^2)-1;
theta=atan((a*Z)/(b*r));

lat=180*atan((Z+eps*b*sin(theta)^3)/(r-es*a*cos(theta)^3))/pi;
lon=180*atan2(Y,X)/pi;

R=a/sqrt(1-f*(2-f)*sind(lat)^2);

h=r/cosd(lat)-R;
end

