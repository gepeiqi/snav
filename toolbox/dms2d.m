function [degrees] = dms2d(d,m,s)
%DMS2D Convert degrees, minutes and seconds to degrees with decimal places
% Having as arguments the degrees, minutes and (optional, defaults to zero)
% seconds of an angular measurement, outputs the value in degrees with
% decimal places.

if nargin==2    % Set the default value for seconds
    s=0;
end

minutes=s/60;       % Usual conversions

if m<0
    minutes=m-minutes;
else
    minutes=minutes+m;
end
degrees=minutes/60;

if d<0  % Signal of the output based on input.
    degrees=d-degrees;
elseif d>=0
    degrees=d+degrees;
end
end

