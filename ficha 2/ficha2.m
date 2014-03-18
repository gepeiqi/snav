p1lat=[38 46 49.61];
p1lon=[-9 29 56.19];
h1=103;

[lat mlat]=dms2dm(p1lat(1),p1lat(2),p1lat(3));
[lon mlon]=dms2dm(p1lon(1),p1lon(2),p1lon(3));

disp('p1:');

fprintf('Latitude: %d deg %f min\n',lat,mlat);
fprintf('Longitude: %d deg %f min\n',lon,mlon);

lat1=dms2d(p1lat(1),p1lat(2),p1lat(3));
lon1=dms2d(p1lon(1),p1lon(2),p1lon(3));

fprintf('Latitude: %f º\n',lat1);
fprintf('Longitude: %f º\n',lon1);

[X1 Y1 Z1]=llh2xyz(lat1, lon1, h1);
fprintf('\n\nX=%f\nY=%f\nZ=%f\n',X1,Y1,Z1);

X2=4910384.3;
Y2=-821478.6;
Z2=3973549.6;

[lat2,lon2,h2]=xyz2llh(X2,Y2,Z2);

fprintf('Latitude: %f º\n',lat2);
fprintf('Longitude: %f º\n',lon2);
fprintf('Altitude: %f m\n',h2);

[lat2d,lat2m]=d2dm(lat2);
[lon2d,lon2m]=d2dm(lon2);

fprintf('Latitude: %d º %f min\n',lat2d,lat2m);
fprintf('Longitude: %d º %f min\n',lon2d, lon2m);
fprintf('Altitude: %f m\n',h2);

[lat2d,lat2m,lat2s]=d2dms(lat2);
[lon2d,lon2m,lon2s]=d2dms(lon2);

fprintf('Latitude: %d º %d min %f seg\n',lat2d,lat2m,lat2s);
fprintf('Longitude: %d º %d min %f seg\n',lon2d, lon2m,lon2s);
fprintf('Altitude: %f m\n',h2);
dist=sqrt((X2-X1)^2+(Y2-Y1)^2+(Z2-Z1)^2);
fprintf('Distancia entre os dois pontos: %f\n\n\n',dist);


a1=6378137;
b1=6356752.3;
e1=sqrt(1-(b1^2)/(a1^2));
delta_a=251;
delta_f=0.14192702*10^-4;
delta_x=84;
delta_y=107;
delta_z=120;


fprintf('Molodensky ponto 1:\n')
molodensky(lat1, lon1, h1, a1, b1, e1, delta_a, delta_f, delta_x, delta_y, delta_z);

fprintf('Molodensky ponto 2:\n')
molodensky(lat2, lon2, h2, a1, b1, e1, delta_a, delta_f, delta_x, delta_y, delta_z);