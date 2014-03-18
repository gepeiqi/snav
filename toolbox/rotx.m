function [X2,Y2,Z2] = rotx(X1,Y1,Z1,alpha)
%ROTX Rotation about x axis
%   Rotates vector [X1,Y1,Z1] about by alpha degrees, about the x axis.

alpha=alpha*pi/180;

X2=X1;
Y2=Y1*cos(alpha)+Z1*sin(alpha);
Z2=-Y1*sin(alpha)+Z1*cos(alpha);

end

