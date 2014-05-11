function kml_drawPath(file,path,color)
%KML_DRAWPATH Draws a colored path on the kml file

fprintf(file,'\n\t<Placemark>');
fprintf(file,'\n\t\t<styleUrl>#%sLineStyle</styleUrl>',color);
fprintf(file,'\n\t\t<LineString>');
fprintf(file,'\n\t\t\t<altitudeMode>absolute</altitudeMode>');
fprintf(file,'\n\t\t\t<coordinates>');
for l=1:size(path,1)
    fprintf(file,'\n\t\t\t  %f,%f,%f',path(l,2),path(l,1),path(l,3));
end
fprintf(file,'\n\t\t\t</coordinates>');
fprintf(file,'\n\t\t</LineString>');
fprintf(file,'\n\t</Placemark>');
end

