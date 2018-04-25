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
  W -= Wf_mean; % See in Shape and Motion from Image Streams under Orthography: a Factorization Method 
  
  % RANSAC ---------------------------------------------------------------------
  for i=1:ransac_nb_iter
    
    % Select 3 trajectories randomly
    rand_ids = randperm(nb_tracks);
    rand_ids = [4056, 7478, 6401, rand_ids]; % I manually choose the 3 basis trajectories
    W_rand = W(:,rand_ids(1:3));
    
    % Compute the projection error for each points not in W_rand
    W_others = W(:,rand_ids(1:end));
    W_errors = projectionError(W_rand, W_others, rand_ids);
    
    % Count inliers
    inliers = find(W_errors < options.ransac_threshold);
    max_inliers = max(max_inliers, length(W_errors(inliers)));
    
  endfor
  
  disp('max_inliers');
  disp(max_inliers);
  disp('Press any key');
  pause();
  
end