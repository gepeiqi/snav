function [E] = solveEA(M,e,t)
%SOLVEEA Retrieves Eccentric anomaly from mean anomaly
%   Detailed explanation goes here

if nargin==2
    t=10^-12;
end

E=M;

while (1)
    Ep=E;
    E=M+e*sin(E);
    if abs(E-Ep)<t
        break
    else
        continue
    end
end

end

