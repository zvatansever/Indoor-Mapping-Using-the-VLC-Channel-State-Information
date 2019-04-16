clear all;close all;clc
%%
print_figures=1;%%
set(0,'DefaultFigureWindowStyle','docked')
%%
% load corridor_model veh_true veh_est mu1
load square veh_true
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
% if print_figures
%
%     figure
%     plot(veh_true(1,1:48), veh_true(2,1:48), 'b-',...
%         veh_est(1,1:48), veh_est(2,1:48), 'r-.',xWall, yWall,'-k',...
%         'markerfacecolor','y','markersize',12,'linewidth',2)
%
%     grid on;
%     % xlim([-5 105]);ylim([-5 105]);
%     xlabel('x-Length (dm)')
%     ylabel('y-Length (dm)')
%     set(gca,'Fontsize',16)
%     axis equal;
% end

%% north-south
lx=map_width/10;
ly=map_height/10;
% for i=1:48
%
%         [ los_power, robot_pos, time, time_nlos, P_received, P_nlos, h2 ] = peak_power( veh_true(1:2,i)/10,lx, ly,XT,YT);
%         rec_power(i)=los_power;
%         Time(i,:)=time;
%         P(i,:)=P_received;
%     end
%%
for i=1:length(veh_true)
    
    
    XT=veh_true(1,i)/10;
    YT=veh_true(2,i)/10;
    i
    [ los_power1, robot_pos, time, time_nlos, P_received, P_nlos,h2,P_2,P_4,t_2,t_4 ] = peak_power( veh_true(1:2,i)/10,lx,ly,XT,YT);
    %
    P1=(P_received);
    % P1=(P_nlos);
    t1=(time);
    % t1=(time_nlos);
    
    %% impulse response
    max_t1=max(t1);
    min_t1=min(t1);
    x_t1=0:0.01:max_t1+1;
    
    ti_me{i}=x_t1;
    
    imP1=gaussian(t1,x_t1,P1);
    %       figure(1)
    %       plot(1:length(imP1),imP1)
    %       pause(.5)
    % %      [peaks,groups,criterion] = peaksandgroups(imP1,3,1);
    
    [peaks1,groups1,criterion1] = peaksandgroups(imP1(9999:1.8e4),3,1);
    
    peaks=9998+peaks1
    impulse_response{i}=imP1;
    second_peak{i}=peaks(2);
    third_peak{i}=peaks(3);
    
    % %         dFactor = 50;
    % %         selectedpeaks= downsample(imP1,dFactor);
    % %         timeElapsed = downsample(1:length(imP1),dFactor);
    % %      [pksTrans,timeTrans] =peak_detection(imP1,50,1e-8);
    %         [pksTrans,timeTrans] =findpeaks(imP1(9e3:2e4),9e3:2e4,'MinPeakProminence',1.5e-8','MinPeakDistance',101);
    %         if print_figures
    %         figure(2)
    %         clf
    %         stem(9e3:2e4,imP1(9e3:2e4),'c')
    
    %         plot(timeTrans,pksTrans,'r*','MarkerSize',10)
    % %         figure(2)
    % %         findpeaks(imP1);
    %         pause(.5)
    % %
    % %
    %      end
    %
    % find d1
    C=3e8;
    m=1;
    P_total=1;
    P_rec1=los_power1;
    Adet=1e-4;
    h=3;
    distance1=(((m+1)/(2*pi))*Adet*h^(m+1).*(P_total./P_rec1)).^(1/(m+3));
    cT1=(peaks(2)*C)/10e11;
    opts = optimoptions('fsolve', 'Algorithm','Levenberg-Marquardt','TolFun', 1E-8, 'TolX', 1E-8);
    lz=h;
    x0=[1];
    [x1]=fsolve(@(x) vcsel_sol(x, h,cT1), x0,opts)
    
    %     alpha(i)=sqrt(distance1^2-lz^2);
    %     %     [x]=lsqnonlin(@(x) funfun(x,alpha,lz,distance1,cT1), x0,[],[],opts);
    %     [x]=fsolve(@(x) funfun(x,alpha(i),lz,distance1,cT1), x0,opts);
    beta1(i)=x1(1);
    %     z=x(2);
    %     h_z=x(3);
    %     d2=x(4);
    %     d3=x(5);
    cT2=(peaks(3)*C)/10e11;
    x0=[1];
    [x2]=fsolve(@(x) vcsel_sol(x, h,cT2), x0,opts)
    %     %     [x]=lsqnonlin(@(x) funfun(x,alpha,lz,distance1,cT2), x0,[],[],opts);
    %     [x]=fsolve(@(x) funfun(x,alpha(i),lz,distance1,cT2), x0,opts);
    beta2(i)=x2(1);
    %     z=x(2);
    %     h_z=x(3);
    %     d2=x(4);
    %     d3=x(5);
    %%
    scale=0.1;
    figure(2)
    plot(veh_true(1,i)*scale, veh_true(2,i)*scale, 'b-','linewidth',2)
    hold on
    
    plot(xWall*scale, yWall*scale,'-k','linewidth',2)
    plot(x_led*scale,y_led*scale,'r^','markerfacecolor','y','markersize',12)
    
    plot(veh_true(1,i)*scale,veh_true(2,i)*scale,'rs','markerfacecolor','y','markersize',12)
end

% scale=0.1;
% figure
% for i=1:length(veh_true)
%
%
%     plot(veh_true(1,i)*scale, veh_true(2,i)*scale, 'b-','linewidth',2)
%     hold on
%     plot(xWall*scale, yWall*scale,'-k','linewidth',2)
%     plot(x_led*scale,y_led*scale,'r^','markerfacecolor','y','markersize',12)
%
%     plot(veh_true(1,i)*scale,veh_true(2,i)*scale,'rs','markerfacecolor','y','markersize',12)
%     %% north-south
%     [X,Y]=circle([veh_true(1,i)*scale,veh_true(2,i)*scale],beta2(i),100,'g');
%     X1(i,:)=X;
%     Y1(i,:)=Y;
%     text(X(50),Y(50)+.1,[num2str(i)]) %for ex: x = 3, y = 5 (scalars)
%
%     plot(veh_true(1,i)*scale,(veh_true(2,i)+beta2(i)*10)*scale,' b.','markerfacecolor','y','markersize',12)
%     wall_pos_north_part(:,i)=[veh_true(1,i)*scale,(veh_true(2,i)+beta2(i)*10)*scale];
%
%     %%south wall
%     [X,Y]=circle([veh_true(1,i)*scale,veh_true(2,i)*scale],beta1(i),100,'r');
%     X2(i,:)=X;
%     Y2(i,:)=Y;
%     text(X(50),Y(50)+.1,[num2str(i)]) %for ex: x = 3, y = 5 (scalars)
%
%     plot(veh_true(1,i)*scale,(veh_true(2,i)-((beta1(i))*10))*scale,'r.','markerfacecolor','y','markersize',12)
%     wall_pos_south_part(:,i)=[veh_true(1,i)*scale,(veh_true(2,i)-((beta1(i))*10))*scale];
%
% end

scale=0.1;
figure
for i=1:length(veh_true)
    
    
    plot(veh_true(1,i)*scale, veh_true(2,i)*scale, 'b-','linewidth',2)
    hold on
    plot(xWall*scale, yWall*scale,'-k','linewidth',2)
    plot(x_led*scale,y_led*scale,'r^','markerfacecolor','y','markersize',12)
    
    plot(veh_true(1,i)*scale,veh_true(2,i)*scale,'rs','markerfacecolor','y','markersize',12)
    %% north-south
    
    
    plot(veh_true(1,i)*scale,(veh_true(2,i)+beta2(i)*10)*scale,' b.','markerfacecolor','y','markersize',12)
    wall_pos_north_part(:,i)=[veh_true(1,i)*scale,(veh_true(2,i)+beta2(i)*10)*scale];
    
    
    plot(veh_true(1,i)*scale,(veh_true(2,i)-((beta1(i))*10))*scale,'r.','markerfacecolor','y','markersize',12)
    wall_pos_south_part(:,i)=[veh_true(1,i)*scale,(veh_true(2,i)-((beta1(i))*10))*scale];
end

figure
subplot 211
plot(1:length(veh_true),veh_true(3,:),'linewidth',2)
xlabel('Time (sec)')
ylabel('Heading angle ({\theta})')
set(gca,'fontsize',18)
subplot 212
plot(1:length(veh_true),beta2,'r*',1:length(veh_true),beta1,'b*')
xlabel('Time (sec)')
ylabel('Distance to walls (m)')
legend('South Wall w.r.t. initial agent position','North Wall w.r.t. initial agent position')
set(gca,'fontsize',18)



scale=0.1;
figure
for i=1:length(veh_true)
    
    
    plot(veh_true(1,i)*scale, veh_true(2,i)*scale, 'b-','linewidth',2)
    hold on
    plot(xWall*scale, yWall*scale,'-k','linewidth',2)
    plot(x_led*scale,y_led*scale,'r^','markerfacecolor','y','markersize',12)
    
    plot(veh_true(1,i)*scale,veh_true(2,i)*scale,'rs','markerfacecolor','y','markersize',12)
    %% north
    plot(veh_true(1,1:21)*scale,(veh_true(2,1:21)+beta1(1:21)*10)*scale,'b*','markersize',10) %1
    plot(veh_true(1,21:41)*scale,(veh_true(2,21:41)+beta1(21:41)*10)*scale,'b*','markersize',10)%2
    plot(veh_true(1,41:61)*scale,(veh_true(2,41:61)+beta1(41:61)*10)*scale,'b*','markersize',10)%3
    plot(veh_true(1,61:81)*scale,(veh_true(2,61:81)+beta2(61:81)*10)*scale,'b*','markersize',10)%4
    plot(veh_true(1,81:101)*scale,(veh_true(2,81:101)+beta1(81:101)*10)*scale,'b*','markersize',10)%5
    plot(veh_true(1,101:121)*scale,(veh_true(2,101:121)+beta1(101:121)*10)*scale,'b*','markersize',10)%6
    plot(veh_true(1,121:141)*scale,(veh_true(2,121:141)+beta1(121:141)*10)*scale,'b*','markersize',10)%7
    plot(veh_true(1,141:161)*scale,(veh_true(2,141:161)+beta2(141:161)*10)*scale,'b*','markersize',10)%8
    plot(veh_true(1,161:181)*scale,(veh_true(2,161:181)+beta2(161:181)*10)*scale,'b*','markersize',10)%9
    plot(veh_true(1,181:201)*scale,(veh_true(2,181:201)+beta1(181:201)*10)*scale,'b*','markersize',10)%10
    plot(veh_true(1,201:221)*scale,(veh_true(2,201:221)+beta1(201:221)*10)*scale,'b*','markersize',10)%11
    plot(veh_true(1,221:241)*scale,(veh_true(2,221:241)+beta2(221:241)*10)*scale,'b*','markersize',10)%12
    plot(veh_true(1,241:261)*scale,(veh_true(2,241:261)+beta2(241:261)*10)*scale,'b*','markersize',10)%13
    plot(veh_true(1,261:281)*scale,(veh_true(2,261:281)+beta1(261:281)*10)*scale,'b*','markersize',10)%14
    plot(veh_true(1,281:301)*scale,(veh_true(2,281:301)+beta1(281:301)*10)*scale,'b*','markersize',10)%15
    plot(veh_true(1,301:321)*scale,(veh_true(2,301:321)+beta2(301:321)*10)*scale,'b*','markersize',10)%16
    plot(veh_true(1,321:341)*scale,(veh_true(2,321:341)+beta2(321:341)*10)*scale,'b*','markersize',10)%17
    plot(veh_true(1,341:361)*scale,(veh_true(2,341:361)+beta1(341:361)*10)*scale,'b*','markersize',10)%18
    plot(veh_true(1,361:381)*scale,(veh_true(2,361:381)+beta1(361:381)*10)*scale,'b*','markersize',10)%19
    plot(veh_true(1,381:399)*scale,(veh_true(2,381:399)+beta2(381:399)*10)*scale,'b*','markersize',10)%20
    %     wall_pos_north_part(:,i)=[veh_true(1,i)*scale,(veh_true(2,i)+beta2(i)*10)*scale];
    
    %% south
    plot(veh_true(1,1:21)*scale,(veh_true(2,1:21)-beta2(1:21)*10)*scale,'r*','markersize',10) %1
    plot(veh_true(1,21:41)*scale,(veh_true(2,21:41)-beta2(21:41)*10)*scale,'r*','markersize',10)%2
    plot(veh_true(1,41:61)*scale,(veh_true(2,41:61)-beta2(41:61)*10)*scale,'r*','markersize',10)%3
    plot(veh_true(1,61:81)*scale,(veh_true(2,61:81)-beta1(61:81)*10)*scale,'r*','markersize',10)%4
    plot(veh_true(1,81:101)*scale,(veh_true(2,81:101)-beta1(81:101)*10)*scale,'r*','markersize',10)%5
    plot(veh_true(1,101:121)*scale,(veh_true(2,101:121)-beta2(101:121)*10)*scale,'r*','markersize',10)%6
    plot(veh_true(1,121:141)*scale,(veh_true(2,121:141)-beta2(121:141)*10)*scale,'r*','markersize',10)%7
    plot(veh_true(1,141:161)*scale,(veh_true(2,141:161)-beta1(141:161)*10)*scale,'r*','markersize',10)%8
    plot(veh_true(1,161:181)*scale,(veh_true(2,161:181)-beta1(161:181)*10)*scale,'r*','markersize',10)%9
    plot(veh_true(1,181:201)*scale,(veh_true(2,181:201)-beta2(181:201)*10)*scale,'r*','markersize',10)%10
    plot(veh_true(1,201:221)*scale,(veh_true(2,201:221)-beta2(201:221)*10)*scale,'r*','markersize',10)%11
    plot(veh_true(1,221:241)*scale,(veh_true(2,221:241)-beta1(221:241)*10)*scale,'r*','markersize',10)%12
    plot(veh_true(1,241:261)*scale,(veh_true(2,241:261)-beta1(241:261)*10)*scale,'r*','markersize',10)%13
    plot(veh_true(1,261:281)*scale,(veh_true(2,261:281)-beta2(261:281)*10)*scale,'r*','markersize',10)%14
    plot(veh_true(1,281:301)*scale,(veh_true(2,281:301)-beta2(281:301)*10)*scale,'r*','markersize',10)%15
    plot(veh_true(1,301:321)*scale,(veh_true(2,301:321)-beta1(301:321)*10)*scale,'r*','markersize',10)%16
    plot(veh_true(1,321:341)*scale,(veh_true(2,321:341)-beta1(321:341)*10)*scale,'r*','markersize',10)%17
    plot(veh_true(1,341:361)*scale,(veh_true(2,341:361)-beta2(341:361)*10)*scale,'r*','markersize',10)%18
    plot(veh_true(1,361:381)*scale,(veh_true(2,361:381)-beta2(361:381)*10)*scale,'r*','markersize',10)%19
    plot(veh_true(1,381:399)*scale,(veh_true(2,381:399)-beta1(381:399)*10)*scale,'r*','markersize',10)%20
    %     plot(veh_true(1,i)*scale,(veh_true(2,i)-((beta1(i))*10))*scale,'r.','markerfacecolor','y','markersize',12)
    %     wall_pos_south_part(:,i)=[veh_true(1,i)*scale,(veh_true(2,i)-((beta1(i))*10))*scale];
end

% %% time
% time_1=ti_me{1};
% time_2=[ti_me{2} zeros(1,length(ti_me{1})-length(ti_me{2}))];
% time_3=[ti_me{3} zeros(1,length(ti_me{1})-length(ti_me{3}))];
% time_4=[ti_me{4} zeros(1,length(ti_me{1})-length(ti_me{4}))];
% time_5=[ti_me{5} zeros(1,length(ti_me{1})-length(ti_me{5}))];
% time_6=[ti_me{6} zeros(1,length(ti_me{1})-length(ti_me{6}))];
% time_7=[ti_me{7} zeros(1,length(ti_me{1})-length(ti_me{7}))];
% time_8=[ti_me{8} zeros(1,length(ti_me{1})-length(ti_me{8}))];
% time_9=[ti_me{9} zeros(1,length(ti_me{1})-length(ti_me{9}))];
% time_10=[ti_me{10} zeros(1,length(ti_me{1})-length(ti_me{10}))];
% time_11=[ti_me{11} zeros(1,length(ti_me{1})-length(ti_me{11}))];
% time_12=[ti_me{12} zeros(1,length(ti_me{1})-length(ti_me{12}))];
% time_13=[ti_me{13} zeros(1,length(ti_me{1})-length(ti_me{13}))];
% time_14=[ti_me{14} zeros(1,length(ti_me{1})-length(ti_me{14}))];
% time_15=[ti_me{15} zeros(1,length(ti_me{1})-length(ti_me{15}))];
% time_16=[ti_me{16} zeros(1,length(ti_me{1})-length(ti_me{16}))];
% time_17=[ti_me{17} zeros(1,length(ti_me{1})-length(ti_me{17}))];
% time_18=[ti_me{18} zeros(1,length(ti_me{1})-length(ti_me{18}))];
% time_19=[ti_me{19} zeros(1,length(ti_me{1})-length(ti_me{19}))];
% %% impulse response
%
% imp_res_1=[impulse_response{1} zeros(1,length(impulse_response{1})-length(impulse_response{1}))];
% imp_res_2=[impulse_response{2} zeros(1,length(impulse_response{1})-length(impulse_response{2}))];
% imp_res_3=[impulse_response{3} zeros(1,length(impulse_response{1})-length(impulse_response{3}))];
% imp_res_4=[impulse_response{4} zeros(1,length(impulse_response{1})-length(impulse_response{4}))];
% imp_res_5=[impulse_response{5} zeros(1,length(impulse_response{1})-length(impulse_response{5}))];
% imp_res_6=[impulse_response{6} zeros(1,length(impulse_response{1})-length(impulse_response{6}))];
% imp_res_7=[impulse_response{7} zeros(1,length(impulse_response{1})-length(impulse_response{7}))];
% imp_res_8=[impulse_response{8} zeros(1,length(impulse_response{1})-length(impulse_response{8}))];
% imp_res_9=[impulse_response{9} zeros(1,length(impulse_response{1})-length(impulse_response{9}))];
% imp_res_10=[impulse_response{10} zeros(1,length(impulse_response{1})-length(impulse_response{10}))];
% imp_res_11=[impulse_response{11} zeros(1,length(impulse_response{1})-length(impulse_response{11}))];
% imp_res_12=[impulse_response{12} zeros(1,length(impulse_response{1})-length(impulse_response{12}))];
% imp_res_13=[impulse_response{13} zeros(1,length(impulse_response{1})-length(impulse_response{13}))];
% imp_res_14=[impulse_response{14} zeros(1,length(impulse_response{1})-length(impulse_response{14}))];
% imp_res_15=[impulse_response{15} zeros(1,length(impulse_response{1})-length(impulse_response{15}))];
% imp_res_16=[impulse_response{16} zeros(1,length(impulse_response{1})-length(impulse_response{16}))];
% imp_res_17=[impulse_response{17} zeros(1,length(impulse_response{1})-length(impulse_response{17}))];
% imp_res_18=[impulse_response{18} zeros(1,length(impulse_response{1})-length(impulse_response{18}))];
% imp_res_19=[impulse_response{19} zeros(1,length(impulse_response{1})-length(impulse_response{19}))];
%
% %  %% time
% % time_1=ti_me{19};
% %
% % %% impulse response
% %
% % imp_res_1=[impulse_response{1} zeros(1,length(impulse_response{19})-length(impulse_response{1}))];
% % imp_res_2=[impulse_response{2} zeros(1,length(impulse_response{19})-length(impulse_response{2}))];
% % imp_res_3=[impulse_response{3} zeros(1,length(impulse_response{19})-length(impulse_response{3}))];
% % imp_res_4=[impulse_response{4} zeros(1,length(impulse_response{19})-length(impulse_response{4}))];
% % imp_res_5=[impulse_response{5} zeros(1,length(impulse_response{19})-length(impulse_response{5}))];
% % imp_res_6=[impulse_response{6} zeros(1,length(impulse_response{19})-length(impulse_response{6}))];
% % imp_res_7=[impulse_response{7} zeros(1,length(impulse_response{19})-length(impulse_response{7}))];
% % imp_res_8=[impulse_response{8} zeros(1,length(impulse_response{19})-length(impulse_response{8}))];
% % imp_res_9=[impulse_response{9} zeros(1,length(impulse_response{19})-length(impulse_response{9}))];
% % imp_res_10=[impulse_response{10} zeros(1,length(impulse_response{19})-length(impulse_response{10}))];
% % imp_res_11=[impulse_response{11} zeros(1,length(impulse_response{19})-length(impulse_response{11}))];
% % imp_res_12=[impulse_response{12} zeros(1,length(impulse_response{19})-length(impulse_response{12}))];
% % imp_res_13=[impulse_response{13} zeros(1,length(impulse_response{19})-length(impulse_response{13}))];
% % imp_res_14=[impulse_response{14} zeros(1,length(impulse_response{19})-length(impulse_response{14}))];
% % imp_res_15=[impulse_response{15} zeros(1,length(impulse_response{19})-length(impulse_response{15}))];
% % imp_res_16=[impulse_response{16} zeros(1,length(impulse_response{19})-length(impulse_response{16}))];
% % imp_res_17=[impulse_response{17} zeros(1,length(impulse_response{19})-length(impulse_response{17}))];
% % imp_res_18=[impulse_response{18} zeros(1,length(impulse_response{19})-length(impulse_response{18}))];
% % imp_res_19=[impulse_response{19} zeros(1,length(impulse_response{19})-length(impulse_response{19}))];
%
% imp=[imp_res_1;imp_res_2;imp_res_3;imp_res_4;imp_res_5;imp_res_5;imp_res_6;imp_res_7;imp_res_8;imp_res_9;
%     imp_res_10;imp_res_11;imp_res_12;imp_res_13;imp_res_14;imp_res_15;imp_res_16;imp_res_17;imp_res_18;imp_res_19;];
% figure
% hold on
% time=time_1(9500:18000);
% for i = 1:19
%     plot3(i*ones(size(time)),time,imp(i,9500:18000),'k','linewidth',2)
% end
% xlabel('# of imp. resp. sample')
% ylabel('Time (ns)')
% grid on
% axis tight
% view(3)
% set(gca,'fontsize',18)
%
%
% norm_data = (imp(10,:) - min(imp(10,:))) / ( max(imp(10,:)) - min(imp(10,:)) );
% norm_data(norm_data==max(norm_data(:))) = 0;
%
% figure
% plot(time_1(1:5:2e4)/10,norm_data(1:5:2e4),'linewidth',2)
% hold on
% plot(time_1(1111),0.01589,'ko','linewidth',2,'markersize',12,'markerfacecolor','r')
% plot(time_1(1340),0.01097,'ko','linewidth',2,'markersize',12,'markerfacecolor','r')
%
% ylabel('Amplitude (W)')
% xlabel('Time (ns)')
% set(gca,'fontsize',20)
% ylim([0 0.02])
% grid on;

% save impulse_response imp

% downed=imp(10,1:100:end);
%
% fc=200e6;
% fs=1e10;
%
% %  [b,a] = butter(1,.5);
%  [b,a] = butter(1,fc/(fs/2));
%
% figure
% freqz(b,a)
% % datafilt=filtfilt(b,a,P1);
%
% %  datafilt=filtfilt(b,a,downed);
%   datafilt=filter(b,a,downed);
%
% % figure
% %
% % plot(P1)
%
% figure
% plot(downed)
%
%
% figure
% plot(datafilt)
