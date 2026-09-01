function [A,B,C,D,d] = set_Fun(flag)
    % clc;clear;
    % 系统参数
    ms = 1173;
    mu = 152.1;
    ks = 60000;
    kt = 362000;
    c = 2050;
    xr = 0;
    % ms = 332;
    % mu = 43.5;
    % ks = 25800;
    % kt = 198000;
    % c = 1200;
    % xr = 0;
    if flag == 0
        %% 被动悬架控制矩阵
        d=[];
        A = [0 1 0 0;
        -ks/ms -c/ms ks/ms c/ms;
        0 0 0 1;
        ks/mu c/mu -(kt+ks)/mu -c/mu];
        % 以xr为输入变量
        B = [0 0 0 kt/mu]';
        C = [-ks/ms -c/ms ks/ms c/ms;
            1 0 -1 0;
            0 0 1 0];
        D = [0 0 0]';
    else
        %% 半主动悬架控制矩阵
        A = [0 1 0 0;
            -ks/ms -c/ms ks/ms c/ms;
            0 0 0 1;
            ks/mu c/mu -(kt+ks)/mu -c/mu];
        B = [0 1/ms 0 -1/mu]';
        d = [0 0 0 kt/mu*xr]';
        C = [-ks/ms -c/ms ks/ms c/ms;
            1 0 -1 0;
            0 0 1 0];
        D = [1/ms 0 0]';
    end




end