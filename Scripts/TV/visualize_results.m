%%%%%%%%%%%%%%%
% Visualize results given by dictionaryNMF.m
%%%%%%%%%%%%%%%

load dictionaryKSVDdata.mat

%Visualize reconstruction
WH = W*H;
visualize_image(WH,'WH.jpg');

%Visualize learned dictionary
visualize_dictionary(W,'W.jpg');

clear

%%%%%%%%%%%%%%%%%%%
% Visualize results of reconstructKSVD.m
%%%%%%%%%%%%%%%%%%%

load reconstruct_OMPdata.mat

% Visualize and export reconstructions
for i = 1:size(WHimgs,3)
	namestr = sprintf('WH%.0fnl.jpg',100*diffvec(i,1));
	figure(1);
	clf;
	imagesc(WHimgs(:,:,i)); axis off; axis image; colormap(gray); 
	saveas(1,namestr,'jpg');
end

%Visualize atom distributions
%for i = 1:size(Hs,3)
%        namestr = sprintf('adistr%.0fnl',100*diffvec(i,1));
%        visualize_atom_distribution(Hs(:,:,i),namestr);
%end

clear

%%%%%%%%%%%%%%%%%%%%%
% Visualize results of learn_noiseNMF.m
%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Visualize results of raw_denoiseNMF.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%

load raw_denoise_OMPdata.mat

% Visualize the Wtot
%Visualize learned dictionary
visualize_dictionary(W,'Wtot.jpg');

% Visualize and export reconstructions
for i = 1:size(WHimgs,3)
        namestr = sprintf('WHrawrec%.0fnl.jpg',100*diffvec(i,1));
        figure(1);
        clf;
        imagesc(WHimgs(:,:,i)); axis off; axis image; colormap(gray);
        saveas(1,namestr,'jpg');
end

% Visualize zoomed reconstructions

for i = 1:size(WHimgs,3)
        namestr = sprintf('WHrawreczoom%.0fnl.jpg',100*diffvec(i,1));
        figure(1);
        clf;
        imagesc(WHimgs(10:20*8,10:20*8,i)); axis off; axis image; colormap(gray);
        saveas(1,namestr,'jpg');
end

%Visualize atom distributions
for i = 1:size(Hs,3)
        namestr = sprintf('adistr%.0fnl',100*diffvec(i,1));
        visualize_atom_distribution(Hs(:,:,i),namestr);
end

clear
