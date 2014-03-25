function [E,N,U] = ecef2enu(X1,Y1,Z1,lat1,lon1,X2,Y2,Z2)
%ECEF2ENU ECEF to ENU conversion
%   Converts ECEF coordinates (X2,Y2,Z2) (in meters) to an ENU frame
%   relative to point 1.

dx=X2-X1;
dy=Y2-Y1;
dz=Z2-Z1;

[E,N,U]=rotz(dx,dy,dz,lon1+90);
[E,N,U]=rotx(E,N,U,90-lat1);

fprintf('E:%f\nN:%f\nU:%f\n',E,N,U);

end

