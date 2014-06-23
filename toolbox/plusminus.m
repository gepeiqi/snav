function out = plusminus(in)
%PLUSMINUS convert 0/1 binary sequence to -1/1

out=zeros(size(in,1),1);

for i=1:size(in,1)
    if in(i)==1
        out(i)=in(i);
    elseif in(i)==0
        out(i)=-1;
    end
end

