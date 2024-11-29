% this code shows an example about the defference between different
% improvement in one_sided_jabovi func.


clear; close all; clc;

addpath('func\');

% Initialize
nlen = 20;
mtdlen = 4;
rep = 10;
ms = floor(linspace(50, 300, nlen));
ns = floor(linspace(25, 150, nlen));
ks = floor(linspace(10, 60, nlen));
methods = {'none', 'derijk', 'qr', 'derijk-qr'};
scan = zeros(nlen, mtdlen);
trans = zeros(nlen, mtdlen);

% compute results
for i = 1:nlen
    for r = 1:rep
        A = rand(ms(i), ns(i));
        [U, D, V] = svd(A);
        A = U(:, 1:ks(i)) * D(1:ks(i), 1:ks(i)) * V(:, 1:ks(i))';
        for m = 1:mtdlen
            [~, ~, ~, s, t] = One_sided_jacobi(A, methods{m});
            scan(i, m) = scan(i, m) + s;
            trans(i, m) = trans(i, m) + t;
        end
    end
end
scan = scan ./ rep;
trans = trans ./ rep;

% show picture
figure(1);
plot(ns, scan, '.-', 'LineWidth', 1);
legend(methods);
xlabel('dim: $2n \times n$');
ylabel('Scanning times');
set(gca,'TickLabelInterpreter','latex');
title('Experiment: Scanning times');
figure(2);
plot(ns, sqrt(trans), '.-', 'LineWidth', 1);
legend(methods);
xlabel('dim: $2n \times n$');
ylabel('Transformation Times$^{1/2}$');
set(gca,'TickLabelInterpreter','latex');
title('Experiment: Transformation times');