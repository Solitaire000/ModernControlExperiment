clc
clear

% Create system model
A=[0 1 0; 0 0 1 ;-2 -4 -5];
B=[0;0;2];
C=[1 0 0];
D=0;
sys=ss(A,B,C,D);

% 定义时间向量  
t = 0:0.01:50;  % 从 0 到 10 秒，步长为 0.01 秒  
  
% 计算单位阶跃响应  
[y, t_out, x] = step(sys, t);  
  
% 提取状态变量  
y_dot = x(:, 2);  % 一阶导数 \dot{y}(t)  
y_ddot = x(:, 3); % 二阶导数 \ddot{y}(t)  
  
% 绘图  
figure;  
% subplot(3, 1, 1);  
plot(t_out, y);  
title('y(t) - 单位阶跃响应');  
xlabel('时间 (s)');  
ylabel('y(t)');  
grid on;  
  
figure;
% subplot(3, 1, 2);  
plot(t_out, y_dot);  
title('\dot{y}(t) - y(t) 的一阶导数');  
xlabel('时间 (s)');  
ylabel('\dot{y}(t)');  
grid on;  
  
figure;
% subplot(3, 1, 3);  
plot(t_out, y_ddot);  
title('\ddot{y}(t) - y(t) 的二阶导数');  
xlabel('时间 (s)');  
ylabel('\ddot{y}(t)');  
grid on;