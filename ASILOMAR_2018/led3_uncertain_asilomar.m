clear all
close all
clc
%%
print_figures=1;
%%
set(0,'DefaultFigureWindowStyle','normal')

%%
load corridor_model veh_true veh_est mu1
veh_true=veh_true/10;
veh_est=veh_est/10;
%%

map_width = 10;
map_height = 2;


%% LEDs
x_led = [10 30 50 70 90 ]/10;
y_led = [10 10 10 10 10]/10;
xWall=[0 100 100 80 80 0 ]/10;
yWall=[0 0 100 100 20 20 ]/10;
if print_figures
    
    figure
    plot(veh_true(1,90:129), veh_true(2,90:129), 'b-',...
        xWall, yWall,'-k',...
        x_led(3),y_led(3),'^k','markerfacecolor','y','markersize',12,'linewidth',2)
    
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
XT=x_led(3);
YT=y_led(3);
j=90:129;

for i=1:size(j,2)
    i
    [ los_power1, robot_pos, time, time_nlos, P_received, P_nlos,h2 ] = peak_power(veh_true(1:2,j(i)),lx,ly,XT,YT);
    %
    LOSP(i)=los_power1;
    P1=(P_received);
    t1=(time);
    
    max_t1=max(t1);
    min_t1=min(t1);
    x_t1=0:0.01:max_t1+1;
    imP1=gaussian(t1,x_t1,P1);
    
    [peaks1,groups1,criterion1] = peaksandgroups(imP1(9999:1.8e4),3,1);
    imp_peaks1=9999+peaks1;
    imp_peaks1=sort(imp_peaks1,'ascend')
    
    % find d1
    C=3e8;
    m=1;
    P_total=1;
    P_rec1=los_power1;
    Adet=1e-4;
    h=3;
    distance1=(((m+1)/(2*pi))*Adet*h^(m+1).*(P_total./P_rec1)).^(1/(m+3));
    cT1=(imp_peaks1(2)*C)/10e11;
    opts = optimoptions('fsolve', 'Algorithm','Levenberg-Marquardt','TolFun', 1E-8, 'TolX', 1E-8);
    lz=h;
    x0=[1 1.5 1.5 1 1];
    
    alpha(i)=sqrt(distance1^2-lz^2);
    %     [x]=lsqnonlin(@(x) funfun(x,alpha,lz,distance1,cT1), x0,[],[],opts);
    [x]=fsolve(@(x) funfun(x,alpha(i),lz,distance1,cT1), x0,opts);
    beta1(i)=x(1);
    z=x(2);
    h_z=x(3);
    d2=x(4);
    d3=x(5);
    
    x0=[1 1.5 1.5 1 1];
    
    cT2=(imp_peaks1(3)*C)/10e11;
    %     [x]=lsqnonlin(@(x) funfun(x,alpha,lz,distance1,cT2), x0,[],[],opts);
    [x]=fsolve(@(x) funfun(x,alpha(i),lz,distance1,cT2), x0,opts);
    beta2(i)=x(1);
    z=x(2);
    h_z=x(3);
    d2=x(4);
    d3=x(5);
    
end



figure
for i=1:size(j,2)
    %  plot(veh_true(1,i)*scale, veh_true(2,i)*scale, 'b-','linewidth',2)
    hold on
    %  plot(veh_est(1,i)*scale, veh_est(2,i)*scale, 'r-.','linewidth',2)
    plot(xWall, yWall,'-k','linewidth',2)
    %     plot(x_led*scale,y_led*scale,'r^','markerfacecolor','y','markersize',12)
    
    plot(veh_est(1,j(i)),veh_est(2,j(i)),'rs','markerfacecolor','b','markersize',12)
    %% north-south
    plot(veh_est(1,j(i)),(veh_est(2,j(i))+beta1(i)),' yp','markerfacecolor','y','markersize',12)
    plot(veh_est(1,j(i)),(veh_est(2,j(i))-((alpha(i)+beta2(i)))),'rp','markerfacecolor','r','markersize',12)
    
end
figure
[peaks1,groups1,criterion1] = peaksandgroups(LOSP,1,1);
led3.los=LOSP;
led3.a=[veh_est(1,i),(veh_est(2,i)+beta1(i))];
led3.b=[veh_est(1,i),(veh_est(2,i)-((alpha(i)+beta2(i))))]


save LED3 led3
