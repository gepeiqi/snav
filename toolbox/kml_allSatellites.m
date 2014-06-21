function kml_allSatellites()
%KML_ALLSATELLITES Creates a KML file with all the satellites from a eph
%file

tst=getcurrenttime;

latestparsed=fopen('latestparsed','r+');
eph_file=sprintf('%s.eph',fscanf(latestparsed,'%s'));
fclose(latestparsed);

eph=load(eph_file);

filename=sprintf('%d',uint32(tst));

file=kml_open(filename);
kml_addSatelliteStyles(file);



for sat=1:size(eph,1);
    kml_placeSatellite(file,eph(sat,:),tst);
end

kml_close(file)

end

