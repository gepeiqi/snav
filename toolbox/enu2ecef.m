function [X,Y,Z] = enu2ecef(e,n,u,lat,lon,a,f)
%ENU2ECEF ENU to ECEF conversion
%   Converts point with coordinates (e,n,u) with respect to point of
%   geodetic coordinates (lat,lon) in degrees with zero altitude. Default
%   datum used is WGS-84.

if nargin == 5
    a=6378137;
    f=1/298.257223563;
end

[dx,dy,dz]=rotx(e,n,u,lat-90);
[dx,dy,dz]=rotz(dx,dy,dz,-lon-90);

[X0,Y0,Z0]=llh2xyz(lat,lon,0,a,f);

X=X0+dx;
Y=Y0+dy;
Z=Z0+dz;

end