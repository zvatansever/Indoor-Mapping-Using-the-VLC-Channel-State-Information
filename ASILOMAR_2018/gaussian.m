function im=gaussian(t,x_t,P_r)
L_im=length(x_t);
L_t=length(t);
im=zeros(1,L_im);
% x=linspace(1,L,L);
% a=1;
% b=18;
c=1000;
for i=1:L_t
        im=im+P_r(i)*exp(-((x_t-t(i))./sqrt(2)*c).^2);
end