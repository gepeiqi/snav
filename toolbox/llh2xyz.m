function [X, Y, Z] = llh2xyz(lat,lon,h,a,f)
%LLH2XYZ ECEF coordinates from geodetic coordinates
%   This function retrieves the ECEF coordinates from the geodetic
%   coordinates. Input arguments are the latitude and longitude of the
%   point to be calculated (in degrees with any number of decimal places)
%   and altitude (in meters) and the output is given in meters, using the
%   usual layout of X, Y and Z. The default ellipsoid used is WGS-84.
if nargin==3
    a=6378137;          % Semimajor axis of the ellipsoid
    f=1/298.257223563;  % Ellipsoidal flattening
end

lat=lat*pi/180; % Convert the angular arguments from degrees to radians
lon=lon*pi/180;

R=a/sqrt(1-f*(2-f)*sin(lat)^2); % Radius of ellipsoid at given latitude

X=(R+h)*cos(lat)*cos(lon);
Y=(R+h)*cos(lat)*sin(lon);
Z=(R*(1-f)^2+h)*sin(lat);
end

