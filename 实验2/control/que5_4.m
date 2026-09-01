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
% C = [1,0, 0, 0;
%     0,0,1,0];

C = [1, 0, 0, 0];
D = [0];
% 状态空间方程模型
SS = ss(A,B,C,0);


% 传递函数模型
[num,den] = ss2tf(A,B,C,D);

TF = tf(num,den);

%% 1.可控性和可观性判断
% 检查可控性
ControllabilityMatrix = ctrb(A, B);
if rank(ControllabilityMatrix) == size(A, 1)
    disp('系统是可控的。');
else
    disp('系统不是可控的。');
end
 
% 检查可观性
ObservabilityMatrix = obsv(A, C);
if rank(ObservabilityMatrix) == size(A, 1)
    disp('系统是可观的。');
else
    disp('系统不是可观的。');
end


%% 极点配置
figure
pzmap(TF) % 绘制零极点图
grid on
[ZT,PT,gain] = ss2zp(A,B,C,D) % 将状态空间方程转换为零极点增益形式

%% 确定反馈增益
P =[-2;-1+2i;-1-2i;-1];
K = place(A,B,P)

%% 新的系统方程
figure
[num1,den1] = ss2tf(A-B*K,B,C,D);
TF1 = tf(num1,den1)
pzmap(TF1)
% 可选：添加格网以更清晰地显示复数区域
grid on
 
% 可选：设置极点和极径的标记样式
% set(findobj(gca, 'Type', 'line'), 'MarkerSize', 10, 'MarkerEdgeColor', 'b', 'MarkerFaceColor', 'b');
% %set(findobj(gca, 'Type', 'patch'), 'FaceColor', 'r', 'EdgeColor', 'r');
% 
% % 可选：设置图例
% legend('极点', '极径');
% 
% % 可选：设置标题
% title('极点图');
[ZT1,PT1,gain1] = ss2zp(A-B*K,B,C,D) 

figure;
TF_f = feedback(TF1,-1);
t = 0:0.01:50;  % 从 0 到 10 秒，步长为 0.01 秒  
step(TF_f,t)
grid on;
