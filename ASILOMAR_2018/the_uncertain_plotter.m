clear all
close all
clc
%%
print_figures=1;
%%
set(0,'DefaultFigureWindowStyle','normal')

%%

load corridor_model veh_true veh_est mu1
load led_1_uncertain led1
load led_2_uncertain led2
load led_3_uncertain led3
load led_4_uncertain led4
load led_5_uncertain led5
%  veh_est=round(veh_est);
%  veh_true=round(veh_true);
%%

map_width = 100;
map_height = 20;


%% LEDs
x_led = [10 30 50 70 90];
y_led = [10 10 10 10 10];
xWall=[0 100 100 80 80 0 0];
yWall=[0 0 100 100 20 20 0];

xWall=[0 100 100 0  0];
yWall=[0 0 20 20  0];
scale=.1;
% if print_figures
    
    figure
    plot(veh_true(1,1:221)*scale, veh_true(2,1:221)*scale, 'b-',...
        veh_est(1,1:221)*scale, veh_est(2,1:221)*scale, 'r-.',xWall*scale, yWall*scale,'-k',...
        x_led(1:5)*scale,y_led(1:5)*scale,'^k','markerfacecolor','y','markersize',12,'linewidth',2)
    hold on
    plot([led1.north_wall_v1(:,1); led2.north_wall_v1(:,1); led3.north_wall_v1(:,1); led4.north_wall_v1(:,1); led5.north_wall_v1(:,1)],...
        [led1.north_wall_v1(:,2); led2.north_wall_v1(:,2); led3.north_wall_v1(:,2); led4.north_wall_v1(:,2); led5.north_wall_v1(:,2)],...
        'r.','markerfacecolor','b','markersize',8)
    plot([led1.south_wall_v1(:,1); led2.south_wall_v1(:,1); led3.south_wall_v1(:,1); led4.south_wall_v1(:,1); led5.north_wall_v1(:,1)],...
        [led1.south_wall_v1(:,2); led2.south_wall_v1(:,2); led3.south_wall_v1(:,2); led4.south_wall_v1(:,2); led5.north_wall_v1(:,2)],...
        'r.','markerfacecolor','b','markersize',8)
%     
%     plot([led1.north_wall_v2(:,1); led2.north_wall_v2(:,1); led3.north_wall_v2(:,1); led4.north_wall_v2(:,1); led5.north_wall_v2(:,1)],...
%         [led1.north_wall_v2(:,2); led2.north_wall_v2(:,2); led3.north_wall_v2(:,2); led4.north_wall_v2(:,2); led5.north_wall_v2(:,2)],...
%         'b.','markerfacecolor','b','markersize',8)
%     
%     plot([led1.south_wall_v2(:,1); led2.south_wall_v2(:,1); led3.south_wall_v2(:,1); led4.south_wall_v2(:,1); led5.south_wall_v2(:,1)],...
%         [led1.south_wall_v2(:,2); led2.south_wall_v2(:,2); led3.south_wall_v2(:,2); led4.south_wall_v2(:,2); led5.south_wall_v2(:,2)],...
%         'b.','markerfacecolor','b','markersize',8)
%     
%      plot([led1.west_wall_v1(:,1); led2.west_wall_v1(:,1); led3.west_wall_v1(:,1); led4.west_wall_v1(:,1); led5.west_wall_v1(:,1)],...
%         [led1.west_wall_v1(:,2); led2.west_wall_v1(:,2); led3.west_wall_v1(:,2); led4.west_wall_v1(:,2); led5.west_wall_v1(:,2)],...
%         'g.','markerfacecolor','b','markersize',8)
%     
%      plot([led1.east_wall_v1(:,1); led2.east_wall_v1(:,1); led3.east_wall_v1(:,1); led4.east_wall_v1(:,1); led5.east_wall_v1(:,1)],...
%         [led1.east_wall_v1(:,2); led2.east_wall_v1(:,2); led3.east_wall_v1(:,2); led4.east_wall_v1(:,2); led5.east_wall_v1(:,2)],...
%         'g.','markerfacecolor','b','markersize',8)
%     
%     plot([led1.west_wall_v2(:,1); led2.west_wall_v2(:,1); led3.west_wall_v2(:,1); led4.west_wall_v2(:,1); led5.west_wall_v2(:,1)],...
%         [led1.west_wall_v2(:,2); led2.west_wall_v2(:,2); led3.west_wall_v2(:,2); led4.west_wall_v2(:,2); led5.west_wall_v2(:,2)],...
%         'm.','markerfacecolor','b','markersize',8)
%     
%      plot([led1.east_wall_v2(:,1); led2.east_wall_v2(:,1); led3.east_wall_v2(:,1); led4.east_wall_v2(:,1); led5.east_wall_v2(:,1)],...
%         [led1.east_wall_v2(:,2); led2.east_wall_v2(:,2); led3.east_wall_v2(:,2); led4.east_wall_v2(:,2); led5.east_wall_v2(:,2)],...
%         'm.','markerfacecolor','b','markersize',8)
%     
    grid on;
    
    xlabel('x-Length (dm)')
    ylabel('y-Length (dm)')
    set(gca,'Fontsize',16)
    axis equal;
% end