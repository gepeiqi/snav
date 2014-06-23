function getlatestdata()
%GETLATESTDATA Parse the latest UB file

% Comparison of the latest downloaded and latest parsed file
latestfile=fopen('latestfile','r');
latestfilename=fscanf(latestfile,'%s');
fclose(latestfile);

latestparsed=fopen('latestparsed','r+');
latestparsedname=fscanf(latestparsed,'%s');
fclose(latestparsed);

% If the latest downloaded and latest parsed file don't have the same name,
% it means we have a new file to parse:
if not(strcmp(latestfilename,latestparsedname));
    % Open the u-blox file to retrive the ephemeris
    ubfile=fopen(latestfilename,'r');
    ub=fread(ubfile);
    data=geteph(ub);
    
    % Open a new file to store the ephemeris
    eph_file=fopen(sprintf('%s.eph',latestfilename),'w+');
    for sat=1:size(data,1)
        for parameter=1:size(data,2)
            fprintf(eph_file,'%s ',num2str(data(sat,parameter)));
        end
        fprintf(eph_file,'\n');
    end
    
    % Close the ephemeris file and change 'latestparsed' to the file we
    % just processed.
    fclose(latestparsed);
    latestparsed=fopen('latestparsed','w+');
    fprintf(latestparsed,'%s',latestfilename);
end

end

