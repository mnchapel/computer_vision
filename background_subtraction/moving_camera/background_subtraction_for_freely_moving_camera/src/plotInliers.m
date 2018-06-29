function plotInliers(num_frame, W, inliers, options)
  
  % Brief:
  %
  % Parameters:
  %   num_frame - the current frame number
  %   W         - 2FxP, the trajectory matrix
  %   inliers   - 
  %   options   - the options of the program
  
  
  
  fname = sprintf(options.image_template, 1);
  
  im = imread(fname);
  im_h = size(im,1);
  
  clf;
  fg = figure(1);
  
  % Plot the image -------------------------------------------------------------
  imshow(im);
  
  % Plot the trajectories ------------------------------------------------------
  hold on;
  
  points = [W(1,:); W(2,:)];
  
  inliers_points = points(:,inliers);
  outliers = setdiff(1:size(W,2), inliers);
  outliers_points = points(:,outliers);
  
  plot(inliers_points(1,:), im_h-inliers_points(2,:), 'wo');
  plot(outliers_points(1,:), im_h-outliers_points(2,:), 'bo');
  
  hold off;
  
  flushPrint('Press any key to continue.\n');
  pause();
  
end