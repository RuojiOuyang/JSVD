% this code shows an example about the difference between svd func and
% qsvd func in different kind of matrix.


clear; close all; clc;

addpath('func\');

% Initialize
error1 = zeros(100,1);
error2 = zeros(100,1);
error3 = zeros(100,1);
error4 = zeros(100,1);
error5 = zeros(100,1);
error6 = zeros(100,1);
N = 8;

for i = 1:100
    A = quaternion(randn(N,N),randn(N,N),randn(N,N),randn(N,N));
    [U,S,V] = svd(A);
    error1(i) = norm(A-U*S*V');
    [U1,S1,V1] = qsvd(A);
    error2(i) = norm(A-U1*S1*V1');
    B = randn(N,N);
    [U,S,V] = svd(B);
    error3(i) = norm(B-U*S*V');
    [U1,S1,V1] = qsvd(B);
    error4(i) = norm(B-U1*S1*V1');
    C = randn(N,N)+randn(N,N)*1i;
    [U,S,V] = svd(C);
    error5(i) = norm(C-U*S*V');
    [U1,S1,V1] = qsvd(C);
    error6(i) = norm(C-U1*S1*V1');
end

% show results
fprintf('Mean error using svd func in quaternion matrix: %e\n',mean(error1));
fprintf('Max error using svd func in quaternion matrix: %e\n',max(error1));
fprintf('Mean error using qsvd func in quaternion matrix: %e\n',mean(error2));
fprintf('Max error using qsvd func in quaternion matrix: %e\n',max(error2));
fprintf('Mean error using svd func in real matrix: %e\n',mean(error3));
fprintf('Max error using svd func in real matrix: %e\n',max(error3));
fprintf('Mean error using svd func in real matrix: %e\n',mean(error4));
fprintf('Max error using svd func in real matrix: %e\n',max(error4));
fprintf('Mean error using svd func in complex matrix: %e\n',mean(error5));
fprintf('Max error using svd func in complex matrix: %e\n',max(error5));
fprintf('Mean error using qsvd func in complex matrix: %e\n',mean(error6));
fprintf('Max error using qsvd func in complex matrix: %e\n',max(error6));