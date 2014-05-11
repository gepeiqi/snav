file=kml_open('coise');
eph=getgpsdata;
kml_addSatelliteStyles(file);
kml_addPathStyles(file);
kml_addGroundStyle(file);
kml_addBlipStyle(file);

time=-3600:60:3600;
time=time';
tst=getcurrenttime;

for s=1:size(eph,1)
    data=eph(s,1:end);
    kml_placeSatellite(file,data,tst);
    path=zeros(size(time,1),3);
    path2=zeros(21,3);
    
    for i=1:5
        [X,Y,Z]=satpos(data,tst-120*i,data(4));
        [lat,lon,~]=xyz2llh(X,Y,Z);
        alt=2500000;
        kml_addPlacemark(file,'','',[lat,lon,alt],'blip');
    end
    
    for i=0:20
        [X,Y,Z]=satpos(data,tst+60*i,data(4));
        [path2(i+1,1),path2(i+1,2),~]=xyz2llh(X,Y,Z);
        path2(i+1,3)=2500000;
    end
    
    kml_drawPath(file,path2,'green');
    
%     for i=1:size(time,1)
%         [X,Y,Z]=satpos(data,tst+time(i),data(4));
%         [path(i,1),path(i,2),~]=xyz2llh(X,Y,Z);
%         path(i,3)=2500000;
%     end
%     
%     kml_drawPath(file,path,'blue');
end

kml_addPlacemark(file,'My house','',[39.231508,-8.683994,0],'ground')
kml_close(file); 