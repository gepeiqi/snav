function kml_close(file)
%KML_CLOSE Closes a kml file

fprintf(file,'\n</Document>');
fprintf(file,'\n</kml>');

end

