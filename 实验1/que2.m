clc
clear

% 定义状态空间方程变量
A=[0 1 0; 0 0 1 ;-2 -4 -5];
B=[0;0;1];
% C=[1 0 0;
%    0 1 0;
%    0 0 1];
C = [2 0 0;
     0 2 0;
     0 0 2]
D=0;
sys=ss(A,B,C,D);

% 定义时间向量  
t = 0:0.01:50;  % 从 0 到 10 秒，步长为 0.01 秒  
  
% 计算单位阶跃响应  
[y, t_out] = step(sys, t);  
  
% 绘图  
figure;  
%subplot(3, 1, 1);  
plot(t_out, y(:,1),'LineWidth',2);  
title('y(t) 单位阶跃响应');  
xlabel('时间 (s)');  
ylabel('y(t)');  
grid on;  
  
figure;
%subplot(3, 1, 2);  
plot(t_out, y(:,2),'LineWidth',2);  
title('y(t) 一阶导数');  
xlabel('时间 (s)');  
ylabel('dy(t)');  
grid on;  
  
figure;
%subplot(3, 1, 3);  
plot(t_out, y(:,3),'LineWidth',2);  
title('y(t) 二阶导数');  
xlabel('时间 (s)');  
ylabel('d2y(t)');  
grid on;