%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Step 2
%Make reconstruction results with given dictionary W
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Load dictionary
load dictionaryKSVDdata.mat W

%Make reconstruction using the given dictionary
load matches_02.mat
image=imG;

%Desired sparsity of the reconstruction
spar=6;
downsamplingcoef=2^3;

i=0;
for noiselevel=[0.0 0.01 0.05 0.1 0.20 0.5 0.7 0.9]

        i=i+1;
        [H,WHimg,Vnoisedimg,diffvecdum] = reconstruct_OMP(image,W,spar,noiselevel,downsamplingcoef);

        if(i==1)
                diffvec=diffvecdum;
        else
                diffvec=[diffvec; diffvecdum];
        end

	%Show the differences
	diffvec	

	%Show the reconstructions and export
	figure(i);
	clf
	imagesc(WHimg); colormap(gray); axis image; axis off;
	str = sprintf('WH%.0fnl.jpg',100*noiselevel);
	saveas(i,str,'jpg');

	%Store noised images
	Vnoisedimgs(:,:,i) = Vnoisedimg;

	%Store reconstructions
	WHimgs(:,:,i) = WHimg;

	%Store coeff. matrices
	H = full(H);
	Hs(:,:,i) = H;

end

clear -except imB imG imR image v0

save reconstruct_OMPdata.mat WHimgs Vnoisedimg Hs W diffvec
%save reconstruct_OMPdata.mat Vnoisedimgs Hs WHimgs  W diffvec

%clear

