% %%%%%%%%%%%%%%%%%%%%%%%%
% %Step 1
% %Learn dictionary W
% %%%%%%%%%%%%%%%%%%%%%%%%

load matches_01.mat
image=imG;

np=8;
natoms=120;
niter=40;
niterW=40;
niterH=20;
downsamplingcoef=2^3;

[V,W,H,dataW,dataH,dataWH,diff] = dictionaryNMF(image,np,natoms,niter,niterW,niterH,downsamplingcoef); 

%%%%%%
%Visualize results of step 1
%%%%%%

%Visualize original image
visualize_image(V,'V.jpg')
 
%Visualize reconstruction
WH = W*H;
visualize_image(WH,'WH.jpg')
 
%Visualize learned dictionary
visualize_dictionary(W,'W.jpg')
 
%Visualize the data given by dictionaryKSVD.m
%Make picture of difference versus iteration
DIFFPLOT=figure;
plot(diff(:,2),'o','linewidth',7);
set(gca,'fontsize',15);
xlabel('Number of iterations');
ylabel('Difference ||V-WH||_F','FontSize',15);
%title('Difference ||V-WH||_F versus number of iterations');
grid on;
colormap(gray);
print('-depsc','diffplot');
%saveas(DIFFPLOT,'diffplot','jpg');

% Save results
save dictionaryNMFdata.mat V W H dataW dataH dataWH diff

clear

