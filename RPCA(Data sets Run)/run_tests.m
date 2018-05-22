function run_tests(path, filename, start_frame, end_frame)
% example usage 
% for the following image set:
% D:\RPCA\Data\ATO04_P016\7-06-12\
% Start Image: IMG_0031.JPG
% End Image:   IMG_0063.JPG
%
% run_tests('D:\RPCA\Data\ATO04_P016\7-06-12\', 'IMG_%04d.JPG', 0031, 0063)


% Change the current folder to the folder of this m-file then add all sub folders to path.
if(~isdeployed)
  cd(fileparts(which(mfilename)));
  addpath(genpath('.'));
end


run_experiment_rsalm(path, filename, start_frame, end_frame);
RPCA_SL(path, filename, start_frame, end_frame);


