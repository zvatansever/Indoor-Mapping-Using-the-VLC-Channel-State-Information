function [X,Y]=circle(center,radius,NOP,style)
%---------------------------------------------------------------------------------------------
% H=CIRCLE(CENTER,RADIUS,NOP,STYLE)
% This routine draws a circle with center defined as
% a vector CENTER, radius as a scaler RADIS. NOP is 
% the number of points on the circle. As to STYLE,
% use it the same way as you use the rountine PLOT.
% Since the handle of the object is returned, you
% use routine SET to get the best result.
%
%   Usage Examples,
%
%   circle([1,3],3,1000,':'); 
%   circle([2,4],2,1000,'--');
%
%---------------------------------------------------------------------------------------------
% 
% if (nargin <3)
%  error('Please see help for INPUT DATA.');
% elseif (nargin==3)
%     style='b-';
% end;
THETA=linspace(0,2*pi,NOP);
RHO=ones(1,NOP)*radius;
[X,Y] = pol2cart(THETA,RHO);
X=X+center(1);
Y=Y+center(2);
plot(X,Y,style);
%axis square;
%axis([0 50 0 50])
%xlabel('Length of Table','fontsize',12,'fontweight','b')
%ylabel('Width of Table','fontsize',12,'fontweight','b')
%title('Top View of LED Propagation Cone Intensity','fontsize',14,'fontweight','b')