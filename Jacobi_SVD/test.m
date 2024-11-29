% clear;
% clc;

N = 100;
addpath('func\');
% tic;
% [U,S,V] = qsvd(A);
% toc;
% norm(A-U*S*V')
% A = quaternion(randn(N,N),randn(N,N),randn(N,N),randn(N,N));
tic;
[U1,S1,V1] = qsvd_para(A,1e-2,100);
toc;
norm(A-U1*diag(S1)*V1')
% tic;
% [U,S,V] = svd(A);
% toc;
% norm(A-U*S*V')