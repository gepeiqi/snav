function [psi,d] = loxodrome(lat1,lon1,lat2,lon2)
%LOXODROME Loxodrome function
%   Calculates the parameters of the loxodrome from point 1 to point 2.
%   Geodetic coordinates given as degrees. A spherical earth of radius
%   equal to 6378 km is assumed.

R=6378000;

lat1=lat1*pi/180;
lon1=lon1*pi/180;
lat2=lat2*pi/180;
lon2=lon2*pi/180;

PLat1=log(tan((pi/4)+lat1/2));
PLat2=log(tan((pi/4)+lat2/2));

psi=atan2(lon2-lon1,PLat2-PLat1);
d=R*abs(lat2-lat1)/abs(cos(psi));
psi=psi*180/pi;

fprintf('Heading:%fº\nLoxodrome Distance:%fm\n\n',psi,d);
end

