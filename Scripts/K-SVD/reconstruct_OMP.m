function [H,WHimg,Vnoisedimg,diffvec]=reconstruct_OMP(image,W,spar,noiselevel,downsamplingcoef)

%Inputs:
%image: of size n x m
%np: number of pixels per one side of a square patch
%spar: maximum number of atoms per approximation of each original patch
%natoms: number of atoms included to dictionary W, i.e. number of columns of W
%niter: number of iterations containing OMP and SVD routines
%downsamplingcoef: pixel number n of n x n square patch that is 
%approximated as one pixel
%
%Outputs:
%H       = coefficient matrix
%WHimg   = approximation WH with dimensions n x m
%diffvec = 

%Number of atoms
natoms = size(W,2);

%Number of pixels, np, per dimension of square patch 
np = sqrt(size(W,1));

%Original matrix
image = double(image);

%downsample the image
image = sumimage(image,downsamplingcoef);

%Put the maximum value to 1.
maxval = max(max(image));
image  = image/maxval;

% Divide the original image into np x np -patches and
% store the patches into columns of V
[V] = divide2patches(image,np);

%Make noisy version of V
[Vnoised] = noisy_version(V,noiselevel);

%Run make reconstruction using dictionary W and OMP-algorithm
[H] = OMP(W,Vnoised,spar);

% Make reconstruction
WH = W*H;

%Compute differences
fro1 = norm(V-WH,'fro');
fro2 = norm(Vnoised-WH,'fro');
fro3 = norm(Vnoised-V,'fro');

% Convert matrices V, Vnoised, and WH back to image shape for SSIM indexing
[Vimg]       = back2image(V);
[Vnoisedimg] = back2image(Vnoised);
[WHimg]      = back2image(WH);

% Convert images from double to uint8 for ssim_indexing
Vimg8       = uint8(100*Vimg);
Vnoisedimg8 = uint8(100*Vnoisedimg);
WHimg8      = uint8(100*WHimg);

%Compute ssim_index (ssim=structural similarity)
ssim1 = ssim_index(Vimg8,WHimg8);
ssim2 = ssim_index(Vnoisedimg8,WHimg8);
ssim3 = ssim_index(Vnoisedimg8,Vimg8);

% Vector of differences
diffvec = [noiselevel fro1 fro2 fro3 ssim1 ssim2 ssim3];

end
