function y = filter2(b,x,shape)
%FILTER2 Two-dimensional digital filter.
%   Y = FILTER2(B,X) filters the data in X with the 2-D FIR
%   filter in the matrix B.  The result, Y, is computed 
%   using 2-D correlation and is the same size as X. 
%
%   Y = FILTER2(B,X,'shape') returns Y computed via 2-D
%   correlation with size specified by 'shape':
%     'same'  - (default) returns the central part of the 
%               correlation that is the same size as X.
%     'valid' - returns only those parts of the correlation
%               that are computed without the zero-padded
%               edges, size(Y) < size(X).
%     'full'  - returns the full 2-D correlation, 
%               size(Y) > size(X).
%
%   FILTER2 uses CONV2 to do most of the work.  2-D correlation
%   is related to 2-D convolution by a 180 degree rotation of the
%   filter matrix.
%
%   See also FILTER, CONV2.

%   Clay M. Thompson 9-17-91
%   L. Shure 10-21-91, modified to use conv2 mex-file
%   S. Eddins 12-6-94, modified to check for separability
%   Copyright (c) 1984-98 by The MathWorks, Inc.
%   $Revision: 5.8 $  $Date: 1997/11/21 23:23:46 $

error(nargchk(2,3,nargin));
if nargin<3, shape = 'same'; end

code = [shape,' ']; code = code(1);
if isempty(find(code=='svf')), error('Unknown shape parameter.'); end

[mx,nx] = size(x);
stencil = rot90(b,2);
[ms,ns] = size(stencil);

% 1-D stencil?
if (ms == 1)
  y = conv2(1,stencil,x,shape);
elseif (ns == 1)
  y = conv2(stencil,1,x,shape);
else
  if (ms*ns > mx*nx)
    % The filter is bigger than the input.  This is a nontypical
    % case, and it may be counterproductive to check the
    % separability of the stencil.
    y = conv2(x,stencil,shape);
  else    
    % Check rank (separability) of stencil
    [u,s,v] = svd(stencil);
    s = diag(s);
    tol = length(stencil) * max(s) * eps;
    rank = sum(s > tol);
    if (rank == 1)
      % Separable stencil
      hcol = u(:,1) * sqrt(s(1));
      hrow = conj(v(:,1)) * sqrt(s(1));
      if (all(all((round(stencil) == stencil))) && all(all((round(x) == x))))
        % Output should be integer
        y = round(conv2(hcol, hrow, x, shape));
      else
        y = conv2(hcol, hrow, x, shape);
      end
    else
      % Nonseparable stencil
      y = conv2(x,stencil,shape);
    end
  end
end
