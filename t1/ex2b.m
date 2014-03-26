file = fopen('nswa1.nmea');

counter=0;
fails=[];
countfail=0;

message = fgetl(file);

while ischar(message)
    if message(1)=='$'
        counter=counter+1;
        [status]=parsenmea(message);
        switch status
            case 'fail'
                countfail=countfail+1;
                fails=[fails; counter];
        end
    end
    message = fgetl(file);
end