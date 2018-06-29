function [start_frame, last_frame, options] = loadDataset(dataset)
  
  % Brief: load data and initialize options
  %
  % Parameters:
  %   dataset - the name of the dataset to load
  %
  % Returns:
  %   start_frame - the start frame number
  %   last_frame  - the last frame number
  %   options     - the options of the program
  
  
  
  % Parameters initialization (the values come from the paper)
  options.ransac_threshold = 0.1;
  options.ransac_nb_inliers = 5000;   % Not provided in the paper
  options.ransac_nb_iter = 1000;
  options.frame_window = 30;
  options.smoothing_parameter = 30;
  
  % Paths
  base_dir = strrep(fileparts(mfilename('fullpath')),'\','/');
  data_path = [base_dir '/../data/' dataset];
  filename_template = 'VHand%03d.bmp';
  image_template = [data_path '/' filename_template];
  [start_frame, last_frame] = getStartLastFrame(data_path, 'bmp', filename_template);
  options.base_dir = base_dir;
  options.data_path = data_path;
  options.image_template = image_template;
  
end



function [start_frame, last_frame] = getStartLastFrame(data_path, extension, image_template)
  
  % Brief: 
  %
  % Parameters:
  %   data_path       - 
  %   extension       - 
  %   image_template  - 
  %
  % Returns:
  %   start_frame - the start frame number
  %   last_frame  - the last frame number
  
  
  
  files = dir([data_path '/*.' extension]);
  last_frame = 0;
  start_frame = 10e10;
  
  nb_files = length(files);
  for i=1:nb_files
    frame_num = sscanf(files(i).name, image_template);
    start_frame = min(start_frame, frame_num);
    last_frame  = max(last_frame,  frame_num); 
  endfor
  
end