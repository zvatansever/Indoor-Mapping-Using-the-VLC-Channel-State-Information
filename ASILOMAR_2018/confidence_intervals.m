clear all
close all
clc
rng(9999, 'twister')

%%
print_figures=1;
%%
set(0,'DefaultFigureWindowStyle','normal')
%%

map_width = 10;
map_height = 2;


%% LEDs
% x_led = [10 30 50 70 90 90 90 90 90];
% y_led = [10 10 10 10 10 30 50 70 90];
x_led = [1];
y_led = [1];
xWall=[0 2 2 0 0];
yWall=[0 0 2 2 0];

% xWall=[0 100 100 80 80 0 ]/10;
% yWall=[0 0 100 100 20 20 ]/10;
% veh_true=[1. 1.9];
% xWall=[0 100 100  0  0];
% yWall=[0   0  20 20  0];
% if print_figures
%     
%     figure
%     plot(veh_true(1), veh_true(2), 'bs',...
%         xWall, yWall,'-k',...
%         x_led(1),y_led(1),'yo',...
%         'MarkerEdgeColor','k','markerfacecolor','y','markersize',12,'linewidth',2)
%     
%     grid on;
%     % xlim([-5 105]);ylim([-5 105]);
%     xlabel('x-Length (dm)')
%     ylabel('y-Length (dm)')
%     set(gca,'Fontsize',16)
%     axis equal;
% end
%% north-south
lx=map_width;
ly=map_height;
XT=x_led(1);
YT=y_led(1);

for i=1:100
%%

veh_true=[1. 1+rand]
[ los_power1, robot_pos, time, time_nlos, P_received, P_nlos,h2 ] ...
    = peak_power( veh_true(1:2),lx,ly,XT,YT);
%
LOSP=los_power1;
P1=(P_received);
t1=(time);

max_t1=max(t1);
min_t1=min(t1);
x_t1=0:0.01:max_t1+1;
imP=gaussian(t1,x_t1,P1);
factor=1e1;
noise=randn(1,length(imP))*max(imP)/factor;
imP1=imP+noise;

SNR=abs(10*log10(imP1.^2./noise.^2));
figure(1)
plot(1:length(SNR),SNR)
title(num2str(max(SNR)))
pause(.01)
clf;
[peaks1,groups1,criterion1] = peaksandgroups(imP1(9999:1.8e4),3,0);
%
imp_peaks1=9998+peaks1;

imp_peaks1=sort(imp_peaks1,'ascend');

C=3e8;
m=1;
P_total=1;
noise_los=randn*max(imP)/factor;
P_rec1=LOSP%+noise_los;
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

%%
rmse_near(i)=sqrt(mean((2-(veh_true(2)+beta1))^2))
rmse_far(i)=sqrt(mean((0-(veh_true(2)-(beta2+alpha)))^2))
end

%% near wall
ci = 0.95;
alpha = 1 - ci;
n = length(rmse_near); %number of elements in the data vector
T_multiplier = tinv(1-alpha/2, n-1)
% the multiplier is large here because there is so little data. That means
% we do not have a lot of confidence on the true average or standard
% deviation
ybar=mean(rmse_near)
s=std(rmse_near)
ci95 = T_multiplier*s/sqrt(n)

% confidence interval
sprintf('The confidence interval is %1.1f +- %1.1f near wall',ybar,ci95)
[ybar - ci95, ybar + ci95]

%%far wall
ci = 0.95;
alpha = 1 - ci;
n = length(rmse_far); %number of elements in the data vector
T_multiplier = tinv(1-alpha/2, n-1)
% the multiplier is large here because there is so little data. That means
% we do not have a lot of confidence on the true average or standard
% deviation
ybar=mean(rmse_far)
s=std(rmse_far)
ci95 = T_multiplier*s/sqrt(n)

% confidence interval
sprintf('The confidence interval is %1.1f +- %1.1f far wall',ybar,ci95)
[ybar - ci95, ybar + ci95]

beep