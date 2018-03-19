function X_bg = backgroundModeling(X_n_img, h, w, d)
  X_bg = median(X_n_img);
  X_bg = reshape(X_bg, h, w, d);
end