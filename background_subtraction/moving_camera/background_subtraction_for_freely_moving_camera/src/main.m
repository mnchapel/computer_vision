clear ; close all; clc
pkg load image



% Load data --------------------------------------------------------------------
dataset_name = "VHand";
[start_frame, last_frame, options] = loadDataset(dataset_name);
%tracks = readTracks(options);
%save('-binary', '../data/tracks.mat', 'tracks');
load('../data/tracks.mat');



% Background subtraction -------------------------------------------------------
start_frame = start_frame + options.frame_window - 1;

for num_frame = start_frame:last_frame
  
  flushPrint('Frame %d\n', num_frame);
  
  % Update trajectories
  W = updateTrajectories(num_frame, tracks, options);
  flushPrint('\tThere are %d trajectories.\n', size(W,2));
  
  % Create background subspace
%  backgroundModel(W, options);
  backgroundModelTest(W, options); % Uncomment to test with 3 basis trajectories selected manually
  
  %plotTrajectories(num_frame, W, options);
  
endfor