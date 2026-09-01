clc;clear;
[A,B,C,D,d] = set_Fun();
ss_sys = ss(A,B,C,D);
[num,den] = ss2tf(A,B,C,D);
tf_sys_y1 = tf(num(1,:),den);
tf_sys_y2 = tf(num(2,:),den);
tf_sys_y3 = tf(num(3,:),den);

%% 绘制零极点分布图
figure;
subplot(1,2,1);
pzmap(tf_sys_y1)
grid on;
% 绘制根轨迹分布图
subplot(1,2,2);
rlocus(tf_sys_y1)
grid on;

%% 绘制零极点分布图
figure;
subplot(1,2,1);
pzmap(tf_sys_y2)
grid on;
% 绘制根轨迹分布图
subplot(1,2,2);
rlocus(tf_sys_y2)
grid on;

%% 绘制零极点分布图
figure;
subplot(1,2,1);
pzmap(tf_sys_y3)
grid on;
% 绘制根轨迹分布图
subplot(1,2,2);
rlocus(tf_sys_y3)
grid on;