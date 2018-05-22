% tvqc_logbarrier_rectangular.m
%
% Solve quadractically constrained TV minimization
% min TV(x)  s.t.  ||Ax-b||_2 <= epsilon.
%
% Recast as the SOCP
% min sum(t) s.t.  ||D_{ij}x||_2 <= t,  i,j=1,...,n
%                  ||Ax - b||_2 <= epsilon
% and use a log barrier algorithm.
%
% Usage:  xp = tvqc_logbarrier(x0, A, At, b, epsilon, num_rows,
% num_cols, lbtol, mu, cgtol, cgmaxiter)
%
% x0 - Nx1 vector, initial point.
%
% A - Either a handle to a function that takes a N vector and returns a K 
%     vector , or a KxN matrix.  If A is a function handle, the algorithm
%     operates in "largescale" mode, solving the Newton systems via the
%     Conjugate Gradients algorithm.
%
% At - Handle to a function that takes a K vector and returns an N vector.
%      If A is a KxN matrix, At is ignored.
%
% b - Kx1 vector of observations.
%
% epsilon - scalar, constraint relaxation parameter
%
% num_rows, num_cols - size of original image (can be non-square)
%
% lbtol - The log barrier algorithm terminates when the duality gap <= lbtol.
%         Also, the number of log barrier iterations is completely
%         determined by lbtol.
%         Default = 1e-3.
%
% mu - Factor by which to increase the barrier constant at each iteration.
%      Default = 10.
%
% cgtol - Tolerance for Conjugate Gradients; ignored if A is a matrix.
%     Default = 1e-8.
%
% cgmaxiter - Maximum number of iterations for Conjugate Gradients; ignored
%     if A is a matrix.
%     Default = 200.
%
% Written by: Justin Romberg, Caltech
% Email: jrom@acm.caltech.edu
% Created: October 2005
%


function xp = tvqc_logbarrier_rectangular(x0, A, At, b, epsilon, ...
    num_rows, num_cols, lbtol, mu, cgtol, cgmaxiter)  

if (nargin < 8), lbtol = 1e-3; end
if (nargin < 9), mu = 10; end
if (nargin < 10), cgtol = 1e-8; end
if (nargin < 11), cgmaxiter = 200; end

if (length(x0) ~= num_rows * num_cols)
   disp('num_rows and num_cols do not match x0');
   return;
end

newtontol = lbtol;
newtonmaxiter = 50;

N = length(x0);

% create (sparse) differencing matrices for TV
Dv = spdiags([reshape([-ones(num_rows - 1, num_cols); ...
  zeros(1, num_cols)], N, 1) ...
  reshape([zeros(1, num_cols); ...
  ones(num_rows - 1, num_cols)], N, 1)], [0 1], N, N);

Dh = spdiags([reshape([-ones(num_rows, num_cols - 1) ...
  zeros(num_rows, 1)], N, 1) ...
  reshape([zeros(num_rows, 1) ...
  ones(num_rows, num_cols - 1)], N, 1)], [0 num_rows], N, N);

x = x0;
Dhx = Dh*x;  Dvx = Dv*x;
t = 1.05*sqrt(Dhx.^2 + Dvx.^2) + .01*max(sqrt(Dhx.^2 + Dvx.^2));

% choose initial value of tau so that the duality gap after the first
% step will be about the origial TV
tau = (N+1)/sum(sqrt(Dhx.^2+Dvx.^2));
                                                                                                                           

lbiter = ceil((log((N+1))-log(lbtol)-log(tau))/log(mu));
disp(sprintf('Number of log barrier iterations = %d\n', lbiter));
totaliter = 0;
for ii = 1:lbiter
  
  [xp, tp, ntiter] = tvqc_newton_rectangular(x, t, A, At, b, epsilon, tau, ...
      newtontol, newtonmaxiter, cgtol, cgmaxiter, Dv, Dh);
  totaliter = totaliter + ntiter;
  
  tvxp = sum(sqrt((Dh*xp).^2 + (Dv*xp).^2));
  disp(sprintf('\nLog barrier iter = %d, TV = %.3f, functional = %8.3f, tau = %8.3e, total newton iter = %d\n', ...
    ii, tvxp, sum(tp), tau, totaliter));
  
  x = xp;
  t = tp;
  
  tau = mu*tau;
  
end
                   
