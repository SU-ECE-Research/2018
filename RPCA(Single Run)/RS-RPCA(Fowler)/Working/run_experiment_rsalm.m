function run_experiment_rsalm()

addpath('../inexact_alm_rpca');
addpath('../inexact_alm_rpca/PROPACK');
addpath('../Tools');
addpath('../l1magic/Optimization');

% datapath = '../Data/Escalator';
% filename = 'escalator';
% col_subrate = 0.1;
% row_subrate = 0.01;

% datapath = '../Data/Arecont1';
% filename = 'arecont1';
% col_subrate = 0.1;
% row_subrate = 0.0001;

datapath = '../Data/SnowLeopard';
filename = 'SnowLeopard';
col_subrate = 1; %sample size from the matrix (check)
row_subrate = 0.5; %sample size of pixels in each image (check) %0.001

load([datapath '/' filename '.mat']);

tic
[L S] = rsalm(double(X), col_subrate, row_subrate);
toc

disp('Writing images/video...');

L = uint8(L);
S = uint8(S + 127);

L_sequence = ['Results/' filename '.L.rsalm.%03d.pgm'];
L_video = ['Results/' filename '.L.rsalm.mp4'];
S_sequence = ['Results/' filename '.S.rsalm.%03d.pgm'];
S_video = ['Results/' filename '.S.rsalm.mp4'];
mattoimg(L, num_rows, num_cols, L_sequence);
mattoimg(S, num_rows, num_cols, S_sequence);
make_video(L_sequence, L_video);
make_video(S_sequence, S_video);


