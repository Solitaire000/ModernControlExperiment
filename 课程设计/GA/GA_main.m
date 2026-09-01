clear
clc

%% 设置初始参数
% 建立主动悬架模型
[A,B,C,D,d] = set_Fun(1);
ss_sys = ss(A,B,C,D);
[num,den] = ss2tf(A,B,C,D);
tf_sys_y1 = tf(num(1,:),den);
tf_sys_y2 = tf(num(2,:),den);
tf_sys_y3 = tf(num(3,:),den);

num_y1 = num(1,:);
num_y2 = num(2,:);
num_y3 = num(3,:);

ms = 1173;
mu = 152.1;
ks = 60000;
kt = 362000;
c = 2050;
xr = 0;
disp("successfully");
% 设置迭代初始增益矩阵
K=[0.1 0.1 0.1];


%% 其他
G0=5*1e-6;
u=20;
f0=0.1;
 


fitnessfcn = @GA_LQR;     % 适应度函数句柄
nvars=3;                  % 个体的变量数目
LB = [0.1 0.1 0.1];       % 上限
UB = [1e6 1e6 1e6];       % 下限
options=gaoptimset('PopulationSize',100,'PopInitRange',[LB;UB],'EliteCount',10,'CrossoverFraction',0.4,'Generations',20,'StallGenLimit',20,'TolFun',1e-100,'PlotFcns',{@gaplotbestf,@gaplotbestindiv});%参数设置
[x_best,fval]=ga(fitnessfcn,nvars, [],[],[],[],LB,UB,[],options); 
