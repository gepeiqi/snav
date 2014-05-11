function file = kml_open(filename)
%KML_OPEN Starts writing a kml file

file=fopen(sprintf('%s.kml',filename),'wt');

fprintf(file,'<?xml version="1.0" encoding="UTF-8"?>');
fprintf(file,'\n<kml xmlns="http://www.opengis.net/kml/2.2">');
fprintf(file,'\n<Document>');

end

