clear all
close all
clc
%%
print_figures=1;
%%
set(0,'DefaultFigureWindowStyle','normal')

%%

load corridor_model

%  veh_est=round(veh_est);
%  veh_true=round(veh_true);
%%

map_width = 100;
map_height = 20;


%% LEDs
x_led = [10 30  50  70  90 90 90 90 90];
y_led = [10 10  10  10  10 30 50 70 90];
xWall=[0 100 100 80 80 0 0];
yWall=[0 0 100 100 20 20 0];
if print_figures
    
    figure
    plot(veh_true(1,:), veh_true(2,:), 'b-',veh_est(1,:), veh_est(2,:), 'r-.',xWall, yWall,'-k',...
        x_led,y_led,'^k','markerfacecolor','y','markersize',12,'linewidth',2)
end
grid on;
xlim([-5 105]);ylim([-5 105]);
xlabel('x-Length (dm)')
ylabel('y-Length (dm)')
set(gca,'Fontsize',16)
%%
lx=map_width/10;
ly=map_height/10;
for k=1%:length(x)
    XT=x_led(1)/10;
    YT=y_led(1)/10;
    for i=1:length(veh_true)
        [ los_power, robot_pos, time, time_nlos, P_received, P_nlos ] = peak_power( veh_true(1:2,i)/10,lx, ly,XT,YT);
        rec_power(k,i)=los_power;
        Time(k,i,:)=time;
        P(k,i,:)=P_received;
    end
end
if print_figures
    figure
    plot(1:length(rec_power),rec_power(1,:))
end
%% find peak point index
[pks_1,locs_1] = findpeaks(rec_power(1,:));
if print_figures
    
    figure
    findpeaks(rec_power(1,:))
end
%%
for i=1
    [ los_power1, robot_pos, time, time_nlos, P_received, P_nlos ] = peak_power( veh_true(1:2,locs_1(1))/10,lx, ly,XT,YT);
    %
    P1=(P_received);
    %      P1=(P_nlos);
    
    t1=(time);
    %     t1=(time_nlos);
    
    max_t1=max(t1);
    min_t1=min(t1);
    x_t1=0:0.01:max_t1+1;
    imP1=gaussian(t1,x_t1,P1);
    
    %
    if print_figures
        figure
        stem(1:length(t1),P1);

        
        figure
        plot(x_t1./10,imP1);
        xlabel('Time (ns)')
        ylabel('Amplitude h(t)')
        grid on;
        set(gca,'fontsize',18)
    end
    %
    [imp_peaks1,imp_locs1]=findpeaks(imP1);
    if print_figures
        
        figure
        findpeaks(imP1)
    end
    %
    % find d1
    C=3e8;
    m=1;
    P_total=1;
    P_rec1=los_power1;
    Adet=1e-4;
    h=3;
    distance1=(((m+1)/(2*pi))*Adet*h^(m+1).*(P_total./P_rec1)).^(1/(m+3));
    cT1=(imp_locs1(2)*C)/10e11;
    
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
end

%%
scale=0.1;
if print_figures
    
    figure
    plot(veh_true(1,:)*scale, veh_true(2,:)*scale, 'b-','linewidth',2)
    hold on
    plot(veh_est(1,:)*scale, veh_est(2,:)*scale, 'r-.','linewidth',2)
    plot(xWall*scale, yWall*scale,'-k','linewidth',2)
    plot(veh_true(1,locs_1(2))*scale,veh_true(2,locs_1(2))*scale,'rs','markerfacecolor','y','markersize',12)
    
    plot(veh_est(1,locs_1(2))*scale,(veh_est(2,locs_1(2))+((beta1)*10))*scale,'rp','markerfacecolor','y','markersize',12)
    plot(x_led*scale,y_led*scale,'r^','markerfacecolor','y','markersize',12)
    
end
%%
veh_true(1,locs_1(2))*scale
veh_true(2,locs_1(2))*scale

veh_est(1,locs_1(2))*scale
veh_est(2,locs_1(2))*scale


veh_est(1,locs_1(2))*scale
(veh_est(2,locs_1(2))+((beta1)*10))*scale
% %% figure
% for k=1:length(x_led)
%     XT=x_led(k)/10;
%     YT=y_led(k)/10;
%     for i=1:length(veh_true)
%         [ los_power, robot_pos, time, time_nlos, P_received, P_nlos ] = peak_power( veh_true(1:2,i)/10,lx, ly,XT,YT);
%         rec_power(k,i)=los_power;
%         Time(k,i,:)=time;
%         P(k,i,:)=P_received;
%     end
% end
% figure
% plot(1:length(rec_power),rec_power(1,:),1:length(rec_power),rec_power(2,:),...
%     1:length(rec_power),rec_power(3,:),1:length(rec_power),rec_power(4,:),'linewidth',2)
% legend('RSS-LED 1','RSS-LED 2','RSS-LED 3','RSS-LED 4')
% xlabel('Time (seconds)')
% ylabel('Optical RSS (W)')
% set(gca,'fontsize',16)
 save los P1 imP1 x_t1 t1