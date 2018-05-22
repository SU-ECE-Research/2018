function run_experiment_rsalm(path, filename, start_frame, end_frame, row_subrate)
% example usage 
% for the following image set:
% D:\RPCA\Data\ATO04_P016\7-06-12\
% Start Image: IMG_0031.JPG
% End Image:   IMG_0063.JPG
%
% run_experiment_rsalm('D:\RPCA\Data\ATO04_P016\7-06-12\', 'IMG_%04d.JPG', 0031, 0063)

if exist('../inexact_alm_rpca', 'file') == 7
    addpath('../inexact_alm_rpca');
end
if exist('../inexact_alm_rpca/PROPACK', 'file') == 7
    addpath('../inexact_alm_rpca/PROPACK');
end
if exist('../Tools', 'file') == 7
    addpath('../Tools');
end
if exist('../l1magic/Optimization', 'file') == 7
    addpath('../l1magic/Optimization');
end

disp('Running RS-RPCA');

col_subrate = 1;
%row_subrate = 0.001;


[X, num_rows, num_cols] = imgtomat(path, filename, start_frame, end_frame);


tic
[L, S] = rsalm(double(X), col_subrate, row_subrate);
runTime = toc;
toc

logfile = strcat(path, 'RS-RPCA_RunTime.txt');

fid = fopen(logfile,'wt');
fprintf(fid, '%10.6f', runTime);
fclose(fid);

disp('Writing images...');

L = uint8(L);
S = uint8(S + 127);

L_filename = strcat('RS-RPCA_L_', filename);
S_filename = strcat('RS-RPCA_S_', filename);
%mattoimg(path, L_filename, L, num_rows, num_cols);
mattoimg(path, S_filename, S, num_rows, num_cols);



