clc
clear
data=load('eph.eph');

c=3e8;
X1=4918526.668;
Y1=-791212.115;
Z1=3969767.140;

[lat,lon,~]=xyz2llh(X1,Y1,Z1);

t=0:3600;
t=t';
minelev=10;

WN=1693;
t=t+213984;

R=zeros(size(t,1),size(data,1));

for i=1:size(t,1)
    for s=1:size(data,1)
        [X,Y,Z]=satpos(data(s,1:end),t(i),WN);
        [E,N,U]=ecef2enu(X1,Y1,Z1,lat,lon,X,Y,Z);
        [az,el]=azelev(E,N,U);
        if el<minelev
            continue
        else
            R(i,s)=distance(0,0,0,E,N,U);
        end
    end       
end

figure();
plot(t,R(1:end,1),t,R(1:end,2),t,R(1:end,3),t,R(1:end,4),t,R(1:end,5),t,R(1:end,6),t,R(1:end,7),t,R(1:end,8));
legend(int2str(data(1,1)),int2str(data(2,1)),int2str(data(3,1)),int2str(data(4,1)),int2str(data(5,1)),int2str(data(6,1)),int2str(data(7,1)),int2str(data(8,1)))

pseudoR=R;
for i=1:size(pseudoR,1)
    for j=1:size(pseudoR,2)
        pseudoR(i,j)=pseudoR(i,j)+c*(500e-6+0.4e-6*(i-1));
    end
end

figure();
for i=1:size(R,2)
    plot(t,R(1:end,i),t,pseudoR(1:end,i));
    title(sprintf('SVN %d',data(i,1)));
    legend('True Range','Pseudo-Range');
    pause('on');
    pause;
end