function [U,S,V] = pca(X)

  [U,S,V] = svds(X,3);
  
end