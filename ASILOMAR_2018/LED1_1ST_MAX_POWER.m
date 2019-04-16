clear all
close all
clc
rng(9999, 'twister')

%%
print_figures=1;
%%
set(0,'DefaultFigureWindowStyle','normal')

%%

load corridor_model veh_true veh_est mu1
veh_true=veh_true/10;
veh_est=veh_est/10;
%  veh_est=round(veh_est);
%  veh_true=round(veh_true);
%%

map_width = 10;
map_height = 2;


%% LEDs
% x_led = [10 30 50 70 90 90 90 90 90];
% y_led = [10 10 10 10 10 30 50 70 90];
x_led = [10 30 50 70 90 ]/10;
y_led = [10 10 10 10 10]/10;
xWall=[0 100 100 80 80 0 ]/10;
yWall=[0 0 100 100 20 20 ]/10;

% xWall=[0 100 100  0  0];
% yWall=[0   0  20 20  0];
if print_figures
    
    figure
    plot(veh_true(1,1:48), veh_true(2,1:48), 'b-',...
        xWall, yWall,'-k',...
        x_led(1),y_led(1),'yo',...
        'MarkerEdgeColor','k','markerfacecolor','y','markersize',12,'linewidth',2)
    
    grid on;
    % xlim([-5 105]);ylim([-5 105]);
    xlabel('x-Length (dm)')
    ylabel('y-Length (dm)')
    set(gca,'Fontsize',16)
    axis equal;
end
%% north-south
lx=map_width;
ly=map_height;
XT=x_led(1);
YT=y_led(1);


%%

% for i=17
i=32 % FIRST PEAK@17 SECOND PEAK@28
[ los_power1, robot_pos, time, time_nlos, P_received, P_nlos,h2 ] ...
    = peak_power( veh_true(1:2,i),lx,ly,XT,YT);
%
LOSP=los_power1;
P1=(P_received);
% P1=(P_nlos);
t1=(time);
% t1=(time_nlos);

max_t1=max(t1);
min_t1=min(t1);
x_t1=0:0.01:max_t1+1;
imP=gaussian(t1,x_t1,P1);
factor=10000
noise=randn(1,length(imP))*max(imP)/factor;
imP1=imP+noise;
figure
plot(1:length(imP),imP)
hold on
plot(1:length(imP1),imP1)

SNR=abs(10*log10(imP1.^2./noise.^2));
figure
plot(1:length(SNR),SNR)
title(num2str(max(SNR)))
%     [imp_peaks1,imp_locs1]=findpeaks(imP1);
figure
[peaks1,groups1,criterion1] = peaksandgroups(imP1(9999:1.8e4),3,1);
%
imp_peaks1=9998+peaks1

imp_peaks1=sort(imp_peaks1,'ascend')

% find d1
C=3e8;
m=1;
P_total=1;
noise_los=randn*max(imP)/factor;
P_rec1=los_power1+noise_los;
Adet=1e-4;
h=3;
distance1=(((m+1)/(2*pi))*Adet*h^(m+1).*(P_total./P_rec1)).^(1/(m+3));
cT1=(imp_peaks1(2)*C)/10e11;
opts = optimoptions('fsolve', 'Algorithm','Levenberg-Marquardt','TolFun', 1E-8, 'TolX', 1E-8);
lz=h;
x0=[1 1 1 1 1];

alpha=sqrt(distance1^2-lz^2);
%     [x]=lsqnonlin(@(x) funfun(x,alpha,lz,distance1,cT1), x0,[],[],opts);
[x]=fsolve(@(x) funfun(x,alpha,lz,distance1,cT1), x0,opts);
beta1=x(1);
z=x(2);
h_z=x(3);
d2=x(4);
d3=x(5);

cT2=(imp_peaks1(3)*C)/10e11;
%     [x]=lsqnonlin(@(x) funfun(x,alpha,lz,distance1,cT2), x0,[],[],opts);
[x]=fsolve(@(x) funfun(x,alpha,lz,distance1,cT2), x0,opts);
beta2=x(1);
z=x(2);
h_z=x(3);
d2=x(4);
d3=x(5);

% end
%% @17
figure
%  plot(veh_true(1,i)*scale, veh_true(2,i)*scale, 'b-','linewidth',2)
hold on
%  plot(veh_est(1,i)*scale, veh_est(2,i)*scale, 'r-.','linewidth',2)
plot(xWall, yWall,'-k','linewidth',2)
%     plot(x_led*scale,y_led*scale,'r^','markerfacecolor','y','markersize',12)
plot( x_led(1),y_led(1),'yo','MarkerEdgeColor','k','markerfacecolor','y','markersize',12,'linewidth',2)

plot(veh_est(1,i),veh_est(2,i),'rs','markerfacecolor','b','markersize',12)
%% north-south
plot(veh_est(1,i),(veh_est(2,i)+beta1),' yp','markerfacecolor','y','markersize',12)
plot(veh_est(1,i),(veh_est(2,i)-(beta2+alpha)),'rp','markerfacecolor','r','markersize',12)




figure
[peaks1,groups1,criterion1] = peaksandgroups(LOSP,1,1);
led1.veh=[veh_true(1,i),veh_true(2,i)];
led1.a=[veh_true(1,i),(veh_true(2,i)+beta1)];
led1.b=[veh_true(1,i),(veh_true(2,i)-(beta2+alpha))];
led1.c=[veh_true(1,i),(veh_true(2,i)-beta1)];
led1.d=[veh_true(1,i),(veh_true(2,i)+(beta2+alpha))];
led1.beta1=beta1;
led1.beta2=beta2+alpha;


% save wallloc1 led1