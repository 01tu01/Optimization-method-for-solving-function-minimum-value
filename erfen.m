function [xmin, fval, k] = erfen(f, df, a, b, delta)
    % f是所求函数表达式，df是所求函数的导数
    % a是区间左端点，b是区间右端点，delta是最终区间长度
    % xmin是极小点，fval是极小值，k是迭代步数
    tic;
    format long
    k = 1; c = (a + b) / 2;
    x = symvar(f); y = symvar(df);
    fprintf('k \t [a_k, b_k]\n');
    fprintf('%d \t [%.5f,%.5f]\n', k, a, b);

    while true

        if subs(df, y, c) == 0
            xmin = vpa(c, 5);
            fval = vpa(subs(f, x, c), 5);
            break;
        elseif subs(df, y, c) > 0
            a = a; b = c;

            if b - a <= delta
                k = k + 1;
                fprintf('%d \t [%.5f,%.5f]\n', k, a, b);
                xmin = vpa((a + b) / 2, 5);
                fval = vpa(subs(f, x, (a + b) / 2), 5);
                break;
            else
                c = (a + b) / 2; k = k + 1;
                fprintf('%d \t [%.5f,%.5f]\n', k, a, b);
            end

        else
            a = c; b = b;

            if b - a <= delta
                k = k + 1;
                fprintf('%d \t [%.5f,%.5f]\n', k, a, b);
                xmin = vpa((a + b) / 2, 5);
                fval = vpa(subs(f, x, (a + b) / 2), 5);
                break;
            else
                c = (a + b) / 2; k = k + 1;
                fprintf('%d \t [%.5f,%.5f]\n', k, a, b);
            end

        end

    end

    toc;

end
