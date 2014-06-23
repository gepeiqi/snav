function kml_mask(lat,lon,h,mask)
%KML_MASK Creates a KML file with all satellites visible above an elevation
% angle

[Xr,Yr,Zr]=llh2xyz(lat,lon,h);
tst=getcurrenttime;

latestparsed=fopen('latestparsed','r+');
eph_file=sprintf('%s.eph',fscanf(latestparsed,'%s'));
fclose(latestparsed);

eph=load(eph_file);

sats_XYZ=zeros(size(eph,1),4);

for sat=1:size(eph,1)
    sats_XYZ(sat,1)=eph(sat,1);
    [sats_XYZ(sat,2),sats_XYZ(sat,3),sats_XYZ(sat,4)]=satpos(eph(sat,:),tst,eph(sat,4));
end

nsat=0;
satList=zeros(1,4);

for sat=1:size(eph,1)
    [E,N,U]=ecef2enu(Xr,Yr,Zr,lat,lon,sats_XYZ(sat,2),sats_XYZ(sat,3),sats_XYZ(sat,4));
    [az,elev]=azelev(E,N,U);
    if elev<mask
        continue
    else
        nsat=nsat+1;
        satList(nsat,1)=sats_XYZ(sat,1);
        satList(nsat,2)=sat;
        satList(nsat,3)=az;
        satList(nsat,4)=elev;
    end
end

kml_sat_matrix=zeros(nsat,4);

filename=sprintf('%2.4f_%3.4f_%d_%ddeg',lat,lon,uint32(tst),mask);
file=kml_open(filename);
kml_addGroundStyle(file);
kml_addSatelliteStyles(file);
kml_addBlipStyle(file);
kml_addPathStyles(file);
kml_addPlacemark(file,'Ground Station','',[lat,lon,h],'ground');

for n=1:nsat
    kml_sat_matrix(n,1)=satList(n,1);
    [kml_sat_matrix(n,2),kml_sat_matrix(n,3),kml_sat_matrix(n,4)]=...
        xyz2llh(sats_XYZ(satList(n,2),2),sats_XYZ(satList(n,2),3),sats_XYZ(satList(n,2),4));
    description=sprintf('Azimuth: %3.4fº\nElevation: %2.4fº\n',...
        satList(n,3),satList(n,4));
    coordinates=[kml_sat_matrix(n,2),kml_sat_matrix(n,3),kml_sat_matrix(n,4)];
    kml_placeSatellite(file,eph(satList(n,2),:),tst,description);
    kml_drawPath(file,[lat lon h; coordinates],'green');
end

kml_close(file);
end

