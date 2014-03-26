function [degrees,minutes] = dms2dm(d,m,s)
%DMS2D Convert degrees, minutes and seconds to degrees and minutes with
% decimal places, having as arguments the degrees, minutes and seconds of
% an angular measurement, outputs the value in degrees  and minutes with
% decimal places.

minutes=s/60;       % Usual conversions

if m<0
    minutes=m-minutes;
else
    minutes=minutes+m;
end

degrees=d;
end