% function [ reflection_point ] = newfun( diffusion_point, cT1, cT2,cT3, TP, RP1, RP2, RP3 )
function [ F,beta ] = funfun(x,alpha, h, d1, cT )
% reflection_point=[sqrt(dot(TP-diffusion_point,TP-diffusion_point))+...
%                   sqrt(dot(diffusion_point-RP1,diffusion_point-RP1))-cT1];
%                   sqrt(dot(TP-diffusion_point,TP-diffusion_point))+...
%                   sqrt(dot(diffusion_point-RP2,diffusion_point-RP2))-cT2;
%                   sqrt(dot(TP-diffusion_point,TP-diffusion_point))+...
%                   sqrt(dot(diffusion_point-RP3,diffusion_point-RP3))-cT3;];
% x(1)=beta;
% x(2)=z;
% x(3)=h-z;
% x(4)=d2
% x(5)=d3
%

F= [ d1-sqrt(alpha^2+h^2);
    x(4)-(((alpha+x(1))/(alpha+2*x(1)))*sqrt((alpha+2*x(1))^2+h^2));
    x(5)-(((x(1))/(alpha+2*x(1)))*sqrt((alpha+2*x(1))^2+h^2));
    sqrt((alpha+2*x(1))^2+h^2)-cT;
    h-(h-x(3))-x(3);
    ((alpha+x(1)/x(4)))-(x(1)/x(5))];
%     (x(2)/x(1))-(x(3)/(alpha+x(1)));
% x(4)-sqrt((alpha+x(1))^2+x(3)^2);
%     x(5)-sqrt(x(2)^2+x(1)^2);
end

