function [lat2, lon2, alt2] = molodensky(lat1, lon1, alt1, a1, b1, e1, delta_a, delta_f, delta_x, delta_y, delta_z)
%MOLODENSKY Molodensky Transformation
%   Retrieves geodetic coordinates of a point with geodetic coordinates
%   lat1 and lon1 (given in degrees with decimal places) and alt1 (in meters).
%   Other arguments are the parameters of the Molodensky Transformation.

lat1=lat1*pi/180;
lon1=lon1*pi/180;

R_N=a1/sqrt(1-(e1^2)*sin(lat1)^2);
R_M=(a1*(1-e1^2))/sqrt((1-(e1^2)*sin(lat1)^2)^3);

fprintf('RN=%f\nRM=%f\n',R_N,R_M);

delta_lat=(-delta_x*sin(lat1)*cos(lon1)-delta_y*sin(lat1)*sin(lon1)+delta_z*cos(lat1)+(delta_a*R_N*(e1^2)/a1+delta_f*(R_M*a1/b1+R_N*b1/a1))*sin(lat1)*cos(lat1))/(R_M+alt1);
delta_lon=(-delta_x*sin(lon1)+delta_y*cos(lon1))/((R_N+alt1)*cos(lat1));
delta_alt=delta_x*cos(lat1)*cos(lon1)+delta_y*cos(lat1)*sin(lon1)+delta_z*sin(lat1)-delta_a*a1/R_N+delta_f*b1*R_N*(sin(lat1)^2)/a1;

delta_lat=delta_lat*180/pi;
delta_lon=delta_lon*180/pi;

lat1=lat1*180/pi;
lon1=lon1*180/pi;

lat2=lat1+delta_lat;
lon2=lon1+delta_lon;
alt2=alt1+delta_alt;

fprintf('lat=%f\nlon=%f\nalt=%f',lat2,lon2,alt2);
end