function [U,S,V] = qsvd(A, tol)
% QSVD      Quaternion SVD using Jacobi method
%
% This function computes the SVD of real, complex or quaternion matrices.
%
% Inputs: 
%   A: real, complex or quaternion matrix.
%   tol(optional): a tolerance, defaults to eps if omitted.
% Outputs:   
%   S: The eigenvalues of A.
%   U: The left singular vectors.
%   V: The right singular vectors.
%
%
% usage:
%   [S, U, V] = qsvd(A)
%       Computes eigenvalues and corresponding singular vectors, U is a m x r
%       matrix of left singular vectors and V a n x n matrix of right singular
%       vectors, which is to say, U*S*V' = A
%
%--------------------------------------------------------------------------

narginchk(1, 2), nargoutchk(0, 3)

if nargin == 1
    tol = eps; % Default value for the tolerance.
end

if nargout == 2
   error('The number of output parameters must be 0, 1 or 3'); 
end

% Check A is a real/complex (i.e. double) or quaternion matrix.

if ~isreal(A) && isa(A,'quaternion')
   error('svd_jacobi does not work with complex quaternion matrices'); 
end

[M,N] = size(A); K = min(M,N); % K is the number of singular values.


F = str2func(class(A)); % F is a function handle.

V = F(eye(N));

% Initialize
On = 0; for c = A, On = On + sum(abs(c).^2); end; On = On ./ N;

% Scanning  
while true 
  for r = 1 : N - 1
    for c = r + 1 : N

      b_rr = sum(abs(A(:,r)).^2); 
      b_cc = sum(abs(A(:,c)).^2);
      b_rc = A(:,r)' * A(:,c);

	  m = abs(b_rc);
      
      if m ~= 0 
        tau = (b_cc - b_rr) / (2 * m); 
        if tau ~= 0
		  t   = sign(tau) ./ (abs(tau) + sqrt(1 + tau .^ 2));
		  C   = 1 ./ sqrt(1 + t .^ 2); 
		  S   = (b_rc .* t .* C) ./ m;
          G = F(eye(N));
          G(r,r) = F(C);
          G(c,c) = F(C);
          G(r,c) = S;
          G(c,r) =-conj(S);

          A = A * G;
          V = V * G;
        end
      end
    end
  end
  
  B = A' * A;
  
  
  Off = sum(sum(abs(triu(B, 1))))/(N.^2); 

  if (Off/On) < tol
    break;
  end  
end

% Extract and sort the singular values. The vector T may be longer than the
% number of singular values (K) in cases where A is not square.
                        
[T,IX] = sort(sqrt(abs(diag(B))),'descend');

% check outputs
if nargout == 0 || nargout == 1 
  U = T(1:K);
end

if nargout == 3
    A = A(:, IX); 
    V = V(:, IX);
    U = A ./ repmat(T',M,1);
    S = diag(T);
end