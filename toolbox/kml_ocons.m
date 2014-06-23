function kml_ocons(lat,lon,h,n,mask)
%KML_OCONS Generate a KML file with the current optimal n-satellite constellation
%   Generates a KML file with the current optimal constellation on the
%   location given by lat and lon (in degrees) and h (in meters).
%   Satellites with an elevation angle lower than mask (in degrees) are
%   ignored.

if nargin==4
    mask=0;
end

[Xr,Yr,Zr]=llh2xyz(lat,lon,h);
tst=getcurrenttime;

latestparsed=fopen('latestparsed','r+');
eph_file=sprintf('%s.eph',fscanf(latestparsed,'%s'));
fclose(latestparsed);

eph=load(eph_file);

if n>size(eph,1);
    disp('number of satellites of ephemeris file is lower than the intended size of the constellation.');
    disp('aborting.');
    return
end

sats_XYZ=zeros(size(eph,1),4);

for sat=1:size(eph,1)
    sats_XYZ(sat,1)=eph(sat,1);
    [sats_XYZ(sat,2),sats_XYZ(sat,3),sats_XYZ(sat,4)]=satpos(eph(sat,:),tst,eph(sat,4));
end

nsat=0;
satList=zeros(1,7);

for sat=1:size(eph,1)
    [E,N,U]=ecef2enu(Xr,Yr,Zr,lat,lon,sats_XYZ(sat,2),sats_XYZ(sat,3),sats_XYZ(sat,4));
    [az,elev]=azelev(E,N,U);
    if elev<mask
        continue
    else
        nsat=nsat+1;
        satList(nsat,1)=sats_XYZ(nsat,1);
        satList(nsat,2)=sat;
        satList(nsat,3)=E;
        satList(nsat,4)=N;
        satList(nsat,5)=U;
        satList(nsat,6)=az;
        satList(nsat,7)=elev;
    end
end

findopt=1;
if nsat<n
    fprintf('not possible to satisfy intended constellation size of %d.\n',n);
    fprintf('using %d satellites instead. (every visible satellite)\n',nsat);
    n=nsat;
    findopt=0;
end

kml_sat_matrix=zeros(n,6);

switch findopt
    case 0
        filename=sprintf('%2.4f_%3.4f_%d_%dsat',lat,lon,uint32(tst),n);
        for sat=1:size(satList,1);
            index=satList(sat,2);
            kml_sat_matrix(sat,1)=sats_ENU(index,1);
            [kml_sat_matrix(sat,2),kml_sat_matrix(sat,3),kml_sat_matrix(sat,4)]=...
                xyz2llh(sats_XYZ(index,2),sats_XYZ(index,3),sats_XYZ(index,4));
            kml_sat_matrix(sat,5)=sats_ENU(sat,5);
            kml_sat_matrix(sat,6)=sats_ENU(sat,6);
        end
    case 1
        sats=1:size(satList,1);
        constellations=combntns(sats,n);
        minPDOP=+inf;
        for c=1:size(constellations,1)
            e=zeros(n,3);
            H=zeros(n,4);
            index=zeros(n,1);
            for s=1:n
                index(s)=satList(constellations(c,s),2);
                dist=distance(sats_XYZ(index(s),2),sats_XYZ(index(s),3),...
                    sats_XYZ(index(s),4),Xr,Yr,Zr);
                r=[Xr,Yr,Zr];
                for l=1:3
                    e(s,l)=(sats_XYZ(index(s),l+1)-r(l))/dist;
                    H(s,l)=-e(s,l);
                end
                H(s,4)=1;
            end
            PDOP=dop(H,3);
            
            if PDOP<minPDOP
                minPDOP=PDOP;
                minPDOPi=constellations(c,:);
            end
        end
        
        for sat=1:n
            kml_sat_matrix(sat,1)=sats_XYZ(minPDOPi(sat),1);
            [kml_sat_matrix(sat,2),kml_sat_matrix(sat,3),kml_sat_matrix(sat,4)]=...
                xyz2llh(sats_XYZ(satList(minPDOPi(sat),2),2),sats_XYZ(satList(minPDOPi(sat),2),3),sats_XYZ(satList(minPDOPi(sat),2),4));
            kml_sat_matrix(sat,5)=satList(minPDOPi(sat),6);
            kml_sat_matrix(sat,6)=satList(minPDOPi(sat),7);
        end
        filename=sprintf('%2.4f_%3.4f_%d_%dsat_%2.3fPDOP',lat,lon,uint32(tst),n,minPDOP);

end

file=kml_open(filename);
kml_addGroundStyle(file);
kml_addSatelliteStyles(file);
kml_addPlacemark(file,'Ground Station','',[lat,lon,h],'ground');
kml_addBlipStyle(file);
kml_addPathStyles(file);

for sat=1:n
    description=sprintf('Azimuth: %3.4fº\nElevation: %2.4fº\n',...
        satList(minPDOPi(sat),6),satList(minPDOPi(sat),7));
    kml_placeSatellite(file,eph(satList(minPDOPi(sat),2),:),tst,description);
    kml_drawPath(file,[lat lon h; kml_sat_matrix(sat,2:4)],'green');
end

kml_close(file);

end