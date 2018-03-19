clear ; close all; clc
pkg load image

% Add paths
addpath("data");



% Parameters initialization ----------------------------------------------------
threshold = 25/255; % Threshold for background subtraction
n = 30;             % Use n previous images for background modeling

img_id = 1:100;
n_img = numel(img_id);
img_pattern_name = 'data/%06d.jpg';
mask_result_pattern_name = 'results/%06d.jpg';



% Background subtraction -------------------------------------------------------
fprintf('Background subtraction...');

img_name = sprintf(img_pattern_name, img_id(1));
im = rgb2gray(imread(img_name));
[h w d] = size(im);
X_n_img = zeros(n, h*w*d);

% Create background
for i=1:n-1
  img_name = sprintf(img_pattern_name, img_id(i));
  im = im2double(rgb2gray(imread(img_name)));
  X_n_img(i+1,:) = im(:)';
end

% Background subtration
for i=n:n_img-1  
  % Current image
  img_name = sprintf(img_pattern_name, img_id(i+1));
  X = im2double(rgb2gray(imread(img_name)));
  
  % Create the background model
  img_name = sprintf(img_pattern_name, img_id(i));
  X_n = im2double(rgb2gray(imread(img_name)));
  X_n_img = [X_n_img(2:end, :); X_n(:)'];
  X_bg = backgroundModeling(X_n_img, h, w, d);
  
  % Background subtraction
  X_mask = backgroundSubtraction(X, X_bg, threshold);
  
  % Write the result
  mask_name = sprintf(mask_result_pattern_name, img_id(i+1));
  imwrite(X_mask, mask_name);
  
endfor
fprintf('Ok. Take a look at the results folder\n');
