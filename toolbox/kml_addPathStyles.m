function kml_addPathStyles(file)
%KML_ADDPATHSTYLES Adds different path styles to the KML file

fprintf(file,'\n\t<Style id="redLineStyle">');
fprintf(file,'\n\t\t<LineStyle>');
fprintf(file,'\n\t\t\t<color>FF1400FF</color>');
fprintf(file,'\n\t\t\t<width>4</width>');
fprintf(file,'\n\t\t</LineStyle>');
fprintf(file,'\n\t</Style>');
fprintf(file,'\n\t<Style id="greenLineStyle">');
fprintf(file,'\n\t\t<LineStyle>');
fprintf(file,'\n\t\t\t<color>FF14F000</color>');
fprintf(file,'\n\t\t\t<width>4</width>');
fprintf(file,'\n\t\t</LineStyle>');
fprintf(file,'\n\t</Style>');
fprintf(file,'\n\t<Style id="blueLineStyle">');
fprintf(file,'\n\t\t<LineStyle>');
fprintf(file,'\n\t\t\t<color>FFF00014</color>');
fprintf(file,'\n\t\t\t<width>4</width>');
fprintf(file,'\n\t\t</LineStyle>');
fprintf(file,'\n\t</Style>');

end

