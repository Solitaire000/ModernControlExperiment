clc;clear;
[A,B,C,D,d] = set_Fun(0);
ss_sys = ss(A,B,C,D);
controllability_ss = ctrb(ss_sys)
n = rank(controllability_ss);
if rank(controllability_ss) == size(ss_sys.A,1);
    disp('通过状态空间模型验证，系统是可控的。');
else
    disp('通过状态空间模型验证，系统是不可控的。');
end

% 判断可观性（对于状态空间模型）
observability_ss = obsv(ss_sys)
 n = rank(controllability_ss);
if rank(observability_ss) == size(ss_sys.A, 1)
    disp('通过状态空间模型验证，系统是可观的。');
else
    disp('通过状态空间模型验证，系统是不可观的。');
end
