function [sigma,V] = two_sided_jacobi(A, method, tol)
% TWO_SIDED_JACOBI    Solve symmetric eigenvalue problem using Two-sided 
% Jacobi method
%
% This function computes eigenvalues and corresponding eigenvectors using
% Jacobi method. 
% Note here we provide some imporvements to choose.
%
% Input:
%   A: The input matrix (must be real-symmetric)
%   method (optional): 
%       'classic': using classic Jacobi method,
%       'cyclic': using cyclic Jacobi method,
%       'threshold': using threshold Jacobi method,
%
%   tol (optional): Stopping criteria
%
% Output:
%   sigma: The eigenvalues of A.
%   V = The singular vectors.
%
% usage:
%   lambda = two_sided_jacobi(A)
%       Only gets eigenvalues: lambda = [l1, l2, ..., ln]
%   [lambda, V] = two_sided_jacobi(A)
%       Computes eigenvalues and corresponding eigenvectors, here A =
%       V'*diag(lambda)*V
%
% -------------------------------------------------------------------------

% Check inputs
if nargin < 2
    method = 'threshold';
end
if nargin < 3
    if strcmp(method, 'threshold')
        tol = 1e-14;
    else
        tol = 1e-7;
    end
end

% Initialize
n = length(A);
if nargout == 2
    V = eye(n);
end

% Check the method
if strcmp(method, 'classic') % Classic Jacobi
    omega = norm(A, 'fro');
    eta = tol * omega;
    omega = sqrt(omega^2 - sum(diag(A).^2));
    while omega > eta
        [a, p] = max(abs(A - diag(diag(A))));
        [~, q] = max(a);
        p = p(q);
        if p > q
            temp = p;
            p = q;
            q = temp;
        end
        apq = A(p, q);
        G = jacobi(A(p, p), apq, A(q, q));
        A(:, [p, q]) = A(:, [p, q]) * G;
        A([p, q], :) = G' * A([p, q], :);
        if nargout == 2
            V(:, [p, q]) = V(:, [p, q]) * G;
        end
        omega = sqrt(omega^2 - 2 * apq^2);
    end
elseif strcmp(method, 'cyclic') % Cyclic Jacobi
    omega = norm(A, 'fro');
    eta = tol * omega;
    omega = sqrt(omega^2 - sum(diag(A).^2));
    while omega > eta
        for p = 1:n-1
            for q = p+1:n
                G = jacobi(A(p, p), A(p, q), A(q, q));
                A(:, [p, q]) = A(:, [p, q]) * G;
                A([p, q], :) = G' * A([p, q], :);
                if nargout == 2
                    V(:, [p, q]) = V(:, [p, q]) * G;
                end
            end
        end
        omega = sqrt(norm(A, 'fro')^2 - sum(diag(A).^2));
    end
elseif strcmp(method, 'threshold') % Threshold Jacobi
    rots = 1;
    while rots >= 1
        rots = 0;
        for p = 1:n-1
            for q = p+1:n
                apq = A(p, q);
                app = A(p, p);
                aqq = A(q, q);
                if abs(apq) >= tol * sqrt(app * aqq)
                    rots = rots + 1;
                    G = jacobi(app, apq, aqq);
                    A(:, [p, q]) = A(:, [p, q]) * G;
                    A([p, q], :) = G' * A([p, q], :);
                    if nargout == 2
                        V(:, [p, q]) = V(:, [p, q]) * G;
                    end
                end
            end
        end
    end
else
    error('Choose method among ''classic'', ''cyclic'' and ''threshold''');
end
sigma = diag(A);
end