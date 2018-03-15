function X_proj = projectData(X, mean, eig)
  X_proj = (X - mean) * eig * eig' + mean;
end