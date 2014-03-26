u=24000*sin(6*pi/180);

R=24000*cos(6*pi/180);

e=R*sin(200*pi/180);
n=R*cos(200*pi/180);

lat=dms2d(38,45,50.50);
lon=dms2d(-9,8,20.20);

fprintf('Geodetic coordinates of radar:\nlat: %fº\nlon: %fº\nalt: 156m\n',lat,lon);

[X,Y,Z]=llh2xyz(lat,lon,156);

[Xp,Yp,Zp]=enu2ecef(e,n,u,lat,lon);

fprintf('Cartesian coordinates of plane:\nX=%f m\nY=%f m\nZ=%f m\n',Xp,Yp,Zp);

[latp,lonp,altp]=xyz2llh(Xp,Yp,Zp);

fprintf('Geodetic coordinates of plane:\nlat: %fº\nlon: %fº\nalt: %fm\n',latp,lonp,altp);