% test TV denoising by (adaptive) modified  PDHG
function [imout, imnoisy, diffvec] = denoiseTV(im,noiselevel)

%
im       = double(im);
maxval   = max(max(im));
imnoisy  = noisy_version(im,noiselevel);
imnoisy  = imnoisy/max(max(imnoisy));

%Set parameters of TV method
lbd     = 5.2;
%lbd     = 1.0;
%lbd     = 0.02;
%lbd     = 0.00000000000002;
%lbd = 2e-15;
%lbd     = 0.0002;
NIT     = 150;
%NIT     = 1000;
GapTol  = 1e-10;
%GapTol  = 1e-15;
verbose = 0;

%Compute the denoising using TV method
imout =  TV_mPDHG(imnoisy,lbd,NIT,GapTol,verbose);

%Scale values of pixels into [0,1]
im      = im/max(max(im));
imnoisy = imnoisy/max(max(imnoisy));
imout   = imout/max(max(imout));

%Compute differences
fro1 = norm(im-imout,'fro');
fro2 = norm(imnoisy-imout,'fro');
fro3 = norm(imnoisy-im,'fro');

% Convert images from double to uint8 for ssim_indexing
%Vimg8       = uint8(100*im);
%Vnoisedimg8 = uint8(100*imnoisy);
%WHimg8      = uint8(100*imout);
im8      = uint8(100*im);
imnoisy8 = uint8(100*imnoisy);
imout8   = uint8(100*imout);

%Compute ssim_index (ssim=structural similarity)
ssim1 = ssim_index(im8,imout8);
ssim2 = ssim_index(imnoisy8,imout8);
ssim3 = ssim_index(imnoisy8,im8);

%Store the differences into diffvec
diffvec = [noiselevel, fro1, fro2, fro3, ssim1, ssim2, ssim3];

end
