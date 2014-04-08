function [phi0, r] = trueanomr(A,e,E)
%TRUEANOMR Calculates true anomaly and radius
%   Returns the true anomaly (in radians) and orbit distance with input of
%   semimajor axis, eccentricity, and true anomaly

phi0=atan2(sqrt(1-e^2)*sin(E),cos(E)-e);
r=A*(1-e*cos(E));
end

