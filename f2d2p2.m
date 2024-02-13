function [xmin, fval, k] = f2d2p2(f, df, a1, a2, delta)
    % f是所求函数表达式，df是导数
    % a1是第1个迭代点(利用其函数值信息)，a2是第2个迭代点
    % xmin是极小点，fval是极小值，k是迭代步数
    tic;
    format long
    phi1 = f(a1); a = a2 - a1;
    dphi1 = df(a1); dphi2 = df(a2); k = 0;
    fprintf('k \t a\n');
    fprintf('%d \t %.5f\n', k, a1);

    if abs(dphi1) <= delta
        xmin = vpa(a1, 5); fval = vpa(f(a1), 5);
        return;
    end

    if dphi1 < 0
        a = abs(a);
    else
        a = -abs(a);
    end

    while true

        a2 = a1 + a; phi2 = f(a2); dphi2 = df(a2);

        if abs(dphi2) <= delta
            xmin = vpa(a2, 5); fval = vpa(f(a2), 5);
            break;
        end

        if dphi1 * dphi2 > 0
            a = 2 * a; a1 = a2; phi1 = phi2; dphi1 = dphi2; k = k + 1;
            fprintf('%d \t %.5f\n', k, a1);
        else
            bar_a = a1 - ((a2 - a1) * dphi1) / (dphi2 - dphi1);
            phi2 = f(a2); dphi1 = df(a2);

            if abs(df(bar_a)) < delta || abs(bar_a - a2) < delta
                xmin = vpa(bar_a, 5); fval = vpa(f(bar_a), 5);
                break;
            else
                a = 0.1 * a; a1 = bar_a; phi1 = f(bar_a);
                dphi1 = df(bar_a); k = k + 1;
                fprintf('%d \t %.5f\n', k, a1);

                if dphi1 < 0
                    a = abs(a);
                else
                    a = -abs(a);
                end

            end

        end

    end

    toc;

end
