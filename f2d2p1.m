function [xmin, fval, k] = f2d2p1(f, df, a1, a2, delta)
    % f是所求函数表达式，df是导数
    % a1是第1个迭代点(利用a1的导数信息)，a2是第2个迭代点
    % xmin是极小点，fval是极小值，k是迭代步数
    tic;
    format long
    phi1 = f(a1); a = a2 - a1; dphi = df(a1); k = 0;
    fprintf('k \t a\n');
    fprintf('%d \t %.5f\n', k, a1);

    if dphi < 0
        a = abs(a);
    else
        a = -abs(a);
    end

    while true

        a2 = a1 + a; phi2 = f(a2); k = k + 1;
        fprintf('%d \t %.5f\n', k, a2);

        if phi2 <= phi1 + dphi * (a2 - a1)
            a = 2 * a;
        else
            a2 = a1 - ((a1 - a2) * dphi) / (dphi - (phi1 - phi2) / (a1 - a2)) / 2;
            phi = f(a2); dphi = df(a2); k = k + 1;
            fprintf('%d \t %.5f\n', k, a2);

            if abs(dphi) < delta || abs(a2 - (a1 + a)) < delta
                xmin = vpa(a2, 5); fval = vpa(f(a2), 5);
                break;
            else
                a1 = a2; phi1 = phi; a = 0.6 * a;

                if dphi < 0
                    a = abs(a);
                else
                    a = -abs(a);
                end

            end

        end

    end

    toc;

end
