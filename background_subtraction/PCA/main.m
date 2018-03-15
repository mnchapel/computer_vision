clear ; close all; clc
pkg load image

% Add paths
addpath("data");



% Parameters initialization ----------------------------------------------------
img_scale = 0.1;
img_pattern_name = 'data/%06d.jpg';
train_img_id = 1:70;
test_img_id = 71:100;
n_train_img = numel(train_img_id);
train_img_id_plot = 20;
bg_sub_threshold = 0.2;

img_name = sprintf(img_pattern_name, train_img_id(1));
img = imresize(imread(img_name), img_scale);
[h w d] = size(img);
X_train = zeros(n_train_img, h*w*d);



% Create the training set ------------------------------------------------------
fprintf('Create the training set...');
for i=1:n_train_img
  img_name = sprintf(img_pattern_name, train_img_id(i));
  img = imresize(imread(img_name), img_scale);
  X_train(i,:) = im2double(img(:));
endfor
fprintf('Ok. Training set created with %d examples\n', n_train_img);

% Plot one original image from the training set
figure;
img_name = sprintf(img_pattern_name, train_img_id_plot);
imshow(reshape(X_train(train_img_id_plot,:),h,w,d));
img_title = sprintf('Image #%d from the training set', train_img_id_plot);
title(img_title);


% Create the background model --------------------------------------------------
% Center data
fprintf('Normalize features...');
[X_center, mu] = centerData(X_train);
fprintf('Ok\n');

% PCA
fprintf('Create the background model...');
[U,S,V] = pca(X_center);
fprintf('Ok. There are %d eigenvector\n', size(V,2));

% Plot one image from the training set
bg_model = U*S*V'; % m x (h*w*d);
bg_model(train_img_id_plot,:) += mu;
figure;
imshow(reshape(bg_model(train_img_id_plot,:),h,w,d));
img_title = sprintf('Image #%d from the background model', train_img_id_plot);
title(img_title);



% Project data -----------------------------------------------------------------
fprintf('Background subtraction on the test set...');
for i=1:numel(test_img_id)
  test_img_name = sprintf(img_pattern_name, test_img_id(i));
  test_img = imresize(imread(test_img_name), img_scale);
  test_img = im2double(test_img);
  X = test_img(:)';
  X_proj = projectData(X, mu, V);
  X_bg_sub = backgroundSubtraction(X, X_proj, bg_sub_threshold, h, w, d);
  
  bg_name = sprintf('results/%06d.jpg', test_img_id(i));
  imwrite(X_bg_sub, bg_name);
  
endfor
fprintf('Ok. Take a look at the results folder\n');



















