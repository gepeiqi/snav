file = fopen('ISTShuttle.nmea');

counter = 0;

message = fgetl(file);

while ischar(message)
    if message(1)=='$'
        counter=counter+1;
    end
    message = fgetl(file);
end

str=sprintf('There are %d messages', counter);
disp(str)

frewind(file);

data=[];
v=[];
nsv=[];
elev=[];

for j=1:counter
    message = fgetl(file);
    chkmsg=message(2:size(message,2)-3);
    chksum=message(size(message,2)-1:size(message,2));
    chkmsg=uint8(chkmsg);
    chk=0;
    for i=1:size(chkmsg,2)
        chk=bitxor(chk,chkmsg(i));
    end
    chksum=hex2dec(chksum);
    
%     if chksum==chk
%         display('checksums match')
%     else
%         display('checksums dont match')
%         continue
%     end
    
    if strcmp(message(2:6),'GPGGA')==1
        data=[data;zeros(1,8)];
        message=message(8:end);
        [input,message]=strtok(message,',');
        input=str2num(input);
        data(end,1)=input;
        message=message(2:end);
        [input,message]=strtok(message,',');
        degrees=str2num(input(1:2));
        minutes=str2num(input(3:end));
        
        input=degrees+minutes/60;
        if message(2)=='N', data(end,2)=input;
        else data(end,2)=-input;
        end
        
        message=message(4:end);
        
        [input,message]=strtok(message,',');
        
        degrees=str2num(input(1:3));
        minutes=str2num(input(4:end));
        
        input=degrees+minutes/60;
        if message(2)=='E', data(end,3)=input;
        else data(end,3)=-input;
        end
        
        message=message(4:end);
        [input,message]=strtok(message,',');
        if strcmp(input,'0')==1
            [data,~]=removerows(data,size(data,1));
            continue;
        end
        data(end,4)=str2num(input);
        message=message(2:end);
        [input,message]=strtok(message,',');
        data(end,5)=str2num(input);
        message=message(2:end);
        [input,message]=strtok(message,',');
        data(end,6)=str2num(input);
        message=message(2:end);
        [input,message]=strtok(message,',');
        data(end,7)=str2num(input);
        message=message(4:end);
        [input,message]=strtok(message,',');
        data(end,8)=str2num(input);
    elseif strcmp(message(2:6),'GPVTG')==1
        message=message(8:end);
        for i=1:5
            [input,message]=strtok(message,',');
        end
        message=message(2:end);
        [vk,~]=strtok(message,',');
        vk=str2num(vk);
        v(size(v)+1)=vk;
    elseif strcmp(message(2:6),'GPGSV')==1
        message=message(8:end);
        for i=1:2
            [input,message]=strtok(message,',');
        end
        message=message(2:end);
        [nsvk,message]=strtok(message,',');
        nsvk=str2num(nsvk);
        nsv(size(nsv)+1)=nsvk;
        while size(message,2)>10
            message=message(2:end);
            elev=[elev;zeros(1,2)];
            [is,message]=strtok(message,',');
            message=message(2:end);
            [angle,message]=strtok(message,',');
            elev(end,1)=str2num(is);
            elev(end,2)=str2num(angle);
            [~,message]=strtok(message,',');
            if (size(message,2)~=0) && (message(2)==',')
                message=message(3:end);
                continue
            elseif size(message,2)~=0
                [~,message]=strtok(message,',');
            end
        end
    else continue
    end
end

minlat=min(data(:,2));
maxlat=max(data(:,2));
minlon=min(data(:,3));
maxlon=max(data(:,3));
minalt=min(data(:,7));
maxalt=max(data(:,7));

maxv=max(v);
maxnsv=max(nsv);

ce=0;

for i=2:size(data,1)
    dh=data(i,7)-data(i-1,7);
    if dh>0
        ce=ce+dh;
    end
end

maxelev=zeros(1,2);
for i=1:size(elev,1)
    if elev(i,2)>maxelev(2)
        maxelev=elev(i,:);
    end
end
