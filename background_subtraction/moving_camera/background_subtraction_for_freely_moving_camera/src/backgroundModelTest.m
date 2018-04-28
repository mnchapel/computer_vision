function backgroundModel(W, options)
  
  % Brief:
  %
  % Parameters:
  %   W       - the trajectories
  %   options - the options of the program
  %
  % Returns
  %
  
  
  
  nb_tracks = size(W,2);
  ransac_nb_iter = options.ransac_nb_iter;
  
  if nb_tracks < 3
    return;
  endif
  
  max_inliers = 0;

  Wf_mean = mean(W,2);
%  W -= Wf_mean; % See in Shape and Motion from Image Streams under Orthography: a Factorization Method 
  
  % RANSAC ---------------------------------------------------------------------
%  No loop here because I selected the 3 basis trajectories manually
    
  % Select 3 trajectories randomly
  rand_ids = [4056, 7478, 6401, rand_ids]; % I manually choose the 3 basis trajectories (trajectories with the same "shape")
  W_rand = W(:,rand_ids(1:3));
  
  % Compute the projection error for each points
  W_others = W(:,rand_ids(1:end)); % Test on all trajectories (3 basis trajectories too)
  W_errors = projectionError(W_rand, W_others, rand_ids);
  
  % Count inliers
  inliers = find(W_errors < options.ransac_threshold);
  max_inliers = max(max_inliers, length(W_errors(inliers)));
  
  disp('max_inliers');
  disp(max_inliers);
  disp('Press any key');
  pause();
  
end