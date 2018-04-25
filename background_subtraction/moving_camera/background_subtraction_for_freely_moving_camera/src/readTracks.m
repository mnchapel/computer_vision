function tracks = readTracks(options)
  
  % Brief: read tracks from file.
  %
  % Parameters:
  %   options - the options of the program
  %
  % Returns
  %   tracks  - 
  
  
  
  flushPrint('Reading tracks...\n');
  
  fname = [options.data_path '/tracks.txt'];
  fid = fopen(fname, 'r');
  
  if ~is_valid_file_id(fid)
    flushPrint('Error, the file %s is not opened\n', fname);
  endif
  
  nb_tracks = fscanf(fid, '%d', 1);
  tracks = cell(nb_tracks,1);
  
  for i=1:nb_tracks
    track_start_frame = fscanf(fid, '%d', 1);
    track_last_frame  = fscanf(fid, '%d', 1);
    
    i_nb_track = track_last_frame-track_start_frame+1;
    
    tracks{i}.start_frame = track_start_frame;
    tracks{i}.last_frame  = track_last_frame;
    tracks{i}.points = zeros(1, i_nb_track*2);
    tracks{i}.is_tracked = zeros(1, i_nb_track);
    
    for j=1:i_nb_track
      is_active = fscanf(fid, '%d', 1);
      x = 0;
      y = 0;
      if is_active
        x = fscanf(fid, '%f', 1);
        y = fscanf(fid, '%f', 1);
      endif
      
      tracks{i}.is_tracked(j) = is_active;
      tracks{i}.points(j*2-1:j*2) = [x, y];

      % all u and all v
%      tracks{i}.points(j) = x;
%      tracks{i}.points(i_nb_track+j) = y;
    endfor
    
  endfor
  
  fclose(fid);
  
  flushPrint('Reading tracks... ok\n');
  
end