function tst = getcurrenttime
%GETCURRENTTIME Get current week time in seconds

format long
c=clock;
hours=c(1,4);
minutes=c(1,5);
seconds=c(1,6);

switch c(1,2)
    case 1
        month='Jan';
    case 2
        month='Feb';
    case 3
        month='Mar';
    case 4
        month='Apr';
    case 5
        month='May';
    case 6
        month='Jun';
    case 7
        month='Jul';
    case 8
        month='Aug';
    case 9
        month='Sep';
    case 10
        month='Oct';
    case 11
        month='Nov';
    case 12
        month='Dec';
end

data=strcat(num2str(c(1,3)),'-',month,'-',num2str(c(1,1)));
[weekd,~]=weekday(data);
tst=(weekd-1)*86400 + hours*3600 + minutes*60 + seconds;

end

