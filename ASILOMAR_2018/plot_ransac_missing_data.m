clc;clear all;close all;
set(0,'DefaultFigureWindowStyle','docked')

load led1_ransac led1
figure
plot(led1.wall1(20:39,1),led1.wall1(20:39,2),'rs-','markerfacecolor','r','linewidth',2)
hold on
plot(led1.wall2(20:48,1),led1.wall2(20:48,2),'ys-','markerfacecolor','y','linewidth',2)

load led2_ransac led2

plot(led2.wall1(49:74,1),led2.wall1(49:74,2),'rs-','markerfacecolor','r','linewidth',2)
plot(led2.wall2(49:74,1),led2.wall2(49:74,2),'ys-','markerfacecolor','y','linewidth',2)

load led3_ransac led3

plot(led3.wall1(90:129,1),led3.wall1(90:129,2),'rs-','markerfacecolor','r','linewidth',2)
plot(led3.wall2(90:129,1),led3.wall2(90:129,2),'ys-','markerfacecolor','y','linewidth',2)

load led4_ransac led4

plot(led4.wall1(140:159,1),led4.wall1(140:159,2),'rs-','markerfacecolor','r','linewidth',2)
plot(led4.wall2(132:159,1),led4.wall2(132:159,2),'ys-','markerfacecolor','y','linewidth',2)

load led5_ransac led5
plot(led5.wall1(173:204,1),led5.wall1(173:204,2),'rs-','markerfacecolor','r','linewidth',2)
plot(led5.wall2(183:199,1),led5.wall2(183:199,2),'ys-','markerfacecolor','y','linewidth',2)

load corridor_model veh_true veh_est mu1
%
[m n]=size(veh_est(3,221));

wall1=zeros(n,2);
wall1(20:39,:)=led1.wall1(20:39,:);
 wall1(49:74,:)=led2.wall1(49:74,:);
 wall1(90:129,:)=led3.wall2(90:129,:);
wall1(140:159,:)=led4.wall1(140:159,:);
wall1(183:199,:)=led5.wall2(183:199,:);
%

wall1(wall1==0)=NaN;
wall1_fill(:,1) = fillmissing(wall1(:,1),'nearest');  
wall1_fill(:,2) = fillmissing(wall1(:,2),'nearest');  

figure
plot(wall1(:,1),wall1(:,2),'rs-','markerfacecolor','r','linewidth',2)
 plot(wall1_fill(:,1),wall1_fill(:,2),'b+-','markerfacecolor','b','linewidth',2)
% 
 hold on
% yy2 = smooth(wall1_fill(:,1),wall1_fill(:,2),0.1,'rloess');
%  plot(wall1_fill(:,1),yy2,'gs-','markerfacecolor','g','linewidth',2)
%  plot(wall1_fill(:,1),smooth(wall1_fill(:,2)),'ks-','markerfacecolor','k','linewidth',2)


wall2=zeros(n,2);
wall2(20:40,:)=led1.wall2(20:40,:);
wall2(49:65,:)=led2.wall2(49:65,:);
wall2(100:120,:)=led3.wall1(100:120,:);
wall2(132:150,:)=led4.wall2(132:150,:);
wall2(173:195,:)=led5.wall1(173:195,:);

wall2(wall2==0)=NaN;
wall2_fill(:,1) = fillmissing(wall2(:,1),'nearest');  
wall2_fill(:,2) = fillmissing(wall2(:,2),'nearest');  
plot(wall2(:,1),wall2(:,2),'ys-','markerfacecolor','y','linewidth',2)




%% set RANSAC options
options.epsilon = 1e-6;
options.P_inlier = 0.9;
options.sigma = .1;
options.est_fun = @estimate_line;
options.man_fun = @error_line;
options.mode = 'RANSAC';
options.Ps = [];
options.notify_iters = [];
options.min_iters = 200;
options.fix_seed = false;
options.reestimate = true;
options.stabilize = false;
% 
X=wall1_fill';
[results, options] = RANSAC(X, options);
% %%
try
    Theta_ML = estimate_line_ML(X, find(results.CS), sigma, 0);
    ML = true;
catch
    % probably the optimization toolbox is not installed
    ML = false;
end;
figure;
hold on
ind = results.CS
% 
plot(X(1, ind), X(2, ind), 'og','markerfacecolor','g')
plot(X(1, ~ind), X(2, ~ind), 'or','markerfacecolor','r')
xlabel('x')
ylabel('y')
title('RANSAC results for 2D line estimation')
legend('Inliers', 'Outliers')
axis equal tight
% 
x = linspace(0.5, 10, 256);
y = -results.Theta(1)/results.Theta(2)*x - results.Theta(3)/results.Theta(2);
plot(x, y, 'k', 'LineWidth', 2)
if ML
    y_ML = -Theta_ML(1)/Theta_ML(2)*x - Theta_ML(3)/Theta_ML(2);
    plot(x, y_ML, 'b--', 'LineWidth', 2)
end;

%% set RANSAC options
options.epsilon = 1e-6;
options.P_inlier = 0.9;
options.sigma = .1;
options.est_fun = @estimate_line;
options.man_fun = @error_line;
options.mode = 'RANSAC';
options.Ps = [];
options.notify_iters = [];
options.min_iters = 200;
options.fix_seed = false;
options.reestimate = true;
options.stabilize = false;

X=wall2_fill';
[results, options] = RANSAC(X, options);
% %%
try
    Theta_ML = estimate_line_ML(X, find(results.CS), sigma, 0);
    ML = true;
catch
    % probably the optimization toolbox is not installed
    ML = false;
end;
% figure;
% hold on
ind = results.CS
% 
plot(X(1, ind), X(2, ind), 'og','markerfacecolor','g')
plot(X(1, ~ind), X(2, ~ind), 'or','markerfacecolor','r')
xlabel('x')
ylabel('y')
title('RANSAC results for 2D line estimation')
legend('Inliers', 'Outliers')
axis equal tight
set(gca,'fontsize',14)
% 
x = linspace(0.5, 10, 256);
y = -results.Theta(1)/results.Theta(2)*x - results.Theta(3)/results.Theta(2);
plot(x, y, 'k', 'LineWidth', 2)
if ML
    y_ML = -Theta_ML(1)/Theta_ML(2)*x - Theta_ML(3)/Theta_ML(2);
    plot(x, y_ML, 'b--', 'LineWidth', 2)
end;

xlim([0 10]); ylim([-1 3]);