%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Make denoising results by TV method
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Load original image
load matches_02.mat
image=imG;

%Down sample the image
downsamplingcoef=2^3;
image = sumimage(image,downsamplingcoef);

i=0;
for noiselevel=[0.0 0.01 0.05 0.1 0.20 0.5 0.7 0.9]
%for noiselevel=[0.0]

        i=i+1;
	[Vrecimg, Vnoisedimg, diffvecdum] = denoiseTV(image,noiselevel);

        if(i==1)
                diffvec=diffvecdum;
        else
                diffvec=[diffvec; diffvecdum];
        end

	%Show the differences
	diffvec(i,:)

	%Store noised images
	Vnoisedimgs(:,:,i) = Vnoisedimg;

	%Store reconstructions
	Vrecimgs(:,:,i) = Vrecimg;
	
end

clear -except imB imG imR image v0

save test_denoise_TV.mat Vrecimgs Vnoisedimgs diffvec

%clear
