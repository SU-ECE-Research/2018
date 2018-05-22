function mattoimg(path, filename, X, num_rows, num_cols)

pathAndFileName = strcat(path, filename);
pathAndFileName = strrep(pathAndFileName,'\','\\');
pathAndFileName = strrep(pathAndFileName,'JPG','PNG');

num_frames = size(X, 2);

if (num_rows * num_cols ~= size(X, 1))
  disp('mattoimg: num_rows and num_cols does not match dataset size');
  exit;
end

for frame = 1:num_frames
  current_filename = sprintf(pathAndFileName, frame);
  image = reshape(X(:, frame), [num_rows num_cols]);
  imwrite(image, current_filename);
end
