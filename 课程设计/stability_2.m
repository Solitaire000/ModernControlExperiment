[A,B,C,D,d] = set_Fun(0);

Q=eye(4,4);
P=lyap(A,Q)
flag = 0;
n = length(A);
% 判断矩阵P是否稳定
for i=1:n
    if(det(P(1:i,1:i))<=0)
        flag = 1;
    end
end
if flag==1
    disp("系统稳定");
else
    disp("系统不稳定");
end
