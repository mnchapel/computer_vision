function X_bg_sub = backgroundSubtraction(X, X_bg, threshold)
  
  X_bg_sub = abs(X-X_bg)>threshold;
  
end