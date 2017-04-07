% %%%%%%%%%%%%%%%%%%%%%%%%
% %Step 3
% %Learn noise dictionary 
% %%%%%%%%%%%%%%%%%%%%%%%%

%Load image
load matches_01.mat
image=imG;

%Define the noiselevel of the noise sample
noiselevel = 0.01;

%Make noise sample of the same size
Ns = make_noise_sample(max(max(image)),noiselevel,size(image,1),size(image,2));

%Number of pixels per dimension in square patch
np     = 8;
niter  = 40;
niterW = 40;
niterH = 20;
natoms = 50;
downsamplingcoef=2^3;

[V,Wnoise,H,dataW,dataH,dataWH,diff] = dictionaryNMF(Ns,np,natoms,niter,niterW,niterH,downsamplingcoef);


% Save results
save learn_noiseNMFdata.mat V Wnoise H diff

clear

