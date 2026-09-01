num = 2;
den = [1,5,4,2];
sys=tf(num,den);

[A,B,C,D] = tf2ss(num,den)
%% 阶跃响应
% 定义时间向量  
t = 0:0.01:50;  % 从 0 到 10 秒，步长为 0.01 秒  
step(sys,t)
grid on;

