function plotOneTrajectory(W)
  
  figure(2);
  
  x = W(1:2:end);
  y = W(2:2:end);
  
  plot(x,y);
  
end