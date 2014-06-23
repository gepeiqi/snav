function kml_addBlipStyle(file)
%KML_ADDBLIPSTYLE Adds the blip icon to the kml file

fprintf(file,'\n\t<Style id="blipStyle">');
fprintf(file,'\n\t\t<IconStyle>');
fprintf(file,'\n\t\t\t<Icon><href>http://i.imgur.com/W1kp2Cl.png</href></Icon>');
fprintf(file,'\n\t\t\t<scale>12</scale>');
fprintf(file,'\n\t\t</IconStyle>');
fprintf(file,'\n\t</Style>');


end

