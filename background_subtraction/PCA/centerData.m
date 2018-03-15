function [X_center mu] = centerData(X)
  
  mu = mean(X);
  X_center = bsxfun(@minus, X, mu);
  
end