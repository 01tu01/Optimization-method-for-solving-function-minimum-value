function [xmin, fval, k] = newton(f, df, ddf, a1, delta)
    % f是所求函数表达式，df是导数
    % ddf是二阶导，a1是起始迭代点
    % xmin是极小点，fval是极小值，k是迭代步数
    tic;
    format long
    phi = f(a1); dphi = df(a1); ddphi = ddf(a1);
    k = 0;
    fprintf('k \t a\n');
    fprintf('%d \t %.5f\n', k, a1);

    if abs(dphi) <= delta
        xmin = vpa(a1, 5); fval = vpa(f(a1), 5);
    end

    while true

        a2 = a1 - dphi / ddphi; dphi = df(a2); ddphi = ddf(a2); k = k + 1;
        fprintf('%d \t %.5f\n', k, a2);

        if abs(dphi) <= delta || abs(a2 - a1) <= delta
            xmin = vpa(a2, 5); fval = vpa(f(a2), 5);
            break;
        end

        a1 = a2;

    end

    toc;

end
