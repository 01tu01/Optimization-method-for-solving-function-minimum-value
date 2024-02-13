function [xmin, fval, k] = f0_618(f, a, b, delta)
    % f是所求函数表达式，a是区间左端点
    % b是区间右端点，delta是精度
    % xmin是极小点，fval是极小值，k是迭代步数
    tic;
    format long
    tau = 0.618;
    lambda = a + (1 - tau) * (b - a);
    mu = a + tau * (b - a);
    x = symvar(f);
    phi_lambda = subs(f, x, lambda);
    phi_mu = subs(f, x, mu);
    k = 0;
    fprintf('k \t [a_k, b_k] \t [lambda_k, mu_k] \t phi(lambda_k) \t phi(mu_k)\n');
    fprintf('%d \t [%.5f,%.5f] \t [%.5f,%.5f] \t %.5f \t %.5f\n', k, a, b, lambda, mu, phi_lambda, phi_mu);

    while true

        if phi_lambda > phi_mu

            if b - lambda > delta
                k = k + 1; a = lambda; b = b; lambda = mu;
                phi_lambda = phi_mu; mu = a + tau * (b - a);
                phi_mu = subs(f, x, mu);
                fprintf('%d \t [%.5f,%.5f] \t [%.5f,%.5f] \t %.5f \t %.5f\n', k, a, b, lambda, mu, phi_lambda, phi_mu);
            end

        else

            if mu - a > delta
                k = k + 1; a = a; b = mu; mu = lambda;
                phi_mu = phi_lambda; lambda = a + (1 - tau) * (b - a);
                phi_lambda = subs(f, x, lambda);
                fprintf('%d \t [%.5f,%.5f] \t [%.5f,%.5f] \t %.5f \t %.5f\n', k, a, b, lambda, mu, phi_lambda, phi_mu);
            end

        end

        if (mu - lambda) <= delta
            break;
        end

    end

    xmin = vpa((lambda + mu) / 2, 5); fval = vpa(subs(f, xmin), 5);
    toc;
end
