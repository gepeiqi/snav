function [X2,Y2,Z2] = roty(X1,Y1,Z1,beta)
%ROTY Rotation about y axis
%   Rotates vector [X1,Y1,Z1] about by beta degrees, about the y axis.

beta=beta*pi/180;

X2=X1*cos(beta)-Z1*sin(beta);
Y2=Y1;
Z2=X1*sin(beta)+Z1*cos(beta);


end

