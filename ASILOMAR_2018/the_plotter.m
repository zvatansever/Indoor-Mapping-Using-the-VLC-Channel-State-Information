clear all
close all
clc
%%
load corridor_model veh_true veh_est mu1
load LED1 LED1
load LED2 LED2
load LED3 LED3
load LED4 LED4
load LED5 LED5
load LED5_east LED5_east
load LED6 LED6
load LED7 LED7
load LED8 LED8
load LED9 LED9

%% LEDs
x_led = [10 30 50 70 90 90 90 90 90];
y_led = [10 10 10 10 10 30 50 70 90];
xWall=[0 100 100 80 80 0 0];
yWall=[0 0 100 100 20 20 0];
scale=0.1;



figure
plot(veh_true(1,:)*scale, veh_true(2,:)*scale, 'b-','linewidth',2)
hold on

plot(veh_est(1,:)*scale, veh_est(2,:)*scale, 'r-.','linewidth',2)

plot(xWall*scale, yWall*scale,'-k','linewidth',2)

plot(x_led*scale,y_led*scale,'r^','markerfacecolor','y','markersize',12)

plot([LED1.wall_north(1),LED2.wall_north(1),LED3.wall_north(1),LED4.wall_north(1)],...
     [LED1.wall_north(2),LED2.wall_north(2),LED3.wall_north(2),LED4.wall_north(2)],...
     'p-','color','[1 0.5 0]','Markerfacecolor','[1 0.5 0]','Markersize',18,'linewidth',2)

 plot([LED1.wall_south(1),LED2.wall_south(1),LED3.wall_south(1),LED4.wall_south(1),LED5.wall_south(1)],...
      [LED1.wall_south(2),LED2.wall_south(2),LED3.wall_south(2),LED4.wall_south(2),LED5.wall_south(2)],...
     'p-','color','[1 0.5 0]','Markerfacecolor','[1 0.5 0]','Markersize',18,'linewidth',2)

 plot([LED5_east.wall_east(1),LED6.wall_east(1),LED7.wall_east(1),LED8.wall_east(1),LED9.wall_east(1)],...
      [LED5_east.wall_east(2),LED6.wall_east(2),LED7.wall_east(2),LED8.wall_east(2),LED9.wall_east(2)],...
    'p-','color','[1 0.5 0]','Markerfacecolor','[1 0.5 0]','Markersize',18,'linewidth',2)
 
plot([LED6.wall_west(1),LED7.wall_west(1),LED8.wall_west(1),LED9.wall_west(1)],...
     [LED6.wall_west(2),LED7.wall_west(2),LED8.wall_west(2),LED9.wall_west(2)],...
    'p-','color','[1 0.5 0]','Markerfacecolor','[1 0.5 0]','Markersize',18,'linewidth',2)
plot([LED1.user_pos_est(1),LED2.user_pos_est(1),LED3.user_pos_est(1),LED4.user_pos_est(1),LED5.user_pos_est(1)],...
    [LED1.user_pos_est(2),LED2.user_pos_est(2),LED3.user_pos_est(2),LED4.user_pos_est(2),LED5.user_pos_est(2)],...
    'rs','Markerfacecolor','g','Markersize',12)

plot([LED5.user_pos_est(1),LED6.user_pos_est(1),LED7.user_pos_est(1),LED8.user_pos_est(1),LED9.user_pos_est(1)],...
     [LED5.user_pos_est(2),LED6.user_pos_est(2),LED7.user_pos_est(2),LED8.user_pos_est(2),LED9.user_pos_est(2)],...
    'rs','Markerfacecolor','g','Markersize',12)