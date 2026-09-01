% clear;
clc;

% 定义传递函数的分子和分母多项式系数
numerator = [1 6 8];  
denominator = [1 4 3];

% 创建传递函数对象
sys = tf(numerator, denominator);
%% 判断稳定性
% isstable()函数通过零极点位置判断系统稳定性
pzmap(sys);
grid on;
[ZT,PT,gain] =tf2zp(numerator,denominator);
stability = all(isstable(sys));
if stability
    disp('系统是稳定的。');
else
    disp('系统是不稳定的。');
end


% 转换为状态空间模型
ss_sys = ss(sys)
% 判断可控性（对于状态空间模型）
controllability_ss = ctrb(ss_sys);
if rank(controllability_ss) == size(ss_sys.A,1)
    disp('通过状态空间模型验证，系统是可控的。');
else
    disp('通过状态空间模型验证，系统是不可控的。');
end

% 判断可观性（对于状态空间模型）
observability_ss = obsv(ss_sys)
if rank(observability_ss) == size(ss_sys.A, 1);
    disp('通过状态空间模型验证，系统是可观的。');
else
    disp('通过状态空间模型验证，系统是不可观的。');
end