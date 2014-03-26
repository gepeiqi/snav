lat1=dms2d(38,39,38.50);
lon1=dms2d(-9,17,56.20);
lat2=dms2d(-3,41,56.40);
lon2=dms2d(-38,28,56.30);

orthodrome(lat1,lon1,lat2,lon2);

[X1,Y1,Z1]=llh2xyz(lat1,lon1,0,6378000,0); %Just using the generic function with a flattening of zero.
[X2,Y2,Z2]=llh2xyz(lat2,lon2,0,6378000,0);

Xm=(X1+X2)/2;
Ym=(Y1+Y2)/2;
Zm=(Z1+Z2)/2;

[latm,lonm,~]=xyz2llh(Xm,Ym,Zm,6378000,0);

fprintf('Orthodrome halfway point:\nLat: %fº\nLon: %fº\n',latm,lonm);

orthodrome(lat1,lon1,latm,lonm);
orthodrome(latm,lonm,lat2,lon2);
