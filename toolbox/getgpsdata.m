function [DATA] = getgpsdata
%GETGPSDATA Retrieves ephemeris matrix from internet data
%   Scans the most recent YUMA almanac from
% https://celestrak.com/GPS/almanac/Yuma/almanac.yuma.txt
% and parses the information into a matrix with the ephemeris data.

%Reading the almanac into a (large) string
YUMA=urlread('https://celestrak.com/GPS/almanac/Yuma/almanac.yuma.txt');

%Parsing the information into a string matrix
YUMAcell=textscan(YUMA,'%s');
DATA = zeros(31,79);
for id=1:31
    %Final arrangement of the ephemeris data. This arrangement of the
    %parsed almanac is correct as of May 11th, 2014.
    DATA(id,1)=str2double(cell2mat(YUMAcell{1,1}(9+47*(id-1),1)));
    DATA(id,43)=str2double(cell2mat(YUMAcell{1,1}(13+47*(id-1),1)));
    DATA(id,7)=str2double(cell2mat(YUMAcell{1,1}(17+47*(id-1),1)));
    DATA(id,49)=str2double(cell2mat(YUMAcell{1,1}(20+47*(id-1),1)));
    DATA(id,58)=str2double(cell2mat(YUMAcell{1,1}(25+47*(id-1),1)));
    DATA(id,34)=str2double(cell2mat(YUMAcell{1,1}(29+47*(id-1),1)));
    DATA(id,55)=str2double(cell2mat(YUMAcell{1,1}(34+47*(id-1),1)));
    DATA(id,46)=str2double(cell2mat(YUMAcell{1,1}(38+47*(id-1),1)));
    DATA(id,40)=str2double(cell2mat(YUMAcell{1,1}(41+47*(id-1),1)));
end
end