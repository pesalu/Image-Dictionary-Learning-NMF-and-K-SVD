%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Step 4
%Make reconstruction results with augmented dictionary W and Wnoise
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Load original image
load matches_02.mat
image=imG;

%Load dictionary from step 1
load dictionaryKSVDdata.mat W
%Load dictionary from step 3
load learn_noiseKSVDdata.mat Wnoise

%Desired sparsity of the reconstruction
spar=6;
downsamplingcoef=2^3;

i=0;
for noiselevel=[0.0 0.01 0.05 0.1 0.20 0.5 0.7 0.9]

        i=i+1;
        [H,WHimg,Vnoisedimg,diffvecdum] = raw_denoise_OMP(image,W,Wnoise,spar,noiselevel,downsamplingcoef);

        if(i==1)
                diffvec=diffvecdum;
        else
                diffvec=[diffvec; diffvecdum];
        end

	%Show the differences
	diffvec	

	%Store noised images
	Vnoisedimgs(:,:,i) = Vnoisedimg;

	%Store reconstructions
	WHimgs(:,:,i) = WHimg;

	%Store coeff. matrices
	H = full(H);
	Hs(:,:,i) = H;
	
end

clear -except imB imG imR image v0

%Save the augmented dictionary
W = [W, Wnoise];

save raw_denoise_OMPdata.mat W WHimgs Vnoisedimg Hs diffvec

%clear
