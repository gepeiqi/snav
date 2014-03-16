function [d,m] = d2dm(degrees)
%D2DM Conversion from degrees to degrees and minutes
%   Detailed explanation goes here

d=fix(degrees);

if d>=0
    m=60*rem(degrees,1);
elseif d<0
    m=abs(60*rem(degrees,1));
end
end