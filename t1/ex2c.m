file = fopen('nswa1.nmea');

message = fgetl(file);

llh=[];

while ischar(message)
    if message(1)=='$'
        [status,data]=parsenmea(message);
        switch status
            case 'GPGGA'
                lat=data(2);
                lon=data(3);
                alt=data(8);
                llh=[llh;lat lon alt];
        end
    end
    message = fgetl(file);
end

d=0;

[oldx,oldy,oldz]=llh2xyz(llh(1,1),llh(1,2),llh(1,3));

for l=2:size(llh,1)
    [x,y,z]=llh2xyz(llh(l,1),llh(l,2),llh(l,3));
    d=d+sqrt((x-oldx)^2+(y-oldy)^2+(z-oldz)^2);
    oldx=x;
    oldy=y;
    oldz=z;
end

fprintf('Total distance: %f m\n',d);