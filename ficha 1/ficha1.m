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

for j=1:counter
    message = fgetl(file);
    if message(2:6)=='GPGGA'
        disp(message)
    else continue
    end
end
    