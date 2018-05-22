% Testing Robust PCA on my data
% load snow leopard images

names = ['1.JPG'; '2.JPG'; '3.JPG'; '4.JPG'; '5.JPG'; '6.JPG'; '7.JPG'; '8.JPG'];



% read the images and create X
X = [];
for i = 1 : 8
    filename = names(i, :);
    im = imread(filename);
    im = rgb2gray(im);
    X(:, i) = im(:);
end
m = 1080;
n = 1920;

nFrames     = size(X,2);
lambda      = 2e-2;
L0          = repmat( median(X,2), 1, nFrames );
S0          = X - L0;
epsilon     = 5e-3*norm(X,'fro'); % tolerance for fidelity to data
opts        = struct('sum',false,'L0',L0,'S0',S0,'max',true,...
    'tau0',3e5,'SPGL1_tol',1e-1,'tol',1e-3);

tic
[L,S] = solver_RPCA_SPGL1(X,lambda,epsilon,[],opts);
toc


mat  = @(x) reshape( x, m, n );
figure(1); clf;
colormap( 'Gray' );
for k = 1:nFrames
    imagesc( [mat(X(:,k)), mat(L(:,k)),  mat(S(:,k))] );
    % compare it to just using the median
%     imagesc( [mat(X(:,k)), mat(L0(:,k)),  mat(S0(:,k))] );
    axis off
    axis image
    drawnow;
    pause(.3);  
end

