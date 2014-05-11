function kml_addPlacemark(file,name,description,coordinates,style)
%KML_ADDPLACEMARK Adds a placemark to the kml file

fprintf(file,'\n\t<Placemark>');
fprintf(file,sprintf('\n\t\t<name>%s</name>',name));
fprintf(file,sprintf('\n\t\t<description>%s</description>',description));
fprintf(file,sprintf('\n\t\t<styleUrl>#%sStyle</styleUrl>',style));



fprintf(file,'\n\t\t<Point>');

if strcmp(style,'satellite')
    fprintf(file,'\n\t\t\t<extrude>1</extrude>');
    fprintf(file,'\n\t\t\t<altitudeMode>absolute</altitudeMode>');
end

fprintf(file,sprintf('\n\t\t\t<coordinates>%f,%f,%f</coordinates>',coordinates(2),coordinates(1),coordinates(3)));
fprintf(file,'\n\t\t</Point>');

fprintf(file,'\n\t</Placemark>');
end

