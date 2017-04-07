fprintf('Load data 5 \n');
load data/raw_denoise_OMPdata.mat diffvec WHimgs Hs
diffOMP2   = diffvec;
WHimgsKSVD = WHimgs;
HsKSVD     = Hs;

fprintf('Load data 6 \n');
load data/raw_denoiseNMFdata.mat diffvec WHimgs Vnoisedimgs
diffNMF2 = diffvec;
WHimgsNMF= WHimgs;
fprintf('Load data 7 \n');
load data/test_denoise_TV.mat diffvec Vrecimgs Hs
diffTV2  = diffvec;
HsNMF    = Hs;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Visualize atom distributions in reconstruction without raw denoising
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i = 1:size(Hs,3)
        namestr = sprintf('atom_distribution_KSVD%.0fnl.eps',100*diffvec(i,1));
        visualize_atom_distribution(HsKSVD(:,:,i),namestr);
end

