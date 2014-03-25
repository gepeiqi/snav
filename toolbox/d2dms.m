function [d,m,s] = d2dms(degrees)
%D2DM Conversion from degrees to degrees and minutes
%   Detailed explanation goes here

d=fix(degrees);
minutes=60*(degrees-d);
m=fix(minutes);
s=60*(minutes-m);

if d<0
    m=abs(m);
    s=abs(s);
elseif d==0
    if m<0
        s=abs(s);
    end
end
end

