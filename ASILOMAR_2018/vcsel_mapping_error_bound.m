clear all;close all;clc
%%
print_figures=1;%%
set(0,'DefaultFigureWindowStyle','docked')
%%
% load corridor_model veh_true veh_est mu1
load to_wall veh_true 
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
for i=1:190


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
    imP1=gaussian(t1,x_t1,P1);

%       figure(1)
%       plot(1:length(imP1),imP1)
%       pause(.5)
% %      [peaks,groups,criterion] = peaksandgroups(imP1,3,1);

     [peaks1,groups1,criterion1] = peaksandgroups(imP1(9999:1.8e4),3,1);

     peaks=9998+peaks1
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
%     scale=0.1;
%     figure(2)
%      plot(veh_true(1,i)*scale, veh_true(2,i)*scale, 'b-','linewidth',2)
%     hold on
%  
%     plot(xWall*scale, yWall*scale,'-k','linewidth',2)
%     plot(x_led*scale,y_led*scale,'r^','markerfacecolor','y','markersize',12)
%     
%     plot(veh_true(1,i)*scale,veh_true(2,i)*scale,'rs','markerfacecolor','y','markersize',12)
end

scale=0.1;
figure
 for i=1:190


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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=191:210


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
    imP1=gaussian(t1,x_t1,P1);

%       figure(1)
%       plot(1:length(imP1),imP1)
%       pause(.5)
% %      [peaks,groups,criterion] = peaksandgroups(imP1,3,1);

     [peaks1,groups1,criterion1] = peaksandgroups(imP1(9999:1.8e4),3,1);

     peaks=9998+peaks1
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
%     scale=0.1;
%     figure(2)
%      plot(veh_true(1,i)*scale, veh_true(2,i)*scale, 'b-','linewidth',2)
%     hold on
%  
%     plot(xWall*scale, yWall*scale,'-k','linewidth',2)
%     plot(x_led*scale,y_led*scale,'r^','markerfacecolor','y','markersize',12)
%     
%     plot(veh_true(1,i)*scale,veh_true(2,i)*scale,'rs','markerfacecolor','y','markersize',12)
end

scale=0.1;
figure
 for  i=191:210


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

 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 for i=211:400


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
    imP1=gaussian(t1,x_t1,P1);

%       figure(1)
%       plot(1:length(imP1),imP1)
%       pause(.5)
% %      [peaks,groups,criterion] = peaksandgroups(imP1,3,1);

     [peaks1,groups1,criterion1] = peaksandgroups(imP1(9999:1.8e4),3,1);

     peaks=9998+peaks1
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
%     scale=0.1;
%     figure(2)
%      plot(veh_true(1,i)*scale, veh_true(2,i)*scale, 'b-','linewidth',2)
%     hold on
%  
%     plot(xWall*scale, yWall*scale,'-k','linewidth',2)
%     plot(x_led*scale,y_led*scale,'r^','markerfacecolor','y','markersize',12)
%     
%     plot(veh_true(1,i)*scale,veh_true(2,i)*scale,'rs','markerfacecolor','y','markersize',12)
end

scale=0.1;
figure
 for i=211:400


    plot(veh_true(1,i)*scale, veh_true(2,i)*scale, 'b-','linewidth',2)
    hold on
    plot(xWall*scale, yWall*scale,'-k','linewidth',2)
    plot(x_led*scale,y_led*scale,'r^','markerfacecolor','y','markersize',12)
    
    plot(veh_true(1,i)*scale,veh_true(2,i)*scale,'rs','markerfacecolor','y','markersize',12)
 %% north-south
    plot(veh_true(1,i)*scale,(veh_true(2,i)+beta1(i)*10)*scale,' b.','markerfacecolor','y','markersize',12)
    wall_pos_north_part(:,i)=[veh_true(1,i)*scale,(veh_true(2,i)+beta1(i)*10)*scale];
    
    plot(veh_true(1,i)*scale,(veh_true(2,i)-((beta2(i))*10))*scale,'r.','markerfacecolor','y','markersize',12)
    wall_pos_south_part(:,i)=[veh_true(1,i)*scale,(veh_true(2,i)-((beta2(i))*10))*scale];

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%