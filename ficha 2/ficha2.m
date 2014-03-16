p1lat=[38 46 49.61];
p1lon=[-9 29 56.19];
h1=103;

[lat mlat]=dms2dm(p1lat(1),p1lat(2),p1lat(3));
[lon mlon]=dms2dm(p1lon(1),p1lon(2),p1lon(3));

disp('p1:');

s=sprintf('Latitude: %d deg %f min',lat,mlat);
disp(s)
s=sprintf('Longitude: %d deg %f min',lon,mlon);
disp(s)

lat1=dms2d(p1lat(1),p1lat(2),p1lat(3));
lon1=dms2d(p1lon(1),p1lon(2),p1lon(3));

s=sprintf('Latitude: %f º',lat1);
disp(s)
s=sprintf('Longitude: %f º',lon1);
disp(s)

[X1 Y1 Z1]=llh2xyz(lat1, lon1, h1);
s=sprintf('\n\nX=%f\nY=%f\nZ=%f\n',X1,Y1,Z1);
disp(s)

X2=4910384.3;
Y2=-821478.6;
Z2=3973549.6;

[lat2,lon2,h2]=xyz2llh(X2,Y2,Z2);

disp('p2:');
s=sprintf('Latitude: %f º',lat2);
disp(s)
s=sprintf('Longitude: %f º',lon2);
disp(s)
s=sprintf('Altitude: %f m\n',h2);
disp(s)

[lat2d,lat2m]=d2dm(lat2);
[lon2d,lon2m]=d2dm(lon2);

s=sprintf('Latitude: %d º %f min',lat2d,lat2m);
disp(s)
s=sprintf('Longitude: %d º %f min',lon2d, lon2m);
disp(s)
s=sprintf('Altitude: %f m\n',h2);
disp(s)

[lat2d,lat2m,lat2s]=d2dms(lat2);
[lon2d,lon2m,lon2s]=d2dms(lon2);

s=sprintf('Latitude: %d º %d min %f seg',lat2d,lat2m,lat2s);
disp(s)
s=sprintf('Longitude: %d º %d min %f seg',lon2d, lon2m,lon2s);
disp(s)
s=sprintf('Altitude: %f m\n',h2);
disp(s)
dist=sqrt((X2-X1)^2+(Y2-Y1)^2+(Z2-Z1)^2);
s=sprintf('Distancia entre os dois pontos: %f',dist);
disp(s)
