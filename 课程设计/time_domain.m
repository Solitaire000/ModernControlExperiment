clc;clear;
[A,B,C,D,d] = set_Fun(0);
ss_sys = ss(A,B,C,D);
[num,den] = ss2tf(A,B,C,D);
tf_sys_y1 = tf(num(1,:),den)
tf_sys_y2 = tf(num(2,:),den)
tf_sys_y3 = tf(num(3,:),den)

%% 阶跃响应
% t = 0:0.01:20;
% % 初始化信号向量，所有元素都设为0
% u = zeros(size(t));
% % 设置阶跃发生的时间点（例如，2秒）
% step_time = 2;
% % 找到阶跃点在时间向量中的索引
% step_index = find(t >= step_time, 1, 'first');
% % 在阶跃点及之后，将信号的值设为0.5
% u(step_index:end) = 0.005;


[y,t] = step(tf_sys_y1,10);
% [y, t] = lsim(tf_sys_y1, u, t);
[ys,tr,ts,tm,ov] = Fun_Step_Performance(t,y,1,"d2(xs)");
[y,t] = step(tf_sys_y2,10);
% [y, t] = lsim(tf_sys_y2, u, t);
[ys,tr,ts,tm,ov] = Fun_Step_Performance(t,y,1,"xs-xu");
[y,t] = step(tf_sys_y3,10);
% [y, t] = lsim(tf_sys_y3, u, t);
[ys,tr,ts,tm,ov] = Fun_Step_Performance(t,y,1,"xu-xr");


