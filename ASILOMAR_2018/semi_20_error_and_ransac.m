clc;clear;close all; 
print_figures=1;
%%
set(0,'DefaultFigureWindowStyle','normal')
%%
load vcsel_part1_20 wall_pos_north_part1_20 wall_pos_south_part1_20
load vcsel_part2_20 wall_pos_north_part2_20 wall_pos_south_part2_20
load vcsel_part3_20 wall_pos_north_part3_20 wall_pos_south_part3_20
load vcsel_part4_20 wall_pos_north_part4_20 wall_pos_south_part4_20
load vcsel_part5_20 wall_pos_north_part5_20 wall_pos_south_part5_20

load corridor_model veh_true veh_est mu1

point_cloud_north=[wall_pos_north_part1_20 wall_pos_north_part2_20(:,49:89)...
                   wall_pos_north_part3_20(:,90:129) wall_pos_north_part4_20(:,130:172)...
                   wall_pos_north_part5_20(:,173:221)]*10;
               
point_cloud_south=[wall_pos_south_part1_20 wall_pos_south_part2_20(:,49:89)...
                   wall_pos_south_part3_20(:,90:129) wall_pos_south_part4_20(:,130:172)...
                   wall_pos_south_part5_20(:,173:221)]*10;

save wall_north_60deg point_cloud_north point_cloud_south
%%
load corridor_model veh_true veh_est mu1
%%
map_width = 100;
map_height = 20;
%% LEDs
x_led = [ ];
y_led = [];
xWall=[0 100 100 80 80 0 ];
yWall=[0 0 100 100 20 20 ];

xWall=[0 100 100  0  0];
yWall=[0   0  20 20  0];
if print_figures
    
    figure
    plot(veh_true(1,1:48), veh_true(2,1:48), 'b-',...
        veh_est(1,1:48), veh_est(2,1:48), 'r-.',xWall, yWall,'-k',...
        point_cloud_north(1,:),point_cloud_north(2,:),'m*',...
        point_cloud_south(1,:),point_cloud_south(2,:),'m*',...
        'markerfacecolor','y','markersize',12,'linewidth',2)
    
    grid on;
    % xlim([-5 105]);ylim([-5 105]);
    xlabel('x-Length (dm)')
    ylabel('y-Length (dm)')
    set(gca,'Fontsize',16)
    axis equal;
    title('VCSEL semiangle 20')
end

X=point_cloud_north;

p=.7;
N=length(X);
Ni = round(p*N);
No = N-Ni;
sigma=1;
% set RANSAC options
options.epsilon = 1e-6;
options.P_inlier =.78;
options.sigma = sigma;
options.est_fun = @estimate_line;
options.man_fun = @error_line;
options.mode = 'MSAC';
options.Ps = [];
options.notify_iters = [];
options.min_iters = 1000;
options.fix_seed = false;
options.reestimate = true;
options.stabilize = false;
% run RANSAC
[results, options] = RANSAC(X, options);
%% refine the estimate via ML estimation
try
    Theta_ML = estimate_line_ML(X, find(results.CS), sigma, 0);
     ML = true
catch
    % probably the optimization toolbox is not installed
    ML = false
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
x = linspace(0, 100, 100);
y = -results.Theta(1)/results.Theta(2)*x - results.Theta(3)/results.Theta(2);
plot(x, y, 'g', 'LineWidth', 2)
if ML
    y_ML = -Theta_ML(1)/Theta_ML(2)*x - Theta_ML(3)/Theta_ML(2);
    plot(x, y_ML, 'b--', 'LineWidth', 2)
end;
set(gca,'Fontsize',14)
grid on
north_Wall_est=y;


%%
X=point_cloud_south;

p=.7;
N=length(X);
Ni = round(p*N);
No = N-Ni;
sigma=1;
% set RANSAC options
options.epsilon = 1e-6;
options.P_inlier =.78;
options.sigma = sigma;
options.est_fun = @estimate_line;
options.man_fun = @error_line;
options.mode = 'MSAC';
options.Ps = [];
options.notify_iters = [];
options.min_iters = 1000;
options.fix_seed = false;
options.reestimate = true;
options.stabilize = false;
% run RANSAC
[results, options] = RANSAC(X, options);
%% refine the estimate via ML estimation
try
    Theta_ML = estimate_line_ML(X, find(results.CS), sigma, 0);
     ML = true
catch
    % probably the optimization toolbox is not installed
    ML = false
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
x = linspace(0, 100, 100);
y = -results.Theta(1)/results.Theta(2)*x - results.Theta(3)/results.Theta(2);
plot(x, y, 'g', 'LineWidth', 2)
if ML
    y_ML = -Theta_ML(1)/Theta_ML(2)*x - Theta_ML(3)/Theta_ML(2);
    plot(x, y_ML, 'b--', 'LineWidth', 2)
end;
set(gca,'Fontsize',14)
grid on

south_Wall_est=y;
%% calculate error
north_error=abs(20-north_Wall_est);
figure
stem(north_error,'b','linewidth',2)
title('Northern wall  error ')
xlabel('# of samples')
ylabel('Absolute Error (m)')

south_error=abs(0-south_Wall_est);
figure
stem(south_error,'b','linewidth',2)
title('Southern wall  error ')
xlabel('# of samples')
ylabel('Absolute Error (m)')

