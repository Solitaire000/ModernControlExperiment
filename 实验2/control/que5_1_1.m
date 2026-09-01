clc
clear

%% 倒立摆参数配置
M = 2;
m = 0.1;
g = 9.8;
l =0.5;
I = 1/3*m*l^2;

%% 考虑转动惯量的矩阵参数
% a23 = -m*m*g*l*l/(I*(m+M)+M*m*l*l);
% a43 = m*g*l*(M+m)/(I*(m+M)+M*m*l*l);
% b2 = (I+m*l*l)/(I*(m+M)+M*m*l*l);
% b4 = -m*l/(I*(m+M)+M*m*l*l);


%% 不考虑转动惯量的矩阵参数
a23 = -(m*g)/M;
a43 = ((M+m)*g)/(M*l);
b2 = 1/M;
b4 = -1/(M*l);

A = [0 1 0 0;
    0 0 a23 0;
    0 0 0 1;
    0 0 a43 0];
B = [0;
    b2;
    0;
    b4];
C = [1,0, 0, 0;
    0,0,1,0];



%% 传递函数
disp("连续型状态空间模型：")
S1 = ss(A,B,C,0)

%% 可控性和可观性判断
% 检查可控性
ControllabilityMatrix = ctrb(A, B)
if rank(ControllabilityMatrix) == size(A, 1)
    disp('系统是可控的。');
else
    disp('系统不是可控的。');
end
 
% 检查可观性
ObservabilityMatrix = obsv(A, C)
if rank(ObservabilityMatrix) == size(A, 1)
    disp('系统是可观的。');
else
    disp('系统不是可观的。');
end



