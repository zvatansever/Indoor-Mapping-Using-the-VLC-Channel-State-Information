function [ los_power, robot_pos, time, time_nlos, P_received, P_nlos,h2,P_2,P_4,t_2,t_4 ] = peak_power( robot,lx, ly,XT,YT)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

theta=60;
% semi-angle at half power
m=-log10(2)/log10(cosd(theta));
%Lambertian order of emission
%Total transmitted power
Adet=1e-4;
%detector physical area of a PD
rho=0.8;
%reflection coefficient
Ts=1;
%gain of an optical filter; ignore if no filter is used
index=1;
%refractive index of a lens at a PD; ignore if no lens is used
FOV=90;
%FOV of a receiver
% G_Con=(index^2)/(sind(FOV).^2);
G_Con=1;
%gain of an optical concentrator; ignore if no lens is used

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
lz=3;
% room dimension in meter
% [XT,YT,ZT]=meshgrid([-lx/4 lx/4],[-ly/4 ly/4],lz/2);
ZT=lz;
% position of Transmitter (LED);
Nx=lx*10; Ny=ly*10; Nz=lz*10;
% number of grid in each surface
dA=lz*ly/(Ny*Nz);
% calculation grid area
x=linspace(0,lx,Nx);
y=linspace(0,ly,Ny);
z=linspace(0.1,lz,Nz);
[XR,YR]=meshgrid(x,y);

RP=[ robot(1), robot(2), 0];
TP1=[XT YT ZT];

C=3e8;
%  h_los=zeros(Nx,Ny);
h_los=0;
%%%%%%%%%%%%%%%calculation of LOS%%%%%%%%%%%%%%%%%%
% receiver position vector
% LOS channel gain
DL1=sqrt(dot(TP1-RP,TP1-RP));
cosphi=lz/DL1;
tau_los=DL1/C;
if abs(acosd(cosphi))<=FOV
    h_los=h_los(index)+(m+1)*Adet.*cosphi^(m+1)./(2*pi.*DL1.^2);
else
    h_los=0;
end
los_power=h_los;
robot_pos=RP;


% h1=zeros(Ny,Nz);
% position vector for wall 1
% for kk=1:Ny
%     for ll=1:Nz
%         WP1=[0 y(kk) z(ll)];
%         D1=sqrt(dot(TP1-WP1,TP1-WP1));
%         cos_phi=abs(WP1(3)-TP1(3))/D1;
%         cos_alpha=abs(TP1(1)-WP1(1))/D1;
%         D2=sqrt(dot(WP1-RP,WP1-RP));
%         cos_beta=abs(WP1(1)-RP(1))/D2;
%         cos_psi=abs(WP1(3)-RP(3))/D2;
%         tau_wall1(kk,ll)=(D1+D2)/C;
%         if abs(acosd(cos_psi))<=FOV
%             h1(kk,ll)=h1(kk,ll)+(m+1)*Adet*rho*dA*cos_phi^m*cos_alpha*cos_beta*cos_psi/(2*pi^2*D1^2*D2^2);
%         else
%             h1(kk,ll)=0;
%         end
%     end
% end


WPV2=[0 1 0];
% position vector for wall 2
h2=zeros(Nx,Nz);
for kk=1:Nx
    for ll=1:Nz
        WP2=[x(kk) 0 z(ll)];
        D1=sqrt(dot(TP1-WP2,TP1-WP2));
        cos_phi= abs(WP2(3)-TP1(3))/D1;
        cos_alpha=abs(TP1(2)-WP2(2))/D1;
        D2=sqrt(dot(WP2-RP,WP2-RP));
        cos_beta=abs(WP2(2)-RP(2))/D2;
        cos_psi=abs(WP2(3)-RP(3))/D2;
        tau_wall2(kk,ll)=(D1+D2)/C;
        if abs(acosd(cos_psi))<=FOV
            h2(kk,ll)=h2(kk,ll)+(m+1)*Adet*rho*dA*cos_phi^m*cos_alpha*cos_beta*cos_psi/(2*pi^2*D1^2*D2^2);
        else
            h2(kk,ll)=0;
        end
    end
end



% h3=zeros(Ny,Nz);
% for kk=1:Ny
%     for ll=1:Nz
%         WP3=[lx y(kk) z(ll)];
%         D1=sqrt(dot(TP1-WP3,TP1-WP3));
%         cos_phi= abs(WP3(3)-TP1(3))/D1;
%         cos_alpha=abs(TP1(1)-WP3(1))/D1;
%         D2=sqrt(dot(WP3-RP,WP3-RP));
%         cos_beta=abs(WP3(1)-RP(1))/D2;
%         cos_psi=abs(WP3(3)-RP(3))/D2;
%         tau_wall3(kk,ll)=(D1+D2)/C;
% 
%         if abs(acosd(cos_psi))<=FOV
%             h3(kk,ll)=h3(kk,ll)+(m+1)*Adet*rho*dA*cos_phi^m*cos_alpha*cos_beta*cos_psi/(2*pi^2*D1^2*D2^2);
%         else
%             h3(kk,ll)=0;
%         end
%     end
% end

h4=zeros(Nx,Nz);

for kk=1:Nx
    for ll=1:Nz
        WP4=[x(kk) ly z(ll)];
        D1=sqrt(dot(TP1-WP4,TP1-WP4));
        cos_phi= abs(WP4(3)-TP1(3))/D1;
        cos_alpha=abs(TP1(2)-WP4(2))/D1;
        D2=sqrt(dot(WP4-RP,WP4-RP));
        cos_beta=abs(WP4(2)-RP(2))/D2;
        cos_psi=abs(WP4(3)-RP(3))/D2;
        tau_wall4(kk,ll)=(D1+D2)/C;

        if abs(acosd(cos_psi))<=FOV
            h4(kk,ll)=h4(kk,ll)+(m+1)*Adet*rho*dA*cos_phi^m*cos_alpha*cos_beta*cos_psi/(2*pi^2*D1^2*D2^2);
        else
            h4(kk,ll)=0;
        end
    end
end


% t_los=reshape(tau_los,1,1);
%  t_1=reshape(tau_wall1,1,Ny*Nz);
% % t_2=reshape(tau_wall2,1,Ny*Nz);
%  t_3=reshape(tau_wall3,1,Ny*Nz);
% % t_4=reshape(tau_wall4,1,Ny*Nz);

t_los=reshape(tau_los,1,1);
% t_1=reshape(tau_wall1,1,Ny*Nz);
 t_2=reshape(tau_wall2,1,Nx*Nz);
% t_3=reshape(tau_wall3,1,Ny*Nz);
 t_4=reshape(tau_wall4,1,Nx*Nz);
 
% P_los=reshape(h_los,1,1);
%  P_1=reshape(h1,1,Ny*Nz);
% % P_2=reshape(h2,1,Ny*Nz);
%  P_3=reshape(h3,1,Ny*Nz);
% % P_4=reshape(h4,1,Ny*Nz);

P_los=reshape(h_los,1,1);
% P_1=reshape(h1,1,Ny*Nz);
 P_2=reshape(h2,1,Nx*Nz);
% P_3=reshape(h3,1,Ny*Nz);
 P_4=reshape(h4,1,Nx*Nz);

% time=[t_los t_1 t_2 t_3 t_4];
% time=round(time.*10^10);
% P_received=[P_los P_1 P_2 P_3 P_4];

time=[t_los t_2 t_4 ];
time=round(time.*10^10);
P_received=[P_los P_2  P_4 ];
time_nlos=[t_2 t_4 ];
 time_nlos=round(time_nlos.*10^10);
P_nlos=[ P_2 P_4];
end

