clc;
clear;
%% 状态空间模型
% 三个状态变量：h vec acc
A = [0 1 0;
     0 0 1;
     0 0 -0.5];

B = [0 0 0.5]';

% 两个输出：h vec
C = [1 0 0;
     0 1 0;
     0 0 1];

%% Cost-Fnc wight matrix init
Q = [1,0,0;
    0,0,0;
    0,0,0];
R = 2;

%% 传递函数
S1 = ss(A,B,C,0);
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
Sd = c2d(S1,Ts); % 连续系统离散化
[Ad,Bd,Cd,Dd,TS] = ssdata(Sd); % 提取状态空间矩阵

%% LQR
[K,S,e] = dlqr(Ad,Bd,Q,R); % 用来计算最有增益矩阵K

%% 使用状态反馈生成新的系统
tS = ss(Ad-Bd*K,Bd,Cd,Dd,Ts);

%% 配置初始状态，生成曲线图
x0 = [10,0,0]'; % 
t=0:0.1:30; % timespan
[Y,~] = initial(tS,x0,t); % 计算状态空间模型对初始状态的响应

%% 绘制最优状态轨迹：位移和速度和加速度
figure; 
pos = Y(:,1);
vec = Y(:,2);
acc = Y(:,3);
plot(t,pos,'linewidth',1.3);hold on
plot(t,vec,'linewidth',1.3);
plot(t,acc,'linewidth',1.3);
legend('pos','vec','acc')
grid on
title('最优状态轨迹')

% 绘制最优控制 u(t)
dvec = [];
for i = 1:length(pos)-1
    dvec = [dvec; vec(i+1)-vec(i)];
end
x = [pos(1:end-1),vec(1:end-1),dvec]
u = -K*x';
figure;
plot(t(1:end-1),u,'linewidth',1.3)
grid on
title('油门输入')


