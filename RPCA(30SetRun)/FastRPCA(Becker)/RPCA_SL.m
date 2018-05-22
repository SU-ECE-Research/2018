function RPCA_SL(path, filename, start_frame, end_frame)
% example usage 
% for the following image set:
% D:\RPCA\Data\ATO04_P016\7-06-12\
% Start Image: IMG_0031.JPG
% End Image:   IMG_0063.JPG
%
% RPCA_SL('D:\RPCA\Data\ATO04_P016\7-06-12\', 'IMG_%04d.JPG', 0031, 0063)




if exist('..\RS-RPCA(Fowler)\Tools', 'file') == 7
    addpath('..\RS-RPCA(Fowler)\Tools');
end


disp('Running FAST-RPCA');

% read the images and create X
[X, num_rows, num_cols] = imgtomat(path, filename, start_frame, end_frame);

X = single(X);

nFrames     = size(X,2);
lambda      = 2e-2;
L0          = repmat( median(X,2), 1, nFrames );
S0          = X - L0;
epsilon     = 5e-3*norm(X,'fro'); % tolerance for fidelity to data
opts        = struct('sum',false,'L0',L0,'S0',S0,'max',true,...
    'tau0',3e5,'SPGL1_tol',1e-1,'tol',1e-3);

tic
[L,S] = solver_RPCA_SPGL1(X,lambda,epsilon,[],opts);
runTime = toc;
toc

logfile = strcat(path, 'Fast-RPCA_RunTime.txt');

fid = fopen(logfile,'wt');
fprintf(fid, '%10.6f', runTime);
fclose(fid);

disp('Writing images...');

L = uint8(L);
S = uint8(S + 127);

L_filename = strcat('Fast-RPCA_L_', filename);
S_filename = strcat('Fast-RPCA_S_', filename);
mattoimg(path, L_filename, L, num_rows, num_cols);
mattoimg(path, S_filename, S, num_rows, num_cols);

