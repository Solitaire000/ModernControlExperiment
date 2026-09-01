clc;clear;
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