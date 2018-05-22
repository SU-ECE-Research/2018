function make_video(sequence_filename, video_filename, bitrate)

if (nargin == 2)
  bitrate = '20M';
end

cmd = ['ffmpeg -loglevel quiet -y -i ' sequence_filename ' -b ' bitrate ...
      ' ' video_filename];

[status, cmdout] = system(cmd);
