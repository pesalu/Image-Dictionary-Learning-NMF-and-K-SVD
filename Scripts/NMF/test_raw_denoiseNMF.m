%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Step 4
% Make reconstruction results with dictionary [W,Wnoise]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Load dictionary
load dictionaryNMFdata.mat W

%Load noise dictionary
load learn_noiseNMFdata.mat Wnoise

%Make reconstruction using the given dictionary
load matches_02.mat
image=imG;

%Set the reconstruction parameters
niterH=40;
downsamplingcoef=2^3;

i=0;
for noiselevel=[0.0 0.01 0.05 0.1 0.20 0.5 0.7 0.9]

        i=i+1;
	[H,WHimg,Vnoisedimg,diffvecdum] = raw_denoiseNMF(image,W,Wnoise,niterH,downsamplingcoef,noiselevel);

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
	Hs(:,:,i) = H;

end

clear -except imB imG imR image v0

save raw_denoiseNMFdata.mat Vnoisedimgs WHimgs Hs W diffvec
