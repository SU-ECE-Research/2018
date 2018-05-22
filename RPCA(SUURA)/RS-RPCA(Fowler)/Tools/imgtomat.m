function [X, num_rows, num_cols] = imgtomat(path, filename, start_frame, end_frame)
% example usage 
% for the following image set:
% D:\RPCA\Data\ATO04_P016\7-06-12\
% Start Image: IMG_0031.JPG
% End Image:   IMG_0063.JPG
%
% imgtomat('D:\RPCA\Data\ATO04_P016\7-06-12\', 'IMG_%04d.JPG', 0031, 0063)

pathAndFileName = strcat(path, filename);
pathAndFileName = strrep(pathAndFileName,'\','\\');
first_filename = sprintf(pathAndFileName, start_frame);
X = imread(first_filename);
num_rows = size(X, 1);
num_cols = size(X, 2);

imageCount = 1;
for frame = start_frame:end_frame
  current_filename = sprintf(pathAndFileName, frame);
  if exist(current_filename, 'file') == 2
    imageCount = imageCount + 1 ;
  end
end


X = zeros(num_rows * num_cols, imageCount - 1, 'uint8');
imageCount = 1;

for frame = start_frame:end_frame
  current_filename = sprintf(pathAndFileName, frame);
  if exist(current_filename, 'file') == 2
    current_image = rgb2gray(imread(current_filename));
    %imwrite(current_image, sprintf('SnowLeopard%d.PGM', frame))
    X(:, imageCount) = current_image(:);
    imageCount = imageCount + 1 ;
  end
end

