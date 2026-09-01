clc;clear;
[A,B,C,D,d] = set_Fun(0);
ss_sys = ss(A,B,C,D);
[num,den] = ss2tf(A,B,C,D);
tf_sys_y1 = tf(num(1,:),den);
tf_sys_y2 = tf(num(2,:),den);
tf_sys_y3 = tf(num(3,:),den);

%% 计算期望极点
a = 0.707;
w = 10;
% p1 = -a*w+(a^2*w*2-w*2)^0.5;
% p2 = -a*w-(a^2*w*2-w*2)^0.5;
% p3 = -2;
% p4 = -1;
% p1 = -8+40i;
% p2 = -8-40i;
% p3 = -8+10i;
% p4 = -8-10i;

p1 = -10+40i;
p2 = -10-40i;
p3 = -8+10i;
p4 = -8-10i;
p = [p1 p2 p3 p4]

%% 极点配置法配置极点
figure
hold on;
% subplot(1,2,1);
pzmap(tf_sys_y1);
% [ZT,PT,Gain] = tf2zp(num(1,:),den)
%% 确定反馈增益
K = place(A,B,p)
%% 新的系统方程
% subplot(1,2,2);
[num_new,den_new] = ss2tf(A-B*K,B,C,D);
tf_sys_y1_new = tf(num_new(1,:),den_new);
tf_sys_y2_new = tf(num_new(2,:),den_new);
tf_sys_y3_new = tf(num_new(3,:),den_new);
pzmap(tf_sys_y1_new);
legend(["原系统d2(xs)输出零极点分布图","改进后系统d2(xs)输出零极点分布图"]);
grid on;
hold off;
[ZT_new,PT_new,Gain_new] = tf2zp(num_new(1,:),den_new);

%% 绘制单位阶跃对比图
[y,t] = step(tf_sys_y1,10);
[ys,tr,ts,tm,ov] = Fun_Step_Performance(t,y,1,"d2(xs)");
[y,t] = step(tf_sys_y1_new,10);
[ys,tr,ts,tm,ov] = Fun_Step_Performance(t,y,1,"d2(xs)");
% legend(["原系统d2(xs)输出阶跃响应","改进后系统d2(xs)输出阶跃响应"]);
[y,t] = step(tf_sys_y2,10);
[ys,tr,ts,tm,ov] = Fun_Step_Performance(t,y,1,"xs-xu");
[y,t] = step(tf_sys_y2_new,10);
[ys,tr,ts,tm,ov] = Fun_Step_Performance(t,y,1,"xs-xu");
[y,t] = step(tf_sys_y3,10);
[ys,tr,ts,tm,ov] = Fun_Step_Performance(t,y,1,"xu-xr");
[y,t] = step(tf_sys_y3_new,10);
[ys,tr,ts,tm,ov] = Fun_Step_Performance(t,y,1,"xu-xr");

