a=6378137;
f=1/298.257223563;

lat=38*pi/180;

R=a/sqrt(1-f*(2-f)*(sin(lat))^2);

arcR=R*cos(lat);

p=2*pi*arcR;

arc=p/3600;

fprintf('%f m\n',arc);