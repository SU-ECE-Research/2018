function [X, num_rows, num_cols] = imgtomat(filename, start_frame, end_frame)

first_filename = sprintf(filename, 1);
X = imread(first_filename);
num_rows = size(X, 1);
num_cols = size(X, 2);
num_frames = end_frame - start_frame + 1;

X = zeros(num_rows * num_cols, num_frames, 'uint8');

for frame = start_frame:end_frame
  current_filename = sprintf(filename, frame);
  current_image = imread(current_filename);
  imwrite(current_image, sprintf('SnowLeopard%d.PGM', frame))
  X(:, frame - start_frame + 1) = current_image(:);
end

