function f=GA_LQR(x)


%% 设置QRN
% Q=[0,0,0,0,0;0,0,0,0,0;0,0,(x(2)+ks.^2/mb.^2),-(x(2)+ks.^2/mb.^2),0;0,0,-(x(2)+ks.^2/mb.^2),(x(1)+x(2)+ks.^2/mb.^2),-x(1);0,0,0,-x(1),x(1)];
% R=1/mb.^2;
% N=[0;0;-ks;ks;0]*(1/mb.^2);
[A,B,C,D,d] = set_Fun(1);
Q1 = diag(x);
Q = C'*(Q1)*C;
R = D'*(Q1)*D;
N = C'*(Q1)*D;
[K,S,E]=lqr(A,B,Q,R,N);
assignin('base','K',K);
assignin('base','Q1',Q1);
assignin('base','Q',Q);
assignin('base','R',R);
assignin('base','N',N);

logOut= sim('suspension',[0,20]);

y1 = logOut.yout{1}.Values.Data;
y2 = logOut.yout{2}.Values.Data;
y3 = logOut.yout{3}.Values.Data;

%%%%%%%%%%%%% the Fitness Value %%%%%%%%%%%

BA_RMS=sqrt(sum(y1.*y1)/size(y1,1));
SWS_RMS=sqrt(sum(y2.*y2)/size(y2,1));
DTD_RMS=sqrt(sum(y3.*y3)/size(y3,1));

BA_pas=1.7816;
SWS_pas=17.1284;
DTD_pas=6.2526;

if (BA_RMS>BA_pas)|(SWS_RMS>SWS_pas)|(DTD_RMS>DTD_pas)
    f=BA_RMS/BA_pas+SWS_RMS/SWS_pas+DTD_RMS/DTD_pas+10;
else
    f=BA_RMS/BA_pas+SWS_RMS/SWS_pas+DTD_RMS/DTD_pas;
end
disp(K)

end