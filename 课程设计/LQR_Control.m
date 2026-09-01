clc;
clear;
[A,B,C,D,d] = set_Fun(0);
ss_pasive = ss(A,B,C,D);
t=0:0.01:20; % timespan
step(ss_pasive,20)
% size(Y)
% figure; 
% pos = Y(:,1);
% vec = Y(:,2);
% acc = Y(:,3);
% plot(t,pos,'linewidth',1.3);hold on
% plot(t,vec,'linewidth',1.3);
% plot(t,acc,'linewidth',1.3);
% legend('pos','vec','acc')
% grid on
% title('被动悬架单位阶跃响应')

disp("ok")

% %% LQR控制
% Q = [1,0,0;
%     0,0,0;
%     0,0,0];
% R = 2;
% [u,pos,vec,acc] = LQR_Fun(A,B,C,D,Q,R);