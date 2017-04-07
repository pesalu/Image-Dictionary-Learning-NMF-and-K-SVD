function [V,W,H,output]=dictionaryKSVD(image,np,spar,natoms,niter,downsamplingcoef)

%Inputs:
%image: of size n x m
%np: number of pixels per one side of a square patch
%spar: maximum number of atoms per approximation of each original patch
%natoms: number of atoms included to dictionary W, i.e. number of columns
%of W
%niter: number of iterations containing OMP and SVD routines
%downsamplingcoef: pixel number n of n x n square patch that is approximated as one pixel
%
%Outputs:
%W=dictionary matrix
%H=coefficient matrix
%output=contains data from the K-SVD run for performance checking
%WHimg=approximation WH with dimensions n x m

%Original matrix
image = double(image);

%downsample the image
image = sumimage(image,downsamplingcoef);

%Put the maximum value to 1.
maxval = max(max(image));
image  = image/maxval;

[V] = divide2patches(image,np);

%Maximum number of atoms in each linear combination of v_i
param.L = spar;
%Number of atoms in dictionary
param.K= natoms;
%Number of iteration to execute the K-SVD algorithm.
param.numIteration = niter; 

%decompose signals until a certain error is reached. do n
param.errorFlag = 0; 
%param.errorGoal = sigma;
param.preserveDCAtom = 0;

param.InitializationMethod =  'DataElements';
param.displayProgress = 1;

%Run K-SVD
size(V)

[W,output]  = KSVD(V,param);
%Store the coefficient matrix H
H=output.CoefMatrix;

end
