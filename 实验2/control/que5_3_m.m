% 变量依赖于第一问
syms k1
syms k2

H = [k2 k1];

Ak = A+B*H*C;
Ak = vpa(Ak,6)

% 计算矩阵A的特征值
eigenvalues = eig(Ak);
 
% 输出特征值
disp('矩阵Ak的特征值为：');
eigenvalues = vpa(eigenvalues,6);
disp(eigenvalues);

disp("根据矩阵特征值，判断无论k1 k2为多少时，特征值均不能都为负数，所以无法通过调整k1 k2 的值来使得系统稳定.")