function [V,W,H,dataW,dataH,dataWH,diff] = dictionaryNMF(image,np,natoms,niter,niterW,niterH,downsamplingcoef)

%inputs:
%Image=an n x m -real matrix
%np=number of pixels per dimension of square patch
%natoms=number of atoms in dictionary
%niter=number of total iterations
%niterW=number of minimization iterations with respect to W
%niterH=number of minimization iterations with respect to H
%downsamplingcoef=number of pixels in one edge of square patch that is approximated as one pixel
%
%Outputs:
%V=original image in reshaped patch form, i.e. np^2 x (n/np)*(m/np) -real matrix
%W=dictionary, np^2 x r -matrix, where r=natoms
%H=coefficient matrix, r x m -real matrix
%
%dataW=contains information about the minimization with respect to W:
%       dataW(:,1)=iter <--- number of iteration
%       dataW(:,2)=norm(V-WH,'fro') <--- difference between approximation and original
%       dataW(:,3)=alpha*lambda <--- step length
%       dataW(:,4)=alpha <--- coefficient having values [0,1] (Armijo step length coefficient)
%       dataW(:,5)=lambda <--- barzilai Borwein step size
%
%dataH=contains information about the minimization with respect to H in the same fashion as
%in dataW
%
%dataWH = collection of information about the 'iter'-subsequent minimizations minW and minH
%
%diff = difference data, norm(V-WH,'fro'), after each total iteration (minimizations minW and minH)
%
%Vimg = n x m -original matrix
%WHimg = n x m -approximation of original
%Wimg = visual representation of dictionary

%Original matrix
image=double(image);

%Downsample the image   
image = sumimage(image,downsamplingcoef);

%Scale the values of image such that the
%maximum value is set to 1
maxval=max(max(image));
image=image/maxval;

% Divide the original image into patches and
% store the patches into columns of matrix V
[V] = divide2patches(image,np);

%tolerance
tol=1.0;
%difference 
%tol2=diff;

%initial step size
lambda=0.01

%minimum and maximum values of step sizes
lambda_min=0.000000001
lambda_max=1000

dim=size(V);
n=dim(1);
m=dim(2);
r=natoms;
W=randn([n r]);
W=W.^2;
mW=max(max(W));
W=W/mW;
H=randn([r m]);
H=H.^2;
mH=max(max(H));
H=H/mH;

lambda1=0.0;
lambda2=0.0;

dataH=zeros(1,6);
dataW=zeros(1,6);
dataWH=zeros(1,6);

%Dummy variables for any purposes
dum1=0.0;

%main loop
for i=1:niter
    
   %Find such H, that minimize ||V-WH||_fro
   [H,grad,iter1,data1]=nlssubprobBB(V,W,H,tol,niterH,0.001);

   dataH=vertcat(dataH,data1);
   dataWH=vertcat(dataWH,data1);

   lambda1=dataH(length(dataH(:,1)),4);

   %Find such WT, that minimize ||VT-HTWT||_fro
   [WT,grad,iter2,data2]=nlssubprobBB(V',H',W',tol,niterW,0.001);

   dataW=vertcat(dataW,data2);
   dataWH=vertcat(dataWH,data2);

   lambda2=dataW(length(dataW(:,1)),4);

   W=WT';

   %Compute the difference
   D=V-W*H;

   %Update WH
   WH=W*H;

   %Modify V and WH for ssim-indexing
   s=size(WH);
   WHdum=reshape(WH,np,[]);
   WHdum=mat2cell(WHdum,np,np*ones(1,s(2)));
   WHdum=reshape(WHdum,s(1)/np,s(2)/np);
   WHdum=cell2mat(WHdum);

   Vdum=reshape(V,np,[]);
   Vdum=mat2cell(Vdum,np,np*ones(1,s(2)));
   Vdum=reshape(Vdum,s(1)/np,s(2)/np);
   Vdum=cell2mat(Vdum);

   %Convert images from double to uint16 for ssim_indexing
   Vdum8=uint8(100*Vdum);
   WHdum8=uint8(100*WHdum);

   %Compute ssim_index (ssim=structural similarity) 
   ssim_index(Vdum8,WHdum8);

   diff(i,1)=i;
   diff(i,2)=sqrt(sum(sum(D.*D)));
   diff(i,3)=ssim_index(Vdum8,WHdum8);
   fprintf('%d  %f  %f\n',diff(i,1),diff(i,2),diff(i,3));

end

dataW(:,1)=1:1:length(dataW(:,2));
dataH(:,1)=1:1:length(dataH(:,2));
dataWH(:,1)=1:1:length(dataWH(:,2));

WH=W*H;

end
