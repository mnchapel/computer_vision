function W = updateTrajectories(num_frame, tracks, options)
  
  % Brief: 
  %
  % Parameters
  %   num_frame - the current frame
  %   tracks    - 
  %   options   - 
  %
  % Returns
  %   W - 2F x P, trajectory matrix
  
  
  
  W = zeros((options.frame_window)*2, 0);
  
  nb_tracks = size(tracks,1);
  for i=1:nb_tracks
    track_start_frame = tracks{i}.start_frame;
    track_last_frame  = tracks{i}.last_frame;
    
    if ((track_start_frame <= num_frame) && (track_last_frame >= num_frame) && ((num_frame-track_start_frame+1) >= (options.frame_window)))
    
      id_start = num_frame-track_start_frame-(options.frame_window)+2;
      id_end   = num_frame-track_start_frame+1;
      points = tracks{i}.points(id_start*2-1:id_end*2);
      is_tracked = tracks{i}.is_tracked(id_start:id_end);
      ind = find(is_tracked(:) == 0);
      
      if isempty(ind)
          W = [W, points'];
      endif

    endif
  
  endfor
  
end