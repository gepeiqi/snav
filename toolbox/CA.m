function CA = CA(SVN)
%CA generation of C/A code for satellite SVN

% Table of the register you're supposed to XOR to obtain the C/A code.
xorTable=[2 6;3 7;4 8;5 9;1 9;2 10;1 8;2 9;3 10;2 3;3 4;5 6;6 7;7 8;8 9;
    9 10;1 4;2 5;3 6;4 7;5 8;6 9;1 3;4 6;5 7;6 8;7 9;8 10;1 6;2 7;3 8;4 9];

% Initial declaration of the registers and sequences.
G1=zeros(1023,1);
sr1=ones(10,1);
G2=zeros(1023,1);
sr2=ones(10,1);
CA=zeros(1023,1);

% Generation of the G1 and G2 sequences, as well as the corresponding C/A
% code
for i=1:1023
    G1(i)=sr1(10);
    G2(i)=sr2(10);
    CA(i)=bitxor(G1(i),bitxor(sr2(xorTable(SVN,1)),sr2(xorTable(SVN,2))));
    sr1=[bitxor(sr1(3),sr1(10));sr1(1:9)];
    sr2=[bitxor(sr2(2),bitxor(sr2(3),bitxor(sr2(6),bitxor(sr2(8),bitxor(sr2(9),sr2(10))))));sr2(1:9)];
end
end

