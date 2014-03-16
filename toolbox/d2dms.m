function [d,m,s] = d2dms(degrees)
%D2DM Conversion from degrees to degrees and minutes
%   Detailed explanation goes here

d=fix(degrees);


if d>=0
    m=fix(60*rem(degrees,1));
elseif d<0
    m=fix(abs(60*rem(degrees,1)));
end

if m>=0
    s=60*rem(60*rem(degrees,1),1);
elseif m<0
    s=abs(60*rem(60*rem(degrees,1),1));     % FIX THIS
end
end