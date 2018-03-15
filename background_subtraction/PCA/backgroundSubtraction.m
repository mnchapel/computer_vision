function X_bg_subr = backgroundSubtraction(X, X_proj, treshold, h, w, d)
  X_bg_subr = abs(X_proj-X);
  X_bg_subr = reshape(X_bg_subr, h, w, d);
  X_bg_subr = max(X_bg_subr, [], 3);
  X_bg_subr = X_bg_subr > treshold;
end