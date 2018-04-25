function plotTrajectories(num_frame, W, options)
  
  % Brief: 
  %
  % Parameters:
  %   num_frame - the current frame number
  %   W         - the trajectory matrix
  %   options   - the options of the program
  
  

  fname = sprintf(options.image_template, num_frame);
  
  im = imread(fname);
  im_h = size(im,1);
  
  clf;
  fg = figure(1);
  
  % Plot the image
  imshow(im);
  
  % Plot the trajectories
  hold on;
  
  points = W(:,end,:);
  plot(points(:,:,1), im_h-points(:,:,2), 'wo');
  
  hold off;
  
%  fname_res_template = '../results/im_traj_%03d.bmp';
%  fname_res = sprintf(fname_res_template, num_frame);
  %print -djpg fname_res_template
  %imwrite(fg, fname_res)
  
  flushPrint('Press any key to continue.\n');
  pause(0.01);
  
  %close;
  
end