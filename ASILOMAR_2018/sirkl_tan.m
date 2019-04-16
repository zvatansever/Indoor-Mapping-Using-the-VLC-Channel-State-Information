function H=sirkl_tan(centers,radii)
%......................................................................
% H=SIRKL(CENTERs,RADII)

% This routine draws a circles with centers defined as a vector CENTERS,
% radius as a vector RADII and also plots external tangents to them. 
%
%   Usage Example,
%
%   sirkl([1 3 5 3],[3 1]); 
%
%   Kaushik Kandakatla <kkaushik@ymail.com>
%   Version 1.00
%   July, 2011

%give centers as a array for example [1 3 5 3] for (1,3) and (5,3) as
%centers

%radii is simply a vector of a non-negative number for example [3 1] for
%radius of two circles as 3 and 1.
%........................................................................
p1=centers(1);
q1=centers(2);
p2=centers(3);
q2=centers(4);
r1=radii(1);
r2=radii(2);
rad=2*radii(1);
n_coor=centers(1:2)-[radii(1) radii(1)];
H=rectangle ('position', [n_coor, rad, rad], 'curvature', [1, 1]); %first circle
daspect([1 1 1]);
rad=2*radii(2);
n_coor=centers(3:4)-[radii(2) radii(2)];
H=rectangle ('position', [n_coor, rad, rad], 'curvature', [1, 1]); %second circle
daspect([1 1 1]);
hold on;
plot(p1,q1,'.');
hold on;
plot(p2,q2,'.');
d2 = (p2-p1)^2+(q2-q1)^2;
r = sqrt(d2-(r2-r1)^2);
s = ((q2-q1)*r+(p2-p1)*(r2-r1))/d2;
c = ((p2-p1)*r-(q2-q1)*(r2-r1))/d2;
x1 = p1-r1*s;
y1 = q1+r1*c;
x2 = p2-r2*s;
y2 = q2+r2*c;
hold on;
plot([x1 x2],[y1 y2]);%plotting first external common tangent
m=(q2-q1)/(p2-p1);
xc1=(p1*m^2-m*q1+m*y1+x1)/(m^2+1);
yc1=(y1*m^2+(x1-p1)*m+q1)/(m^2+1);
xp1=2*xc1-x1;
yp1=2*yc1-y1;
xc2=(p1*m^2-m*q1+m*y2+x2)/(m^2+1);
yc2=(y2*m^2+(x2-p1)*m+q1)/(m^2+1);
xp2=2*xc2-x2;
yp2=2*yc2-y2;
hold on;
plot([xp1 xp2],[yp1 yp2]);%plotting second external common tangent