function errors = projectionError(W_basis, W, rand_ids)
  
  % Brief:
  %
  % Parameters:
  %   W_basis - (frame_window*2) x 3
  %   W       - (frame_window*2) x m
  %
  % Returns:
  %   errors - the projection errors
  

  
  % Projection matrix
  P = W_basis * pinv(W_basis' * W_basis) * W_basis';
  
  
  % Projection error
  nb_tracks = size(W,2);
  errors = ones(nb_tracks,1);
  diff = P*W - W;
  
  
  
  for i=1:nb_tracks    
    errors(i) = norm(diff(:,i));
    
    % Print the trajectory i 
    %plotOneTrajectory(W(:,i));
    %flushPrint('\tThe projection error is %f for the trajectory n°%d\n', errors(i), rand_ids(i));
    %flushPrint('Press any key\n');
    %pause();
  endfor
  
end