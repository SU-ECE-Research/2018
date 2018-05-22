function run_experiment_alm()

addpath('../inexact_alm_rpca');
addpath('../inexact_alm_rpca/PROPACK');
addpath('../Tools');

% datapath = '../Data/Escalator';
% filename = 'escalator';
datapath = '../Data/Arecont1';
filename = 'arecont1';

load([datapath '/' filename '.mat']);

num_frames = size(X, 2);

disp('Running ALM...');
tic
[L S] = inexact_alm_rpca(double(X));
toc

% save([filename '.alm.mat'], ...
%     'L', 'S', 'num_rows',  'num_cols');

[U Sigma V] = svd(L, 'econ');
% save([filename '.alm.mat'], ...
%     'U', 'Sigma', 'V', '-v7.3');

disp('Writing images/video...');

L = uint8(L);
S = uint8(S + 127);

L_sequence = ['Results/' filename '.L.alm.%03d.pgm'];
L_video = ['Results/' filename '.L.alm.mp4'];
S_sequence = ['Results/' filename '.S.alm.%03d.pgm'];
S_video = ['Results/' filename '.S.alm.mp4'];
mattoimg(L, num_rows, num_cols, L_sequence);
mattoimg(S, num_rows, num_cols, S_sequence);
make_video(L_sequence, L_video);
make_video(S_sequence, S_video);
