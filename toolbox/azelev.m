function [az,el] = azelev(E,N,U)
%AZELEV Calculate azimuth and elevation
%   Outputs azimuth and elevation (in degrees) given ENU coordinates in
%   meters.

az=atan2(E,N)*180/pi;
el=atan2(U,sqrt(N^2+E^2))*180/pi;

end

