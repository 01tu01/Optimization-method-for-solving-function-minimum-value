function [xmin, fval, k] = Fibonacci(f, a, b, delta)
    % f是所求函数表达式，a是区间左端点
    % b是区间右端点，delta是精度
    % xmin是极小点，fval是极小值，k是迭代步数
    tic;
    format long
    Fn = (b - a) / delta;
    F = [];
    F(1) = 1; F(2) = 1;
    i = 1;

    while F(i) < Fn
        F(i + 2) = F(i) + F(i + 1);
        i = i + 1;
    end

    n = i;
    lambda = a + F(n - 2) / F(n) * (b - a);
    mu = a + F(n - 1) / F(n) * (b - a);
    x = symvar(f);
    phi_lambda = subs(f, x, lambda);
    phi_mu = subs(f, x, mu);
    k = 0;
    fprintf('k \t [a_k, b_k] \t [lambda_k, mu_k] \t phi(lambda_k) \t phi(mu_k)\n');
    fprintf('%d \t [%.5f,%.5f] \t [%.5f,%.5f] \t %.5f \t %.5f\n', k, a, b, lambda, mu, phi_lambda, phi_mu);
    k = 1;

    while true

        if k == n - 1
            xmin = vpa(lambda, 5);
            fval = vpa(subs(f, x, lambda), 5);
            break;
        else

            if phi_lambda > phi_mu
                a = lambda; b = b; lambda = mu; phi_lambda = phi_mu;

                if k == n - 2
                    xmin = vpa(lambda, 5);
                    fval = vpa(subs(f, x, lambda), 5);
                    break;
                else
                    mu = a + F(n - k - 1) / F(n - k) * (b - a);
                    phi_mu = subs(f, x, mu); k = k + 1;
                    fprintf('%d \t [%.5f,%.5f] \t [%.5f,%.5f] \t %.5f \t %.5f\n', k, a, b, lambda, mu, phi_lambda, phi_mu);
                end

            else
                a = a; b = mu; mu = lambda; phi_mu = phi_lambda;

                if k == n - 2
                    xmin = vpa(lambda, 5);
                    fval = vpa(subs(f, x, lambda), 5);
                    break;
                else
                    lambda = a + F(n - k - 2) / F(n - k) * (b - a);
                    phi_lambda = subs(f, x, lambda); k = k + 1;
                    fprintf('%d \t [%.5f,%.5f] \t [%.5f,%.5f] \t %.5f \t %.5f\n', k, a, b, lambda, mu, phi_lambda, phi_mu);
                end

            end

        end

    end

    toc;

end
