clear ; close all; clc
pkg load image

% Add paths
addpath("data");



% Parameters initialization ----------------------------------------------------
threshold = 15;
img_id = 1:100;
n_img = numel(img_id);
img_pattern_name = 'data/%06d.jpg';
img_result_pattern_name = 'results/%06d.jpg';



% Background subtraction over the sequence -------------------------------------
fprintf('Background subtraction...');
for i=1:n_img-1
  % Background image
  img_name = sprintf(img_pattern_name, img_id(i));
  X_bg = rgb2gray(imread(img_name));
  
  % Current image
  img_name = sprintf(img_pattern_name, img_id(i+1));
  X = rgb2gray(imread(img_name));
  
  % Background subtraction
  X_bg_sub = backgroundSubtraction(X, X_bg, threshold);
  
  % Write the result
  bg_name = sprintf(img_result_pattern_name, img_id(i+1));
  imwrite(X_bg_sub, bg_name);
  
  if(img_id(i+1) == 21)
    imshow(X_bg_sub);
  endif
  
endfor
fprintf('Ok. Take a look at the results folder\n');

