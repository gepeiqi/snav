function [status,data] = parsenmea(s)
%PARSENMEA Parsing of an NMEA message
%   Parses NMEA message string s. First return is a string with the status
%   of the message: might have the type of message, or 'fail' if the
%   checksum does not match the message. Consequent returns are the 

status=s(2:6);

switch status
    case 'GPGGA'
        disp('esta é uma mensagem gga')
        data=zeros(10,1);
        message=s(8:end);
        [input,message]=strtok(message,',');
        data(1)=str2double(input);
        message=message(2:end);
        [input,message]=strtok(message,',');
        degrees=str2double(input(1:2));
        minutes=str2double(input(3:end));
        input=degrees+minutes/60;
        if message(2)=='N', data(2)=input;
        else data(2)=-input;
        end
        message=message(4:end);
        [input,message]=strtok(message,',');
        degrees=str2double(input(1:3));
        minutes=str2double(input(4:end));
        input=degrees+minutes/60;
        if message(2)=='E', data(3)=input;
        else data(3)=-input;
        end
        message=message(4:end);
        [input,message]=strtok(message,',');
        data(4)=str2double(input);
        message=message(2:end);
        [input,message]=strtok(message,',');
        data(5)=str2double(input);
        message=message(2:end);
        [input,message]=strtok(message,',');
        data(6)=str2double(input);
        message=message(2:end);
        [input,message]=strtok(message,',');
        data(7)=str2double(input);
        message=message(4:end);
        [input,message]=strtok(message,',');
        data(8)=str2double(input);
        message=message(4:end);
        [input,message]=strtok(message,',');
        data(9)=str2double(input);
        message=message(2:end);
        [input,message]=strtok(message,',');
        data(10)=str2double(input);
    case 'GPGSV'
        disp('esta é uma mensagem gsv')
    case 'GPRMC'
        disp('esta é uma mensagem rmc')
end

chkmsg=s(2:size(s,2)-3);
chksum=s(size(s,2)-1:size(s,2));
chkmsg=uint8(chkmsg);
chk=0;
for i=1:size(chkmsg,2)
    chk=bitxor(chk,chkmsg(i));
end
chksum=hex2dec(chksum);
    
if chksum==chk
    display('checksum is OK')
else
    display('checksum is not OK')
    data='fail';
end