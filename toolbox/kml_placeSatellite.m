function kml_placeSatellite(file,data,tst,add_description)
%KML_PLACESATELLITE Adds a Satellite placemark to the kml file

[X,Y,Z]=satpos(data,tst,data(4));

if nargin ==3
    add_description='';
end

OmegaDot_e=7.2921151467*10^-5;

coordinates=zeros(1,3);
[coordinates(1,1),coordinates(1,2),coordinates(1,3)]=xyz2llh(X,Y,Z);
description=sprintf('Position relative to ground:\n\t\tLatitude %fº\n\t\tLongitude: %fº\n\t\tAltitude: %.3f km\n%s',coordinates(1),coordinates(2),coordinates(3)/1000,add_description);

kml_addPlacemark(file,sprintf('SVN%d',data(1)),description,coordinates,'satellite')
kml_addPlacemark(file,'','',coordinates,'shadow')

Tp=60:60:300;

for i=1:5
    [Xb,Yb,Zb]=satpos(data,tst-Tp(i),data(4));
    [coordinates(1,1),coordinates(1,2),coordinates(1,3)]=xyz2llh(Xb,Yb,Zb);
    kml_addPlacemark(file,sprintf('SVN%d %dm ago',data(1),i),'',coordinates,'blip');
end

Tf=0:60:600;

path=zeros(11,3);

for i=1:(1+24*60)
    [Xp,Yp,Zp]=satpos(data,tst+Tf(i),data(4));
    [lat,lon,alt]=xyz2llh(Xp,Yp,Zp);
    
    % Longitude correction to account for Earth spin movement
    lon=lon+OmegaDot_e*Tf(i)*180/pi;
    
    if lon>180
        lon=lon-360;
    elseif lon<-180
        lon=lon+360;
    end
    
    path(i,1)=lat;
    path(i,2)=lon;
    path(i,3)=alt;
end

kml_drawPath(file,path,'blue');
end

