% %%%%%%%%%%%%%%%%%%%%%%%%
% %Step 3
% %Learn noise dictionary 
% %%%%%%%%%%%%%%%%%%%%%%%%

%Load image
load matches_01.mat
image      = imG;
%Define noiselevel of the noise sample
noiselevel = 0.01;

%Make noise sample of the same size
Ns = make_noise_sample(max(max(image)),noiselevel,size(image,1),size(image,2));

%Number of pixels per dimension in square patch
np=8;
spar=6;
natoms=50;
niter=40;
downsamplingcoef=2^3;

[V,Wnoise,H,data]=dictionaryKSVD(Ns,np,spar,natoms,niter,downsamplingcoef);


%%%%%%
%Visualize results
%%%%%%

%Visualize original image
visualize_image(V,'V.jpg')
 
%Visualize reconstruction
WH = Wnoise*H;
visualize_image(WH,'WH.jpg')
 
%Visualize learned dictionary
visualize_dictionary(Wnoise,'W.jpg')
 
%Visualize the data given by dictionaryKSVD.m
%Make picture of difference versus iteration
DIFFPLOT=figure;
plot(data.totalerr,'o','linewidth',7);
set(gca,'fontsize',15);
xlabel('Number of iterations');
ylabel('Difference ||V-WH||_F','FontSize',15);
%title('Difference ||V-WH||_F versus number of iterations');
grid on;
colormap(gray);
print('-depsc','diffplot');
%saveas(DIFFPLOT,'diffplot','jpg');

% Save results
save learn_noiseKSVDdata.mat V Wnoise H data

clear

