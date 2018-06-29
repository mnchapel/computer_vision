function inliers = backgroundModelTest(W, options)
  
  % Brief:
  %
  % Parameters:
  %   W       - the trajectories
  %   options - the options of the program
  %
  % Returns
  %   inliers - 
  
  
  
  nb_tracks = size(W,2);
  ransac_nb_iter = options.ransac_nb_iter;
  
  if nb_tracks < 3
    return;
  endif
  
  max_inliers = 0;
  
  % Normalization --------------------------------------------------------------
  W_bis = W(3:end,:);
  W_bis = W(1:end-2,:)-W_bis;
  W_norm = zeros(options.frame_window-1, nb_tracks);
  
  for i=1:nb_tracks
    for j=1:options.frame_window-1
      
      W_norm(j,i) = norm(W_bis(j*2-1:j*2, i));
      
    endfor
  endfor
  
  W_sum = sum(W_norm, 1);
  W = W ./ W_sum;
  

  % Mean -----------------------------------------------------------------------
  Wf_mean_x = mean(W(1:2:end-1,:),1);
  Wf_mean_y = mean(W(2:2:end,:),1);
  W(1:2:end-1,:) -= Wf_mean_x; % See in Shape and Motion from Image Streams under Orthography: a Factorization Method
  W(2:2:end,:) -= Wf_mean_y;
  
  % RANSAC ---------------------------------------------------------------------
%  No loop here because I selected the 3 basis trajectories manually
    
  % Select 3 trajectories randomly
  rand_ids = randperm(nb_tracks);
  rand_ids = [4565, 6401, 2884, 2205, 7478, rand_ids]; % I manually choose the 3 basis trajectories (trajectories with the same "shape")
  W_basis = W(:,rand_ids(1:3));
  
  % Compute the projection error for each points
  W_others = W(:,rand_ids(1:end)); % Test on all trajectories (3 basis trajectories too)
  W_errors = projectionError(W_basis, W_others, rand_ids);
  
  % Count inliers
  inliers = find(W_errors < options.ransac_threshold);
  max_inliers = max(max_inliers, length(W_errors(inliers)));
  
  disp('max_inliers');
  disp(max_inliers);
  disp('Press any key');
  pause();
  
end