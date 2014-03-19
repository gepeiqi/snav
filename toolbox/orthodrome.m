function [theta, psi1, psi2,d] = orthodrome(lat1,lon1,lat2,lon2)
%ORTHODROME Orthodrome parameter function
%   Retrieves the parameters of the orthodrome between points 1 and 2. Its
%   geodetic coordinates given in degrees with decimal places. Theta is the
%   angle of the orthodrome, psi1 and psi2 the depart and approach heading,
%   and d the orthodrome distance. A spherical earth with a radius of
%   6378km is assumed.

R=6378000;

lat1=lat1*pi/180;
lon1=lon1*pi/180;
lat2=lat2*pi/180;
lon2=lon2*pi/180;

theta=acos(cos(lat2)*cos(lon1-lon2)*cos(lat1)+sin(lat2)*sin(lat1));
psi1=atan2(-cos(lat2)*sin(lon1-lon2),-cos(lat2)*cos(lon1-lon2)*sin(lat1)+sin(lat2)*cos(lat1))*180/pi;
psi2=atan2(-sin(lon1-lon2)*cos(lat1),sin(lat2)*cos(lon1-lon2)*cos(lat1)-cos(lat2)*sin(lat1))*180/pi;

d=theta*R;
theta=theta*180/pi;

fprintf('Theta:%fº\nDeparture Heading:%fº\nApproach Heading:%fº\nOrthodrome Distance:%fm\n\n',theta,psi1,psi2,d);
end

