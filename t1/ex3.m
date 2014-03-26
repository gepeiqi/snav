N=dms2d(38,45,30);
S=dms2d(38,41,40);
W=dms2d(-9,19,59);
E=dms2d(-9,7,00);

avlat=(N+S)/2;
avlon=(W+E)/2;
a1=6378388;
f=1/297;
b1=a1*(1-f);
e1=sqrt(1-(1-f)^2);

delta_a=-251;
delta_f=-0.14192702*10^-4;
delta_x=-84;
delta_y=-107;
delta_z=-102;

[lat,lon,alt]=molodensky(avlat, avlon, 0, a1, b1, e1, delta_a, delta_f, delta_x, delta_y, delta_z);