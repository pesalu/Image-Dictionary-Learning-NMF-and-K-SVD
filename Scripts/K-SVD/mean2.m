function y = mean2(x) 
%MEAN2 Compute mean of matrix elements. 
%   B = MEAN2(A) computes the mean of the values in A. 
% 
%   Class Support 
%   ------------- 
%   A can be numeric or logical. B is a scalar of class double.  
% 
%   See also MEAN, STD, STD2. 
 
%   Copyright 1993-2002 The MathWorks, Inc.   
%   $Revision: 5.19 $  $Date: 2002/03/28 21:39:51 $ 
 
y = sum(x(:))/prod(size(x)); 
