clc;clear all;close all;
set(0,'DefaultFigureWindowStyle','normal')

load corridor_model veh_true mu1
veh_true=veh_true/10;
veh_est=veh_true/10;
%%
%% LEDs
x_led = [10 30 50 70 90 90 90 90 90]/10;
y_led = [10 10 10 10 10 30 50 70 90]/10;
xWall=[0 0 100 100 80 80 0 ]/10;
yWall=[20 0 0 100 100 20 20 ]/10;
%%
load wallloc1 led1
load wallloc2 led2
load wallloc3 led3
load wallloc4 led4
load wallloc5 led5
load wallloc5east led5east
load wallloc6 led6
load wallloc7 led7
load wallloc8 led8
load wallloc9 led9


figure
hold on

plot(veh_true(1,:),veh_true(2,:),'b-','markerfacecolor','b','markersize',8,'linewidth',2)
% plot(veh_est(1,:),veh_est(2,:),'r-','markerfacecolor','r','markersize',8,'linewidth',2)

plot( x_led,y_led,'yo','markerfacecolor','y','markersize',12,'linewidth',2)
plot(xWall, yWall,'-k','linewidth',2)
%% led1-2
sirkl_tan([led1.veh(1) led1.veh(2), led2.veh(1) led2.veh(2)],[led1.beta1, led2.beta1])  %north
hold on
sirkl_tan([led1.veh(1) led1.veh(2), led2.veh(1) led2.veh(2)],[led1.beta2, led2.beta2]) %south
%% led2-3
sirkl_tan([led2.veh(1) led2.veh(2), led3.veh(1) led3.veh(2)],[led2.beta1, led3.beta1]) %north
sirkl_tan([led2.veh(1) led2.veh(2), led3.veh(1) led3.veh(2)],[led2.beta2, led3.beta2]) %south
%% led3-4

sirkl_tan([led3.veh(1) led3.veh(2), led4.veh(1) led4.veh(2)],[led3.beta1, led4.beta1]) %north
sirkl_tan([led3.veh(1) led3.veh(2), led4.veh(1) led4.veh(2)],[led3.beta2, led4.beta2]) %south
%% led4-5
sirkl_tan([led4.veh(1) led4.veh(2), led5.veh(1) led5.veh(2)],[led4.beta1, led5.beta1]) %north
sirkl_tan([led4.veh(1) led4.veh(2), led5.veh(1) led5.veh(2)],[led4.beta2, led5.beta2]) %south

%% led5-6
sirkl_tan([led6.veh(1) led6.veh(2), led5east.veh(1) led5east.veh(2)],[led6.beta1, led5east.beta1]) %east

%% led6-7
sirkl_tan([led6.veh(1) led6.veh(2), led7.veh(1) led7.veh(2)],[led6.beta1, led7.beta1]) %east
sirkl_tan([led6.veh(1) led6.veh(2), led7.veh(1) led7.veh(2)],[led6.beta2, led7.beta2]) %west

% led7-8
sirkl_tan([led7.veh(1) led7.veh(2), led8.veh(1) led8.veh(2)],[led7.beta1, led8.beta1]) %east
sirkl_tan([led7.veh(1) led7.veh(2), led8.veh(1) led8.veh(2)],[led7.beta2, led8.beta2]) %west
%% led8-9
sirkl_tan([led8.veh(1) led8.veh(2), led9.veh(1) led9.veh(2)],[led8.beta1, led9.beta1]) %east
sirkl_tan([led8.veh(1) led8.veh(2), led9.veh(1) led9.veh(2)],[led8.beta2, led9.beta2]) %west

xlabel('Length (m)')
ylabel('Width (m)')
grid on
set(gca,'fontsize',20)
% xaxis([0 12]);
% yaxis([-2 10])
figure
    hold on

    plot(veh_true(1,:),veh_true(2,:),'b-','markerfacecolor','b','markersize',8,'linewidth',2)
%     plot(veh_est(1,:)*10,veh_est(2,:)*10,'r-','markerfacecolor','r','markersize',8,'linewidth',2)

    plot( x_led,y_led,'yo','markerfacecolor','y','markersize',12,'linewidth',2)
    plot(xWall, yWall,'-k','linewidth',2)

    plot([led1.a(1) led2.a(1) led3.a(1) led4.a(1)],...
         [led1.a(2) led2.a(2) led3.a(2) led4.a(2) ],...
         'gs-','markerfacecolor','g','markersize',12,'linewidth',4)

      plot([led1.c(1) led2.c(1) led3.c(1) led4.c(1)],...
         [led1.c(2) led2.c(2) led3.c(2) led4.c(2) ],...
         's-','color',[.95 .95 .95],'markerfacecolor',[.95 .95 .95],'markersize',8,'linewidth',4)

     plot([led5east.a(1) led6.a(1) led7.a(1) led8.b(1) led9.b(1)],...
          [led5east.a(2) led6.a(2) led7.a(2) led8.b(2) led9.b(2)],...
           'gs-','markerfacecolor','g','markersize',12,'linewidth',4)

    plot([led5east.b(1) led6.c(1) led7.c(1) led8.d(1) led9.d(1)],...
          [led5east.b(2) led6.c(2) led7.c(2) led8.d(2) led9.d(2)],...
           's-','color',[.95 .95 .95],'markerfacecolor',[.95 .95 .95],'markersize',8,'linewidth',4)

    plot([led1.b(1) led2.b(1) led3.b(1) led4.b(1) led5.b(1) ],...
         [led1.b(2) led2.b(2) led3.b(2) led4.b(2) led5.b(2) ],...
        'rs-','markerfacecolor','r','markersize',12,'linewidth',4)

     plot([led1.d(1) led2.d(1) led3.d(1) led4.d(1) led5.d(1) ],...
         [led1.d(2) led2.d(2) led3.d(2) led4.d(2) led5.d(2) ],...
        's-','color',[.95 .95 .95],'markerfacecolor',[.95 .95 .95],'markersize',8,'linewidth',4)
%
    plot([led6.b(1) led7.b(1) led8.a(1) led9.a(1) ],...
         [led6.b(2) led7.b(2)  led8.a(2) led9.a(2) ],...
         'rs-','markerfacecolor','r','markersize',12,'linewidth',4)
%
     plot([led6.d(1) led7.d(1) led8.c(1) led9.c(1) ],...
         [led6.d(2) led7.d(2)  led8.c(2) led9.c(2) ],...
        's-','color',[.95 .95 .95],'markerfacecolor',[.95 .95 .95],'markersize',8,'linewidth',4)

    xlabel('Length (m)')
       ylabel('Width (m)')
       grid on
       set(gca,'fontsize',20)