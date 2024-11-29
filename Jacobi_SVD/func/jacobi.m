function [c, s, t] = jacobi(alpha, beta, gamma)
% JACOBI    Compute Jacobi rotation.
%
% This function computes Jacobi rotation.
%
% Input:
%   alpha: a_p,q
%   beta: a_p,p
%   gamma: a_q,q
%
% Output:
%   c: cos\theta
%   s: sin\theta
%   t: tan\theta
%
% usage:
%   [c, s, t] = JACOBI(alpha, beta, gamma)
%   [G, t] = JACOBI(alpha, beta, gamma), where G = [c, s; -s, c]
%   
% ------------------------------------------------------------

if beta ~= 0
    tau = (gamma-alpha) / (2*beta);
    if tau >= 0
        t = 1 / (tau + sqrt(1+tau^2));
    else
        t = -1 / (- tau + sqrt(1+tau^2));
    end
    c = 1 / sqrt(1+t^2); s = t * c;
else
    c = 1; s = 0; t = 0;
end

if nargout <= 2  % Output [G, t]
    c = [c, s; -s, c];
    s = t;
end