clc
Q1 = 0.5*[1, 0, 0;
      0, 0, 0;
      0, 0, 0];
R1 = 0.5*2;
[u1,pos1,vec1,acc1] = que6_LQR(Q1,R1);

Q2 = 0.5*[1, 0, 0;
      0, 0, 0;
      0, 0, 0];
R2 = 0.5*2000;
[u2,pos2,vec2,acc2] = que6_LQR(Q2,R2);


Q3 = 0.5*[10, 0, 0;
      0, 0, 0;
      0, 0, 0];
R3 = 0.5*2;
[u3,pos3,vec3,acc3] = que6_LQR(Q3,R3);


Q4 = 0.5*[1, 0, 0;
      0, 100, 0;
      0, 0, 0];
R4 = 0.5*2;
[u4,pos4,vec4,acc4] = que6_LQR(Q4,R4);

t=0:0.1:30; % timespan
figure; 
plot(t,pos1,'linewidth',1.3);hold on
plot(t,pos2,'linewidth',1.3);
plot(t,pos3,'linewidth',1.3);
plot(t,pos4,'linewidth',1.3);
legend('pos1','pos2','pos3','pos4')
grid on
title('最优高度控制响应曲线对比')


disp("a驱动动力较小，超调量较小，但响应时间较长");
disp("c驱动动力较大，超调量较大，但响应时间较短");