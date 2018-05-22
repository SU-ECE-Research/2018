function [L S] = rsalm(X, col_subrate, row_subrate)

disp('  Running column ALM...');
[L S] = run_column_alm(X, col_subrate);

disp('  Running SVD...');
[U Sigma V] = svd(L, 'econ');

% save('rsalm.mat', ...
%     'U', 'Sigma', 'V', 'Q_hat', '-v7.3');

disp('  Running row l1...');
Q_hat = run_row_l1(X, U, row_subrate);

L = U * Q_hat;
S = X - L;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [L S] = run_column_alm(D, col_subrate)

[num_rows num_cols] = size(D);

num_cols2 = round(num_cols * col_subrate);
I_columns = randperm(num_cols);
I_columns = I_columns(1:num_cols2);

n = max([num_rows num_cols2]);
lambda = 1/sqrt(n);

[L S] = inexact_alm_rpca(D(:, I_columns), lambda);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function Q_hat = run_row_l1(D, U, row_subrate)

[num_rows num_cols] = size(D);
num_rows2 = round(num_rows * row_subrate);
I_rows = randperm(num_rows);
I_rows = I_rows(1:num_rows2);
D = D(I_rows, :);
U = U(I_rows, :);

M = size(U, 2);

A = @(q) reshape(U * reshape(q, [M num_cols]), ...
    [num_rows2 * num_cols, 1]);
At = @(y) reshape(U' * reshape(y, [num_rows2 num_cols]), ...
    [M * num_cols, 1]);

Q_hat = reshape(l1decode_pd(At(D(:)), A, At, D(:)), [M num_cols]);

