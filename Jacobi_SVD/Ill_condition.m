% this code shows an example about the difference between eig func and
% two_sided_jacobi func in some ill_condition

clear; close all; clc;

addpath('func\');

% set ill_conditional matrix
A = [1e40, 1e29, 1e19; 1e29, 1e20, 1e9; 1e19, 1e9, 1];
lambda1 = eig(A);
lambda2 = two_sided_jacobi(A);

% show results
disp('The result using eig function in Matlab');
disp(lambda1);
disp('The result using two_sided_jacobi function');
disp(lambda2);