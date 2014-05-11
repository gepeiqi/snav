function kml_addGroundStyle(file)
%KML_ADDGROUNDSTYLE Adds ground station icon style to kml file


fprintf(file,'\n\t<Style id="groundStyle">');
fprintf(file,'\n\t\t<IconStyle>');
fprintf(file,'\n\t\t\t<Icon><href>http://i.imgur.com/RJWpR1A.png</href></Icon>');
fprintf(file,'\n\t\t</IconStyle>');
fprintf(file,'\n\t</Style>');

end

