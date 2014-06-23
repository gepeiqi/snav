function eph = geteph(data)
%GETEPH Parse UBX file to get ephemeris content

% Initial declaration of the ephemeris matrix, satellite count, and read
% messages count.
eph=zeros(1,79);
SVcount=0;
readMessages=0;

% Just so the program doesn't sit there forever, we're reading until there
% are 12 satellites in the ephemeris file, and at least 500 read messages.
while or(size(eph,1)<12,readMessages<500)
    header=data(1:4);
    if and(header(3)==11,header(4)==49)
        payload=data(7:6+data(5)+data(6)*256);
        
        % Payload size
        payloadLSB=dec2bin(data(5),8);
        payloadMSB=dec2bin(data(6),8);
        payloadLength=bin2dec(cat(2,payloadMSB,payloadLSB));
        if payloadLength==104
            % Satellite ID
            SVN_bin=cat(2,dec2bin(payload(4,1),8),dec2bin(payload(3,1),8),...
                dec2bin(payload(2,1),8),dec2bin(payload(1,1),8));
            SVN=bin2dec(SVN_bin);
            
            if ismember(SVN,eph(:,1));
                data=data(9+data(5)+data(6)*256:end);
                readMessages=readMessages+1;
                clearvars -except data SVcount readMessages eph
                continue
            end
            
            SVcount=SVcount+1; 
            eph(SVcount,1)=SVN;
            
%             how_bin=cat(2,dec2bin(payload(8,1),8),dec2bin(payload(7,1),8),...
%                 dec2bin(payload(6,1),8),dec2bin(payload(5,1),8));
%             how=bin2dec(how_bin);
            
            SF1=payload(9:40);
            SF2=payload(41:72);
            SF3=payload(73:end);
            
            % Declaration of the subframe words
            
            SF1D0_bin=cat(2,dec2bin(SF1(3),8),dec2bin(SF1(2),8),dec2bin(SF1(1),8));
%             SF1D1_bin=cat(2,dec2bin(SF1(7),8),dec2bin(SF1(6),8),dec2bin(SF1(5),8));
%             SF1D2_bin=cat(2,dec2bin(SF1(11),8),dec2bin(SF1(10),8),dec2bin(SF1(9),8));
%             SF1D3_bin=cat(2,dec2bin(SF1(15),8),dec2bin(SF1(14),8),dec2bin(SF1(13),8));
%             SF1D4_bin=cat(2,dec2bin(SF1(19),8),dec2bin(SF1(18),8),dec2bin(SF1(17),8));
%             SF1D5_bin=cat(2,dec2bin(SF1(23),8),dec2bin(SF1(22),8),dec2bin(SF1(21),8));
%             SF1D6_bin=cat(2,dec2bin(SF1(27),8),dec2bin(SF1(26),8),dec2bin(SF1(25),8));
%             SF1D7_bin=cat(2,dec2bin(SF1(31),8),dec2bin(SF1(30),8),dec2bin(SF1(29),8));
            
            SF2D0_bin=cat(2,dec2bin(SF2(3),8),dec2bin(SF2(2),8),dec2bin(SF2(1),8));
            SF2D1_bin=cat(2,dec2bin(SF2(7),8),dec2bin(SF2(6),8),dec2bin(SF2(5),8));
            SF2D2_bin=cat(2,dec2bin(SF2(11),8),dec2bin(SF2(10),8),dec2bin(SF2(9),8));
            SF2D3_bin=cat(2,dec2bin(SF2(15),8),dec2bin(SF2(14),8),dec2bin(SF2(13),8));
            SF2D4_bin=cat(2,dec2bin(SF2(19),8),dec2bin(SF2(18),8),dec2bin(SF2(17),8));
            SF2D5_bin=cat(2,dec2bin(SF2(23),8),dec2bin(SF2(22),8),dec2bin(SF2(21),8));
            SF2D6_bin=cat(2,dec2bin(SF2(27),8),dec2bin(SF2(26),8),dec2bin(SF2(25),8));
            SF2D7_bin=cat(2,dec2bin(SF2(31),8),dec2bin(SF2(30),8),dec2bin(SF2(29),8));
            
            SF3D0_bin=cat(2,dec2bin(SF3(3),8),dec2bin(SF3(2),8),dec2bin(SF3(1),8));
            SF3D1_bin=cat(2,dec2bin(SF3(7),8),dec2bin(SF3(6),8),dec2bin(SF3(5),8));
            SF3D2_bin=cat(2,dec2bin(SF3(11),8),dec2bin(SF3(10),8),dec2bin(SF3(9),8));
            SF3D3_bin=cat(2,dec2bin(SF3(15),8),dec2bin(SF3(14),8),dec2bin(SF3(13),8));
            SF3D4_bin=cat(2,dec2bin(SF3(19),8),dec2bin(SF3(18),8),dec2bin(SF3(17),8));
            SF3D5_bin=cat(2,dec2bin(SF3(23),8),dec2bin(SF3(22),8),dec2bin(SF3(21),8));
            SF3D6_bin=cat(2,dec2bin(SF3(27),8),dec2bin(SF3(26),8),dec2bin(SF3(25),8));
            SF3D7_bin=cat(2,dec2bin(SF3(31),8),dec2bin(SF3(30),8),dec2bin(SF3(29),8));
            
            % Storage of the parameters according to IS-GPS-200 and the eph
            % format:
            
            % Week Number
            wn=bin2dec(SF1D0_bin(1:10));
            eph(SVcount,4)=wn;
            
%             P=bin2dec(SF1D0_bin(11:12));
            % URA Index
            URA=bin2dec(SF1D0_bin(13:16));
            eph(SVcount,11)=URA;
            
            
            % Time of ephemeris
            toe=bin2dec(SF2D7_bin(1:16))*2^4;
            eph(SVcount,7)=toe; 
            
            
            % Satellite Health Index
            SV_health=bin2dec(SF1D0_bin(17:22));
            eph(SVcount,10)=SV_health;
            
            
            % Square root of the semimajor axis
            sqrtA=bin2dec(cat(2,SF2D5_bin(17:24),SF2D6_bin))*2^-19;
            eph(SVcount,34)=sqrtA;
            
            
            % Correction to mean angular velocity
            deltaN_unscaled=typecast(uint16(bin2dec(SF2D1_bin(1:16))), 'int16');
            deltaN=pi*double(deltaN_unscaled)*2^-43;
            eph(SVcount,37)=deltaN;
            
            
            % Mean anomaly
            M0_unscaled=typecast(uint32(bin2dec(cat(2,SF2D1_bin(17:24),SF2D2_bin))),'int32');
            M0=pi*double(M0_unscaled)*2^-31;
            eph(SVcount,40)=M0;
            
            
            % Eccentricity
            e=bin2dec(cat(2,SF2D3_bin(17:24),SF2D4_bin))*2^-33;
            eph(SVcount,43)=e;            
            

            % Argument of perigee
            w_unscaled=typecast(uint32(bin2dec(cat(2,SF3D4_bin(17:24),SF3D5_bin))),'int32');  
            w=pi*double(w_unscaled)*2^-31;
            eph(SVcount,46)=w;            
            
            
            % Orbit inclination angle
            i0_unscaled=typecast(uint32(bin2dec(cat(2,SF3D2_bin(17:24),SF3D3_bin))),'int32');            
            i0=pi*double(i0_unscaled)*2^-31;
            eph(SVcount,49)=i0;
            
            
            % Rate of orbit inclination angle
            IDOT_bin=SF3D7_bin(9:22);
            if IDOT_bin(1)=='1'
                IDOT=-pi*double(bitcmp(bin2dec(IDOT_bin)+1,14))*2^-43;
            else
                IDOT=pi*double(bin2dec(IDOT_bin))*2^-43;
            end
            eph(SVcount,52)=IDOT;          
            
            % Longitude of ascending node
            Omega0_unscaled=typecast(uint32(bin2dec(cat(2,SF3D0_bin(17:24),SF3D1_bin))),'int32');
            Omega0=pi*double(Omega0_unscaled)*2^-31;
            eph(SVcount,55)=Omega0; 
            
            
            % Correction for the longitude of the right ascending node
            OmegaDot_bin=SF3D6_bin;
            if OmegaDot_bin(1)=='1'
                OmegaDot=-pi*double(bitcmp(bin2dec(OmegaDot_bin)+1,24))*2^-43;
            else
                OmegaDot=pi*double(bin2dec(OmegaDot_bin))*2^-43;
            end
            eph(SVcount,58)=OmegaDot;            

            % Harmonic correction coefficients for the argument of latitude
            cuc_unscaled=typecast(uint16(bin2dec(SF2D3_bin(1:16))), 'int16');
            cuc=double(cuc_unscaled)*2^-29;
            eph(SVcount,61)=cuc;

            cus_unscaled=typecast(uint16(bin2dec(SF2D5_bin(1:16))), 'int16');
            cus=double(cus_unscaled)*2^-29;
            eph(SVcount,64)=cus;
            
            
            % Harmonic correction coefficients for orbit radius
            crc_unscaled=typecast(uint16(bin2dec(SF3D4_bin(1:16))), 'int16');
            crc=double(crc_unscaled)*2^-5;
            eph(SVcount,67)=crc;            

            crs_unscaled=typecast(uint16(bin2dec(SF2D0_bin(9:24))), 'int16');
            crs=double(crs_unscaled)*2^-5;
            eph(SVcount,70)=crs;  
            

            % Harmonic correction coefficients for orbital inclination
            cic_unscaled=typecast(uint16(bin2dec(SF3D0_bin(1:16))), 'int16');
            cic=double(cic_unscaled)*2^-29;
            eph(SVcount,73)=cic;

            cis_unscaled=typecast(uint16(bin2dec(SF3D2_bin(1:16))), 'int16');
            cis=double(cis_unscaled)*2^-29;
            eph(SVcount,76)=cis;
        end
    end
    data=data(9+data(5)+data(6)*256:end);
    readMessages=readMessages+1;
    % Erase everything but control variables and data
    clearvars -except data SVcount readMessages eph
end
readMessages
end

