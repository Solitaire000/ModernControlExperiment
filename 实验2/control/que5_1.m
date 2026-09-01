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

%% Q R矩阵
Q = [100,0,0,0;
    0,0,0,0;
    0,0,10,0;
    0,0,0,0];
R = 1;

%% 传递函数
disp("连续型状态空间模型：")
S1 = ss(A,B,C,0)
Ts = 0.1; % 采样时间

%% 可控性和可观性判断
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

%% 连续系统离散化
% 离散型状态空间模型
Sd = c2d(S1,Ts); % 连续系统离散化
[Ad,Bd,Cd,Dd,TS] = ssdata(Sd); % 提取状态空间矩阵

%% LQR
[K,S,e] = dlqr(Ad,Bd,Q,R); % 用来计算最有增益矩阵K

%% 使用状态反馈生成新的系统
disp("LQR优化后的状态空间模型：")
tS = ss(Ad-Bd*K,Bd,Cd,Dd,Ts)

%% 配置初始状态，生成曲线图
x0 = [0,0.1,0.05,0]'; % P'=0.1;theta=0.05
t=0:0.1:20; % timespan
[Y,~] = initial(tS,x0,t); % 计算初始状态值, 返回值是个系统

%% 绘制最优状态轨迹：位移和角度
figure; 
pos = Y(:,1);
angle = Y(:,2);
plot(t,angle,'linewidth',1.3);hold on
plot(t,pos,'linewidth',1.3);
legend('angle','pos')
grid on
title('Optimal State Trajectory')

%% 绘制最优控制 u(t)
dpos = [];dangle = [];
for i = 1:length(pos)-1
    dpos = [dpos; pos(i+1)-pos(i)];
    dangle = [dangle; angle(i+1)-angle(i)];
end
x = [pos(1:end-1),dpos,angle(1:end-1),dangle];
u = -K*x';
figure;
plot(t(1:end-1),u,'linewidth',1.3)
grid on
title('Optimal U(t)=F')


