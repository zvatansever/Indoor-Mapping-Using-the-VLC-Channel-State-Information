close all;clear all;clc;

load led_1_uncertain led1

X=led1.north_wall_v1';
p=0.5;
N=length(X);
Ni = round(p*N);
No = N-Ni;
sigma=.1;
% set RANSAC options
options.epsilon = 1e-3;
options.P_inlier = .3;
options.sigma = .1;
options.est_fun = @estimate_line;
options.man_fun = @error_line;
options.mode = 'MSAC';
options.Ps = [];
options.notify_iters = [];
options.min_iters = 1000;
options.fix_seed = true;
options.reestimate = true;
options.stabilize = false;

% run RANSAC
[results, options] = RANSAC(X, options);

%% refine the estimate via ML estimation
try
    Theta_ML = estimate_line_ML(X, find(results.CS), sigma, 0);
     ML = true;
catch
    % probably the optimization toolbox is not installed
    ML = false;
end;

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Results Visualization
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure;
hold on
ind = results.CS;
plot(X(1, ind), X(2, ind), 'sg') 
plot(X(1, ~ind), X(2, ~ind), 'sr')
xlabel('x')
ylabel('y')
title(sprintf('RANSAC results for 2D line estimation (inlier percentage = %3.2f%%)', Ni/N*100))
legend('Inliers', 'Outliers', 'Estimated Iniliers', 'Estimated Outliers')
axis equal tight
x = linspace(0, 3, 256);
y = -results.Theta(1)/results.Theta(2)*x - results.Theta(3)/results.Theta(2);
plot(x, y, 'g', 'LineWidth', 2)
if ML
    y_ML = -Theta_ML(1)/Theta_ML(2)*x - Theta_ML(3)/Theta_ML(2);
    plot(x, y_ML, 'b--', 'LineWidth', 2)
end;
set(gca,'Fontsize',14)
grid on