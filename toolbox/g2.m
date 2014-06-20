function G2 = g2
%G2 G2 sequence generator

G2=zeros(1023,1);
sr=ones(10,1);

for i=1:1023
    G2(i)=sr(10);
    sr=[bitxor(sr(2),bitxor(sr(3),bitxor(sr(6),bitxor(sr(8),bitxor(sr(9),sr(10))))));sr(1:9)];
end
end

