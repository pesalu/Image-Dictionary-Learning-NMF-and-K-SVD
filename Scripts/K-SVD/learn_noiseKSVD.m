function [W,H,output,WHimg]=learn_noiseKSVD(image,np,spar,natoms,niter,downsamplingcoef,noiselevel)
%Function that uses K-SVD to learn noise atoms

%Inputs:
%image: of size n x m
%np: number of pixels per one side of a square patch
%spar: maximum number of atoms per approximation of each original patch
%natoms: number of atoms included to dictionary W, i.e. number of columns
%of W
%niter: number of iterations containing OMP and SVD routines
%downsamplingcoef: pixel number n of n x n square patch that is approximated as one pixel
%noiselevel=value [0, 1] indicating the percentage of corrupted pixels in original image
%
%Outputs:
%W=dictionary matrix
%H=coefficient matrix
%output=contains data from the K-SVD run for performance investigation
%WHimg=approximation WH with dimensions n x m

%Original matrix
v0=image;
v0=double(v0);

%put the maximum value to 1.
maxv0=max(max(v0));
v0=v0/maxv0;

%downsample the image
v0 = sumimage(v0,downsamplingcoef);

%Number of nxn patches in each dimension fo original matrix v0
numpatch1=(np*ones(1,size(v0,1)/np));
numpatch2=(np*ones(1,size(v0,2)/np));

%Split original picture into nxn patches
V=mat2cell(v0,numpatch1,numpatch2);

numpatch1=size(V,1);
numpatch2=size(V,2);

%Reshaped version of V  
C=reshape(V,1,numpatch1*numpatch2);
Voriginalreshaped=C;

%Reshaped version of C, V2, this is the matrix for
%which NMF is done
V2=zeros(np*np,numpatch1*numpatch2);
for i=1:numpatch1*numpatch2
  V2(:,i)=C{1,i}(:);
end

%Final original data matrix V
V=V2;

V=V/max(max(V));

%Save unnoised version of V
Vunnoised=V;

%Add random noise to original matrix v0
%noiselevel is same as the percentage of corrupted pixels in original image
noiseind=sprand(size(V,1),size(V,2),noiselevel);
noiseind(noiseind~=0.0)=1.0;
noiseind=logical(noiseind);

%finally add the noise with maximum amplitude maxV
maxV=max(max(V));
noisematrix=zeros(size(V,1),size(V,2));
noisematrix(noiseind)=maxV*rand(length(V(noiseind)),1);
V=noisematrix;
size(V)

%Save the noised version of V for
Vnoised=V;


%Maximum number of atoms in each linear combination of v_i
param.L = spar;
%Number of atoms in dictionary
param.K= natoms;
%Number of iteration to execute the K-SVD algorithm.
param.numIteration = niter; 

%decompose signals until a certain error is reached. do n
param.errorFlag = 0; 
%param.errorGoal = sigma;
param.preserveDCAtom = 0;

param.InitializationMethod =  'DataElements';
param.displayProgress = 1;

%Run K-SVD
size(V)

[W,output]  = KSVD(V,param);
%Store the coefficient matrix H
H=output.CoefMatrix;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Make plots
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Make picture of difference versus iteration
DIFFPLOT=figure;
plot(output.totalerr,'o'); xlabel('Number of iterations');
ylabel('Difference ||V-WH||_F'); 
title('Difference ||V-WH||_F versus number of iterations');
grid on;
colormap(gray);
%axis image;
%Remove extra space from figure
%tightPos=get(gca,'TightInset');
%noDeadSpacePos = [0 0 1 1] + [tightPos(1:2) -(tightPos(1:2) + ...
%  tightPos(3:4))];             
%set(gca,'Position',noDeadSpacePos)
saveas(DIFFPLOT,'diffplot','jpg');

%Make picture of the dictionary W
Wimg=W;
%Making W suitable for graphical presentation
Wimg=reshape(Wimg,np,[]);
r=size(Wimg,2)/np;
Wimg=mat2cell(Wimg,[np],np*ones(1,r));
D=isqrt(r);
dum=1:r;
dum=dum(rem(r,dum)==0);
[minval,minind]=min(abs(dum-D));
D=dum(minind);
Wimg=reshape(Wimg,D,[]);
%maxW=max(max(W{1,1}));
maxW=0;

WIMG=figure;
for i=1:size(Wimg,1)
        for j=1:size(Wimg,2)
                subplot(size(Wimg,1),size(Wimg,2),j+(i-1)*size(Wimg,2))

                im=Wimg{i,j};
                %put the values of im into range [0,1]
                im=im-min(min(im));
                %maximum value of image
                maxim=max(max(im));
                %minimum value of image
                minim=min(min(im));
                %threshold for black, i.e. value of zero
                %MIN=0.3;
                MIN=minim;
                %threhold for whit, i.e. value of 1
                MAX=maxim;
                %gamma parameter
                gam=1.0;
                imagesc(im.^gam,[MIN MAX]);
                colormap(gray);
                axis image;
                axis off;
        end
end

%Remove extra space from figure
%tightPos=get(gca,'TightInset');
%noDeadSpacePos = [0 0 1 1] + [tightPos(1:2) -(tightPos(1:2) + ...
%  tightPos(3:4))];
%set(gca,'Position',noDeadSpacePos)
str=sprintf('Wimg');
saveas(WIMG,str,'jpg');

%Wimg=cell2mat(Wimg);
%WIMG=figure;
%imagesc(Wimg);
%colormap(gray);
%axis image;
%colorbar;
%title('Dictionary (W) K-SVD');
%%Remove extra space from figure
%tightPos=get(gca,'TightInset');
%noDeadSpacePos = [0 0 1 1] + [tightPos(1:2) -(tightPos(1:2) + ...
%  tightPos(3:4))];
%set(gca,'Position',noDeadSpacePos)
%saveas(WIMG,'W','jpg');


%Make picture of the reconstruction
%Compute first the approximation WH
WH=W*H;
%Reshape WH
WH=reshape(WH,np,[]);
WH=mat2cell(WH,[np],np*ones(1,numpatch1*numpatch2));
WH=reshape(WH,numpatch1,numpatch2);
WHimg=cell2mat(WH);

%Make image of the approximation WH
WHIMG=figure;
im=WHimg;
im=im-min(min(im));
                %maximum value of image
                maxim=max(max(im));
                %minimum value of image
                minim=min(min(im));
                %threshold for black, i.e. value of zero
                MIN=minim;
                %threhold for whit, i.e. value of 1
                MAX=maxim;
                %gamma parameter
                gam=1.0;
imagesc(im.^gam,[MIN MAX]);
colormap(gray);
axis image;
axis off;
colormap(gray);
%title('Reconstruction (WH)');
%Remove extra space from figure
tightPos=get(gca,'TightInset');
noDeadSpacePos = [0 0 1 1] + [tightPos(1:2) -(tightPos(1:2) + ...
  tightPos(3:4))];
set(gca,'Position',noDeadSpacePos)
saveas(WHIMG,'WH','jpg');


%Make picture of the original image
%First reshape V
Vimg=reshape(V,np,[]);
Vimg=mat2cell(Vimg,[np],np*ones(1,numpatch1*numpatch2));
Vimg=reshape(Vimg,numpatch1,numpatch2);
Vimg=cell2mat(Vimg);

%Make image of the original V
VIMG=figure; 
imagesc(Vimg); 
colormap(gray);
%colorbar; 
axis image; 
axis off;
%title('Original picture (V)');
%Remove extra space from figure
tightPos=get(gca,'TightInset');
noDeadSpacePos = [0 0 1 1] + [tightPos(1:2) -(tightPos(1:2) + ...
  tightPos(3:4))];
set(gca,'Position',noDeadSpacePos)
saveas(VIMG,'V','jpg');


clear -except image v0

str=sprintf('results_learn_noiseKSVD_r%d_np%d_spar%d_natoms%d_niter%d.mat',r,np,spar,natoms,niter);
save(str);

end
