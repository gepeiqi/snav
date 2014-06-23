function kml_addSatelliteStyles(file)
%KML_ADDSATELLITESTYLES Adds the two Satellite styles to the kml file

fprintf(file,'\n\t<Style id="satelliteStyle">');
fprintf(file,'\n\t\t<IconStyle>');
fprintf(file,'\n\t\t\t<Icon><href>http://i.imgur.com/kABV40x.png</href></Icon>');
fprintf(file,'\n\t\t\t<scale>16</scale>');

fprintf(file,'\n\t\t</IconStyle>');
fprintf(file,'\n\t</Style>');
fprintf(file,'\n\t<Style id="shadowStyle">');
fprintf(file,'\n\t\t<IconStyle>');
fprintf(file,'\n\t\t\t<Icon><href>http://i.imgur.com/ToSXvb9.png</href></Icon>');
fprintf(file,'\n\t\t\t<color>55ffffff</color>');
fprintf(file,'\n\t\t</IconStyle>');
fprintf(file,'\n\t</Style>');

end

