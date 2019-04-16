clc;clear all;close all;
x=[20 40 60 80];

lower_near=[.3926 .2657 .0867 .0647]*10;
upper_near=[.5199 .3686 .1249 .0930]*10;
y_near=[.4562 .3172 .1058 .0788]*10;
e_near=[0.3208 0.2593 0.0960 0.0713]*10
errorbar(x,y_near,e_near,'rx');

lower_far=[.6684 .6221 .1532 .0236]*10;
upper_far=[.7639 .7324 .3152 .0289]*10;
y_far=[0.7161 0.6772 0.2342 0.0312]*10;
e_far=[0.2408 0.2781 0.4082 0.0385]*10
% figure
% ciplot(lower_near,upper_near,x)
% hold on
% ciplot(lower_far,upper_far,x)


figure
hp1 = patch([x x(end:-1:1) x(1)], [lower_near upper_near(end:-1:1) lower_near(1)], 'r');
hp2 = patch([x x(end:-1:1) x(1)], [lower_far upper_far(end:-1:1) lower_far(1)], 'r');

hold on;
hl1 = semilogy(x,y_near);
hl2 = semilogy(x,y_far);

set(hp1, 'facecolor', [1 0.8 0.8], 'edgecolor', 'none');
set(hp2, 'facecolor', [.9 .9 1], 'edgecolor', 'none');
set(hl1, 'color', 'r', 'marker', 'x');
set(hl2, 'color', 'b', 'marker', 'x');
set(gca,'fontsize',20)
xlabel('VLC-SNR (dB)')
ylabel('RMSE (dm)')
legend('Near wall','Far wall')

grid on
