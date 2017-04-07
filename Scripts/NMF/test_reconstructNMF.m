%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Step 2
% Make reconstruction results with given dictionary W
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Load dictionary
load dictionaryNMFdata.mat W

%Make reconstruction using the given dictionary
load matches_02.mat
image=imG;

%Set the reconstruction parameters
np=8;
niterH=40;
downsamplingcoef=2^3;

i=0;
for noiselevel=[0.0 0.01 0.05 0.1 0.20 0.5 0.7 0.9]

        i=i+1;
	[H,WHimg,Vnoisedimg,diffvecdum] = reconstructNMF(image,W,niterH,downsamplingcoef,noiselevel);

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

save reconstruct_NMFdata.mat WHimgs Vnoisedimgs Hs W diffvec
