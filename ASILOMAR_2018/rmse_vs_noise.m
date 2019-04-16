clc;clear all;close all;
x_led = [10 30 50 70 90 ]/10;
y_led = [10 10 10 10 10]/10;
xWall=[0 100 100 80 80 0 ]/10;
yWall=[0 0 100 100 20 20 ]/10;

%% LED1
load wallloc1_20db led1
led1_20_a=led1.a;
led1_20_b=led1.b;
rmse_led1_20_a=sqrt(mean(2-led1_20_a(2))^2)
rmse_led1_20_b=sqrt(mean(0-led1_20_b(2))^2)

figure
plot(led1_20_a(1),2,'yo','markerfacecolor','y','markersize',12)
hold on
plot(xWall,yWall,'linewidth',2)

plot(led1_20_a(1),0,'yo','markerfacecolor','y','markersize',12)
plot(led1_20_a(1),led1_20_a(2),'rs','markersize',12)
plot(led1_20_b(1),led1_20_b(2),'rs','markersize',12)
plot(1,led1_20_a(2),'*','markersize',12)
plot(1,led1_20_b(2),'*','markersize',12)


load wallloc1_40db led1
led1_40_a=led1.a;
led1_40_b=led1.b;
rmse_led1_40_a=sqrt(mean((2-led1_40_a(2))^2))
rmse_led1_40_b=sqrt(mean((0-led1_40_b(2))^2))

plot(led1_40_a(1),led1_40_a(2),'rs','markersize',12)
plot(led1_40_b(1),led1_40_b(2),'rs','markersize',12)
plot(1,led1_40_a(2),'*','markersize',12)
plot(1,led1_40_b(2),'*','markersize',12)

load wallloc1_60db led1
led1_60_a=led1.a;
led1_60_b=led1.b;
rmse_led1_60_a=sqrt(mean((2-led1_60_a(2))^2))
rmse_led1_60_b=sqrt(mean((0-led1_60_b(2))^2))

plot(led1_60_a(1),led1_60_a(2),'rs','markersize',12)
plot(led1_60_b(1),led1_60_b(2),'rs','markersize',12)
plot(1,led1_60_a(2),'*','markersize',12)
plot(1,led1_60_b(2),'*','markersize',12)

load wallloc1_80db led1
led1_80_a=led1.a;
led1_80_b=led1.b;

rmse_led1_80_a=sqrt(mean((2-led1_80_a(2))^2))
rmse_led1_80_b=sqrt(mean((0-led1_80_b(2))^2))


plot(led1_80_a(1),led1_80_a(2),'rs','markersize',12)
plot(led1_80_b(1),led1_80_b(2),'rs','markersize',12)
plot(1,led1_80_a(2),'*','markersize',12)
plot(1,led1_80_b(2),'*','markersize',12)

snr=[20 40 60 80]

figure
plot(snr,[rmse_led1_20_a rmse_led1_40_a rmse_led1_60_a rmse_led1_80_a],'markersize',12,'linewidth',2)

figure
plot(snr,[rmse_led1_20_b rmse_led1_40_b rmse_led1_60_b rmse_led1_80_b],'markersize',12,'linewidth',2)
%% LED2
load wallloc2_20db led2
led2_20_a=led2.a;
led2_20_b=led2.b;
rmse_led2_20_a=sqrt(mean((2-led2_20_a(2))^2))
rmse_led2_20_b=sqrt(mean((0-led2_20_b(2))^2))

figure
plot(led2_20_a(1),2,'yo','markerfacecolor','y','markersize',12)
hold on
plot(xWall,yWall,'linewidth',2)
plot(led2_20_a(1),0,'yo','markerfacecolor','y','markersize',12)
plot(led2_20_a(1),led2_20_a(2),'rs','markersize',12)
plot(led2_20_b(1),led2_20_b(2),'rs','markersize',12)

load wallloc2_40db led2
led2_40_a=led2.a;
led2_40_b=led2.b;
rmse_led2_40_a=sqrt(mean((2-led2_40_a(2))^2))
rmse_led2_40_b=sqrt(mean((0-led2_40_b(2))^2))

plot(led2_40_a(1),led2_40_a(2),'rs','markersize',12)
plot(led2_40_b(1),led2_40_b(2),'rs','markersize',12)

load wallloc2_60db led2
led2_60_a=led2.a;
led2_60_b=led2.b;
rmse_led2_60_a=sqrt(mean((2-led2_60_a(2))^2))
rmse_led2_60_b=sqrt(mean((0-led2_60_b(2))^2))

plot(led2_60_a(1),led2_60_a(2),'rs','markersize',12)
plot(led2_60_b(1),led2_60_b(2),'rs','markersize',12)

load wallloc2_80db led2
led2_80_a=led2.a;
led2_80_b=led2.b;

rmse_led2_80_a=sqrt(mean((2-led2_80_a(2))^2))
rmse_led2_80_b=sqrt(mean((0-led2_80_b(2))^2))

plot(led2_80_a(1),led2_80_a(2),'rs','markersize',12)
plot(led2_80_b(1),led2_80_b(2),'rs','markersize',12)

figure
plot(snr,[rmse_led2_20_a rmse_led2_40_a rmse_led2_60_a rmse_led2_80_a],'markersize',12,'linewidth',2)

figure
plot(snr,[rmse_led2_20_b rmse_led2_40_b rmse_led2_60_b rmse_led2_80_b],'markersize',12,'linewidth',2)

%% LED3
load wallloc3_20db led3
led3_20_a=led3.a;
led3_20_b=led3.b;
rmse_led3_20_a=sqrt(mean((2-led3_20_a(2))^2))
rmse_led3_20_b=sqrt(mean((0-led3_20_b(2))^2))

figure
plot(xWall,yWall,'linewidth',2)
hold on

plot(led3_20_a(1),2,'yo','markerfacecolor','y','markersize',12)
plot(led3_20_a(1),0,'yo','markerfacecolor','y','markersize',12)
plot(led3_20_a(1),led3_20_a(2),'rs','markersize',12)
plot(led3_20_b(1),led3_20_b(2),'rs','markersize',12)

load wallloc3_40db led3
led3_40_a=led3.a;
led3_40_b=led3.b;
rmse_led3_40_a=sqrt(mean((2-led3_40_a(2))^2))
rmse_led3_40_b=sqrt(mean((0-led3_40_b(2))^2))

plot(led3_40_a(1),led3_40_a(2),'rs','markersize',12)
plot(led3_40_b(1),led3_40_b(2),'rs','markersize',12)

load wallloc3_60db led3
led3_60_a=led3.a;
led3_60_b=led3.b;
rmse_led3_60_a=sqrt(mean((2-led3_60_a(2))^2))
rmse_led3_60_b=sqrt(mean((0-led3_60_b(2))^2))

plot(led3_60_a(1),led3_60_a(2),'rs','markersize',12)
plot(led3_60_b(1),led3_60_b(2),'rs','markersize',12)

load wallloc3_80db led3
led3_80_a=led3.a;
led3_80_b=led3.b;

rmse_led3_80_a=sqrt(mean((2-led3_80_a(2))^2))
rmse_led3_80_b=sqrt(mean((0-led3_80_b(2))^2))
plot(led3_80_a(1),led3_80_a(2),'rs','markersize',12)
plot(led3_80_b(1),led3_80_b(2),'rs','markersize',12)

figure
plot(snr,[rmse_led3_20_a rmse_led3_40_a rmse_led3_60_a rmse_led3_80_a],'markersize',12,'linewidth',2)

figure
plot(snr,[rmse_led3_20_b rmse_led3_40_b rmse_led3_60_b rmse_led3_80_b],'markersize',12,'linewidth',2)
%% LED4
load wallloc4_20db led4
led4_20_a=led4.a;
led4_20_b=led4.b;
rmse_led4_20_a=sqrt(mean((2-led4_20_a(2))^2))
rmse_led4_20_b=sqrt(mean((0-led4_20_b(2))^2))

figure
plot(led4_20_a(1),2,'yo','markerfacecolor','y','markersize',12)
hold on
plot(xWall,yWall,'linewidth',2)

plot(led4_20_a(1),0,'yo','markerfacecolor','y','markersize',12)
plot(led4_20_a(1),led4_20_a(2),'rs','markersize',12)
plot(led4_20_b(1),led4_20_b(2),'rs','markersize',12)

load wallloc4_40db led4
led4_40_a=led4.a;
led4_40_b=led4.b;
rmse_led4_40_a=sqrt(mean((2-led4_40_a(2))^2))
rmse_led4_40_b=sqrt(mean((0-led4_40_b(2))^2))

plot(led4_40_a(1),led4_40_a(2),'rs','markersize',12)
plot(led4_40_b(1),led4_40_b(2),'rs','markersize',12)

load wallloc4_60db led4
led4_60_a=led4.a;
led4_60_b=led4.b;
rmse_led4_60_a=sqrt(mean((2-led4_60_a(2))^2))
rmse_led4_60_b=sqrt(mean((0-led4_60_b(2))^2))

plot(led4_60_a(1),led4_60_a(2),'rs','markersize',12)
plot(led4_60_b(1),led4_60_b(2),'rs','markersize',12)

load wallloc4_80db led4
led4_80_a=led4.a;
led4_80_b=led4.b;

rmse_led4_80_a=sqrt(mean((2-led4_80_a(2))^2))
rmse_led4_80_b=sqrt(mean((0-led4_80_b(2))^2))
plot(led4_80_a(1),led4_80_a(2),'rs','markersize',12)
plot(led4_80_b(1),led4_80_b(2),'rs','markersize',12)


figure
plot(snr,[rmse_led4_20_a rmse_led4_40_a rmse_led4_60_a rmse_led4_80_a],'markersize',12,'linewidth',2)
figure
plot(snr,[rmse_led4_20_b rmse_led4_40_b rmse_led4_60_b rmse_led4_80_b],'markersize',12,'linewidth',2)
%% LED5
load wallloc5_20 led5
led5_20_a=real(led5.a);
led5_20_b=real(led5.b);
rmse_led5_20_a=sqrt(mean((0-led5_20_a(2))^2))
rmse_led5_20_b=sqrt(mean((2-led5_20_b(2))^2))

figure
%plot(9,2,'yo','markerfacecolor','y','markersize',12)
hold on
plot(xWall,yWall,'linewidth',2)

plot(led5_20_a(1),0,'yo','markerfacecolor','y','markersize',12)
%plot(led5_20_a(1),led5_20_a(2),'rs','markersize',12)
plot(led5_20_b(1),led5_20_b(2),'rs','markersize',12)

load wallloc5_40 led5
led5_40_a=led5.a;
led5_40_b=led5.b;
rmse_led5_40_a=sqrt(mean((0-led5_40_a(2))^2))
rmse_led5_40_b=sqrt(mean((2-led5_40_b(2))^2))

%plot(led5_40_a(1),led5_40_a(2),'rs','markersize',12)
plot(led5_40_b(1),led5_40_b(2),'rs','markersize',12)

load wallloc5_60 led5
led5_60_a=led5.a;
led5_60_b=led5.b;
rmse_led5_60_a=sqrt(mean((0-led5_60_a(2))^2))
rmse_led5_60_b=sqrt(mean((2-led5_60_b(2))^2))

%plot(led5_60_a(1),led5_60_a(2),'rs','markersize',12)
plot(led5_60_b(1),led5_60_b(2),'rs','markersize',12)

load wallloc5_80 led5
led5_80_a=led5.a;
led5_80_b=led5.b;

rmse_led5_80_a=sqrt(mean((0-led5_80_a(2))^2))
rmse_led5_80_b=sqrt(mean((2-led5_80_b(2))^2))
%plot(led5_80_a(1),led5_80_a(2),'rs','markersize',12)
plot(led5_80_b(1),led5_80_b(2),'rs','markersize',12)

figure
plot(snr,[rmse_led5_20_a rmse_led5_40_a rmse_led5_60_a rmse_led5_80_a],'markersize',12,'linewidth',2)
figure
plot(snr,[rmse_led5_20_b rmse_led5_40_b rmse_led5_60_b rmse_led5_80_b],'markersize',12,'linewidth',2)
%% LED5
load wallloc5east_20 led5east
led5_20_a=led5east.a;
led5_20_b=led5east.b;
rmse_led5_20_a_east=sqrt(mean((10-led5_20_a(1))^2))

figure
plot(10,led5_20_a(2),'yo','markerfacecolor','y','markersize',12)
hold on
plot(xWall,yWall,'linewidth',2)

plot(led5_20_a(1),led5_20_a(2),'rs','markersize',12)

load wallloc5east_40 led5east
led5_40_a=led5east.a;
led5_40_b=led5east.b;
rmse_led5_40_a_east=sqrt(mean((10-led5_40_a(1))^2))

plot(led5_40_a(1),led5_40_a(2),'rs','markersize',12)

load wallloc5east_60 led5east
led5_60_a=led5east.a;
led5_60_b=led5east.b;
rmse_led5_60_a_east=sqrt(mean((10-led5_60_a(1))^2))

plot(led5_60_a(1),led5_60_a(2),'rs','markersize',12)

load wallloc5east_80 led5east
led5_80_a=led5east.a;
led5_80_b=led5east.b;
rmse_led5_80_a_east=sqrt(mean((10-led5_20_a(1))^2))

plot(led5_80_a(1),led5_80_a(2),'rs','markersize',12)

figure
plot(snr,[rmse_led5_20_a_east rmse_led5_40_a_east rmse_led5_60_a_east rmse_led5_80_a_east],'markersize',12,'linewidth',2)

%% LED6
load wallloc6_20db led6
led6_20_a=real(led6.a);
led6_20_b=real(led6.b);
rmse_led6_20_a=sqrt(mean((10-led6_20_a(1))^2))
rmse_led6_20_b=sqrt(mean((8-led6_20_b(1))^2))

figure
plot(10,led6_20_a(2),'yo','markerfacecolor','y','markersize',12)
hold on
plot(xWall,yWall,'linewidth',2)

plot(8,led6_20_a(2),'yo','markerfacecolor','y','markersize',12)
plot(led6_20_a(1),led6_20_a(2),'rs','markersize',12)
plot(led6_20_b(1),led6_20_b(2),'rs','markersize',12)

load wallloc6_40db led6
led6_40_a=led6.a;
led6_40_b=led6.b;
rmse_led6_40_a=sqrt(mean((10-led6_40_a(1))^2))
rmse_led6_40_b=sqrt(mean((8-led6_40_b(1))^2))

plot(led6_40_a(1),led6_40_a(2),'rs','markersize',12)
plot(led6_40_b(1),led6_40_b(2),'rs','markersize',12)

load wallloc6_60db led6
led6_60_a=led6.a;
led6_60_b=led6.b;
rmse_led6_60_a=sqrt(mean((10-led6_60_a(1))^2))
rmse_led6_60_b=sqrt(mean((8-led6_60_b(1))^2))

plot(led6_60_a(1),led6_60_a(2),'rs','markersize',12)
plot(led6_60_b(1),led6_60_b(2),'rs','markersize',12)

load wallloc6_80db led6
led6_80_a=led6.a;
led6_80_b=led6.b;
rmse_led6_80_a=sqrt(mean((10-led6_80_a(1))^2))
rmse_led6_80_b=sqrt(mean((8-led6_80_b(1))^2))

plot(led6_80_a(1),led6_80_a(2),'rs','markersize',12)
plot(led6_80_b(1),led6_80_b(2),'rs','markersize',12)

figure
plot(snr,[rmse_led6_20_a rmse_led6_40_a rmse_led6_60_a rmse_led6_80_a],'markersize',12,'linewidth',2)
figure
plot(snr,[rmse_led6_20_b rmse_led6_40_b rmse_led6_60_b rmse_led6_80_b],'markersize',12,'linewidth',2)
%% LED7
load wallloc7_20db led7
led7_20_a=led7.a;
led7_20_b=led7.b;
rmse_led7_20_a=sqrt(mean((10-led7_20_a(1))^2))
rmse_led7_20_b=sqrt(mean((8-led7_20_b(1))^2))

figure
plot(10,led7_20_a(2),'yo','markerfacecolor','y','markersize',12)
hold on
plot(xWall,yWall,'linewidth',2)
plot(8,led7_20_a(2),'yo','markerfacecolor','y','markersize',12)
plot(led7_20_a(1),led7_20_a(2),'rs','markersize',12)
plot(led7_20_b(1),led7_20_b(2),'rs','markersize',12)

load wallloc7_40db led7
led7_40_a=led7.a;
led7_40_b=led7.b;
rmse_led7_40_a=sqrt(mean((10-led7_40_a(1))^2))
rmse_led7_40_b=sqrt(mean((8-led7_40_b(1))^2))

plot(led7_40_a(1),led7_40_a(2),'rs','markersize',12)
plot(led7_40_b(1),led7_40_b(2),'rs','markersize',12)

load wallloc7_60db led7
led7_60_a=led7.a;
led7_60_b=led7.b;
rmse_led7_60_a=sqrt(mean((10-led7_60_a(1))^2))
rmse_led7_60_b=sqrt(mean((8-led7_60_b(1))^2))

plot(led7_60_a(1),led7_60_a(2),'rs','markersize',12)
plot(led7_60_b(1),led7_60_b(2),'rs','markersize',12)

load wallloc7_80db led7
led7_80_a=led7.a;
led7_80_b=led7.b;
rmse_led7_80_a=sqrt(mean((10-led7_80_a(1))^2))
rmse_led7_80_b=sqrt(mean((8-led7_80_b(1))^2))

plot(led7_80_a(1),led7_80_a(2),'rs','markersize',12)
plot(led7_80_b(1),led7_80_b(2),'rs','markersize',12)

figure
plot(snr,[rmse_led7_20_a rmse_led7_40_a rmse_led7_60_a rmse_led7_80_a],'markersize',12,'linewidth',2)
figure
plot(snr,[rmse_led7_20_b rmse_led7_40_b rmse_led7_60_b rmse_led7_80_b],'markersize',12,'linewidth',2)
%% LED8
load wallloc8_20db led8
led8_20_a=real(led8.a);
led8_20_b=real(led8.b);
rmse_led8_20_a=sqrt(mean((8-led8_20_a(1))^2))
rmse_led8_20_b=sqrt(mean((10-led8_20_b(1))^2))

figure
plot(8,led8_20_a(2),'yo','markerfacecolor','y','markersize',12)
hold on
plot(xWall,yWall,'linewidth',2)
plot(10,led8_20_a(2),'yo','markerfacecolor','y','markersize',12)
plot(led8_20_a(1),led8_20_a(2),'rs','markersize',12)
plot(led8_20_b(1),led8_20_b(2),'rs','markersize',12)

load wallloc8_40db led8
led8_40_a=led8.a;
led8_40_b=led8.b;
rmse_led8_40_a=sqrt(mean((8-led8_40_a(1))^2))
rmse_led8_40_b=sqrt(mean((10-led8_40_b(1))^2))

plot(led8_40_a(1),led8_40_a(2),'rs','markersize',12)
plot(led8_40_b(1),led8_40_b(2),'rs','markersize',12)

load wallloc8_60db led8
led8_60_a=led8.a;
led8_60_b=led8.b;
rmse_led8_60_a=sqrt(mean((8-led8_60_a(1))^2))
rmse_led8_60_b=sqrt(mean((10-led8_60_b(1))^2))

plot(led8_60_a(1),led8_60_a(2),'rs','markersize',12)
plot(led8_60_b(1),led8_60_b(2),'rs','markersize',12)

load wallloc8_80db led8
led8_80_a=led8.a;
led8_80_b=led8.b;
rmse_led8_80_a=sqrt(mean((8-led8_80_a(1))^2))
rmse_led8_80_b=sqrt(mean((10-led8_80_b(1))^2))

plot(led8_80_a(1),led8_80_a(2),'rs','markersize',12)
plot(led8_80_b(1),led8_80_b(2),'rs','markersize',12)
figure
plot(snr,[rmse_led8_20_a rmse_led8_40_a rmse_led8_60_a rmse_led8_80_a],'markersize',12,'linewidth',2)
figure
plot(snr,[rmse_led8_20_b rmse_led8_40_b rmse_led8_60_b rmse_led8_80_b],'markersize',12,'linewidth',2)
%% LED9
load wallloc9_20db led9
led9_20_a=led9.a;
led9_20_b=led9.b;
rmse_led9_20_a=sqrt(mean((8-led9_20_a(1))^2))
rmse_led9_20_b=sqrt(mean((10-led9_20_b(1))^2))

figure
plot(10,led9_20_a(2),'yo','markerfacecolor','y','markersize',12)
hold on
plot(xWall,yWall,'linewidth',2)
plot(8,led9_20_a(2),'yo','markerfacecolor','y','markersize',12)
plot(led9_20_a(1),led9_20_a(2),'rs','markersize',12)
plot(led9_20_b(1),led9_20_b(2),'rs','markersize',12)

load wallloc9_40db led9
led9_40_a=led9.a;
led9_40_b=led9.b;
rmse_led9_40_a=sqrt(mean((8-led9_40_a(1))^2))
rmse_led9_40_b=sqrt(mean((10-led9_40_b(1))^2))

plot(led9_40_a(1),led9_40_a(2),'rs','markersize',12)
plot(led9_40_b(1),led9_40_b(2),'rs','markersize',12)

load wallloc9_60db led9
led9_60_a=led9.a;
led9_60_b=led9.b;
rmse_led9_60_a=sqrt(mean((8-led9_60_a(1))^2))
rmse_led9_60_b=sqrt(mean((10-led9_60_b(1))^2))

plot(led9_60_a(1),led9_60_a(2),'rs','markersize',12)
plot(led9_60_b(1),led9_60_b(2),'rs','markersize',12)

load wallloc9_80db led9
led9_80_a=led9.a;
led9_80_b=led9.b;
rmse_led9_80_a=sqrt(mean((8-led9_80_a(1))^2))
rmse_led9_80_b=sqrt(mean((10-led9_80_b(1))^2))

plot(led9_80_a(1),led9_80_a(2),'rs','markersize',12)
plot(led9_80_b(1),led9_80_b(2),'rs','markersize',12)
figure
plot(snr,[rmse_led9_20_a rmse_led9_40_a rmse_led9_60_a rmse_led9_80_a],'markersize',12,'linewidth',2)
figure
plot(snr,[rmse_led9_20_b rmse_led9_40_b rmse_led9_60_b rmse_led9_80_b],'markersize',12,'linewidth',2)
%%
snr=[20 40 60 80]
rmse=[rmse_led1_20_a rmse_led2_20_a rmse_led3_20_a rmse_led4_20_a rmse_led5_20_a  rmse_led6_20_a rmse_led7_20_a rmse_led8_20_a rmse_led9_20_a;
    rmse_led1_40_a rmse_led2_40_a rmse_led3_40_a rmse_led4_40_a rmse_led5_40_a  rmse_led6_40_a rmse_led7_40_a rmse_led8_40_a rmse_led9_40_a;
    rmse_led1_60_a rmse_led2_60_a rmse_led3_60_a rmse_led4_60_a rmse_led5_60_a rmse_led6_60_a rmse_led7_60_a rmse_led8_60_a rmse_led9_60_a;
    rmse_led1_80_a rmse_led2_80_a rmse_led3_80_a rmse_led4_80_a rmse_led5_80_a rmse_led6_80_a rmse_led7_80_a rmse_led8_80_a rmse_led9_80_a]';
figure
plot(snr, rmse(1,:),'--h',snr, rmse(2,:),'-.s',snr, rmse(3,:),'--d',snr, rmse(4,:),'-o',snr, rmse(5,:),'--p',snr, rmse(6,:),'-.*',snr, rmse(7,:),'--x',snr, rmse(8,:),'-+','markersize',12,'linewidth',2)
xlabel('VLC-SNR (dB)')
ylabel('RMSE (m)')
grid on;
set(gca,'fontsize',20)
rmse=[rmse_led1_20_b rmse_led2_20_b rmse_led3_20_b rmse_led4_20_b rmse_led5_20_a_east rmse_led6_20_b rmse_led7_20_b rmse_led8_20_b rmse_led9_20_b;
    rmse_led1_40_b rmse_led2_40_b rmse_led3_40_b rmse_led4_40_b rmse_led5_40_a_east rmse_led6_40_b rmse_led7_40_b rmse_led8_40_b rmse_led9_40_b;
    rmse_led1_60_b rmse_led2_60_b rmse_led3_60_b rmse_led4_60_b rmse_led5_60_a_east rmse_led6_60_b rmse_led7_60_b rmse_led8_60_b rmse_led9_60_b;
    rmse_led1_80_b rmse_led2_80_b rmse_led3_80_b rmse_led4_80_b rmse_led5_80_a_east rmse_led6_80_b rmse_led7_80_b rmse_led8_80_b rmse_led9_80_b]';
figure
plot(snr, rmse(1,:),'--h',snr, rmse(2,:),'-.s',snr, rmse(3,:),'--d',snr, rmse(4,:),'-o',snr, rmse(5,:),'--p',snr, rmse(6,:),'-.*',snr, rmse(7,:),'--x',snr, rmse(8,:),'-+','markersize',12,'linewidth',2)
xlabel('VLC-SNR (dB)')
ylabel('MSE (m)')
grid on;
set(gca,'fontsize',20)

%%
rmse1=10*[(rmse_led1_20_a+rmse_led2_20_a+rmse_led3_20_a+rmse_led4_20_a +rmse_led5_20_a + rmse_led6_20_a +rmse_led7_20_a +rmse_led8_20_a +rmse_led9_20_a)/4;
      (rmse_led1_40_a+rmse_led2_40_a+rmse_led3_40_a+rmse_led4_40_a +rmse_led5_40_a +rmse_led6_40_a +rmse_led7_40_a +rmse_led8_40_a +rmse_led9_40_a)/4;
      (rmse_led1_60_a+rmse_led2_60_a+rmse_led3_60_a+rmse_led4_60_a +rmse_led5_60_a +rmse_led6_60_a +rmse_led7_60_a +rmse_led8_60_a +rmse_led9_60_a)/4;
      (rmse_led1_80_a+rmse_led2_80_a+rmse_led3_80_a+rmse_led4_80_a +rmse_led5_80_a +rmse_led6_80_a +rmse_led7_80_a +rmse_led8_80_a +rmse_led9_80_a)/4]';

rmse2=10*[(rmse_led1_20_b+rmse_led2_20_b+rmse_led3_20_b+rmse_led4_20_b+rmse_led5_20_a_east +rmse_led6_20_b +rmse_led7_20_b +rmse_led8_20_b +rmse_led9_20_b)/4;
      (rmse_led1_40_b+rmse_led2_40_b+rmse_led3_40_b+rmse_led4_40_b+rmse_led5_20_a_east+rmse_led6_40_b +rmse_led7_40_b +rmse_led8_40_b +rmse_led9_40_b)/4;
      (rmse_led1_60_b+rmse_led2_60_b+rmse_led3_60_b+rmse_led4_60_b+rmse_led5_20_a_east +rmse_led6_60_b +rmse_led7_60_b +rmse_led8_60_b +rmse_led9_60_b)/4;
      (rmse_led1_80_b+rmse_led2_80_b+rmse_led3_80_b+rmse_led4_80_b +rmse_led5_20_a_east+rmse_led6_80_b +rmse_led7_80_b +rmse_led8_80_b +rmse_led9_80_b)/4]';  
  
figure
semilogy(snr, rmse1,'--h',snr,rmse2,'--*','markersize',12,'linewidth',2)
xlabel('VLC-SNR (dB)')
ylabel('RMSE (dm)')

grid on;
set(gca,'fontsize',20)


% rmse=[rmse_led1_20_b rmse_led2_20_b rmse_led3_20_b rmse_led4_20_b rmse_led6_20_b rmse_led7_20_b rmse_led8_20_b rmse_led9_20_b;
%     rmse_led1_40_b rmse_led2_40_b rmse_led3_40_b rmse_led4_40_b  rmse_led6_40_b rmse_led7_40_b rmse_led8_40_b rmse_led9_40_b;
%     rmse_led1_60_b rmse_led2_60_b rmse_led3_60_b rmse_led4_60_b  rmse_led6_60_b rmse_led7_60_b rmse_led8_60_b rmse_led9_60_b;
%     rmse_led1_80_b rmse_led2_80_b rmse_led3_80_b rmse_led4_80_b  rmse_led6_80_b rmse_led7_80_b rmse_led8_80_b rmse_led9_80_b]';
% figure
% plot(snr, rmse(1,:),'--h',snr, rmse(2,:),'-.s',snr, rmse(3,:),'--d',snr, rmse(4,:),'-o',snr, rmse(5,:),'--p',snr, rmse(6,:),'-.*',snr, rmse(7,:),'--x',snr, rmse(8,:),'-+','markersize',12,'linewidth',2)
% xlabel('VLC-SNR (dB)')
% ylabel('MSE (m)')
% grid on;
% set(gca,'fontsize',20)
