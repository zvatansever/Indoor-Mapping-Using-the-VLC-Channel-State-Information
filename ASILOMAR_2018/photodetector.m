function [ranges,angles,visible] = photodetector( robotPos, LedPos , max_range, VLC_noise )

theta=60;
m=-log10(2)/log10(cosd(theta));
P_total=20;
Adet=1e-4;
Ts=1;
index=1;
G_Con=1;
h=3;

relativePos = LedPos - repmat(robotPos(1:2),1,length(LedPos));

for k=1:length(LedPos)
    
    D=sqrt((robotPos(1)-LedPos(1,k)).^2+(robotPos(2)-LedPos(2,k)).^2+h^2);
    P_rec=((m+1)*Adet*h^(m+1)*P_total)./(2*pi.*D.^(m+3));
    noise=sqrt(VLC_noise); %std of noise
    snr=10*log10((P_rec.^2)./noise^2);
    SNR= max(real(snr(:)));
    [a b]=size(P_rec);
    P_rec= P_rec+ abs(noise * randn(a,b));
    distance=(((m+1)/(2*pi))*Adet*h^(m+1).*(P_total./P_rec)).^(1/(m+3));
    ranges(k)=real(sqrt(distance.^2-h^2));   
end

    visible = find(ranges <= max_range);
    measures = relativePos(:,visible);
    ranges = ranges(visible);
    angles = wrapToPi(atan2(measures(2,:), measures(1,:)) - robotPos(3));
end