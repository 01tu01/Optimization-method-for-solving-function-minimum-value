function [xmin, fval, k] = f3d2p(f, a1, a2, a3, delta)
    % f是所求函数表达式，a1是第1个迭代点
    % a2是第2个迭代点，a3是第3个迭代点
    % xmin是极小点，fval是极小值，k是迭代步数
    tic;
    format long
    % x = symvar(f);
    phi1 = f(a1);
    phi2 = f(a2);
    phi3 = f(a3);
    bar_a = ((a2^2 - a3^2) * phi1 + (a3^2 - a1^2) * phi2 + (a1^2 - a2^2) * phi3) / ((a2 - a3) * phi1 + (a3 - a1) * phi2 + (a1 - a2) * phi3) / 2;
    bar_phi = f(bar_a);
    k = 0;
    fprintf('k \t a1 \t a2 \t a3 \t bar_a \t phi1 \t phi2 \t phi3 \t bar_phi\n');
    fprintf('%d \t %.5f \t %.5f \t %.5f \t %.5f \t %.5f \t %.5f \t %.5f \t %.5f\n', k, a1, a2, a3, bar_a, phi1, phi2, phi3, bar_phi);

    while true

        if bar_a > a2

            if bar_phi <= phi2

                if abs(a2 - bar_a) < delta
                    break;
                end

                a1 = a2; a2 = bar_a; phi1 = phi2; phi2 = bar_phi;
                bar_a = ((a2^2 - a3^2) * phi1 + (a3^2 - a1^2) * phi2 + (a1^2 - a2^2) * phi3) / ((a2 - a3) * phi1 + (a3 - a1) * phi2 + (a1 - a2) * phi3) / 2; bar_phi = f(bar_a); k = k + 1;
                fprintf('%d \t %.5f \t %.5f \t %.5f \t %.5f \t %.5f \t %.5f \t %.5f \t %.5f\n', k, a1, a2, a3, bar_a, phi1, phi2, phi3, bar_phi);
            else

                if abs(a3 - bar_a) < delta
                    break;
                end

                a3 = bar_a; phi3 = bar_phi;
                bar_a = ((a2^2 - a3^2) * phi1 + (a3^2 - a1^2) * phi2 + (a1^2 - a2^2) * phi3) / ((a2 - a3) * phi1 + (a3 - a1) * phi2 + (a1 - a2) * phi3) / 2; bar_phi = f(bar_a); k = k + 1;
                fprintf('%d \t %.5f \t %.5f \t %.5f \t %.5f \t %.5f \t %.5f \t %.5f \t %.5f\n', k, a1, a2, a3, bar_a, phi1, phi2, phi3, bar_phi);
            end

        else

            if bar_phi <= phi2

                if abs(a2 - bar_a) < delta
                    break;
                end

                a3 = a2; a2 = bar_a; phi3 = phi2; phi2 = bar_phi;
                bar_a = ((a2^2 - a3^2) * phi1 + (a3^2 - a1^2) * phi2 + (a1^2 - a2^2) * phi3) / ((a2 - a3) * phi1 + (a3 - a1) * phi2 + (a1 - a2) * phi3) / 2; bar_phi = f(bar_a); k = k + 1;
                fprintf('%d \t %.5f \t %.5f \t %.5f \t %.5f \t %.5f \t %.5f \t %.5f \t %.5f\n', k, a1, a2, a3, bar_a, phi1, phi2, phi3, bar_phi);
            else

                if abs(a1 - bar_a) < delta
                    break;
                end

                a1 = bar_a; phi1 = bar_phi;
                bar_a = ((a2^2 - a3^2) * phi1 + (a3^2 - a1^2) * phi2 + (a1^2 - a2^2) * phi3) / ((a2 - a3) * phi1 + (a3 - a1) * phi2 + (a1 - a2) * phi3) / 2; bar_phi = f(bar_a); k = k + 1;
                fprintf('%d \t %.5f \t %.5f \t %.5f \t %.5f \t %.5f \t %.5f \t %.5f \t %.5f\n', k, a1, a2, a3, bar_a, phi1, phi2, phi3, bar_phi);
            end

        end

    end

    xmin = vpa(bar_a, 5); fval = vpa(f(bar_a), 5);
    toc;

end
