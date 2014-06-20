function getlatestdata()
%GETLATESTDATA Parse the latest UB file

latestfile=fopen('latestfile','r');
latestfilename=fscanf(latestfile,'%s');
fclose(latestfile);

latestparsed=fopen('latestparsed','r+');
latestparsedname=fscanf(latestparsed,'%s');
fclose(latestparsed);

if not(strcmp(latestfilename,latestparsedname));
    ubfile=fopen(latestfilename,'r');
    ub=fread(ubfile);
    data=geteph(ub);
    eph_file=fopen(sprintf('%s.eph',latestfilename),'w+');
    for sat=1:size(data,1)
        for parameter=1:size(data,2)
            fprintf(eph_file,'%s ',num2str(data(sat,parameter)));
        end
        fprintf(eph_file,'\n');
    end
    fclose(latestparsed);
    latestparsed=fopen('latestparsed','w+');
    fprintf(latestparsed,'%s',latestfilename);
end

end

