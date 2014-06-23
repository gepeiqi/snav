function r = recpos(cons,pseudoRanges,r0)
%RECPOS Summary of this function goes here
%   Detailed explanation goes here

if size(cons,1)~=size(pseudoRanges,1)
    fprintf('number of satellites and number of pseudoranges dont match, aborting');
    return
end

delta_d=500;

while delta_d>0.001
    e=zeros(size(cons,1),3);
    H=zeros(size(cons,1),4);
    z=zeros(size(cons,1),1);
    Q=eye(size(cons,1));
    
    for s=1:size(cons,1)
        for l=1:3
            e(s,l)=(cons(s,l+1)-r0(l))/distance(cons(s,2),cons(s,3),cons(s,4),r0(1),r0(2),r0(3));
            H(s,l)=-e(s,l);
        end
        
        z(s)=pseudoRanges(s)-dot(e(s,1:end),cons(s,2:end));
        H(s,4)=1;
    end
    
    r=(H'*Q*H)\H'*Q*z;
    r=r(1:3);
    delta_d=distance(r0(1),r0(2),r0(3),r(1),r(2),r(3));
    r0=r(1:3);
end

