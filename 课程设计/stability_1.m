
[A,B,C,D,d] = set_Fun(0);
[Q,labmda] = eig(A)

ss_sys = ss(A,B,C,D);
pzmap(ss_sys);
grid on;
stability = all(isstable(ss_sys));
if stability
    disp('系统是稳定的。');
else
    disp('系统是不稳定的。');
end
