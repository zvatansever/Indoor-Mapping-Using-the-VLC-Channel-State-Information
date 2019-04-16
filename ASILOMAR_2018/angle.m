function radian=angle(A,B)
%%
%   this function is to compute the include angle between the two vectors we
%   give
%%
radian=acos(dot(A,B)/(norm(A)*norm(B)));
end