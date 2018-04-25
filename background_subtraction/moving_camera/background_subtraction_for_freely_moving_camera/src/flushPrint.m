function n = flushPrint(varargin)
  
  % Brief: 
  %
  % Parameters:
  %   varargin
  %
  % Returns
  %   n
  
  
  n = fprintf(stdout(), varargin{:});
  fflush(stdout);
    
end