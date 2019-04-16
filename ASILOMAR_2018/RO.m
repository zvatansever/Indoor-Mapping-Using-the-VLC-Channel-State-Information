% Lambertian radiant intensity, Ro

function [Ro] = RO(Irrad_angle,dist,semi)  

m = -log(2)/log(cos(pi/180*semi));
Ro = ((m+1)/((2*pi)*(dist)^2))*cos(Irrad_angle)^m;




