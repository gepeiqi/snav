function kml_placeSatellite(file,data,tst)
%KML_PLACESATELLITE Adds a Satellite placemark to the kml file

[X,Y,Z]=satpos(data,tst,data(4));

coordinates=zeros(1,3);
[coordinates(1,1),coordinates(1,2),coordinates(1,3)]=xyz2llh(X,Y,Z);
description=sprintf('Position relative to ground:\n\t\tLatitude %fº\n\t\tLongitude: %fº\n\t\tAltitude: %.3f km',coordinates(1),coordinates(2),coordinates(3)/1000);

coordinates(1,3)=2500000; % Just so it's on screen

kml_addPlacemark(file,sprintf('SVN%d',data(1)),description,coordinates,'satellite')
kml_addPlacemark(file,'','',coordinates,'shadow')
end

