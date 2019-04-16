clear all
close all
clc
%%
print_figures=1;
%%
set(0,'DefaultFigureWindowStyle','normal')

%%

load corridor_model veh_true veh_est mu1

%  veh_est=round(veh_est);
%  veh_true=round(veh_true);
%%

map_width = 100;
map_height = 20;


%% LEDs
x_led = [10 30 50 70 90 90 90 90 90];
y_led = [10 10 10 10 10 30 50 70 90];
xWall=[0 100 100 80 80 0 0];
yWall=[0 0 100 100 20 20 0];
if print_figures
    
    figure
    plot(veh_true(1,:), veh_true(2,:), 'b-',...
        veh_est(1,:), veh_est(2,:), 'r-.',xWall, yWall,'-k',...
        x_led,y_led,'^k','markerfacecolor','y','markersize',12,'linewidth',2)
end
grid on;
xlim([-5 105]);ylim([-5 105]);
xlabel('x-Length (dm)')
ylabel('y-Length (dm)')
set(gca,'Fontsize',16)
axis equal;
%% north-south
lx=map_width/10;
ly=map_height/10;
for k=1:5
    XT=x_led(k)/10;
    YT=y_led(k)/10;
    for i=1:length(veh_true)
        [ los_power, robot_pos, time, time_nlos, P_received, P_nlos, h2 ] = peak_power( veh_true(1:2,i)/10,lx, ly,XT,YT);
        rec_power(k,i)=los_power;
        Time(k,i,:)=time;
        P(k,i,:)=P_received;
    end
end

% %% find peak point index
% [pks_1,locs_1] = findpeaks(rec_power(1,:))
% if print_figures
%     
%     figure
%     findpeaks(rec_power(1,:))
% end

figure
for i=1:5
    plot(rec_power(i,:))
    hold on
end

figure
plot([rec_power(1,1:48),rec_power(2,49:89),...
     rec_power(3,90:129),rec_power(4,130:172),...
     rec_power(5,173:221)])