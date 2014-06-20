function G1 = g1
%G1 G1 sequence generator

G1=zeros(1023,1);
sr=ones(10,1);

for i=1:1023
    G1(i)=sr(10);
    sr=[bitxor(sr(3),sr(10));sr(1:9)];
end
end

